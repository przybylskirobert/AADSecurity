<#
.NOTES
All rigts reserved to 
Robert Przybylski 
www.azureblog.pl 
robert(at)azureblog.pl
2022
.Synopsis

.Example
.\Get-AADCAPolicySetup.ps1 -Filename "AAD_ConditionalAccessPolicySetup" -OutputPath c:\temp -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
VERBOSE: FileName: 'AAD_ConditionalAccessPolicySetup'
VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
VERBOSE: CertificateThumbprint: 'XXXX'
VERBOSE: ApplicationId: 'XXXX'
VERBOSE: TenantID: 'XXXX'
VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
Connecting to MS Graph
Found '7' entries under 'mvp.azureblog.pl' tenant
VERBOSE: Working on '[ZeroTrust] Require ToU for external users' policy
VERBOSE: Working on '[ZeroTrust] Block legacy authentication methods' policy
VERBOSE: Working on '[ZeroTrust] Device Assurance Win10 - Compliance State' policy
VERBOSE: Working on '[ZeroTrust] Microsoft Cloud App Security - monitroing & blocking actions' policy
VERBOSE: Working on 'External ConditionalAccessPolicySetup and Guests - MVP AzureBlog Terms of use' policy
VERBOSE: Working on 'Block Countires' policy
VERBOSE: Working on 'test' policy
Exporting entries to file: 'AAD_ConditionalAccessPolicySetup_11_21_2022.csv'
.Example
.\Get-AADCAPolicySetup.ps1 -Filename "AAD_ConditionalAccessPolicySetup" -OutputPath c:\temp -SecretCliXMLPath "XXX" -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
Connecting to MS Graph
Found '7' entries under 'mvp.azureblog.pl' tenant
Exporting entries to file: 'AAD_ConditionalAccessPolicySetup_11_21_2022.csv'
#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = 'AAD_ConditionalAccessPolicySetup',
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
    [string] $SecretCliXMLPath
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

