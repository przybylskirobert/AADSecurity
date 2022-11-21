<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADAdministrativeUnits.ps1 -Filename "AAD_AdministrativeUnits" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_AdministrativeUnits'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '2' entries
    VERBOSE:  Working on 'TEST' Admnistrative Unit
    VERBOSE:  Working on 'SSS' Admnistrative Unit
    Exporting entries to file: 'AAD_AdministrativeUnits_11_21_2022.csv'
    
    .Example
    .\Get-AADAdministrativeUnits.ps1 -Filename "AAD_AdministrativeUnits" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '2' entries
    Exporting entries to file: 'AAD_AdministrativeUnits_11_21_2022.csv'

    #>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_AdministrativeUnits",
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

$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
$rawArray = Get-MgDirectoryAdministrativeUnit -All 
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($unit in $rawArray) {
        Write-Verbose " Working on '$($unit.DisplayName)' Admnistrative Unit"
        $entry = New-Object PSObject -Property @{
            DateChecked      = $dateChecked
            ID               = $unit.id
            DisplayName      = $unit.DisplayName
            Members          = $unit.Members -join " | "
            ScopeRoleMembers = $unit.ScopeRoleMembers -join " | "
            Visibility       = $unit.Visibility
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