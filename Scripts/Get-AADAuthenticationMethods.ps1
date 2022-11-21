<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis   
   
    .Example
    .\Get-AADAuthenticationMethods.ps1 -Filename "AAD_AuthenticationMethods" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
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
    
    .Example
    .\Get-AADAuthenticationMethods.ps1 -Filename "AAD_AuthenticationMethods" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Working on URI 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy'
    Found '5' entries
    Exporting entries to file: 'AAD_AuthenticationMethods_11_21_2022.csv'
#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_AuthenticationMethods",
    [Parameter(Position = 1)]
    [string] $OutputPath,      
    [Parameter(Position = 2)]
    [string] $SecretCliXMLPath = ".\YourPathTo\AppSecret.xml",
    [Parameter(Position = 3)]
    [string] $ApplicationID,
    [Parameter(Position = 4)]
    [string] $TenantDomainName,
    [Parameter(Position = 5)]
    [string] $Uri = 'https://graph.microsoft.com/v1.0/authenticationMethodsPolicy', 
    [Parameter(Position = 6)]
    [string] $CertificateThumbprint,
    [Parameter(Position = 7)]
    [string] $TenantID
)

Write-Verbose "FileName: '$FileName'"
Write-Verbose "OutputPath: '$OutputPath'"
Write-Verbose "SecretCliXMLPath: '$SecretCliXMLPath'"
Write-Verbose "CertificateThumbprint: '$CertificateThumbprint'"
Write-Verbose "ApplicationId: '$ApplicationId'"
Write-Verbose "TenantID: '$TenantID'"
Write-Verbose "Uri: '$Uri'"
Write-Verbose "TenantDomainName: '$TenantDomainName'"

try {
    Get-AZTenant | out-null
}
catch {
    Login-AzAccount | out-null
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
}#endregion

Write-Host "Working on URI '$Uri'" -ForegroundColor Yellow
$rawData = Invoke-RestMethod -Headers $authHeader -Uri $Uri -Method get
$dateChecked = get-date -UFormat %d/%m/%Y
$results = @()
$authenticationMethods = $rawData.authenticationMethodConfigurations

foreach ($method in $authenticationMethods ) {
    Write-Verbose "Working on '$($method.ID)'"
    $entry = New-Object PSObject -Property @{
        DateChecked = $dateChecked
        ID          = $method.ID
        Staste      = $method.State
    }
    $results += $entry
}

Write-Host "Found '$($results.Count)' entries" -ForegroundColor Green
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
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}
