function ConfigureAdapter {
    Try {
    $interfaces = Read-Host "¿Cuántas interfaces de red piensas configurar?"
    Write-Host "=========="

    For ($contador = 0; $contador -lt $interfaces; $contador++) {

        $interface_name = Read-Host "Ingrese el nombre de la interfaz que va a cambiar"
        $interface_newName = Read-Host "Ingrese el nuevo nombre"
        
        Rename-NetAdapter -Name "$interface_name" -NewName "$interface_newName" -ErrorAction Stop
        
        Write-Host "La interfaz: " -NoNewline
        Write-Host "$interface_name" -ForegroundColor Cyan -NoNewline
        Write-Host " ahora se llamará: " -ForegroundColor White -NoNewline
        Write-Host "$interface_newName" -ForegroundColor Green
        Write-Host "=========="

    }

    Write-Host "Se ha cambiado con exito el nombre de todas las interfaces!" -ForegroundColor Green
    }
    Catch {
        Write-Host "Error al nombrar el adaptador:" -ForegroundColor Red
        Write-Host $($_.Exception.Message) -ForegroundColor Yellow
    }
}

function ConfigureIPAddress {
    Try {
        # IPv4

        $interface_name = Read-Host "Asigna la IP de la interfaz de red que será configurado"

        New-NetIPAddress -IPAddress 172.16.0.2 -InterfaceAlias "$interface_name" -AddressFamily IPv4 -PrefixLength 24 -ErrorAction Stop | Out-Null
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
Write-Host "Ejecutando fase 2" -ForegroundColor DarkYellow;

ConfigureAdapter;
ConfigureIPAddress;
SetDNS;