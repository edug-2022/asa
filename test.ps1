# # Zona directa
function AddDirectZone {
    Try {
        $domain_name = Read-Host "Ingrese su dominio"
        Add-DnsServerPrimaryZone -Name "$domain_name" -ZoneFile "$domain_name.dns" -ErrorAction Stop
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow
    }
}

# # Zona inversa
function AddInverseZone {
    Try {
        $ip_addr_net = Read-Host "Ingrese su IP de red (x.x.x.0)"
        $octets = $ip_addr -split '\.'
        Add-DnsServerPrimaryZone -NetworkId "$ip_addr_net/24" -ZoneFile "$($octets[2]).$($octets[1]).$($octets[0]).in-addr.arpa.dns"
    }

    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow
    }
}


function AddRecords {
    Try {
        Write-Host "NOTA: Use las comas como separadores y sin espacios" -ForegroundColor Cyan
        $subdomains_list = Read-Host "Ingrese el/los subdominio(s)"
        $subdomains = $subdomains_list -split '\,'
        $domain = Read-Host "Ingrese el dominio"
        $ip_addr = Read-Host "Ingrese la IP del servidor"

        foreach ($subdomain in $subdomains) {
            Write-Host $subdomain -ForegroundColor DarkYellow
            Add-DnsServerResourceRecordA -Name "$subdomain" -ZoneName "$domain" -IPv4Address "$ip_addr" -CreatePtr -ErrorAction Stop
        }
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor DarkYellow  
    }
}

AddDirectZone;
AddInverseZone;
AddRecords;