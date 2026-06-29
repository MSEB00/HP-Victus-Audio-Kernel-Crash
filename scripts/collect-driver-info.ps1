Write-Host "===== REALTEK ====="

Get-CimInstance Win32_PnPSignedDriver |
Where-Object {$_.DeviceName -like "*Realtek*"} |
Select DeviceName, DriverVersion, DriverDate, InfName

Write-Host "`n===== AMD AUDIO ====="

Get-CimInstance Win32_PnPSignedDriver |
Where-Object {$_.DeviceName -like "*AMD*Audio*"} |
Select DeviceName, DriverVersion, DriverDate, InfName

Write-Host "`n===== NVIDIA ====="

Get-CimInstance Win32_PnPSignedDriver |
Where-Object {$_.DeviceName -like "*NVIDIA*"} |
Select DeviceName, DriverVersion, DriverDate
