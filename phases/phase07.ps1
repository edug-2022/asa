function ReverseLookupZone {
	Try {
		Add-DnsServerPrimaryZone -NetworkId "$ip_addr" -ReplicationScope "Forest"	
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

Clear-History
Write-Host "Ejecutando fase 6..." -ForegroundColor Yellow
$ip_addr = Read-Host "Ingrese la IP del DNS"
$domain_name = Read-Host "Ingrese el dominio del DNS/AD-DS"
ReverseLookupZone;
AddRecordA;
