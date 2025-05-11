# Instalar Active Dictory
Clear-Host

Try {
    Install-WindowsFeature -Name AD-Domain-Services -ErrorAction Stop

    Write-Host "======= INSTALACION DE AD-DS =======" -ForegroundColor Cyan

    $domain = Read-Host "Ingrese el nombre del dominio"
    $netbios = Read-Host "Ingrese el nombre para el NetBIOS"
    $password = Read-Host "Ingrese una contraseña para el dominio"

    Install-ADDSForest `
        -DomainName "$domain" `
        -DomainNetbiosName "$netbios" `
        -SafeModeAdministratorPassword (ConvertTo-SecureString "$password" -AsPlainText -Force) `
        -InstallDNS `
        -Force
}
Catch {
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}