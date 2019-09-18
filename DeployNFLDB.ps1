$ResourceGroupName= $args[0]
$Location= $args[1]
$SQLServername=     $args[2]
$SQLPassword=   $args[3]
$StorageAcctName=   $args[4]
$FunctionAppName=   $args[5]


#TODO Add deployment JSON code here
az group create --name $ResourceGroupName --location $Location
az group deployment create --name NFLDBDeployment --resource-group $ResourceGroupName  --template-uri "https://raw.githubusercontent.com/ml-systems/nfldb/master/mlsystemsnfldbtemplate.json"  --parameters dbserver_name=$SQLServername FunctionApp_name=$FunctionAppName storageAccount_name=$StorageAcctName dbpassword=$SQLPassword

#Download Powershell Script file and execute (this can be changed to github)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ml-systems/nfldb/master/script.sql" -OutFile "script.sql"

Write-Output "Downloaded NFLDB Schema"
Write-Output "Deploying NFLDB Schema to nfldb"

Invoke-Sqlcmd -ServerInstance "$SQLServername.database.windows.net" -Username dbadmin -Password $SQLPassword -Database nfldb -InputFile "script.sql"  -QueryTimeout 65535 -ConnectionTimeout 60 -Verbose

Write-Output "NFLDB Schema Deployment Completed"

Invoke-Sqlcmd -ServerInstance "$SQLServername.database.windows.net" -Username dbadmin -Password $SQLPassword -Database nfldb -Query "exec Deploy.InitiateNFLDB"  -QueryTimeout 65535 -ConnectionTimeout 60 -Verbose

Write-Output "$SQLDBName Initiated"

Invoke-Sqlcmd -ServerInstance "$SQLServername.database.windows.net" -Username dbadmin -Password $SQLPassword -Database nfldb -Query "CREATE EXTERNAL DATA SOURCE nflgenstorage WITH ( TYPE = BLOB_STORAGE,LOCATION = 'https://$($StorageAcctName).blob.core.windows.net')"  -QueryTimeout 65535 -ConnectionTimeout 60 -Verbose

Write-Output "Blob Storage Path Added to nfldb"


#Load 2019 Schedule ? 

Start-AzureRmLogicApp -ResourceGroupName "$ResourceGroupName" -Name "LoadNFLSchedule" -TriggerName "Recurrence"
