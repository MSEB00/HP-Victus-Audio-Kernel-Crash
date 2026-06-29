Write-Host "=============================="
Write-Host " HP Victus Diagnostic Toolkit"
Write-Host "=============================="

.\collect-system-info.ps1

.\collect-driver-info.ps1

.\collect-audio-endpoints.ps1

.\collect-services.ps1

.\collect-reliability.ps1

.\collect-event-logs.ps1

.\collect-crash-dumps.ps1

.\collect-dism-info.ps1

.\collect-directx-info.ps1

.\collect-gpu-info.ps1

.\collect-system-files.ps1

.\collect-bios-info.ps1

Write-Host "`nDiagnostic collection completed."
