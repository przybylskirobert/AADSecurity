#    .\Get-AADAudit.ps1 -AuditPath 'X:\temp' -IncludeRAW -CliXMLPath 'C:\Users\tauze\OneDrive\04_Repos\Projekty_prywatne\Private\AADSecurity\CertificateThumbprint.xml' -SecretCliXMLPath "C:\Users\tauze\OneDrive\04_Repos\Projekty_prywatne\Private\AADSecurity\AppSecret.xml" -ApplicationID 'bf43dc83-2fb1-4cd6-80a0-fb34696379c6' -TenantID '56b759c4-70fd-4f95-8a65-88d5ca311666'
<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022

    .EXAMPLE
    .\Get-AADAudit.ps1 -AuditPath 'X:\temp' -CliXMLPath 'Path_to_your_xml_file_with_thumbprint' -SecretCliXMLPath 'Path_to_your_xml_file_with_appsecret' -ApplicationID 'Your_App_ID' -TenantID 'Your_Tenant_ID' -IncludeRAW 
    Transcript started, output file is X:\temp\AAD_Audit\MVP Tenant\AAD_Audit_21_11_2022_1854.log

    ###############################################
    #          Starging DATA Collection           #
    # Scripts Version: 1.1                        #
    ###############################################

    Welcome To Microsoft Graph!
    ----> Running Get-AADAccessReviews script
    Connecting to MS Graph
    Found '8' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_AccessReviews_11_21_2022.csv'
    ----> Running Get-AADAdminConsent script
    Connecting to MS Graph
    Found '1' entries
    Exporting entries to file: 'AAD_AdminConsent_11_21_2022.csv'
    ----> Running Get-AADAdministrativeUnits script
    Connecting to MS Graph
    Found '2' entries
    Exporting entries to file: 'AAD_AdministrativeUnits_11_21_2022.csv'
    ----> Running Get-AADApplications script
    Connecting to MS Graph
    Found '7' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Applications_11_21_2022.csv'
    ----> Running Get-AADAuthenticationMethods script
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Found '5' entries
    Exporting entries to file: 'AAD_AuthenticationMethods_11_21_2022.csv'
    ----> Running Get-AADDevices script
    Connecting to MS Graph
    Found '10' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Devices_11_21_2022.csv'
    ----> Running Get-AADDomains script
    Connecting to MS Graph
    Found '3' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Domains_11_21_2022.csv'
    ----> Running Get-AADGroups script
    Connecting to MS Graph
    Found '16' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Groups_11_21_2022.csv'
    ----> Running Get-AADNamedLocations script
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_NamedLocations_11_21_2022.csv'
    ----> Running Get-AADRiskDetection script
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_RiskDetection_11_21_2022.csv'
    ----> Running Get-AADRiskyUsers script
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_RiskyUsers_11_21_2022.csv'
    ----> Running Get-AADRoles script
    Connecting to MS Graph
    Found '13' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Roles_11_21_2022.csv'
    ----> Running Get-AADSecureScore script
    Connecting to MS Graph
    WARNING: 199 - "Microsoft/SecureScore/500/10047"
    Found '0' entries under 'mvp.azureblog.pl' tenant
    No entries found, no file to be created.
    ----> Running Get-AADServicePrincipals script
    Connecting to MS Graph
    Found '100' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_ServicePrincipals_11_21_2022.csv'
    ----> Running Get-AADTermsOfUse script
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_TermsOfUse_11_21_2022.csv'
    ----> Running Get-AADUsers script
    Connecting to MS Graph
    Found '19' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Users_11_21_2022.csv'
    ----> Running Get-CAPolicySetup script
    Connecting to MS Graph
    Found '7' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_ConditionalAccessPolicySetup_11_21_2022.csv'
    ----> Running Get-CloudBGA script
    Connecting to MS Graph
    Fount '1' entries
    Exporting entries to file: 'AAD_PotentialBreakGlassSetup_11_21_2022.csv'

    ###############################################
    #          Starging RAW DATA Collection       #
    # Scripts Version: 1.1                       #
    ###############################################

    ----> Collecting RAW data in json files.
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
    Working on URI 'https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations'
    Working on URI 'https://graph.microsoft.com/v1.0/directory/administrativeUnits'
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/partners'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/crossTenantAccessPolicy/default'
    Working on URI 'https://graph.microsoft.com/v1.0/policies/adminConsentRequestPolicy'
    Transcript stopped, output file is X:\temp\AAD_Audit\MVP Tenant\AAD_Audit_21_11_2022_1854.log

    .EXAMPLE
    .\Get-AADAudit.ps1 -AuditPath 'X:\temp' -CliXMLPath 'Path_to_your_xml_file_with_thumbprint' -SecretCliXMLPath 'Path_to_your_xml_file_with_appsecret' -ApplicationID 'Your_App_ID' -TenantID 'Your_Tenant_ID'
    Transcript started, output file is X:\temp\AAD_Audit\MVP Tenant\AAD_Audit_21_11_2022_1856.log

    ###############################################
    #          Starging DATA Collection           #
    # Scripts Version: 1.1                        #
    ###############################################

    Welcome To Microsoft Graph!
    ----> Running Get-AADAccessReviews script
    Connecting to MS Graph
    Found '8' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_AccessReviews_11_21_2022.csv'
    ----> Running Get-AADAdminConsent script
    Connecting to MS Graph
    Found '1' entries
    Exporting entries to file: 'AAD_AdminConsent_11_21_2022.csv'
    ----> Running Get-AADAdministrativeUnits script
    Connecting to MS Graph
    Found '2' entries
    Exporting entries to file: 'AAD_AdministrativeUnits_11_21_2022.csv'
    ----> Running Get-AADApplications script
    Connecting to MS Graph
    Found '7' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Applications_11_21_2022.csv'
    ----> Running Get-AADAuthenticationMethods script
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Found '5' entries
    Exporting entries to file: 'AAD_AuthenticationMethods_11_21_2022.csv'
    ----> Running Get-AADDevices script
    Connecting to MS Graph
    Found '10' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Devices_11_21_2022.csv'
    ----> Running Get-AADDomains script
    Connecting to MS Graph
    Found '3' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Domains_11_21_2022.csv'
    ----> Running Get-AADGroups script
    Connecting to MS Graph
    Found '16' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Groups_11_21_2022.csv'
    ----> Running Get-AADNamedLocations script
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_NamedLocations_11_21_2022.csv'
    ----> Running Get-AADRiskDetection script
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_RiskDetection_11_21_2022.csv'
    ----> Running Get-AADRiskyUsers script
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_RiskyUsers_11_21_2022.csv'
    ----> Running Get-AADRoles script
    Connecting to MS Graph
    Found '13' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Roles_11_21_2022.csv'
    ----> Running Get-AADSecureScore script
    Connecting to MS Graph
    WARNING: 199 - "Microsoft/SecureScore/502/90"
    Found '0' entries under 'mvp.azureblog.pl' tenant
    No entries found, no file to be created.
    ----> Running Get-AADServicePrincipals script
    Connecting to MS Graph
    Found '100' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_ServicePrincipals_11_21_2022.csv'
    ----> Running Get-AADTermsOfUse script
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_TermsOfUse_11_21_2022.csv'
    ----> Running Get-AADUsers script
    Connecting to MS Graph
    Found '19' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_Users_11_21_2022.csv'
    ----> Running Get-CAPolicySetup script
    Connecting to MS Graph
    Found '7' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_ConditionalAccessPolicySetup_11_21_2022.csv'
    ----> Running Get-CloudBGA script
    Connecting to MS Graph
    Fount '1' entries
    Exporting entries to file: 'AAD_PotentialBreakGlassSetup_11_21_2022.csv'
    Transcript stopped, output file is X:\temp\AAD_Audit\MVP Tenant\AAD_Audit_21_11_2022_1856.log

    .Example 
    .\Get-AADAudit.ps1 -AuditPath 'X:\temp' -CliXMLPath 'Path_to_your_xml_file_with_thumbprint' -SecretCliXMLPath 'Path_to_your_xml_file_with_appsecret' -ApplicationID 'Your_App_ID' -TenantID 'Your_Tenant_ID' -IncludeRAW -Verbose 

    ###############################################
    #          Starging DATA Collection           #
    # Scripts Version: 1.1                        #
    ###############################################

    Welcome To Microsoft Graph!
    ----> Running Get-AADAccessReviews script
    VERBOSE: FileName: 'AAD_AccessReviews'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '8' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'Review guest access across Microsoft 365 groups 2'
    VERBOSE: Working on 'one time review'
    VERBOSE: Working on 'Review guest access across Microsoft 365 groups'
    VERBOSE: Working on 'Review guest access across Microsoft 365 groups'
    VERBOSE: Working on 'AccessPackage1 - Initial Policy'
    VERBOSE: Working on 'mvp_graph review'
    VERBOSE: Working on 'group review '
    VERBOSE: Working on 'graph api for powershell '
    Exporting entries to file: 'AAD_AccessReviews_11_21_2022.csv'
    ----> Running Get-AADAdminConsent script
    VERBOSE: FileName: 'AAD_AdminConsent'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '1' entries
    Exporting entries to file: 'AAD_AdminConsent_11_21_2022.csv'
    ----> Running Get-AADAdministrativeUnits script
    VERBOSE: FileName: 'AAD_AdministrativeUnits'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '2' entries
    VERBOSE:  Working on 'TEST' Admnistrative Unit
    VERBOSE:  Working on 'SSS' Admnistrative Unit
    Exporting entries to file: 'AAD_AdministrativeUnits_11_21_2022.csv'
    ----> Running Get-AADApplications script
    VERBOSE: FileName: 'AAD_Applications'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '7' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'P2P Server'
    VERBOSE: Working on 'mvp.azureblog.pl'
    VERBOSE: Working on 'MVP-graph'
    VERBOSE: Working on 'AzureBlog-Bicep-SponsorshipMVP'
    VERBOSE: Working on 'AzureBlog-Bicep-XXXX'
    VERBOSE: Working on 'AADAssessment'
    VERBOSE: Working on 'AzureBlog-Bicep-XXXX'
    Exporting entries to file: 'AAD_Applications_11_21_2022.csv'
    ----> Running Get-AADAuthenticationMethods script
    VERBOSE: FileName: 'AAD_AuthenticationMethods'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: SecretCliXMLPath: 'XXXX\AppSecret.xml'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: Uri: 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    VERBOSE: POST with -1-byte payload
    VERBOSE: received 2412-byte response of content type application/json; charset=utf-8
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    VERBOSE: GET with 0-byte payload
    VERBOSE: received -1-byte response of content type
    application/json;odata.metadata=minimal;odata.streaming=true;IEEE754Compatible=false;charset=utf-8
    VERBOSE: Working on 'Fido2'
    VERBOSE: Working on 'MicrosoftAuthenticator'
    VERBOSE: Working on 'TemporaryAccessPass'
    VERBOSE: Working on 'Email'
    VERBOSE: Working on 'X509Certificate'
    Found '5' entries
    Exporting entries to file: 'AAD_AuthenticationMethods_11_21_2022.csv'
    ----> Running Get-AADDevices script
    VERBOSE: FileName: 'AAD_Devices'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '10' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'vm-pco5-neu-1'
    VERBOSE: Working on 'samsungSM-G980F'
    VERBOSE: Working on 'vm-aadjoined-ne'
    VERBOSE: Working on 'vm-pco5-neu-0'
    VERBOSE: Working on 'vm-pco5-neu-1'
    VERBOSE: Working on 'vm-0'
    VERBOSE: Working on 'vm-pco5-neu-0'
    VERBOSE: Working on 'vm-pco1-neu'
    VERBOSE: Working on 'vm-pco-neu-0'
    VERBOSE: Working on 'vm-pco-neu-1'
    Exporting entries to file: 'AAD_Devices_11_21_2022.csv'
    ----> Running Get-AADDomains script
    VERBOSE: FileName: 'AAD_Domains'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '3' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'mvp.azureblog.pl'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_Domains_11_21_2022.csv'
    ----> Running Get-AADGroups script
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
    ----> Running Get-AADNamedLocations script
    VERBOSE: FileName: 'AAD_NamedLocations'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_NamedLocations_11_21_2022.csv'
    ----> Running Get-AADRiskDetection script
    VERBOSE: FileName: 'AAD_RiskDetection'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_RiskDetection_11_21_2022.csv'
    ----> Running Get-AADRiskyUsers script
    VERBOSE: FileName: 'AAD_RiskyUsers'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '2' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXX'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_RiskyUsers_11_21_2022.csv'
    ----> Running Get-AADRoles script
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
    ----> Running Get-AADSecureScore script
    VERBOSE: FileName: 'AAD_SecureScore'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_SecureScore_11_21_2022.csv'
    ----> Running Get-AADServicePrincipals script
    VERBOSE: FileName: 'AAD_ServicePrincipals'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '100' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'XXXX'
    VERBOSE: Working on 'XXXX'
    Exporting entries to file: 'AAD_ServicePrincipals_11_21_2022.csv'
    ----> Running Get-AADTermsOfUse script
    VERBOSE: FileName: 'AAD_TermsOfUse'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '1' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'MVP AzureBlog Terms of use'
    Exporting entries to file: 'AAD_TermsOfUse_11_21_2022.csv'
    ----> Running Get-AADUsers script
    VERBOSE: FileName: 'AAD_Users'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: CertificateThumbprint: 'XXXX'
    VERBOSE: ApplicationId: 'XXXX'
    VERBOSE: TenantID: 'XXXX'
    VERBOSE: TenantDomainName: 'mvp.azureblog.pl'
    Connecting to MS Graph
    Found '19' entries under 'mvp.azureblog.pl' tenant
    VERBOSE: Working on 'On-Premises Directory Synchronization Service Account'
    VERBOSE: Working on 'Agnieszka'
    VERBOSE: Working on 'BlackPanter'
    VERBOSE: Working on 'Black Widow'
    VERBOSE: Working on 'Bruce Banner'
    VERBOSE: Working on 'Capitan America'
    VERBOSE: Working on 'Drax'
    VERBOSE: Working on 'Im Groot'
    VERBOSE: Working on 'Justin Case'
    VERBOSE: Working on 'Loki'
    VERBOSE: Working on 'PasswordLessTester'
    VERBOSE: Working on 'Robert'
    VERBOSE: Working on 'Rocket Raccoon'
    VERBOSE: Working on 'Robert Przybylski'
    VERBOSE: Working on 'Robert Przybylski [BG]'
    VERBOSE: Working on 'Test User 1'
    VERBOSE: Working on 'Test User 2'
    VERBOSE: Working on 'Test User 3'
    Exporting entries to file: 'AAD_Users_11_21_2022.csv'
    ----> Running Get-CAPolicySetup script
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
    VERBOSE: Working on 'External Users and Guests - MVP AzureBlog Terms of use' policy
    VERBOSE: Working on 'Block Countires' policy
    VERBOSE: Working on 'test' policy
    Exporting entries to file: 'AAD_ConditionalAccessPolicySetup_11_21_2022.csv'
    ----> Running Get-CloudBGA script
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

    ###############################################
    #          Starging RAW DATA Collection       #
    # Scripts Version: 1.1                       #
    ###############################################

    ----> Collecting RAW data in json files.
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
    [Parameter(Position = 0, mandatory = $true)]
    [string] $AuditPath,
    [Parameter(Position = 1, mandatory = $true)]
    [string] $CliXMLPath,
    [Parameter(Position = 2, mandatory = $true)]
    [string] $SecretCliXMLPath,
    [Parameter(Position = 3, mandatory = $true)]
    [string] $ApplicationID ,
    [Parameter(Position = 4, mandatory = $true)]
    [string] $TenantID,
    [Parameter(Position = 5)]
    [switch] $IncludeRAW
)

