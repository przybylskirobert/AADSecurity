<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADDomains.ps1 -filename "AAD_Domains" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '3' Domains
    Exporting Domains to file: 'AAD_Domains_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Domains",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Domain.Read.All, Directory.Read.All' | out-null

$rawArray = Get-MgDomain | Select-Object ID, AuthenticationType, AvailabilityStatus, IsAdminManaged, IsDefault, IsRoot, IsVerified, Manufacturer, Model, PasswordNotificationWindowInDays
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green


if ($rawArray.Length -ne 0) {
    foreach ($domain in $rawArray) {
        Write-Verbose "Working on '$($domain.id)'"
        $entry = New-Object PSObject -Property @{
            DateChecked                      = $dateChecked
            ID                               = $domain.Id
            AuthenticationType               = $domain.AuthenticationType
            AvailabilityStatus               = $domain.AvailabilityStatus
            IsAdminManaged                   = $domain.IsAdminManaged
            IsDefault                        = $domain.IsDefault
            IsRoot                           = $domain.IsRoot
            IsVerified                       = $domain.IsVerified
            Manufacturer                     = $domain.Manufacturer
            Model                            = $domain.Model
            PasswordNotificationWindowInDays = $domain.PasswordNotificationWindowInDays
        }
        $results += $entry
    }

    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Domains to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}