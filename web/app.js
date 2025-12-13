const characterData = [
  {
    id: 'frodo',
    name: 'Frodo',
    color: '#a3e635',
    vibe: 'Ring-bearer stealth and stubbornness',
    emoji: '💍',
    boost: { stealth: 2, heart: 1 },
  },
  {
    id: 'sam',
    name: 'Samwise',
    color: '#f59e0b',
    vibe: 'Loyalty and morale spike, plus great snacks',
    emoji: '🥔',
    boost: { heart: 2, grit: 1 },
  },
  {
    id: 'gandalf',
    name: 'Gandalf',
    color: '#c084fc',
    vibe: 'Wizard style: fireworks, wisdom, and risky ideas',
    emoji: '✨',
    boost: { magic: 2, wisdom: 1 },
  },
  {
    id: 'yoda',
    name: 'Yoda',
    color: '#22c55e',
    vibe: 'Force-lift boulders, reverse syntax, zero chill',
    emoji: '🛸',
    boost: { magic: 1, stealth: 1, wisdom: 2 },
  },
  {
    id: 'eleven',
    name: 'Eleven',
    color: '#f472b6',
    vibe: 'Telekinesis, nosebleeds, and waffle diplomacy',
    emoji: '🧇',
    boost: { chaos: 2, grit: 1 },
  },
  {
    id: 'aragorn',
    name: 'Aragorn',
    color: '#60a5fa',
    vibe: 'Ranger instincts and king-level pep talks',
    emoji: '🗡️',
    boost: { stealth: 1, heart: 1, grit: 1 },
  },
];

