function EnableDNSForwarder {
	Try {
		Add-DnsServerForwarder -IPAddress 1.1.1.1 -ErrorAction Stop
	}
	Catch { 
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

function EnableNAT {
	Try {
		
		$nat_name = Read-Host "Ingresa el nuevo nombre de la red NAT"
		New-NetNat -Name "$nat_name" -InternalIPInterfaceAddressPrefix 172.16.0.0/24

		Write-Host "Red NAT: $nat_name disponible!" -ForegroundColor Green
	}

	Catch {
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

Clear-History
Write-Host "Ejecutando fase 6..." -ForegroundColor Yellow
EnableDNSForwarder;
EnableNAT;
