<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example
    .\Get-AADRiskyUsers.ps1 -filename "AAD_RiskyUsers" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '1' Risky Users
    Exporting Risk Detection array to file: 'AAD_RiskyUsers_11_03_2022.csv'

#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $fileName = 'AAD_RiskyUsers'  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -scope 'IdentityRiskyUser.Read.All'| out-null

$rawArray = Get-MgRiskyUser
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    foreach ($risk in $rawArray){
        Write-Verbose "Working on '$($risk.id)'"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            Id = $risk.id
            IsDeleted = $risk.IsDeleted
            IsProcessing = $risk.IsProcessing
            RiskDetail = $risk.RiskDetail
            RiskLastUpdatedDateTime = $risk.RiskLastUpdatedDateTime
            RiskLevel = $risk.RiskLevel
            RiskState = $risk.RiskState
            UserDisplayName = $risk.UserDisplayName
            UserPrincipalName = $risk.UserPrincipalName
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