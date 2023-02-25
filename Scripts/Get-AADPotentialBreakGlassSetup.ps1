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
    .\Get-AADPotentialBreakGlassSetup.ps1 -Filename "AAD_PotentialBreakGlassSetup" -OutputPath c:\temp -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_PotentialBreakGlassSetup'
    VERBOSE: DirectoryRoleId: 'b54c6a04-043c-4769-821b-86576a6bca34'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    VERBOSE: Found new entry - 'XXXX' that meets criteria for member of AAD role 'Global Administrator'
    with id 'b54c6a04-043c-4769-821b-86576a6bca34' in '' tenant
    VERBOSE: Updating BGA array
    Fount '1' entries
    Exporting entries to file: 'AAD_PotentialBreakGlassSetup_11_21_2022.csv'
    .Example
    .\Get-AADPotentialBreakGlassSetup.ps1 -Filename "AAD_PotentialBreakGlassSetup" -OutputPath c:\temp  -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Fount '1' entries
    Exporting entries to file: 'AAD_PotentialBreakGlassSetup_11_21_2022.csv'

#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_PotentialBreakGlassSetup",
    [Parameter(Position = 1)]
    [string] $OutputPath,
    [Parameter(Position = 2)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 3)]
    [string] $ApplicationId,
    [Parameter(Position = 4)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [string] $TenantDomainName,
    [Parameter(Position = 6)]
    [string] $SecretCliXMLPath,
    [Parameter(Position = 7)]
    [string] $DirectoryRoleId = 'b54c6a04-043c-4769-821b-86576a6bca34'
)

Write-Verbose "FileName: '$FileName'"
Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "SecretCliXMLPath: '$SecretCliXMLPath'"
Write-Verbose "CertificateThumbprint: '$CertificateThumbprint'"
Write-Verbose "ApplicationId: '$ApplicationId'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -CertificateThumbprint $certificateThumbprint -ClientId $ApplicationID -TenantId $TenantID | Out-Null

$users = Get-MgUser -All 
$rawArray = @()
$users | where-object { $_.UserPrincipalName -like '*onmicrosoft.com' } | foreach-object { $rawArray += $_ }
$users | where-object { $_.DisplayName -like 'admin' } | foreach-object { $rawArray += $_ }
$users | where-object { $_.DisplayName -like 'Break' } | foreach-object { $rawArray += $_ }
$users | where-object { $_.DisplayName -like 'Glass' } | foreach-object { $rawArray += $_ }

$globalAdminRole = Get-MgDirectoryRoleMember -DirectoryRoleId $DirectoryRoleId
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y

if ($null -ne $globalAdminRole) {
    $roleName = (Get-MgDirectoryRole | where-Object { $_.id -eq $DirectoryRoleId }).DisplayName
    $rawArray | foreach-object {
        $accountID = $_.id
        $accountName = $_.DisplayName
        $accountUPN = $_.UserPrincipalName
        if (($globalAdminRole.id).contains($accountID)) {
            Write-Verbose "Found new entry - '$accountName' that meets criteria for member of AAD role '$roleName' with id '$DirectoryRoleId' in '$TenandDomainName' tenant"
            $entry = New-Object PSObject -Property @{
                AccountName = $accountName
                AccountUPN  = $accountUPN
                AccountID   = $accountID
                AADRole     = $roleName
                AADRoleID   = $DirectoryRoleId
                DateChecked = $dateChecked
            }
            Write-Verbose "Updating BGA array"
            $results += $entry
        }
    }
    Write-Host "Fount '$($results.count)' entries" -ForegroundColor Yellow

}
else {
    Write-Host "No assignements found for the Azure AD Role with ID '$DirectoryRoleId'" -ForegroundColor Green
}

if ($results.Length -ne 0) {
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