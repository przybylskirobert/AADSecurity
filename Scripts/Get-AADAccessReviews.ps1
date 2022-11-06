<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis

    .Example
    .\Get-AADAccessReviews.ps1 -Filename "AAD_AccessReviews" -OutPath c:\temp
    Connecting to MS Graph
    Found '8' Access Reviews
    Exporting Access Reviews to file: 'AAD_AccessReviews_11_03_2022.csv'
#>
[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_AccessReviews",
    [Parameter(Position = 1)]
    [string] $OutputPath  
)

Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'AccessReview.Read.All' | out-null

$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
$rawArray = Get-MgIdentityGovernanceAccessReviewDefinition -Top 100 -Skip 0
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($review in $rawArray) {
        Write-Verbose "Working on '$($review.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked = $dateChecked
            ID = $review.id
            CreatedBy = $review.CreatedBy.UserPrincipalName
            CreatedDateTime = $review.CreatedDateTime
            DescriptionForAdmins = $review.DescriptionForAdmins
            DescriptionForReviewers = $review.DescriptionForReviewers
            DisplayName = $review.DisplayName
            QueryType = $review.Scope.AdditionalProperties.queryType
            Query = $review.Scope.AdditionalProperties.query
            Status = $review.Status
            Reviewers = $review.Reviewers.query -join  " | "
            SettingsAutoApplyDecisionsEnabled = $review.Settings.AutoApplyDecisionsEnabled
            SettingsDecisionHistoriesForReviewersEnabled = $review.Settings.DecisionHistoriesForReviewersEnabled
            SettingsDefaultDecision = $review.Settings.DefaultDecision
            SettingsDefaultDecisionEnabled = $review.Settings.DefaultDecisionEnabled
            SettingsInstanceDurationInDays = $review.Settings.InstanceDurationInDays
            SettingsJustificationRequiredOnApproval = $review.Settings.JustificationRequiredOnApproval
            SettingsMailNotificationsEnabled = $review.Settings.MailNotificationsEnabled
            SettingsRecommendationsEnabled = $review.Settings.RecommendationsEnabled
            SettingsReminderNotificationsEnabled = $review.Settings.ReminderNotificationsEnabled
            SettingsReocurrenceDayOfMonth = $review.Settings.Recurrence.DayOfMonth
            SettingsReocurrenceDaysOfWeek = $review.Settings.Recurrence.DaysOfWeek
            SettingsReocurrenceFirstDayOfWeek = $review.Settings.Recurrence.FirstDayOfWeek
            SettingsReocurrenceIndex = $review.Settings.Recurrence.Index
            SettingsReocurrenceInterval = $review.Settings.Recurrence.Interval
            SettingsReocurrenceMonth = $review.Settings.Recurrence.Month
            SettingsReocurrenceType = $review.Settings.Recurrence.Type
        }
        $results += $entry
    }    
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting Access Reviews to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path "$OutputPath\$fileName.csv"
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}