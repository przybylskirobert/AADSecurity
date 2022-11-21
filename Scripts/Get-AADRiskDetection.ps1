<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example
    .\Get-AADRiskDetection.ps1 -Filename "AAD_RiskDetection" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_RiskDetection'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_RiskDetection_11_21_2022.csv'
    .Example
    .\Get-AADRiskDetection.ps1 -Filename "AAD_RiskDetection" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_RiskDetection_11_21_2022.csv'

#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $FileName = 'AAD_RiskDetection',
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

$rawArray = Get-MgRiskDetection
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($risk in $rawArray) {
        Write-Verbose "Working on '$($risk.ID)'"
        $entry = New-Object PSObject -Property @{
            DateChecked       = $dateChecked
            Id                = $risk.id
            Activity          = $risk.Activity
            ActivityDateTime  = $risk.ActivityDateTime
            AdditionalInfo    = $risk.AdditionalInfo
            CorrelationId     = $risk.CorrelationId
            DetectedDateTime  = $risk.DetectedDateTime
            IPAddress         = $risk.IPAddress
            LocationCity      = $risk.Location.city
            CountryOrRegion   = $risk.Location.CountryOrRegion
            State             = $risk.Location.State
            RiskDetail        = $risk.RiskDetail
            RiskEventType     = $risk.RiskEventType
            RiskLevel         = $risk.RiskLevel
            RiskState         = $risk.RiskState
            Source            = $risk.Source
            TokenIssuerType   = $risk.TokenIssuerType
            UserDisplayName   = $risk.UserDisplayName
            UserPrincipalName = $risk.UserPrincipalName
            UserId            = $risk.UserId
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