const pathData = [
  {
    id: 'northern',
    name: 'Northern Pass via Rivendell',
    accent: '#38bdf8',
    flavor: 'Classic fellowship route with cozy elf stops and Moria chaos.',
    tag: 'Steady + social',
    stops: [
      {
        id: 'bree',
        name: 'Bree & the Prancing Pony',
        challenge: 'Nazgûl sniffing around the inn.',
        options: [
          { id: 'stealth', label: 'Hide in barrels and wait it out', stats: { stealth: 3, heart: 1 }, story: 'The team slipped through the ale cellar.' },
          { id: 'distraction', label: 'Stage fireworks to distract the riders', stats: { chaos: 2, magic: 1 }, story: 'Chaos and sparkles sent the Nazgûl galloping elsewhere.' },
          { id: 'ally', label: 'Recruit Strider for guidance', stats: { wisdom: 2, heart: 1 }, story: 'A ranger in the corner decided you were worth the bother.' },
        ],
      },
      {
        id: 'rivendell',
        name: 'Rivendell',
        challenge: 'Council time: who carries the ring?',
        options: [
          { id: 'volunteer', label: 'Volunteer boldly', stats: { heart: 3 }, story: 'Your courage impressed elves and dwarves alike.' },
          { id: 'delegate', label: 'Delegate to another hero', stats: { wisdom: 2, stealth: 1 }, story: 'A careful handoff gave the mission fresh energy.' },
          { id: 'brainstorm', label: 'Workshop side quests for allies', stats: { wisdom: 1, chaos: 1, heart: 1 }, story: 'The council left with sticky notes and new allies.' },
        ],
      },
      {
        id: 'moria',
        name: 'Moria',
        challenge: 'Balrog appears on the bridge.',
        options: [
          { id: 'youShallNotPass', label: 'Wizard duel on the bridge', stats: { magic: 3, grit: 1 }, story: 'A dramatic stand slowed the Balrog and hyped morale.' },
          { id: 'collapse', label: 'Collapse a tunnel and sprint', stats: { stealth: 1, chaos: 2 }, story: 'Rubblestrewn shortcuts spared the team from fire.' },
          { id: 'befriend', label: 'Attempt diplomacy (because why not)', stats: { chaos: 3 }, story: 'The Balrog was briefly confused and everyone laughed.' },
        ],
      },
      {
        id: 'lothlorien',
        name: 'Lothlórien',
        challenge: 'Galadriel tests your intent.',
        options: [
          { id: 'honesty', label: 'Lay your fears on the table', stats: { heart: 2, wisdom: 1 }, story: 'Transparency won you elven gifts and glowing cloaks.' },
          { id: 'mirror', label: 'Gaze into the mirror for intel', stats: { wisdom: 2 }, story: 'Visions revealed shortcuts and looming risks.' },
          { id: 'vibes', label: 'Perform a song for morale', stats: { heart: 1, chaos: 1 }, story: 'The elves clapped politely; the team felt lighter.' },
        ],
      },
      {
        id: 'blackgate',
        name: 'Black Gate',
        challenge: 'Get past Sauron’s armies.',
        options: [
          { id: 'decoy', label: 'Send a decoy raid', stats: { grit: 2, chaos: 1 }, story: 'Diversions bought precious minutes.' },
          { id: 'cloak', label: 'Wear elven cloaks and sneak', stats: { stealth: 3 }, story: 'The shadows hid you from prying eyes.' },
          { id: 'eagles', label: 'Call in the Eagles (controversial)', stats: { magic: 1, chaos: 2 }, story: 'Aerial entry was loud, fast, and very on-brand.' },
        ],
      },
    ],
  },
  {
    id: 'southern',
    name: 'Secret Southern Loop',
    accent: '#f59e0b',
    flavor: 'Swampy detours and stealthy passes near Minas Tirith.',
    tag: 'Sneaky + gritty',
    stops: [
      {
        id: 'oldforest',
        name: 'Old Forest',
        challenge: 'Trees whisper and try to trap you.',
        options: [
          { id: 'song', label: 'Sing with Tom Bombadil', stats: { heart: 1, chaos: 1 }, story: 'Musical vibes loosened roots and tension.' },
          { id: 'fire', label: 'Use controlled fire to clear path', stats: { grit: 2, chaos: 1 }, story: 'A smoky route opened, slightly crispy.' },
          { id: 'sneak', label: 'Slip quietly along the river', stats: { stealth: 2 }, story: 'You ghosted past the trees without a twig snap.' },
        ],
      },
      {
        id: 'deadmarshes',
        name: 'Dead Marshes',
        challenge: 'Ghostly lights lure travelers off course.',
        options: [
          { id: 'rope', label: 'Use rope and buddy system', stats: { grit: 1, heart: 1 }, story: 'Teamwork beat spooky illusions.' },
          { id: 'blink', label: 'Eleven blinks lights away', stats: { magic: 1, chaos: 1 }, story: 'Psychic static dispersed the ghosts.' },
          { id: 'gollum', label: 'Hire Gollum as a guide', stats: { stealth: 1, chaos: 1 }, story: 'Shifty guidance, but surprisingly effective.' },
        ],
      },
      {
        id: 'minastirith',
        name: 'Minas Tirith',
        challenge: 'City requests aid before letting you pass.',
        options: [
          { id: 'rally', label: 'Rally citizens with a speech', stats: { heart: 2, wisdom: 1 }, story: 'A pep talk raised banners and opened gates.' },
          { id: 'trade', label: 'Trade gear for supplies', stats: { wisdom: 1, grit: 1 }, story: 'Fair swaps gained horses and rope.' },
          { id: 'sneakpast', label: 'Sneak through the sewers', stats: { stealth: 2 }, story: 'Messy but effective shortcut.' },
        ],
      },
      {
        id: 'cirithungol',
        name: 'Cirith Ungol',
        challenge: 'Shelob blocks the high pass.',
        options: [
          { id: 'light', label: 'Use the phial of light', stats: { magic: 1, wisdom: 1 }, story: 'Blinding light scattered the webs.' },
          { id: 'decoy', label: 'Send bait (maybe a goat)', stats: { chaos: 2 }, story: 'Shelob chased the goat, horrified but distracted.' },
          { id: 'teamup', label: 'Team up with local rangers', stats: { grit: 2, heart: 1 }, story: 'Rangers cleared tunnels with you.' },
        ],
      },
      {
        id: 'mordor',
        name: 'Cracks of Doom',
        challenge: 'Final climb under watchful eyes.',
        options: [
          { id: 'stealthclimb', label: 'Climb at night, lights off', stats: { stealth: 3 }, story: 'Silent progress with zero selfies.' },
          { id: 'powerup', label: 'Channel every ally power at once', stats: { magic: 2, chaos: 1 }, story: 'A risky fusion that paid off.' },
          { id: 'buddy', label: 'Carry each other up the slope', stats: { heart: 2, grit: 1 }, story: 'Mutual support sealed the deal.' },
        ],
      },
    ],
  },
  {
    id: 'sky',
    name: 'Skyward Shortcut',
    accent: '#c084fc',
    flavor: 'Questionable plan: boats to the Grey Havens, then Eagles.',
    tag: 'Fast + risky',
    stops: [
      {
        id: 'havens',
        name: 'Grey Havens',
        challenge: 'Convince the elves to lend an Eagle squad.',
        options: [
          { id: 'diplomacy', label: 'Promise to return the Eagles with snacks', stats: { heart: 1, wisdom: 1 }, story: 'Snacks are persuasive currency.' },
          { id: 'race', label: 'Win a boat race to earn trust', stats: { grit: 2 }, story: 'Victory on the waves impressed the captains.' },
          { id: 'force', label: 'Yoda negotiates with the Force', stats: { magic: 2 }, story: 'Mind tricks delivered winged transport.' },
        ],
      },
      {
        id: 'theride',
        name: 'Eagle Airspace',
        challenge: 'Avoid Nazgûl flyers mid-flight.',
        options: [
          { id: 'barrelRoll', label: 'Barrel rolls and evasive moves', stats: { grit: 1, chaos: 2 }, story: 'Aerial gymnastics dodged danger.' },
          { id: 'cloak', label: 'Cloak the squad in clouds', stats: { stealth: 2 }, story: 'Mist hid everyone from wraith radar.' },
          { id: 'lightning', label: 'Call storm lightning', stats: { magic: 2 }, story: 'Thunder kept pursuers distant.' },
        ],
      },
      {
        id: 'mordor-drop',
        name: 'Drop Zone',
        challenge: 'Land close without causing a scene.',
        options: [
          { id: 'night', label: 'Night glide onto a ridge', stats: { stealth: 2 }, story: 'A soft landing near the cracks of doom.' },
          { id: 'distraction', label: 'Drop fireworks on Orc camps', stats: { chaos: 2, grit: 1 }, story: 'Loud, bright, and surprisingly effective.' },
          { id: 'teamwork', label: 'Form a flying V like ducks', stats: { heart: 1, grit: 1 }, story: 'Style points for synchronized Eagles.' },
        ],
      },
      {
        id: 'finale',
        name: 'Final Step',
        challenge: 'Throw the ring or turn back?',
        options: [
          { id: 'throw', label: 'Throw it into the fire', stats: { heart: 2, grit: 1 }, story: 'Clean shot, mission success.' },
          { id: 'debate', label: 'Debate ownership one last time', stats: { chaos: 1, wisdom: 1 }, story: 'Tense discussion but the right choice emerged.' },
          { id: 'temptation', label: 'Use ring briefly for invisibility', stats: { stealth: 2, chaos: 1 }, story: 'Risky cloak-and-toss maneuver.' },
        ],
      },
    ],
  },
];

