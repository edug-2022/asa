function ConfigureAdapter {
    Try {
    Rename-NetAdapter -Name "Ethernet 2" -NewName "semita" -ErrorAction Stop
    Rename-NetAdapter -Name "Ethernet" -NewName "default" -ErrorAction Stop

    Write-Host "Se ha cambiado con exito el nombre de las interfaces!" -ForegroundColor Green
    }
    Catch {
        Write-Host "Error al nombrar el adaptador:" -ForegroundColor Red
        Write-Host $($_.Exception.Message) -ForegroundColor Yellow
    }
}

function ConfigureIPAddress {
    Try {
        # IPv4
        # New-NetIPAddress -IPAddress 172.30.64.1 -InterfaceAlias "default" -AddressFamily IPv4 -PrefixLength 20 -ErrorAction Stop | Out-Null
    
        New-NetIPAddress -IPAddress 172.16.0.4 -InterfaceAlias "semita" -AddressFamily IPv4 -PrefixLength 24 -ErrorAction Stop | Out-Null

        Write-Host "Se ha cambiado con exito el subneteo de la red!" -ForegroundColor Green
    }
    Catch {
        Write-Host "Error al configurar la IP:" -ForegroundColor Red
        Write-Host $($_.Exception.Message) -ForegroundColor Yellow
    }
}

function SetDNS {
    Try {
        
        Set-DnsClientServerAddress -InterfaceAlias "semita" -ServerAddresses "172.16.0.2", "1.1.1.1" | Out-Null
        Write-Host "Se ha asginado con exito el DNS en el servidor!" -ForegroundColor Green
        ipconfig /flushdns | Out-Null
        Write-Host "Nota: Se ha reiniciado el caché del DNS!" -ForegroundColor Cyan
    }
    Catch {
        Write-Host "Error al asignar el DNS": -ForegroundColor Red
        Write-Host $($_.Exception.Message) -ForegroundColor Yellow
    }
}

Clear-Host
Write-Host "Ejecutando fase 2" -ForegroundColor Yellow;

ConfigureAdapter;
ConfigureIPAddress;
SetDNS;