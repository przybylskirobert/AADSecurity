<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
    .Example
    .\Get-AADUsers.ps1 -Filename "AAD_Users" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_Users'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '19' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'On-Premises Directory Synchronization Service Account'
    VERBOSE: Working on 'Agnieszka'
    VERBOSE: Working on 'BlackPanter'
    VERBOSE: Working on 'Black Widow'
    VERBOSE: Working on 'Bruce Banner'
    VERBOSE: Working on 'Capitan America'
    VERBOSE: Working on 'Drax'
    VERBOSE: Working on 'Im Groot'
    VERBOSE: Working on 'Justin Case'
    VERBOSE: Working on 'Loki'
    VERBOSE: Working on 'PasswordLessTester'
    VERBOSE: Working on 'Robert'
    VERBOSE: Working on 'Rocket Raccoon'
    VERBOSE: Working on 'Robert Przybylski'
    VERBOSE: Working on 'Robert Przybylski [BG]'
    VERBOSE: Working on 'Test User 1'
    VERBOSE: Working on 'Test User 2'
    VERBOSE: Working on 'Test User 3'
    Exporting entries to file: 'AAD_Users_11_21_2022.csv'
    .Example
    .\Get-AADUsers.ps1 -Filename "AAD_Users" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '19' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Users_11_21_2022.csv'
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_Users",
    [Parameter(Position = 1)]
    [string] $OutputPath,
    [Parameter(Position = 2)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 3)]
    [string] $ApplicationId,
    [Parameter(Position = 4)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [string] $TenantDomainName
)

Write-Verbose "FileName: '$FileName'"
Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "CertificateThumbprint: '$CertificateThumbprint'"
Write-Verbose "ApplicationId: '$ApplicationId'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -CertificateThumbprint $certificateThumbprint -ClientId $ApplicationID -TenantId $TenantID | Out-Null

$rawArray = Get-MgUser -All 
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($user in $rawArray) {
        Write-Verbose "Working on '$($user.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            Id                = $user.Id
            DateChecked       = $dateChecked
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
            UserType          = $user.UserType
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $middlePath = $FileName.Replace('_', '')
    $auditFolderTest = Test-Path  "$OutputPath\$middlePath"
    if ($auditFolderTest -eq $false) {
        New-Item -Path $OutputPath -Name $middlePath -ItemType Directory -Force | Out-Null
    }
    $fileName = $FileName + "_" + $date
    Write-Host "Exporting entries to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$middlePath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}
Disconnect-MgGraph | out-null   