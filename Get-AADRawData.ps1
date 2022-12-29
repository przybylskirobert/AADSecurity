<#
.NOTES
All rigts reserved to 
Robert Przybylski 
www.azureblog.pl 
robert(at)azureblog.pl
2022

.Example
.\Get-AADRawData.ps1 -OutputPath $OutputPath -CliXMLPath CliXMLPath -SecretCliXMLPath SecretCliXMLPath -ApplicationID ApplicationID -CertificateThumbprint CertificateThumbprint -TenantID TenantID -TenatDomainName TenatDomainName    
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

.Example
VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant\RAW'
VERBOSE: SecretCliXMLPath: 'XXXX\AppSecret.xml'
VERBOSE: ApplicationID: 'XXXX'
VERBOSE: TenantID: 'XXXX'
VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
VERBOSE: DebugMe: ''
VERBOSE: POST with -1-byte payload
VERBOSE: received 2412-byte response of content type application/json; charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/devices'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/directoryRoles'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/domains'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/groupSettings'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/users'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/directoryRoles'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/accessReviews/definitions'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/policies/identitySecurityDefaultsEnforcementPolicy'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/subscribedSkus'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type
application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/partners'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/default'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
Working on URI 'https://graph.microsoft.com/v1.0/policies/adminConsentRequestPolicy'
VERBOSE: GET with 0-byte payload
VERBOSE: received -1-byte response of content type application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
#>

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [string] $OutputPath,
    [Parameter(Position = 1)]
    [string] $SecretCliXMLPath,
    [Parameter(Position = 2)]
    [string] $ApplicationID,
    [Parameter(Position = 3)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 4)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [string] $TenantDomainName
)

Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "SecretCliXMLPath: '$SecretCliXMLPath'"
Write-Verbose "ApplicationID: '$ApplicationID'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"
Write-Verbose "DebugMe: '$DebugMe'"

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
    '/roleManagement/directory/roleEligibilityScheduleInstances'
)  

try {
    Get-AZTenant | out-null
}
catch {
    Login-AzAccount -CertificateThumbprint $certificateThumbprint -ApplicationId $ApplicationID -TenantId $TenantID | Out-Null
}

#Region Connection

$Body = @{    
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $applicationID
    Client_Secret = (Import-CliXml -Path $SecretCliXMLPath).GetNetworkCredential().Password
} 

$connectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantDomainName/oauth2/v2.0/token" -Method POST -Body $Body -ContentType 'application/x-www-form-urlencoded'

$authHeader = @{
    'Authorization' = "Bearer $($connectGraph.access_token)"
}
#endregion


foreach ($entry in $uriArray) {
    $uri = $uriPrefix + $entry
    Write-Host "Working on URI '$uri'" -ForegroundColor Yellow
    $output = Invoke-RestMethod -Headers $authHeader -Uri $Uri -Method get | convertto-json -Depth 10
    $outputFile = "$OutputPath\" + ($entry).replace('/', '').replace('?', '').replace('=', '').replace('$', '') + ".json"
    $output | Out-file $outputFile 
}