$rawArray = Get-MgIdentityConditionalAccessPolicy -All
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($policy in $rawArray) {
        Write-Verbose "Working on '$( $policy.DisplayName)' policy"
        $entry = New-Object PSObject -Property @{
            DateChecked                                                                    = $dateChecked
            PolicyName                                                                     = $policy.DisplayName
            PolicyDescription                                                              = $policy.Description
            PolicyID                                                                       = $policy.Id
            PolicyCreationDate                                                             = $policy.CreatedDateTime
            PolicyState                                                                    = $policy.State
            PolicyModificationDate                                                         = $policy.ModifiedDateTime
            PolicyConditionApplicationsExcluded                                            = $policy.Conditions.Applications.ExcludeApplications -join " | "
            PolicyConditionApplicationsIncluded                                            = $policy.Conditions.Applications.IncludeApplications -join " | "
            PolicyConditionApplicationsIncludeAuthenticationContextClassReferences         = $policy.Conditions.Applications.IncludeAuthenticationContextClassReferences -join " | "
            PolicyConditionApplicationsIncludeUserActions                                  = $policy.Conditions.Applications.IncludeUserActions -join " | "
            PolicyConditionClientAppTypes                                                  = $policy.Conditions.ClientAppTypes -join " | "
            PolicyConditionClientApplicationsExcludeServicePrincipals                      = $policy.Conditions.ClientApplications.ExcludeServicePrincipals -join " | "
            PolicyConditionClientApplicationsIncludeServicePrincipals                      = $policy.Conditions.ClientApplications.IncludeServicePrincipals -join " | "
            PolicyConditionDevicesDeviceFilterMode                                         = $policy.Conditions.Devices.DeviceFilter.Mode -join " | "
            PolicyConditionDevicesDeviceFilterRule                                         = $policy.Conditions.Devices.DeviceFilter.Rule -join " | "
            PolicyConditionLocationsIncluded                                               = $policy.Conditions.locations.IncludeLocations -join " | "
            PolicyConditionLocationsExcluded                                               = $policy.Conditions.Locations.ExcludeLocations -join " | "
            PolicyConditionPlatformsIncluded                                               = $policy.Conditions.Platforms.IncludePlatforms -join " | "
            PolicyConditionPlatformsExcluded                                               = $policy.Conditions.Platforms.ExcludePlatforms -join " | "
            PolicyConditionSignInRiskLevels                                                = $policy.Conditions.SignInRiskLevels -join " | "
            PolicyConditionUserRiskLevels                                                  = $policy.Conditions.UserRiskLevels -join " | "
            PolicyConditionConditionalAccessPolicySetupExcludeGroups                       = $policy.Conditions.ConditionalAccessPolicySetup.ExcludeGroups -join " | "
            PolicyConditionConditionalAccessPolicySetupExcludeRoles                        = $policy.Conditions.ConditionalAccessPolicySetup.ExcludeRoles -join " | "
            PolicyConditionConditionalAccessPolicySetupExcludeConditionalAccessPolicySetup = $policy.Conditions.ConditionalAccessPolicySetup.ExcludeConditionalAccessPolicySetup -join " | "
            PolicyConditionConditionalAccessPolicySetupIncludeGroups                       = $policy.Conditions.ConditionalAccessPolicySetup.IncludeGroups -join " | "
            PolicyConditionConditionalAccessPolicySetupIncludeRoles                        = $policy.Conditions.ConditionalAccessPolicySetup.IncludeRoles -join " | "
            PolicyConditionConditionalAccessPolicySetupIncludeConditionalAccessPolicySetup = $policy.Conditions.ConditionalAccessPolicySetup.IncludeConditionalAccessPolicySetup -join " | "
            PolicyGrantControlsBuiltInControls                                             = $policy.GrantControls.BuiltInControls -join " | "
            PolicyGrantControlsCustomAuthenticationFactors                                 = $policy.GrantControls.CustomAuthenticationFactors -join " | "
            PolicyGrantControlsOperator                                                    = $policy.GrantControls.Operator -join " | "
            PolicyGrantControlsTermsOfUse                                                  = $policy.GrantControls.TermsOfUse -join " | "
            PolicySessionControlsApplicationEnforcedRestrictionsEnabled                    = $policy.SessionControls.ApplicationEnforcedRestrictions.IsEnabled -join " | "
            PolicySessionControlsCloudAppSecurityIsEnabled                                 = $policy.SessionControls.CloudAppSecurity.IsEnabled -join " | "
            PolicySessionControlsCloudAppSecurityCloudAppSecurityType                      = $policy.SessionControls.CloudAppSecurity.CloudAppSecurityType -join " | "
            PolicySessionControlsDisableResilienceDefaults                                 = $policy.SessionControls.DisableResilienceDefaults -join " | "
            PolicySessionControlsPersistentBrowserIsEnabled                                = $policy.SessionControls.PersistentBrowser.IsEnabled -join " | "
            PolicySessionControlsPersistentBrowserMode                                     = $policy.SessionControls.PersistentBrowser.Mode -join " | "
            PolicySessionControlsSignInFrequencyAuthenticationType                         = $policy.SessionControls.SignInFrequency.AuthenticationType -join " | "
            PolicySessionControlsSignInFrequencyFrequencyInterval                          = $policy.SessionControls.SignInFrequency.FrequencyInterval -join " | "
            PolicySessionControlsSignInFrequencyIsEnabled                                  = $policy.SessionControls.SignInFrequency.IsEnabled -join " | "
            PolicySessionControlsSignInFrequencyType                                       = $policy.SessionControls.SignInFrequency.Type -join " | "
            PolicySessionControlsSignInFrequencyValue                                      = $policy.SessionControls.SignInFrequency.Value -join " | "
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
    if($VerbosePreference -eq "continue"){
        Write-Verbose "Results array:"
        $results
    }
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}
Disconnect-MgGraph | out-null   