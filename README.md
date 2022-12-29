# AADSecurity Repository

Hi there!

This is my place where I'm putting all the scripts and  files regarding Azure Active Directory Security check.

1. In order to run the scrip you have to register Azure AD Application using the following link [Register an application](https://portal.azure.com/#view/Microsoft_AAD_RegisteredApps/CreateApplicationBlade/quickStartType~/null/isMSAApp~/false)

3. After registering application assign the following permissions and **grant admin consent**:
- AccessReview.Read.All
- AdministrativeUnit.Read.All
- Agreement.Read.All
- AgreementAcceptance.Read.All
- APIConnectors.Read.All
- Application.Read.All
- AuditLog.Read.All
- AuthenticationContext.Read.All
- Device.Read.All
- Directory.Read.All
- Domain.Read.All
- Group.Read.All
- GroupMember.Read.All
- IdentityProvider.Read.All
- IdentityRiskEvent.Read.All
- IdentityRiskyServicePrincipal.Read.All
- IdentityRiskyUser.Read.All
- Policy.Read.All
- RoleManagement.Read.All
- RoleManagement.Read.Directory
- SecurityEvents.Read.All
- ServicePrincipalEndpoint.Read.All
- User.Read.All
- UserAuthenticationMethod.Read.All

3.**Upload Certificate** to registered application - [how to do this](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal#option-1-upload-a-certificate)

4.Create **Client secret** - [how to do this](https://learn.microsoft.com/en-us/azure/active-directory/develop/quickstart-register-app#add-a-client-secret)

5.Save **Certificate thumbprint** in xml file using the following procedure:
	
	$Credential = Get-Credential
	$Credential | Export-Clixml .\CertificateThumbprint.xml


6.Save **Client Secret** in xml file using the following procedure:

	$Credential = Get-Credential
	$Credential | Export-Clixml .\AppSecret.xml

7.Run the follwing command to start data gathering:

	.\Get-AADAudit.ps1 -AuditPath 'X:\temp' -CliXMLPath 'Path_to_your_xml_file_with_thumbprint' -SecretCliXMLPath 'Path_to_your_xml_file_with_appsecret' -ApplicationID 'Your_App_ID' -TenantID 'Your_Tenant_ID'

There are additionall switched to be used during the script run:

	-Verbose - enabling debugging mode
	-IncludeRAW - saving RAW json files with results from Graph API

## FlowChart
![image](https://user-images.githubusercontent.com/56112893/203147859-5588e0ce-80a3-4459-b35f-9c0f8c84ac42.png)
