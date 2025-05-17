# Zona directa
function AddDirectZone {
    Try {
        $domain_name = Read-Host "Ingrese su dominio"
        Add-DnsServerPrimaryZone -Name "$domain_name" -ZoneFile "$domain_name.dns" -ErrorAction Stop
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow
    }
}

function AddRecordsA {
    Try {
        $domain = Read-Host "Ingrese el dominio principal"
        $ip_addr = Read-Host "Ingrese la IP del servidor"
	    $subdomains_list = Read-Host "Ingrese los subdominios que se usaran como registros A. (Use comas para separar los dominios y no agregue espacios innecesarios)"
	    $subdomains = $subdomains_list -split '\,'

        foreach ($subdomain in $subdomains)  {
		     Add-DnsServerResourceRecordA -Name "$subdomain" -ZoneName "$domain" -IPv4Address "$ip_addr" -ErrorAction Stop
        }

	    Write-Host "-Se ha agregado los dominios: '$subdomains' al registro" -ForegroundColor Green
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow  
    }
}

function AddInverseZone {
    Try {
        $ip_addr_net = Read-Host "Ingrese su IP de red (x.x.x.0)"
        $octets = $ip_addr -split '\.'
        Add-DnsServerPrimaryZone -NetworkId "$ip_addr_net/24" -ZoneFile "$($octets[2]).$($octets[1]).$($octets[0]).in-addr.arpa.dns"
	    Write-Host "-Se ha agregado la zona inversa al registro" -ForegroundColor Green
    }

    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow
    }
}

function AddRecordPTR {
    Try {
        $ip_addr = Read-Host "Ingrese la IP del servidor"
        $octets = $ip_addr -split '\.'
        Add-DnsServerResourceRecordPtr -Name "$($octets[3])" -Zone "$($octets[2]).$($octets[1]).$($octets[0]).in-addr.arpa" -PtrDomainName "semita.sv"
	    Write-Host "-Se ha agregado el puntero $domain al registro" -ForegroundColor Green
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow
    }
}

Clear-Host
Write-Host "Ejecutando fase 7..." -ForegroundColor DarkYellow
AddDirectZone;
AddRecordsA;
AddInverseZone;
AddRecordPTR;
