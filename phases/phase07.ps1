function AddRecordA {
	Try {
		$records = @(
			"www",
			"ftp",
			"rdp"
		)
		foreach ($record in $records) {
			Add-DnsServerResourceRecordA -Name "$record" -ComputerName "$ip_addr" -ZoneName "$domain_name" -AllowUpdateAny -IPv4Address "$ip_addr"
		}
		Write-Host "Se han configurado los subdominios correspondientes con éxito!" -Foreground Green 
	}

	Catch {
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

function ReverseLookupZone {
	Try {
		Add-DnsServer -NetworkId "$ip_addr" -ReplicationScope "Forest"	
	}
	Catch { 
		Write-Host $_.Exception.Message -ForegroundColor Yellow
	}
}

function AddRecordPTR {
	Try {
		$ip_addr
		$octets = $ip_addr -split '\.'

		Add-DnsServerResourceRecordPtr -Name "$($octets[3])" -ZoneName "$($octets[2]).$($octets[1]).$($octets[0]).in-addr.arpa" -PtrDomainName "servidor1.ejemplo.local"
	}
	Catch {
		
	}
}

Clear-History
Write-Host "Ejecutando fase 7..." -ForegroundColor DarkYellow
$ip_addr = Read-Host "Ingrese la IP del DNS"
$domain_name = Read-Host "Ingrese el dominio del DNS/AD-DS"
ReverseLookupZone;
AddRecordA;
