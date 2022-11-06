<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADServicePrincipals.ps1 -filename "AAD_ServicePrincipals" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '100' service principals
    Exporting Service Principals array to file: 'AAD_ServicePrincipals_11_01_2022.csv'    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_ServicePrincipals",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Application.Read.All, Directory.Read.All' | out-null

$rawArray = Get-MgServicePrincipal | Select-Object ID, DisplayName, AppID, SigninAudience, PublisherName, ServicePrincipalType
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($spn in $rawArray) {
        Write-Verbose "Working on '$($spn.id)'"
        $entry = New-Object PSObject -Property @{
            DateChecked          = $dateChecked
            Id                   = $spn.id
            DisplayName          = $spn.DisplayName
            AppID                = $spn.AppID
            SigninAudience       = $spn.SigninAudience
            PublisherName        = $spn.PublisherName
            ServicePrincipalType = $spn.ServicePrincipalType
        }
        $results += $entry
    }

    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Service Principals array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}