const traitWeights = { stealth: 2, heart: 2, magic: 2, grit: 1.5, wisdom: 1.5, chaos: 1 };

const teams = [];

const teamNameInput = document.getElementById('teamName');
const leadCharacterSelect = document.getElementById('leadCharacter');
const teamShareInput = document.getElementById('teamShare');
const teamForm = document.getElementById('teamForm');
const teamCards = document.getElementById('teamCards');
const leaderboard = document.getElementById('leaderboard');
const narrativeList = document.getElementById('narrativeList');

const addTeamBtn = document.getElementById('addTeamBtn');
const randomizeBtn = document.getElementById('randomizeBtn');
const clearTeamsBtn = document.getElementById('clearTeamsBtn');
const scoreAllBtn = document.getElementById('scoreAllBtn');
const narrateBtn = document.getElementById('narrateBtn');

const characterList = document.getElementById('characterList');
const pathGallery = document.getElementById('pathGallery');

function initCharacterSelect() {
  leadCharacterSelect.innerHTML = '';
  characterData.forEach((char) => {
    const option = document.createElement('option');
    option.value = char.id;
    option.textContent = `${char.name} — ${char.vibe}`;
    leadCharacterSelect.appendChild(option);
  });
}

function renderCharacters() {
  characterList.innerHTML = '';
  characterData.forEach((char) => {
    const chip = document.createElement('span');
    chip.className = 'chip';
    chip.textContent = `${char.emoji} ${char.name} • ${char.vibe}`;
    characterList.appendChild(chip);
  });
}

