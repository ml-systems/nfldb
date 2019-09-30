import logging
import azure.functions as func
import argparse
import json
import multiprocessing.pool
import os
import re
import sys
import traceback
import requests

from bs4 import BeautifulSoup

try:
    import lxml.html  # noqa
    PARSER = 'lxml'
except ImportError:
    try:
        import html5lib  # noqa
        PARSER = 'html5lib'
    except ImportError:
        PARSER = 'html.parser'


# define URLS
urls = {
    'roster': 'http://www.nfl.com/teams/roster',
    'gsis_profile': 'http://www.nfl.com/players/profile',
}

#supporting functions 

def try_int(s):
    try:
        return int(s)
    except ValueError:
        return 0
def height_as_inches(txt):
    # Defaults to 0 if `txt` isn't parseable.
    feet, inches = 0, 0
    pieces = re.findall('[0-9]+', txt)
    if len(pieces) >= 1:
        feet = try_int(pieces[0])
        if len(pieces) >= 2:
            inches = try_int(pieces[1])
    return feet * 12 + inches    

def first_int(s):
    m = re.search('[0-9]+', s)
    if m is None:
        return 0
    return int(m.group(0))

def first_word(s):
    m = re.match('\S+', s)
    if m is None:
        return ''
    return m.group(0)

def profile_id_from_url(url):
    if url is None:
        return None
    m = re.search('/([0-9]+)/', url)
    return None if m is None else int(m.group(1))

def profile_url(gsis_id):
    resp = requests.head(urls['gsis_profile'], params={'id':gsis_id})
    if resp.status_code != 301:
        return None
    loc = resp.headers['location']
    if not loc.startswith('http://'):
        loc = 'http://www.nfl.com' + loc
    return loc

def gsis_id(profile_url):
    resp = requests.get(profile_url)
    if resp.status_code != 200:
        return None
    m = re.search('GSIS\s+ID:\s+([0-9-]+)', resp.text)
    if m is None:
        return None
    gid = m.group(1).strip()
    if len(gid) != 10:  # Can't be valid...
        return None
    return gid    

def roster_soup(team):
    resp = requests.get(urls['roster'], params={'team':team})
    if resp.status_code != 200:
        return None
    return BeautifulSoup(resp.text, PARSER)


#Get Meta
def meta_from_profile_html(html):
    if not html:
        return html
    try:
        soup = BeautifulSoup(html, 'html.parser')
        pinfo = soup.find(id='player-bio').find(class_='player-info')

        # Get the full name and split it into first and last.
        # Assume that if there are no spaces, then the name is the last name.
        # Otherwise, all words except the last make up the first name.
        # Is that right?
        name = pinfo.find(class_='player-name').get_text().strip()
        name_pieces = name.split(' ')
        if len(name_pieces) == 1:
            first, last = '', name
        else:
            first, last = ' '.join(name_pieces[0:-1]), name_pieces[-1]
        meta = {
            'first_name': first,
            'last_name': last,
            'full_name': name,
        }
        
        #Get team
        team = pinfo.find(class_='player-team-links')
        teamreg = re.search('profile[?]team=(.*?)">', str(team)).group(1)
        meta['team'] = teamreg

        # The position is only in the <title>... Weird.
        title = soup.find('title').get_text()
        m = re.search(',\s+([A-Z]+)', title)
        if m is not None:
            meta['position'] = m.group(1)

        # Look for a whole bunch of fields in the format "Field: Value".
        search = pinfo.get_text()
        fields = {'Height': 'height', 'Weight': 'weight', 'Born': 'birthdate',
                  'College': 'college'}
        for f, key in list(fields.items()):
            m = re.search('%s:\s+([\S ]+)' % f, search)
            if m is not None:
                meta[key] = m.group(1)
                if key == 'height':
                    meta[key] = height_as_inches(meta[key])
                elif key == 'weight':
                    meta[key] = first_int(meta[key])
                elif key == 'birthdate':
                    meta[key] = first_word(meta[key])

        # Experience is a little weirder...
        m = re.search('Experience:\s+([0-9]+)', search)
        if m is not None:
            meta['years_pro'] = int(m.group(1))

        return meta
    except AttributeError:
        return None

def meta_from_soup_row(team, soup_row):
    tds, data = [], []
    for td in soup_row.find_all('td'):
        tds.append(td)
        data.append(td.get_text().strip())
    profile_url = 'http://www.nfl.com%s' % tds[1].a['href']

    name = tds[1].a.get_text().strip()
    if ',' not in name:
        last_name, first_name = name, ''
    else:
        last_name, first_name = [s.strip() for s in name.split(',')][:2]

    return {
        'team': team,
        'gsis_id': gsis_id(profile_url),
        'profile_id': profile_id_from_url(profile_url),
        'profile_url': profile_url,
        'number': try_int(data[0]),
        'first_name': first_name,
        'last_name': last_name,
        'full_name': '%s %s' % (first_name, last_name),
        'position': data[2],
        'status': data[3],  
        'height': height_as_inches(data[4]),
        'weight': first_int(data[5]),
        'birthdate': data[6],
        'years_pro': try_int(data[7]),
        'college': data[8],
    } 

#fetch 
def fetchRoster(team):
    roster = []

    soup = roster_soup(team)
    tbodys = soup.find(id='result').find_all('tbody')

    for row in tbodys[len(tbodys)-1].find_all('tr'):
        try:
            roster.append(meta_from_soup_row(team, row))
        except Exception:
            errors.append(
                'Could not get player info from roster row:\n\n%s\n\n'
                'Exception:\n\n%s\n\n'
                % (row, traceback.format_exc()))
    json_string = json.dumps(roster)
    return json_string

def fetchPlayer(gsisID):
    purl = profile_url(gsisID)
    if purl == None:
        return None
    resp = requests.get(purl)
    if resp.status_code != 200:
        return None
    html = resp.text
    more_meta = meta_from_profile_html(html)
    if not more_meta:
    #if more_meta is False, then it was a 404. Not our problem.
        if more_meta is None:
            errors.append('Could not fetch HTML for %s' % purl)
    else: 
        more_meta['gsis_id'] = gsisID
        more_meta['profile_id'] = profile_id_from_url(purl)
        more_meta['profile_url'] = purl
 
        json_string = json.dumps(more_meta)
 
    return json_string


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    lookup = req.params.get('lookup')
    if not lookup:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            lookup = req_body.get('lookup')

    if lookup:
        print(lookup)
        if lookup.startswith('00-'):
            getResponse = fetchPlayer(lookup)
        else:
            getResponse = fetchRoster(lookup)
        return func.HttpResponse(getResponse)
    else:
        return func.HttpResponse(
             "Please pass a player gsis id or team name on the query string or in the request body",
             status_code=400
        )

