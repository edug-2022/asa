function ReverseLookupZone {
	Try {
		Add-DnsServerPrimaryZone -NetworkId "$ip_addr" -ReplicationScope "Forest" -ErrorAction Stop	
	}
	Catch { 
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

function AddRecordA {
	Try {
		$records = @(
			"www"
			"ftp"
		)

		Add-DnsServerResourceRecordA -Name "semita-server" -ComputerName "$ip_addr" -ZoneName "$domain_name" -AllowUpdateAny -IPv4Address "$ip_addr"
	}

	Catch {
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

Clear-History
Write-Host "Ejecutando fase 6..." -ForegroundColor Yellow
$ip_addr = Read-Host "Ingrese la IP del DNS"
$domain_name = Read-Host "Ingrese el dominio del DNS/AD-DS"
EnableDNSForwarder;
EnableNAT;
