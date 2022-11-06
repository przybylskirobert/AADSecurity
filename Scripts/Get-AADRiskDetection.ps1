<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example
    .\Get-AADRiskDetection.ps1 -filename "AAD_RiskDetection" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '1' Risk Detections
    Exporting Risk Detection array to file: 'AAD_RiskDetection_11_03_2022.csv'

#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $fileName = 'AAD_RiskDetection'  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -scope 'IdentityRiskEvent.Read.All'| out-null

$rawArray = Get-MgRiskDetection
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    foreach ($risk in $rawArray){
        Write-Verbose "Working on '$($risk.ID)'"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            Id = $risk.id
            Activity = $risk.Activity
            ActivityDateTime = $risk.ActivityDateTime
            AdditionalInfo = $risk.AdditionalInfo
            CorrelationId = $risk.CorrelationId
            DetectedDateTime = $risk.DetectedDateTime
            IPAddress = $risk.IPAddress
            LocationCity = $risk.Location.city
            CountryOrRegion = $risk.Location.CountryOrRegion
            State = $risk.Location.State
            RiskDetail = $risk.RiskDetail
            RiskEventType = $risk.RiskEventType
            RiskLevel = $risk.RiskLevel
            RiskState = $risk.RiskState
            Source = $risk.Source
            TokenIssuerType = $risk.TokenIssuerType
            UserDisplayName = $risk.UserDisplayName
            UserPrincipalName = $risk.UserPrincipalName
            UserId = $risk.UserId
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Risk Detection array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}

else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}