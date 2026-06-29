Write-Host "===== AUDIO ENDPOINTS ====="

Get-PnpDevice -Class AudioEndpoint

Write-Host "`n===== AUDIO DEVICES ====="

Get-PnpDevice | Where-Object {
    $_.Class -eq "MEDIA"
}
