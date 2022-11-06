<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis   
   
    .Example
    .\Get-AADAuthenticationMethods.ps1 -fileName AAD_AuthenticationMethods -OutputPath c:\temp -CliXMLPath CliXMLPath -ApplicationID ApplicationID -TenatDomainName TenatDomainName -Uri Uri
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Found '5' Authentication methods
    Exporting Authentication Methods array to file: 'AAD_AuthenticationMethods_11_03_2022.csv'
    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_AuthenticationMethods",
    [Parameter(Position = 1)]
    [string] $OutputPath,      
    [Parameter(Position = 2)]
    [string] $CliXMLPath,
    [Parameter(Position = 3)]
    [string] $ApplicationID,
    [Parameter(Position = 4)]
    [string] $TenatDomainName,
    [Parameter(Position = 5)]
    [string] $Uri = 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
)

try {
    Get-AZTenant |out-null
}
catch {
    Login-AzAccount |out-null
}
#Region Connection
$Body = @{    
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $applicationID
    Client_Secret = (Import-CliXml -Path  $CliXMLPath).GetNetworkCredential().Password
} 

$connectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenatDomainName/oauth2/v2.0/token" -Method POST -Body $Body -ContentType 'application/x-www-form-urlencoded'

$authHeader = @{
    'Authorization' = "Bearer $($connectGraph.access_token)"
}
#endregion

Write-Host "Working on URI '$Uri'" -ForegroundColor Yellow
$rawData = Invoke-RestMethod -Headers $authHeader -Uri $Uri -Method get

$results = @()
$authenticationMethods = $rawData.authenticationMethodConfigurations
$dateChecked = get-date -UFormat %m/%d/%Y

foreach ($method in $authenticationMethods ){
    Write-Verbose "Working on '$($method.ID)'"
    $entry = New-Object PSObject -Property @{
        DateChecked = $dateChecked
        ID = $method.ID
        Staste = $method.State
    }
    $results += $entry
}

Write-Host "Found '$($results.Count)' entries" -ForegroundColor Green
if ($results.Length -ne 0){
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Authentication Methods array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}