<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example

    .Example
    .\Get-AADTermsOfUse.ps1 -filename AAD_TermsOfUse -OutputPath c:\temp
    Connecting to MS Graph
    Found '1' Terms Of Use
    Exporting Terms of Use array to file: 'AAD_TermsOfUse_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $fileName = 'AAD_TermsOfUse'  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Agreement.Read.All' | out-null

$rawArray = Get-MgIdentityGovernanceTermOfUseAgreement
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green


if ($rawArray.Length -ne 0){
    foreach ($term in $rawArray){
        Write-Verbose "Working on '$($term.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            DisplayName = $term.DisplayName
            IsPerDeviceAcceptanceRequired = $term.IsPerDeviceAcceptanceRequired
            IsViewingBeforeAcceptanceRequired = $term.IsViewingBeforeAcceptanceRequired
            UserReacceptRequiredFrequency = $term.UserReacceptRequiredFrequency
            TermsExpiration = $term.TermsExpiration.StartDateTime
            EnabledServices = $term.EnabledServices -join " | "
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