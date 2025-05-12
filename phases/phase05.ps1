function InstallDHCP {
    Try {
        Install-WindowsFeature -Name DHCP -IncludeManagementTools -ErrorAction Stop
	Add-DhcpServerInDC -DnsName "semita.sv" -IpAddress "172.16.0.2" -ErrorAction Stop
	Add-DhcpServerv4Scope -Name "Oficina" -StartRange 172.16.0.100 -EndRange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active -ErrorAction Stop
	Set-DhcpServerv4OptionValue -ScopeId 172.16.0.0 -Router 172.6.0.2 -ErrorAction Stop
	Set-DhcpServerv4OptionValue -ScopeId 172.16.0.0 -DnsServer 172.16.0.2, 1.1.1.1 -DnsDomain "semita.sv"
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

