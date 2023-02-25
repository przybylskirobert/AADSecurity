<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis

    .Example
    .\Get-AADAccessReviews.ps1 -Filename "AAD_AccessReviews" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX" -Verbose
    VERBOSE: FileName: 'AAD_AccessReviews'
    VERBOSE: OutputPath: 'X:\temp\AAD_Audit\MVP Tenant'
    VERBOSE: SecretCliXMLPath: 'XXXX\AppSecret.xml'
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
    
    .Example
    .\Get-AADAccessReviews.ps1 -Filename "AAD_AccessReviews" -OutputPath c:\temp -CertificateThumbprint "XXX" -ApplicationId "XXX" -TenantID "XXXX" -TenantDomainName "XXX"
    Connecting to MS Graph
    Found '8' entries under 'mvp.azureblog.pl' tenant
    Exporting entries to file: 'AAD_AccessReviews_11_21_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $FileName = "AAD_AccessReviews",
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
$results = @()
$dateChecked = get-date -UFormat %d/%m/%Y
$rawArray = Get-MgIdentityGovernanceAccessReviewDefinition -Top 100 -Skip 0
Write-Host "Found '$($rawArray.Count)' entries under '$TenantDomainName' tenant" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($review in $rawArray) {
        Write-Verbose "Working on '$($review.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked                                  = $dateChecked
            ID                                           = $review.id
            CreatedBy                                    = $review.CreatedBy.UserPrincipalName
            CreatedDateTime                              = $review.CreatedDateTime
            DescriptionForAdmins                         = $review.DescriptionForAdmins
            DescriptionForReviewers                      = $review.DescriptionForReviewers
            DisplayName                                  = $review.DisplayName
            QueryType                                    = $review.Scope.AdditionalProperties.queryType
            Query                                        = $review.Scope.AdditionalProperties.query
            Status                                       = $review.Status
            Reviewers                                    = $review.Reviewers.query -join " | "
            SettingsAutoApplyDecisionsEnabled            = $review.Settings.AutoApplyDecisionsEnabled
            SettingsDecisionHistoriesForReviewersEnabled = $review.Settings.DecisionHistoriesForReviewersEnabled
            SettingsDefaultDecision                      = $review.Settings.DefaultDecision
            SettingsDefaultDecisionEnabled               = $review.Settings.DefaultDecisionEnabled
            SettingsInstanceDurationInDays               = $review.Settings.InstanceDurationInDays
            SettingsJustificationRequiredOnApproval      = $review.Settings.JustificationRequiredOnApproval
            SettingsMailNotificationsEnabled             = $review.Settings.MailNotificationsEnabled
            SettingsRecommendationsEnabled               = $review.Settings.RecommendationsEnabled
            SettingsReminderNotificationsEnabled         = $review.Settings.ReminderNotificationsEnabled
            SettingsReocurrenceDayOfMonth                = $review.Settings.Recurrence.DayOfMonth
            SettingsReocurrenceDaysOfWeek                = $review.Settings.Recurrence.DaysOfWeek
            SettingsReocurrenceFirstDayOfWeek            = $review.Settings.Recurrence.FirstDayOfWeek
            SettingsReocurrenceIndex                     = $review.Settings.Recurrence.Index
            SettingsReocurrenceInterval                  = $review.Settings.Recurrence.Interval
            SettingsReocurrenceMonth                     = $review.Settings.Recurrence.Month
            SettingsReocurrenceType                      = $review.Settings.Recurrence.Type
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
Disconnect-MgGraph | Out-Null