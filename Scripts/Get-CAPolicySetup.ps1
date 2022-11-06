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
    .\Get-AADCAPolicySetup.ps1 -fileName AAD_ConditionalAccessPolicySetup -OutputPath c:\temp 
    Connecting to MS Graph
    Found '7' CA Polices
    Working on '[ZeroTrust] Require ToU for external users' policy
    Working on '[ZeroTrust] Block legacy authentication methods' policy
    Working on '[ZeroTrust] Device Assurance Win10 - Compliance State' policy
    Working on '[ZeroTrust] Microsoft Cloud App Security - monitroing & blocking actions' policy
    Working on 'External Users and Guests - MVP AzureBlog Terms of use' policy
    Working on 'Block Countires' policy
    Working on 'test' policy
    Exporting CA Policies array to file: 'AAD_ConditionalAccessPolicySetup_11_03_2022.csv'

#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = 'AAD_ConditionalAccessPolicySetup',
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Policy.Read.All' | out-null

$rawArray = Get-MgIdentityConditionalAccessPolicy -All
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0){
    foreach ($policy in $rawArray){
        Write-Verbose "Working on '$( $policy.DisplayName)' policy"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            PolicyName = $policy.DisplayName
            PolicyDescription = $policy.Description
            PolicyID = $policy.Id
            PolicyCreationDate = $policy.CreatedDateTime
            PolicyState = $policy.State
            PolicyModificationDate = $policy.ModifiedDateTime
            PolicyConditionApplicationsExcluded = $policy.Conditions.Applications.ExcludeApplications-join " | "
            PolicyConditionApplicationsIncluded = $policy.Conditions.Applications.IncludeApplications-join " | "
            PolicyConditionApplicationsIncludeAuthenticationContextClassReferences = $policy.Conditions.Applications.IncludeAuthenticationContextClassReferences-join " | "
            PolicyConditionApplicationsIncludeUserActions = $policy.Conditions.Applications.IncludeUserActions-join " | "
            PolicyConditionClientAppTypes = $policy.Conditions.ClientAppTypes-join " | "
            PolicyConditionClientApplicationsExcludeServicePrincipals = $policy.Conditions.ClientApplications.ExcludeServicePrincipals-join " | "
            PolicyConditionClientApplicationsIncludeServicePrincipals = $policy.Conditions.ClientApplications.IncludeServicePrincipals-join " | "
            PolicyConditionDevicesDeviceFilterMode = $policy.Conditions.Devices.DeviceFilter.Mode-join " | "
            PolicyConditionDevicesDeviceFilterRule = $policy.Conditions.Devices.DeviceFilter.Rule-join " | "
            PolicyConditionLocationsIncluded = $policy.Conditions.locations.IncludeLocations-join " | "
            PolicyConditionLocationsExcluded = $policy.Conditions.Locations.ExcludeLocations-join " | "
            PolicyConditionPlatformsIncluded = $policy.Conditions.Platforms.IncludePlatforms-join " | "
            PolicyConditionPlatformsExcluded = $policy.Conditions.Platforms.ExcludePlatforms-join " | "
            PolicyConditionSignInRiskLevels = $policy.Conditions.SignInRiskLevels-join " | "
            PolicyConditionUserRiskLevels = $policy.Conditions.UserRiskLevels-join " | "
            PolicyConditionUsersExcludeGroups = $policy.Conditions.Users.ExcludeGroups-join " | "
            PolicyConditionUsersExcludeRoles = $policy.Conditions.Users.ExcludeRoles-join " | "
            PolicyConditionUsersExcludeUsers = $policy.Conditions.Users.ExcludeUsers-join " | "
            PolicyConditionUsersIncludeGroups = $policy.Conditions.Users.IncludeGroups-join " | "
            PolicyConditionUsersIncludeRoles = $policy.Conditions.Users.IncludeRoles-join " | "
            PolicyConditionUsersIncludeUsers = $policy.Conditions.Users.IncludeUsers-join " | "
            PolicyGrantControlsBuiltInControls = $policy.GrantControls.BuiltInControls-join " | "
            PolicyGrantControlsCustomAuthenticationFactors = $policy.GrantControls.CustomAuthenticationFactors-join " | "
            PolicyGrantControlsOperator  = $policy.GrantControls.Operator-join " | "
            PolicyGrantControlsTermsOfUse  = $policy.GrantControls.TermsOfUse-join " | "
            PolicySessionControlsApplicationEnforcedRestrictionsEnabled = $policy.SessionControls.ApplicationEnforcedRestrictions.IsEnabled -join " | "
            PolicySessionControlsCloudAppSecurityIsEnabled = $policy.SessionControls.CloudAppSecurity.IsEnabled -join " | "
            PolicySessionControlsCloudAppSecurityCloudAppSecurityType = $policy.SessionControls.CloudAppSecurity.CloudAppSecurityType-join " | "
            PolicySessionControlsDisableResilienceDefaults = $policy.SessionControls.DisableResilienceDefaults-join " | "
            PolicySessionControlsPersistentBrowserIsEnabled = $policy.SessionControls.PersistentBrowser.IsEnabled-join " | "
            PolicySessionControlsPersistentBrowserMode = $policy.SessionControls.PersistentBrowser.Mode-join " | "
            PolicySessionControlsSignInFrequencyAuthenticationType = $policy.SessionControls.SignInFrequency.AuthenticationType-join " | "
            PolicySessionControlsSignInFrequencyFrequencyInterval = $policy.SessionControls.SignInFrequency.FrequencyInterval-join " | "
            PolicySessionControlsSignInFrequencyIsEnabled = $policy.SessionControls.SignInFrequency.IsEnabled-join " | "
            PolicySessionControlsSignInFrequencyType = $policy.SessionControls.SignInFrequency.Type-join " | "
            PolicySessionControlsSignInFrequencyValue = $policy.SessionControls.SignInFrequency.Value-join " | "
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting CA Policies array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}