$scriptsVersion = '1.1'
$rawVersion = '1.1'
#region initial setup
try {
    Stop-Transcript
}
catch {

}
$auditFolderTest = Test-Path $AuditPath
if ($auditFolderTest -eq $false) {
    New-Item -Path $AuditPath -Name AAD_Audit -ItemType Directory -Force | Out-Null
}

$certificateThumbprint = (Import-CliXml -Path $CliXMLPath).GetNetworkCredential().Password

try {
    Get-AZTenant | out-null
}
catch {
    Connect-AzAccount
}
$tenantName = (Get-AZTenant).name
$tenantAuditPath = "$AuditPath\AAD_Audit\$tenantName"
$tenantFolderTest = Test-Path $tenantAuditPath
if ($tenantFolderTest -eq $false) {
    New-Item -path "$AuditPath\AAD_Audit" -Name $tenantName -ItemType Directory -Force | Out-Null
}

$oldLocation = Get-Location

#endregion 

#region transcript
$date = Get-Date -Format "dd_MM_yyyy_HHmm"
$transcriptPath = "$tenantAuditPath\AAD_Audit_$($date).log"
Start-Transcript -Path $transcriptPath
#endregion

#region Audit Scripts run

Write-Host ""
Write-Host "###############################################" -ForegroundColor Blue
Write-Host "#          "  -ForegroundColor Blue -NoNewline
Write-Host "Starging DATA Collection" -NoNewline
Write-Host "           #" -ForegroundColor Blue
Write-Host "# "  -ForegroundColor Blue -NoNewline
Write-Host "Scripts Version: " -NoNewline
Write-Host "$scriptsVersion                        #" -ForegroundColor Blue
Write-Host "###############################################" -ForegroundColor Blue
Write-Host ""

