<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
    
    .Example
    .\Get-AADNamedLocations.ps1 -filename "AAD_RiskyUsers" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '1' Named Locations
    Exporting Risk Detection array to file: 'AAD_NamedLocations_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $fileName = 'AAD_NamedLocations'  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scope 'Policy.Read.All'| out-null

$rawArray  = Get-MgIdentityConditionalAccessNamedLocation
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green


if ($rawArray.Length -ne 0){
    foreach ($location in $rawArray ){
        Write-Verbose "Working on '$($location.ID)'"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked 
            Id = $location.id
            CreatedDateTime = $location.CreatedDateTime
            ModifiedDateTime = $location.ModifiedDateTime
            countriesAndRegions = (($location.AdditionalProperties.GetEnumerator() |ForEach-Object{$_})[1].value ) -join " | "
            includeUnknownCountriesAndRegions = ($location.AdditionalProperties.GetEnumerator() |ForEach-Object{$_})[2].value
            countryLookupMethod = ($location.AdditionalProperties.GetEnumerator() |ForEach-Object{$_})[3].value
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