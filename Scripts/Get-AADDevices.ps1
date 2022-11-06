<#
    .NOTES
    All rigts reserved to 
    Robert Przybylski 
    www.azureblog.pl 
    robert(at)azureblog.pl
    2022
    .Synopsis
     
   
    .Example
    .\Get-AADDevices.ps1 -fileName AAD_Devices -OutputPAth c:\temp
    Connecting to MS Graph 
    Found '10' devices
    Exporting devices array to file: 'AAD_Devices_11_01_2022.csv'
#>

[CmdletBinding()]

param (
    [Parameter(Position = 0)]
    [string] $fileName = "AAD_Devices",
    [Parameter(Position = 1)]
    [string] $OutputPath
)
Write-Host "Connecting to MS Graph " -ForegroundColor Yellow
Connect-MgGraph -Scopes 'Device.Read.All, Directory.Read.All' | out-null

$rawArray = Get-MgDevice | Select-Object Id, AccountEnabled, DisplayName, DeviceId, ApproximateLastSignInDateTime, OperatingSystem, OperatingSystemVersion, ProfileType, TrustType, IsCompliant, IsManaged, MdmAppId, MemberOf, RegisteredOwners, RegisteredUsers, RegistrationDateTime
$results = @()
$dateChecked = get-date -UFormat %m/%d/%Y
Write-Host "Found '$($rawArray.Count)' entries" -ForegroundColor Green

if ($rawArray.Length -ne 0) {
    foreach ($device in $rawArray) {
        Write-Verbose "Working on '$($device.DisplayName)'"
        $entry = New-Object PSObject -Property @{
            DateChecked                   = $dateChecked
            ID                            = $device.ID
            DisplayName                   = $device.DisplayName
            AccountEnabled                = $device.AccountEnabled
            DeviceId                      = $device.DeviceId
            ApproximateLastSignInDateTime = $device.ApproximateLastSignInDateTime
            OperatingSystem               = $device.OperatingSystem
            OperatingSystemVersion        = $device.OperatingSystemVersion
            ProfileType                   = $device.ProfileType
            TrustType                     = $device.TrustType
            IsCompliant                   = $device.IsCompliant
            IsManaged                     = $device.IsManaged
            MdmAppId                      = $device.MdmAppId
            MemberOf                      = $device.MemberOf -join " | "
            RegisteredOwners              = $device.RegisteredOwners -join " | "
            RegisteredUsers               = $device.RegisteredUsers -join " | "
            RegistrationDateTime          = $device.RegistrationDateTime
        }
        $results += $entry
    }
    $date = get-date -UFormat %m_%d_%Y
    $fileName = $fileName + "_" + $date
    Write-Host "Exporting devices array to file: '$filename.csv'" -ForegroundColor Yellow
    $results | export-csv -NoClobber -NoTypeInformation -append -path $OutputPath\$fileName.csv
}
else {
    Write-Host "No entries found, no file to be created."  -ForegroundColor Yellow
}