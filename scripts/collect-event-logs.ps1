Write-Host "===== SYSTEM ERRORS ====="

Get-WinEvent -LogName System -MaxEvents 100

Write-Host "`n===== APPLICATION ERRORS ====="

Get-WinEvent -LogName Application -MaxEvents 100