Connect-MgGraph -CertificateThumbprint $certificateThumbprint -ClientId $ApplicationID -TenantId $TenantID
$tenantDomainName = (Get-MgDomain | Where-Object { $_.IsDefault -eq $true }).id

$scripts = Get-ChildItem -Path .\Scripts\ -File
foreach ($entry in $scripts) {

    $fileName = $entry.Name
    $fileNameClean = [io.path]::GetFileNameWithoutExtension($fileName)
    write-Host "----> Running $fileNameClean script" -ForegroundColor Blue

    if ($VerbosePreference -eq 'Continue') {
        . .\Scripts\$fileName -OutputPath $tenantAuditPath -CertificateThumbprint $certificateThumbprint -ApplicationId $ApplicationID -TenantId $TenantID -TenantDomainName $tenantDomainName -Verbose
    }
    else {
            
        . .\Scripts\$fileName -OutputPath $tenantAuditPath -CertificateThumbprint $certificateThumbprint -ApplicationId $ApplicationID -TenantId $TenantID -TenantDomainName $tenantDomainName
    }
}
#end region

if ($IncludeRAW) {
    Write-Host ""
    Write-Host "###############################################" -ForegroundColor Blue
    Write-Host "#          "  -ForegroundColor Blue -NoNewline
    Write-Host "Starging RAW DATA Collection" -NoNewline
    Write-Host "       #" -ForegroundColor Blue
    Write-Host "# "  -ForegroundColor Blue -NoNewline
    Write-Host "Scripts Version: " -NoNewline
    Write-Host "$rawVersion                       #" -ForegroundColor Blue
    Write-Host "###############################################" -ForegroundColor Blue
    Write-Host ""
    $rawPath = "$tenantAuditPath\RAW"
    $rawTest = test-path $rawPath
    if ($rawTest -eq $false ) {
        New-Item -path "$tenantAuditPath" -Name RAW -ItemType Directory -Force | Out-Null
    }
    write-Host "----> Collecting RAW data in json files." -ForegroundColor Blue
    if ($VerbosePreference -eq 'Continue') {
        . .\Get-AADRawData.ps1 -OutputPath $rawPath -SecretCliXMLPath $SecretCliXMLPath -ApplicationID $ApplicationID -CertificateThumbprint $certificateThumbprint -TenantId $TenantID -TenantDomainName $TenantDomainName -Verbose
    }
    else {
        . .\Get-AADRawData.ps1 -OutputPath $rawPath -SecretCliXMLPath $SecretCliXMLPath -ApplicationID $ApplicationID -CertificateThumbprint $certificateThumbprint -TenantId $TenantID -TenantDomainName $TenantDomainName
    }
}

Stop-Transcript
Set-Location $oldLocation