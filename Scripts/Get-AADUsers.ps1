<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADUsers.ps1
    Connecting to MS Graph 
    Welcome To Microsoft Graph!
    Found '22' users
    Exporting Users array to file: 'AAD_Users_11_01_2022.csv'
    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Users",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'User.Read.All, Directory.Read.All' | out-null

$rawArray = Get-MgUser -All 
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Users array to file: '$filename.csv'" -ForegroundColor Yellow
    $rawArray | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}