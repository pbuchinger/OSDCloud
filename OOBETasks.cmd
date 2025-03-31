Write-Host -ForegroundColor Green "Create C:\Windows\System32\OOBETasks.CMD"
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
