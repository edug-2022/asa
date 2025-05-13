function InstallWebServer {
    $folderPath = "C:\www"

    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory | Out-Null
        Write-Host "Se ha creado la carpeta 'C:\www'"
    }

    Install-WindowsFeature Web-Server
    Get-Service W3SVC
    Set-ItemProperty 'IIS:\Sites\Default Web Site' -Name physicalPath -Value "$folderPath"
    Write-Host "Se ha instalado correctamente el servidor web!" -ForegroundColor Green
}

function SetNewBindings {
    Try {
        Get-WebBinding -Name "Default Web Site" | Remove-WebBinding
        
        $sites_count = Read-Host "Indique cuantos dominios agregará"
        
        for ($i = 0; $i -lt $sites_count.Count; $i++) {
            $domain_name = Read-Host "Ingrese el dominio #$i"

            New-WebBinding -Name "Default Web Site" -Protocol "http" -Port 80 -IPAddress "172.16.0.2" -HostHeader "$domain_name"
        }

        Write-Host "Se han añadido $sites_count sitios a los bidnings"
    }
    Catch {
        Write-Host $($_.Exception.Message) -ForegroundColor Yellow
    }
}

Clear-Host
Write-Host "Ejecutando fase 8..." -ForegroundColor DarkYellow
InstallWebServer;
SetNewBindings;