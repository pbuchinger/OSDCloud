Write-Host -ForegroundColor Cyan "Starting Nufarm OSDCloud Deployment"
Start-Sleep -seconds 5

Start-OSDCloudGUI

#=======================================================================
#   PostOS: AutopilotOOBE Staging
#=======================================================================


Write-Host -ForegroundColor Green "Creating directory C:\ProgramData\OSDeploy"

if (!(Test-Path "C:\ProgramData\OSDeploy")) {
        New-Item "C:\ProgramData\OSDeploy" -ItemType Directory -Force | Out-Null
    }

Write-Host -ForegroundColor Green "Creating C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json"

$AutopilotOOBEJson = @'
{
    "Assign":  {
                   "IsPresent":  true
               },
    "GroupTag":  "AT-LNZ-CORP",
    "GroupTagOptions":  [
                            				"AR-VEN-CORP",
							"AT-LNZ-CORP",
							"AU-DRY-CORP",
							"AU-LAV-CORP",
							"AU-LAV-LAB",
							"BR-ACN-CORP",
							"BR-CWB-CORP",
							"CA-BAR-CORP",
							"CA-REM-CORP",
							"CN-SHA-CORP",
							"DE-CGN-CORP",
							"EG-CAI-CORP",
							"ES-BAR-CORP",
							"FR-CDG-CORP",
							"FR-GAI-CORP",
							"FR-GAI-LAB",
							"FR-REM-CORP",
							"GR-ATH-CORP",
							"ID-JAK-CORP",
							"ID-MER-CORP",
							"ID-REM-CORP",
							"IT-BLQ-CORP",
							"JP-TOK-CORP",
							"KR-SEO-CORP",
							"MX-QUE-CORP",
							"MY-POR-CORP",
							"MY-SET-CORP",
							"NL-CAP-CORP",
							"NZ-OTA-CORP",
							"PL-WAR-CORP",
							"PT-LIS-CORP",
							"RO-BUH-CORP",
							"RS-QND-CORP",
							"TR-IST-CORP",
							"UA-KBP-CORP",
							"UK-MAN-CORP",
							"UK-WYK-CORP",
							"UK-WYK-LAB",
							"US-ALP-CORP",
							"US-BRE-CORP",
							"US-CHI-CORP",
							"US-GRE-CORP",
							"US-MOR-CORP",
							"US-REM-CORP",
							"US-SMF-LAB",
							"US-SMF-CORP",
							"US-WOO-CORP",
							"VN-HOC-CORP"
                        ],
    "Hidden":  [
                   "AddToGroup",
                   "AssignedComputerName",
                   "AssignedUser",
                   "PostAction"
               ],
    "PostAction":  "Quit",
    "Run":  "NetworkingWireless",
    "Docs":  "https://autopilotoobe.osdeploy.com/",
    "Title":  "Nufarm Autopilot Registration"
}
'@
$AutopilotOOBEJson | Out-File -FilePath "C:\ProgramData\OSDeploy\OSDeploy.AutopilotOOBE.json" -Encoding ascii -Force

#OOBE SCript




Write-Host -ForegroundColor Green "Creating C:\Windows\System32\OOBETasks.CMD"
$OOBETasksCMD = @'
PowerShell -NoL -Com Set-ExecutionPolicy RemoteSigned -Force
Set Path = %PATH%;C:\Program Files\WindowsPowerShell\Scripts
Start /Wait PowerShell -NoL -C Install-Module AutopilotOOBE -Force -Verbose
Start /Wait PowerShell -NoL -C Install-Module OSD -Force -Verbose
Start /Wait PowerShell -NoL -C Start-AutopilotOOBE
Start /Wait PowerShell -NoL -C Start-OOBEDeploy
Start /Wait PowerShell -NoL -C Restart-Computer -Force
'@
$OOBETasksCMD | Out-File -FilePath 'C:\Windows\System32\OOBETasks.CMD' -Encoding ascii -Force
