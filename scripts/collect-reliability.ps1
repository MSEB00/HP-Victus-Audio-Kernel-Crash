Write-Host "===== RELIABILITY MONITOR EVENTS ====="

Get-WinEvent -LogName Microsoft-Windows-Reliability-Operational -MaxEvents 100
