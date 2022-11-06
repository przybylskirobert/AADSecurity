<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADAdministrative Units.ps1 -Filename "AAD_Administrative Units" -OutPath c:\temp
    Connecting to MS Graph
    Found '2' Administrative Units
    Exporting Administrative Units to file: 'AAD_AdministrativeUnits_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_AdministrativeUnits",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'AdministrativeUnit.Read.All, Directory.Read.All' | out-null

$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
$rawArray = Get-MgDirectoryAdministrativeUnit -All 
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($unit in $rawArray) {
        Write-Verbose " Working on '$($unit.DisplayName)' Admnistrative Unit"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            ID          = $unit.id
            DisplayName = $unit.DisplayName
            Members = $unit.Members -join " | "
            ScopeRoleMembers = $unit.ScopeRoleMembers -join " | "
            Visibility = $unit.Visibility
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Administrative Units to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}