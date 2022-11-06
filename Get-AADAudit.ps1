<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022

    .EXAMPLE 
    .\Get-AADAudit.ps1 -AuditPath 'c:\temp'
    Transcript started, output file is c:\temp\AAD_Audit\MVP Tenant\AAD_Audit_03_11_2022_1136.log
    ----> Running Get-AADAccessReviews script  <-----
    Connecting to MS Graph
    Found '8' Access Reviews
    Exporting Access Reviews to file: 'AAD_AccessReviews_11_03_2022.csv'
    ----> Running Get-AADAdminConsent script  <-----
    Connecting to MS Graph
    Found '1' Admin Consent
    Exporting Admin Consent to file: 'AAD_AdminConsent_11_03_2022.csv'
    ----> Running Get-AADAdministrativeUnits script  <-----
    Connecting to MS Graph
    Found '2' Administrative Units
    Exporting Administrative Units to file: 'AAD_AdministrativeUnits_11_03_2022.csv'
    ----> Running Get-AADApplications script  <-----
    Connecting to MS Graph 
    Found '6' applications
    Exporting Applications array to file: 'AAD_Applications_11_03_2022.csv'
    ----> Running Get-AADAuthenticationMethods script  <-----
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Found '5' Authentication methods
    Exporting Authentication Methods array to file: 'AAD_AuthenticationMethods_11_03_2022.csv'
    ----> Running Get-AADDevices script  <-----
    Connecting to MS Graph 
    Found '10' devices
    Exporting devices array to file: 'AAD_Devices_11_03_2022.csv'
    ----> Running Get-AADDomains script  <-----
    Connecting to MS Graph 
    Found '3' Domains
    Exporting Domains to file: 'AAD_Domains_11_03_2022.csv'
    ----> Running Get-AADGroups script  <-----
    Connecting to MS Graph 
    Found '16' groups
    Exporting Groups array to file: 'AAD_Groups_11_03_2022.csv'
    ----> Running Get-AADNamedLocations script  <-----
    Connecting to MS Graph 
    Found '1' Names Locations
    Exporting Risk Detection array to file: 'AAD_NamedLocations_11_03_2022.csv'
    ----> Running Get-AADRiskDetection script  <-----
    Connecting to MS Graph 
    Found '1' Risk Detections
    Exporting Risk Detection array to file: 'AAD_RiskDetection_11_03_2022.csv'
    ----> Running Get-AADRiskyUsers script  <-----
    Connecting to MS Graph 
    Found '1' Risky Users
    Exporting Risk Detection array to file: 'AAD_RiskyUsers_11_03_2022.csv'
    ----> Running Get-AADRoles script  <-----
    Connecting to MS Graph 
    Found '13' Roles in use
    Exporting Roles to file: 'AAD_Roles_11_03_2022.csv'
    ----> Running Get-AADSecureScore script  <-----
    Connecting to MS Graph
    Exporting Risk Detection array to file: 'AAD_SecureScore_11_03_2022.csv'
    ----> Running Get-AADServicePrincipals script  <-----
    Connecting to MS Graph
    Found '100' service principals
    Exporting Service Principals array to file: 'AAD_ServicePrincipals_11_03_2022.csv'
    ----> Running Get-AADTermsOfUse script  <-----
    Connecting to MS Graph
    Found '1' Terms Of Use
    No entries found, no file to be created.
    ----> Running Get-AADUsers script  <-----
    Connecting to MS Graph
    Found '19' users
    Exporting Users array to file: 'AAD_Users_11_03_2022.csv'
    ----> Running Get-CAPolicySetup script  <-----
    Connecting to MS Graph
    Found '7' CA Polices
    Working on '[ZeroTrust] Require ToU for external users' policy
    Working on '[ZeroTrust] Block legacy authentication methods' policy
    Working on '[ZeroTrust] Device Assurance Win10 - Compliance State' policy
    Working on '[ZeroTrust] Microsoft Cloud App Security - monitroing & blocking actions' policy
    Working on 'External Users and Guests - MVP AzureBlog Terms of use' policy
    Working on 'Block Countires' policy
    Working on 'test' policy
    Exporting CA Policies array to file: 'AAD_ConditionalAccessPolicySetup_11_03_2022.csv'
    ----> Running Get-CloudBGA script  <-----
    Connecting to MS Graph
    Found new entry - 'Robert Przybylski [BG]' that meets criteria for member of AAD role 'Global Administrator' with id 'b54c6a04-043c-4769-821b-86576a6bca34'
    Updating BGA array
    Exporting BGA array to file: 'AAD_PotentialBreakGlassSetup_11_03_2022.csv'
    Transcript stopped, output file is C:\temp\AAD_Audit\MVP Tenant\AAD_Audit_03_11_2022_1136.log
#>

[CmdletBinding()] 
param (
    [Parameter(Position = 0, mandatory = $true)]
    [string] $AuditPath,
    [switch] $IncludeRAW
)

$version = '1.0'

#region initial setup
try {
    Stop-Transcript
}
catch {

}
$auditFolderTest = Test-Path $AuditPath
if ($auditFolderTest -eq $false) {
    New-Item -Path $AuditPath -Name AAD_Audit -ItemType Directory -Force | Out-Null
}

try {
    Get-AZTenant | out-null
}
catch {
    Login-AzAccount | out-null
}
$tenantName = (Get-AZTenant).name
$tenantAuditPath = "$AuditPath\AAD_Audit\$tenantName"
$tenantFolderTest = Test-Path $tenantAuditPath
if ($tenantFolderTest -eq $false) {
    New-Item -path "$AuditPath\AAD_Audit" -Name $tenantName -ItemType Directory -Force | Out-Null
}

$oldLocation = Get-Location

#endregion 

#region transcript
$date = Get-Date -Format "dd_MM_yyyy_HHmm"
$transcriptPath = "$tenantAuditPath\AAD_Audit_$($date).log"
Start-Transcript -Path $transcriptPath
#endregion

#region Audit Scripts run

Write-Host ""
Write-Host "###############################################" -ForegroundColor Blue
Write-Host "#          "  -ForegroundColor Blue -NoNewline
Write-Host "Starging DATA Collection" -NoNewline
Write-Host "           #" -ForegroundColor Blue
Write-Host "# "  -ForegroundColor Blue -NoNewline
Write-Host "Scripts Version: " -NoNewline
Write-Host "$version                        #" -ForegroundColor Blue
Write-Host "###############################################" -ForegroundColor Blue
Write-Host ""

$scripts = Get-ChildItem -Path .\Scripts\ -File
foreach ($entry in $scripts) {
    $fileName = $entry.Name
    $fileNameClean = [io.path]::GetFileNameWithoutExtension($fileName)
    write-Host "----> Running $fileNameClean script" -ForegroundColor Blue
    . .\Scripts\$fileName -OutputPath $tenantAuditPath

}
#end region

if ($IncludeRAW) {
    $rawPath = "$tenantAuditPath\RAW"
    $rawTest = test-path $rawPath
    if ($rawTest -eq $false ) {
        New-Item -path "$tenantAuditPath" -Name RAW -ItemType Directory -Force | Out-Null
    }
    write-Host "----> Collecting RAW data in json files." -ForegroundColor Blue
    . .\Get-AADRawData.ps1 -OutputPath $rawPath -CliXMLPath .\secret.xml -ApplicationID 'e9a10830-1903-4b00-8229-3cc716ea2e67' -TenatDomainName 'mvp.azureblog.pl'
}

Stop-Transcript
Set-Location $oldLocation