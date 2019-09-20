# nfldb

<b>Azure auto-deploying, auto-updating NFL database. Get it up and running with 3 lines of code</b>
  
  
  
## Instructions:
  
- read the notes  
- get an Azure account  [Get a Free Azure Account](https://azure.microsoft.com/en-us/free/)
- log in: https://portal.azure.com
- from the web portal, open a cloud shell window  
- choose powershell as the language in your cloud shell (not bash)  
- enter the three lines of code below, replacing your own unique arguments in the last command.  
   - this will build all the resources  
- go into the GameDayData_PFunction_Schedule2 logic app in your Azure portal and run it  
   -this will load 2019's data.. will take about 20 min (on the lowest DB tier that it's defaulted to)  
- download SSMS  
- connect to your database server at the location mydbserver.database.windows.net  (replace mydbserver with your unique name)  
- it will prompt you to login, to allow your ip address through the database server firewall  
- see your data in the NFLMaster tables!  
  
  
  
## The Three Lines of Code:
  
    CD  
  
    invoke-WebRequest -Uri "https://raw.githubusercontent.com/ml-systems/nfldb/master/DeployNFLDB.ps1" -OutFile "DeployNFLDB.ps1"  
  
    ./DeployNFLDB.ps1 myresourcegroup "Central US" mydbserver P@ssw0rd mystorageacct myfunctionapp  
  
  
  
## Notes:  
  
note that the last line of code has 6 arguments for unique names to give your various resources.  
Since a lot of resource names need to be unique across all of Azure, it might bark at you to pick a new name.  
  
### The arguments in the last line of code are:  
- myresourcegroup  (a unique name for your resource group, which holds all the resources you're creating)  
- "Central US" (the region you want to set everything up in. Check Azure docs for the regions and syntax)  
- mydbserver (the name of your db server.. no caps)  
- P@ssw0rd (your password to connect. Your id will be admin)  
- mystorageacct (storage account name to hold your various files)  
- myfunctionapp (name of the function app that converts json grabbed from the NFL api into csv files for load into sql server)  
  
### The Azure framework's inner-workings are based on two logic apps:  
LoadNFLSchedule loads the schedule  
GameDayData_PFunction_Schedule2 loads the data based on that schedule. It automatically finds missing games and updates. It is on a schedule so will keep updating throughout the week  
  
### to run other years of data:  
edit the logic app LoadNFLSchedule to change the year  
run it  
edit the logic app GameDayData_PFunction_Schedule2 to change the year  
run it  
  
### the three lines of code explained:  
    CD (creates a folder to load your remote powershell script into)  
    invoke-WebRequest ... (pulls the powershell script from github)  
    ./DeployNFLDB.ps1 ... (runs the powershell script with your 6 arguments  

## Cost:  
the DB costs ~ $15/mo.. the storage is a few dollars/mo, maybe. It's pay as you go, and you can delete and reload as you want so.. try it, it'll cost a couple dollars.. and delete the resource group when you're done. It'll stop charging you..
