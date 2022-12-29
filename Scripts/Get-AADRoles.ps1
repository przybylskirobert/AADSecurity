<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
    .Example
    .\Get-AADRoles.ps1 -Filename "AAD_Roles" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_Roles'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '13' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'SharePoint Administrator'
    VERBOSE: Working on 'Azure AD Joined Device Local Administrator'
    VERBOSE: Working on 'Intune Administrator'
    VERBOSE: Working on 'Cloud Device Administrator'
    VERBOSE: Working on 'Conditional Access Administrator'
    VERBOSE: Working on 'Authentication Administrator'
    VERBOSE: Working on 'User Administrator'
    VERBOSE: Working on 'Directory Readers'
    VERBOSE: Working on 'Global Administrator'
    VERBOSE: Working on 'Robert@mvp.azureblog.pl'
    VERBOSE: Working on 'Password Administrator'
    VERBOSE: Working on 'Security Administrator'
    VERBOSE: Working on 'Application Administrator'
    VERBOSE: Working on 'Robert@mvp.azureblog.pl'
    VERBOSE: Working on 'Directory Synchronization Accounts'
    VERBOSE: Working on 'ADToAADSyncServiceAccount@XXXX'
    Exporting entries to file: 'AAD_Roles_11_21_2022.csv'
    .Example
    .\Get-AADRoles.ps1 -Filename "AAD_Roles" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '13' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Roles_11_21_2022.csv'

#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_Roles",
    [Parameter(Position = 1)]
    [string] $OutputPath,
    [Parameter(Position = 2)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 3)]
    [string] $ApplicationId,
    [Parameter(Position = 4)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [string] $TenantDomainName
)

Write-Verbose "FileName: '$FileName'"
Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "CertificateThumbprint: '$CertificateThumbprint'"
Write-Verbose "ApplicationId: '$ApplicationId'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -CertificateThumbprint $certificateThumbprint -ClientId $ApplicationID -TenantId $TenantID | Out-Null

$rawArray = Get-MgDirectoryRole -All | Select-Object id, displayname, description, Members, ScopedMembers
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($role in $rawArray) {
        Write-Verbose "Working on '$($role.displayname)'"
        $roleId = $role.ID
        $roleName = $role.displayname
        $roleMembers = Get-MgDirectoryRoleMember -DirectoryRoleId $roleId 
        foreach ($member in $roleMembers) {
            $roleMember = Get-MgUser -UserId $member.Id
            Write-Verbose "Working on '$($roleMember.UserPrincipalName)'"
            $entry = New-Object PSObject -Property @{
                DateChecked   = $dateChecked               
                RoleMemberID  = $roleMember.Id
                RoleMemberUPN = $roleMember.UserPrincipalName
                RoleId        = $roleId
                RoleName      = $roleName
            }
            $results += $entry
        }
    }

    $date = get-date -UFormat %m_%d_%Y
    $middlePath = $FileName.Replace('_', '')
    $auditFolderTest = Test-Path  "$OutputPath\$middlePath"
    if ($auditFolderTest -eq $false) {
        New-Item -Path $OutputPath -Name $middlePath -ItemType Directory -Force | Out-Null
    }
    $fileName = $FileName + "_" + $date
    Write-Host "Exporting entries to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$middlePath\$fileName.csv"
    if ($VerbosePreference -eq "continue") {
        Write-Verbose "Results array:"
        $results
    }
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}
Disconnect-MgGraph | out-null   