function renderPathGallery() {
  pathGallery.innerHTML = '';
  pathData.forEach((path) => {
    const card = document.createElement('article');
    card.className = 'path-card';
    card.innerHTML = `
      <span class="tag">${path.tag}</span>
      <h3>${path.name}</h3>
      <p>${path.flavor}</p>
      <div class="badges">${path.stops
        .map((stop) => `<span class="badge">${stop.name}</span>`)
        .join('')}</div>
    `;
    pathGallery.appendChild(card);
  });
}

function createTeam(name, heroId, shareText) {
  const hero = characterData.find((c) => c.id === heroId) || characterData[0];
  const id = crypto.randomUUID();
  const defaultPath = pathData[0];
  const choices = {};
  defaultPath.stops.forEach((stop) => {
    choices[stop.id] = stop.options[0].id;
  });

  const team = {
    id,
    name,
    hero,
    path: defaultPath,
    choices,
    sharedIdea: shareText?.trim() || 'To be decided together.',
    creativity: Math.floor(Math.random() * 3),
    score: 0,
    narrative: '',
  };
  teams.push(team);
  renderTeams();
}

function renderTeams() {
  teamCards.innerHTML = '';
  teams.forEach((team) => {
    const card = document.createElement('article');
    card.className = 'team-card';
    card.dataset.teamId = team.id;

    const header = document.createElement('header');
    const title = document.createElement('div');
    title.innerHTML = `<p class="eyebrow">${team.path.name}</p><h3>${team.name}</h3>`;

    const heroPill = document.createElement('div');
    heroPill.className = 'hero-pill';
    heroPill.style.background = `${team.hero.color}22`;
    heroPill.innerHTML = `
      <span class="hero-icon" style="background:${team.hero.color}">${team.hero.emoji}</span>
      <span><strong>${team.hero.name}</strong><br/><small>${team.hero.vibe}</small></span>
    `;
    header.append(title, heroPill);

    const pathSelect = document.createElement('select');
    pathSelect.innerHTML = pathData
      .map((p) => `<option value="${p.id}" ${p.id === team.path.id ? 'selected' : ''}>${p.name}</option>`)
      .join('');
    pathSelect.addEventListener('change', (e) => switchPath(team.id, e.target.value));

    const shareInput = document.createElement('textarea');
    shareInput.value = team.sharedIdea;
    shareInput.rows = 2;
    shareInput.placeholder = 'Document the group discussion so others can riff on it';
    shareInput.addEventListener('input', (e) => {
      team.sharedIdea = e.target.value;
    });

    const stopsContainer = document.createElement('div');
    stopsContainer.className = 'stops';
    team.path.stops.forEach((stop) => {
      const stopEl = document.createElement('div');
      stopEl.className = 'stop';
      stopEl.innerHTML = `<h4>${stop.name}</h4><small>${stop.challenge}</small>`;

      const optionsWrap = document.createElement('div');
      optionsWrap.className = 'options';
      stop.options.forEach((option) => {
        const optionEl = document.createElement('label');
        optionEl.className = 'option';
        optionEl.innerHTML = `
          <div style="display:flex;align-items:center;gap:8px;">
            <input type="radio" name="${team.id}-${stop.id}" value="${option.id}" ${team.choices[stop.id] === option.id ? 'checked' : ''} />
            <strong>${option.label}</strong>
          </div>
          <div class="stats">${Object.entries(option.stats)
            .map(([stat, val]) => `<span>${stat} +${val}</span>`)
            .join('')}</div>
          <small>${option.story}</small>
        `;
        optionEl.querySelector('input').addEventListener('change', (e) => {
          team.choices[stop.id] = e.target.value;
          updateJourneyGraphic(card, team);
        });
        optionsWrap.appendChild(optionEl);
      });

      const share = document.createElement('textarea');
      share.rows = 2;
      share.placeholder = 'Share the group decision for this stop';
      share.addEventListener('input', (e) => {
        const noteKey = `${stop.id}-note`;
        team[noteKey] = e.target.value;
      });

      stopEl.appendChild(optionsWrap);
      stopEl.appendChild(share);
      stopsContainer.appendChild(stopEl);
    });

    const journey = document.createElement('div');
    journey.className = 'journey-map';
    journey.innerHTML = `
      <div class="journey-track"><div class="journey-progress"></div><div class="journey-marker">${team.hero.emoji}</div></div>
      <div class="journey-stops">${team.path.stops.map((stop) => `<span>${stop.name}</span>`).join('')}</div>
    `;

    const actions = document.createElement('div');
    actions.className = 'team-actions';
    const scoreBtn = document.createElement('button');
    scoreBtn.className = 'primary';
    scoreBtn.textContent = 'Score this team';
    scoreBtn.addEventListener('click', () => scoreTeam(team.id));

    const removeBtn = document.createElement('button');
    removeBtn.className = 'ghost';
    removeBtn.textContent = 'Remove';
    removeBtn.addEventListener('click', () => removeTeam(team.id));

    actions.append(scoreBtn, removeBtn);

    card.append(header, pathSelect, shareInput, journey, stopsContainer, actions);
    teamCards.appendChild(card);

    updateJourneyGraphic(card, team);
  });
}

