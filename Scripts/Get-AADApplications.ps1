<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADApplications.ps1 -Filename "AAD_Applications" -OutPath c:\temp
    Connecting to MS Graph 
    Found '6' applications
    Exporting Applications array to file: 'AAD_Applications_11_03_2022.csv'
    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Applications",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Application.Read.All, Application.ReadWrite.All, Directory.Read.All' | out-null

$rawArray = Get-MgApplication | Select-Object ID, DisplayName, AppID, SignInAudience, PublisherDomain, CreatedDateTime, CreatedOnBehalfOf, PasswordCredentials
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($application in $rawArray) {
        Write-Verbose "Working on '$($application.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked        = $dateChecked
            ID                 = $application.ID
            DisplayName        = $application.DisplayName
            AppID              = $application.AppID
            SignInAudience    = $application.SignInAudience
            PublisherDomain    = $application.PublisherDomain
            CreatedDateTime    = $application.CreatedDateTime
            CreatedOnBehalfOf  = $application.CreatedOnBehalfOf
            PasswordCredential = $application.PasswordCredential
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Applications array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}