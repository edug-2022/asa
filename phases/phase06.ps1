Try {
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "IPEnableRouter" -Value 1
	WriteHost "Se permite la conexión al exterior. Se recomienda reiniciar el equipo con: shutdown /r /t 0"
}
Catch {
	Write-Host $($_.Exception.Message) -ForegroundColor Yellow
}
