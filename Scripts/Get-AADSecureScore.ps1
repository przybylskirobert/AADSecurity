<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example
    .\Get-AADSecureScore.ps1 -filename "AAD_SecureScore" -OutputPath c:\temp
    Connecting to MS Graph
    Exporting Risk Detection array to file: 'AAD_SecureScore_11_03_2022.csv'    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $fileName = 'AAD_SecureScore'  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -scope 'SecurityEvents.Read.All'| out-null

$rawArray = Get-MgSecuritySecureScore -Top 1 
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    foreach ($entry in $rawArray){
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            ActiveUserCount = $entry.ActiveUserCount
            LicensedUserCount = $entry.LicensedUserCount
            CurrentScore = $entry.CurrentScore
            MaxScore = $entry.MaxScore
            EnabledServices = ($entry.EnabledServices -join " | ")
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