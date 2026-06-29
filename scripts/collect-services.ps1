Write-Host "===== AUDIO SERVICES ====="

Get-Service audiosrv,AudioEndpointBuilder

Write-Host "`n===== WINDOWS UPDATE ====="

Get-Service wuauserv

Write-Host "`n===== RPC ====="

Get-Service RpcSs
