function InstallDHCP {
    Try {
        Install-WindowsFeature -Name DHCP -IncludeManagementTools -ErrorAction Stop
    }

    Catch {
        Write-Host $_.Exception.Message -ForegroundColor Yellow
    }
}

function ConfigureDHCP {

}

Clear-Host
Write-Host "Ejecutando fase 5" -ForegroundColor Yellow;
InstallDHCP;

