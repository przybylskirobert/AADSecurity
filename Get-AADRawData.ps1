<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022

    .Example
    .\Get-AADRawData.ps1 -OutputPath $OutputPath -CliXMLPath CliXMLPath -ApplicationID ApplicationID -TenatDomainName TenatDomainName    
    Working on URI 'https://graph.microsoft.com/v1.0/devices'
    Working on URI 'https://graph.microsoft.com/v1.0/directoryRoles'
    Working on URI 'https://graph.microsoft.com/v1.0/domains'
    Working on URI 'https://graph.microsoft.com/v1.0/groupSettings'
    Working on URI 'https://graph.microsoft.com/v1.0/users'
    Working on URI 'https://graph.microsoft.com/v1.0/directoryRoles'
    Working on URI 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies'
    Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/accessReviews/definitions'
    Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement'
    Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements'
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/identitySecurityDefaultsEnforcementPolicy'
    Working on URI 'https://graph.microsoft.com/v1.0/subscribedSkus'
    Working on URI 'https://graph.microsoft.com/v1.0/security/secureScores'
    Working on URI 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations'
    Working on URI 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/partners'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/default'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/adminConsentRequestPolicy'
#>
param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $CliXMLPath,
    [Parameter(Position = 2)]
    [string] $ApplicationID,
    [Parameter(Position = 3)]
    [string] $TenatDomainName
)

$uriPrefix = 'https://graph.microsoft.com/v1.0/'
$uriArray = @(
    "devices",
    "directoryRoles",
    "domains",
    "groupSettings",
    'users',
    'directoryRoles',
    "identity/conditionalAccess/policies",
    "identityGovernance/accessReviews/definitions",
    "identityGovernance/entitlementManagement",
    "identityGovernance/termsOfUse/agreements",
    "authenticationMethodsPolicy",
    "policies/identitySecurityDefaultsEnforcementPolicy",
    "subscribedSkus",
    'identity/conditionalAccess/namedLocations',
    'directory/administrativeUnits',
    'authenticationMethodsPolicy',
    'policies/crossTenantAccessPolicy/partners',
    'policies/crossTenantAccessPolicy/default',
    'policies/adminConsentRequestPolicy'
)  

try {
    Get-AZTenant |out-null
}
catch {
    Login-AzAccount |out-null
}

#Region Connection
$Body = @{    
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $applicationID
    Client_Secret = (Import-CliXml -Path $CliXMLPath).GetNetworkCredential().Password
} 

$connectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenatDomainName/oauth2/v2.0/token" -Method POST -Body $Body -ContentType 'application/x-www-form-urlencoded'

$authHeader = @{
    'Authorization' = "Bearer $($connectGraph.access_token)"
}
#endregion


foreach ($entry in $uriArray){
    $uri = $uriPrefix + $entry
    Write-Host "Working on URI '$uri'" -ForegroundColor Yellow
    $output = Invoke-RestMethod -Headers $authHeader -Uri $Uri -Method get | convertto-json -Depth 10
    $outputFile = "$OutputPath\" + ($entry).replace('/','').replace('?','').replace('=','').replace('$','') + ".json"
    $output | Out-file $outputFile 
}