function switchPath(teamId, pathId) {
  const team = teams.find((t) => t.id === teamId);
  const newPath = pathData.find((p) => p.id === pathId) || pathData[0];
  team.path = newPath;
  team.choices = {};
  newPath.stops.forEach((stop) => {
    team.choices[stop.id] = stop.options[0].id;
  });
  renderTeams();
}

function removeTeam(teamId) {
  const index = teams.findIndex((t) => t.id === teamId);
  if (index >= 0) {
    teams.splice(index, 1);
    renderTeams();
    updateLeaderboard();
    renderNarratives();
  }
}

function sumStats(stats) {
  return Object.entries(stats).reduce((total, [trait, value]) => {
    const weight = traitWeights[trait] || 1;
    return total + value * weight;
  }, 0);
}

function calculateTeamScore(team) {
  let score = 0;
  let momentum = 0;
  const journal = [];

  team.path.stops.forEach((stop) => {
    const optionId = team.choices[stop.id] || stop.options[0].id;
    const option = stop.options.find((o) => o.id === optionId) || stop.options[0];
    const optionScore = sumStats(option.stats);
    const heroBonus = Object.entries(team.hero.boost).reduce((total, [trait, bonus]) => {
      const weight = traitWeights[trait] || 1;
      return total + bonus * weight * 0.8;
    }, 0);

    momentum += optionScore * 0.1;
    const stepScore = optionScore + heroBonus + momentum;
    score += stepScore;
    journal.push({ stop: stop.name, choice: option.label, story: option.story });
  });

  score += (team.sharedIdea?.length || 0) * 0.05;
  score += (team.creativity || 0) * 2;
  score = Math.round(score);
  return { score, journal };
}

