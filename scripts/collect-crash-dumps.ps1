Write-Host "===== MINIDUMPS ====="

Get-ChildItem C:\Windows\Minidump |
Sort LastWriteTime -Descending

Write-Host "`n===== MEMORY.DMP ====="

Get-Item C:\Windows\MEMORY.DMP -ErrorAction SilentlyContinue
