<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADDomains.ps1 -Filename "AAD_Domains" -OutputPath c:\temp -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_Domains'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '3' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'mvp.azureblog.pl'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_Domains_11_21_2022.csv'    
    .Example
    .\Get-AADDomains.ps1 -Filename "AAD_Domains" -OutputPath c:\temp -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '3' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Domains_11_21_2022.csv'    

#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_Domains",
    [Parameter(Position = 1)]
    [string] $OutputPath,
    [Parameter(Position = 2)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 3)]
    [string] $ApplicationId,
    [Parameter(Position = 4)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [string] $TenantDomainName,
    [Parameter(Position = 6)]
    [string] $SecretCliXMLPath
)

Write-Verbose "FileName: '$FileName'"
Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "SecretCliXMLPath: '$SecretCliXMLPath'"
Write-Verbose "CertificateThumbprint: '$CertificateThumbprint'"
Write-Verbose "ApplicationId: '$ApplicationId'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -CertificateThumbprint $certificateThumbprint -ClientId $ApplicationID -TenantId $TenantID | Out-Null

$rawArray = Get-MgDomain | Select-Object ID, AuthenticationType, AvailabilityStatus, IsAdminManaged, IsDefault, IsRoot, IsVerified, Manufacturer, Model, PasswordNotificationWindowInDays
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($domain in $rawArray) {
        Write-Verbose "Working on '$($domain.id)'"
        $entry = New-Object PSObject -Property @{
            DateChecked                      = $dateChecked
            ID                               = $domain.Id
            AuthenticationType               = $domain.AuthenticationType
            AvailabilityStatus               = $domain.AvailabilityStatus
            IsAdminManaged                   = $domain.IsAdminManaged
            IsDefault                        = $domain.IsDefault
            IsRoot                           = $domain.IsRoot
            IsVerified                       = $domain.IsVerified
            Manufacturer                     = $domain.Manufacturer
            Model                            = $domain.Model
            PasswordNotificationWindowInDays = $domain.PasswordNotificationWindowInDays
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
    if ($VerbosePreference -eq "continue") {
        Write-Verbose "Results array:"
        $results
    }
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}
Disconnect-MgGraph | out-null   