function scoreTeam(teamId) {
  const team = teams.find((t) => t.id === teamId);
  if (!team) return;
  const { score, journal } = calculateTeamScore(team);
  team.score = score;
  team.narrative = buildNarrative(team, journal);
  updateLeaderboard();
  renderNarratives();
  renderTeams();
}

function buildNarrative(team, journal) {
  const beats = journal
    .map((entry, index) => `${index + 1}. At ${entry.stop}, they chose to ${entry.choice.toLowerCase()} — ${entry.story}`)
    .join(' ');
  return `${team.name} led by ${team.hero.name} took the ${team.path.name} route. ${beats} Final vibe: ${team.sharedIdea || 'They kept the plan secret.'}`;
}

function updateLeaderboard() {
  const sorted = [...teams].sort((a, b) => b.score - a.score);
  leaderboard.innerHTML = '';
  sorted.forEach((team) => {
    const li = document.createElement('li');
    li.innerHTML = `<strong>${team.name}</strong> — ${team.score || 0} pts <span class="note">(${team.path.tag})</span>`;
    leaderboard.appendChild(li);
  });
}

function renderNarratives() {
  narrativeList.innerHTML = '';
  teams
    .filter((team) => team.narrative)
    .forEach((team) => {
      const card = document.createElement('div');
      card.className = 'narrative-card';
      card.innerHTML = `<strong>${team.name}</strong><p>${team.narrative}</p>`;
      narrativeList.appendChild(card);
    });
}

function updateJourneyGraphic(card, team) {
  const progressEl = card.querySelector('.journey-progress');
  const marker = card.querySelector('.journey-marker');
  const progress = Object.keys(team.choices).length / team.path.stops.length;
  const width = Math.max(10, progress * 100);
  if (progressEl) progressEl.style.width = `${width}%`;
  if (marker) marker.style.left = `${width}%`;
}

function scoreAllTeams() {
  teams.forEach((team) => scoreTeam(team.id));
}

function narrateAllTeams() {
  teams.forEach((team) => {
    if (!team.narrative) {
      const { journal } = calculateTeamScore(team);
      team.narrative = buildNarrative(team, journal);
    }
  });
  renderNarratives();
}

function randomizeTeam() {
  const randomHero = characterData[Math.floor(Math.random() * characterData.length)];
  const randomPath = pathData[Math.floor(Math.random() * pathData.length)];
  const name = `Team ${randomHero.name} ${Math.floor(Math.random() * 90) + 10}`;
  const shareText = 'Inspired by the room. Will improvise wildly.';
  createTeam(name, randomHero.id, shareText);
  const team = teams[teams.length - 1];
  switchPath(team.id, randomPath.id);
  scoreTeam(team.id);
}

function clearTeams() {
  teams.splice(0, teams.length);
  renderTeams();
  updateLeaderboard();
  renderNarratives();
}

addTeamBtn.addEventListener('click', () => teamForm.requestSubmit());
randomizeBtn.addEventListener('click', randomizeTeam);
clearTeamsBtn.addEventListener('click', clearTeams);
scoreAllBtn.addEventListener('click', scoreAllTeams);
narrateBtn.addEventListener('click', narrateAllTeams);

teamForm.addEventListener('submit', (e) => {
  e.preventDefault();
  const name = teamNameInput.value.trim();
  const heroId = leadCharacterSelect.value;
  const shareText = teamShareInput.value;
  if (!name) return;
  createTeam(name, heroId, shareText);
  teamForm.reset();
  leadCharacterSelect.value = heroId;
});

initCharacterSelect();
renderCharacters();
renderPathGallery();

// Add a default team for demo purposes
createTeam('Fellowship Demo', characterData[0].id, 'Sneak, sing, and improvise.');
scoreTeam(teams[0].id);
