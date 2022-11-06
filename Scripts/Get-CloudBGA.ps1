<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
    ID 'b54c6a04-043c-4769-821b-86576a6bca34' is a Global Administrator role ID.
    ID 'c46dce14-3cf8-4727-96d2-7040604037e0' is a Security Administrator role ID.
    
    .Example
    .\Get-CloudBGA.ps1 -DirectoryRoleId 'b54c6a04-043c-4769-821b-86576a6bca34' -fileName 'Potential_BGA_list'    
    Connecting to MS Graph - 'User.Read.All'
    Found new entry - 'Robert Przybylski [BG]' that meets criteria for member of AAD role 'Global Administrator' with id 'b54c6a04-043c-4769-821b-86576a6bca34'
    Updating BGA array
    Exporting BGA array to file: 'Potential_BGA_list'

    .Example
    .\Get-CloudBGA.ps1 -DirectoryRoleId 'c46dce14-3cf8-4727-96d2-7040604037e0' -fileName 'Potential_BGA_list'
    Connecting to MS Graph - 'User.Read.All'
    No assignements found for the Azure AD Role with ID 'c46dce14-3cf8-4727-96d2-7040604037e0'
    No entries found, no file to be created.

#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $DirectoryRoleId = 'b54c6a04-043c-4769-821b-86576a6bca34',
    [Parameter(Position = 1)]
    [string] $fileName = "AAD_PotentialBreakGlassSetup",
    [Parameter(Position = 2)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'User.Read.All' | out-null

$users = Get-MgUser -All 
$rawArray = @()
$users | where-object {$_.UserPrincipalName -like '*onmicrosoft.com'} | foreach-object {$rawArray += $_}
$users | where-object {$_.DisplayName -like 'admin'} | foreach-object {$rawArray += $_}
$users | where-object {$_.DisplayName -like 'Break'} | foreach-object {$rawArray += $_}
$users | where-object {$_.DisplayName -like 'Glass'} | foreach-object {$rawArray += $_}

$globalAdminRole = Get-MgDirectoryRoleMember -DirectoryRoleId $DirectoryRoleId
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y

if ($null -ne $globalAdminRole) {
    $roleName = (Get-MgDirectoryRole | where-Object {$_.id -eq $DirectoryRoleId}).DisplayName
    $rawArray | foreach-object {
        $accountID = $_.id
        $accountName = $_.DisplayName
        $accountUPN = $_.UserPrincipalName
        if (($globalAdminRole.id).contains($accountID)){
            Write-Verbose "Found new entry - '$accountName' that meets criteria for member of AAD role '$roleName' with id '$DirectoryRoleId'"
            $entry = New-Object PSObject -Property @{
                AccountName = $accountName
                AccountUPN = $accountUPN
                AccountID = $accountID
                AADRole = $roleName
                AADRoleID = $DirectoryRoleId
                DateChecked = $dateChecked
            }
            Write-Verbose "Updating BGA array"
            $results += $entry
        }
    }
    Write-Host "Fount '$($results.count)' entries" -ForegroundColor Yellow

}
else{
    Write-Host "No assignements found for the Azure AD Role with ID '$DirectoryRoleId'" -ForegroundColor Green
}

if ($results.Length -ne 0){
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting BGA array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}