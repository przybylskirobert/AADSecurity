<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    
    .Synopsis
   
    .Example
    .\Get-AADGroups.ps1 -filename "AAD_Groups" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '16' groups
    Exporting Groups array to file: 'AAD_Groups_11_03_2022.csv'
    
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Groups",
    [Parameter(Position = 1)]
    [string] $OutputPath
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'GroupMember.Read.All, Group.Read.All, Directory.Read.All' | out-null

$rawArray = Get-MgGroup -All
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($group in $rawArray) {
        Write-Verbose "Working on '$($group.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked     = $dateChecked
            ID              = $group.Id
            DisplayName     = $group.DisplayName
            MailEnabled     = $group.MailEnabled
            SecurityEnabled = $group.SecurityEnabled
            MemberOf        = $group.MemberOf -join " | "
            Members         = $group.members -join " | "
        }
        $results += $entry
    }

    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Groups array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}