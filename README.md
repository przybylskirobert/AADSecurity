# AADSecurity Repository

Hi there!
This is my place where I'm putting all the scripts and config files regarding Azure Active Directory Security check.

Run the command below in order to start check and save all data into the C:\temp folder

- .\Get-AADAudit.ps1 -AuditPath 'c:\temp'

If you need also to save RAW json files from the script run run the following command
- .\Get-AADAudit.ps1 -AuditPath 'c:\temp' -IncludeRAW
