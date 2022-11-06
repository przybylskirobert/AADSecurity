<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
   
    .Example
    .\Get-AADAdminConsent.ps1 -Filename "AAD_AdminConsent" -OutPath c:\temp
    Connecting to MS Graph
    Found '1' Admin Consent
    Exporting Admin Consent to file: 'AAD_AdminConsent_11_03_2022.csv'   
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_AdminConsent",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Policy.Read.All, Directory.Read.All' | out-null

$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
$rawArray = Get-MgPolicyAdminConsentRequestPolicy
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    $entry = New-Object PSObject -Property @{
        DateChecked           = $dateChecked
        ID                    = $rawArray.id
        IsEnabled             = $rawArray.IsEnabled
        NotifyReviewers       = $rawArray.NotifyReviewers
        RemindersEnabled      = $rawArray.RemindersEnabled
        RequestDurationInDays = $rawArray.RequestDurationInDays
        Version               = $rawArray.Version
        Reviewers             = $rawArray.Reviewers.query -join " | "
    }   
    $results += $entry 
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Admin Consent to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}