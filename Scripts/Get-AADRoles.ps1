<#
    .Synopsis
     
    .Example
    .\Get-AADRoles.ps1 -filename "AAD_Roles" -OutputPath c:\temp
    Connecting to MS Graph 
    Found '13' Roles in use
    Exporting Roles to file: 'AAD_Roles_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Roles",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'RoleManagement.Read.Directory, Directory.Read.All' | out-null

$rawArray = Get-MgDirectoryRole -All | Select-Object id, displayname, description,Members,ScopedMembers
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    foreach ($role in $rawArray){
        Write-Verbose "Working on '$($role.displayname)'"
        $roleId = $role.ID
        $roleName = $role.displayname
        $roleMembers = Get-MgDirectoryRoleMember -DirectoryRoleId $roleId 
        foreach ($member in $roleMembers){
            $roleMember = Get-MgUser -UserId $member.Id
            Write-Verbose "Working on '$($roleMember.UserPrincipalName)'"
            $entry = New-Object PSObject -Property @{
                DateChecked = $dateChecked               
                RoleMemberID = $roleMember.Id
                RoleMemberUPN = $roleMember.UserPrincipalName
                RoleId = $roleId
                RoleName = $roleName
            }
            $results += $entry
        }
    }

    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Roles to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}