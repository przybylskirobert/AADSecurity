<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    
    .Synopsis
   
    .Example
    .\Get-AADGroups.ps1 -Filename "AAD_Groups" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_Groups'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '16' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'AAD DC Administrators'
    VERBOSE: Working on 'Microsoft 365 E5 Developer (without Windows and Audio Conferencing)'
    VERBOSE: Working on 'Privileged_users'
    VERBOSE: Working on 'Azure ATP mvpazureblog Users'
    VERBOSE: Working on 'Subscription_contributors'
    VERBOSE: Working on 'Passwordless'
    VERBOSE: Working on 'External_Collaboration'
    VERBOSE: Working on 'MVP Tenant'
    VERBOSE: Working on 'Collaboration_with_partners'
    VERBOSE: Working on 'Azure ATP mvpazureblog Viewers'
    VERBOSE: Working on 'Azure ATP mvpazureblog Administrators'
    VERBOSE: Working on 'Subscription_Owners'
    VERBOSE: Working on 'Sponsored_Subscription_Owners'
    VERBOSE: Working on 'ZeroTrust'
    VERBOSE: Working on 'Catalog_Creators'
    VERBOSE: Working on 'Sponsored_Subscription_contributors'
    Exporting entries to file: 'AAD_Groups_11_21_2022.csv'
    .Example
    .\Get-AADGroups.ps1 -Filename "AAD_Groups" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '16' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Groups_11_21_2022.csv'

#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_Groups",
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

$rawArray = Get-MgGroup -All
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

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