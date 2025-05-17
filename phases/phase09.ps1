function CreateCertDir {
    # Crear carpeta para certificados

    $folderPath = "C:\Certs"

    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory -Force | Out-Null
    }
}

function CreateCert {
    # Crear CA raíz (auto-firmada)
    $caCert = New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My `
        -Subject "CN=Nayib Root CA" `
        -KeyExportPolicy Exportable `
        -KeyUsage CertSign, CRLSign, DigitalSignature `
        -KeyLength 2048 `
        -KeyAlgorithm RSA `
        -HashAlgorithm SHA256 `
        -NotAfter (Get-Date).AddYears(10) `
        -KeyUsageProperty All `
        -TextExtension @("2.5.29.19={critical}{text}")

    # Exportar certificado de la CA raíz para distribuir en clientes
    Export-Certificate -Cert $caCert -FilePath "C:\Certs\nayib_root_ca.cer"

    # Obtener objeto CA para firmar certificados
    $ca = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object { $_.Subject -eq "CN=Nayib Root CA" }

    # Crear certificado SSL para www.semita.sv firmado por la CA
    $webCert = New-SelfSignedCertificate -DnsName "www.semita.sv" `
        -CertStoreLocation Cert:\LocalMachine\My `
        -Signer $ca `
        -KeyExportPolicy Exportable `
        -KeyLength 2048 `
        -KeyAlgorithm RSA `
        -HashAlgorithm SHA256 `
        -NotAfter (Get-Date).AddYears(2) `
        -KeyUsage DigitalSignature, KeyEncipherment `
        -FriendlyName "Cert SSL www.semita.sv"

    # Exportar certificado público para referencia
    Export-Certificate -Cert $webCert -FilePath "C:\Certs\semita_cert.cer"

    # Exportar certificado con clave privada (PFX) con contraseña
    Export-PfxCertificate -Cert $webCert -FilePath "C:\Certs\semita_cert.pfx" -Password (ConvertTo-SecureString -String "semita123" -AsPlainText -Force)

    # Importar CA raíz al almacén de "Trusted Root Certification Authorities"
    Import-Certificate -FilePath "C:\Certs\nayib_root_ca.cer" -CertStoreLocation Cert:\LocalMachine\Root

    # Obtener thumbprint del certificado www.semita.sv (sin espacios)
    $thumb = (Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -like "*www.semita.sv*" }).Thumbprint.Replace(" ", "")

    # Identificador único para el appid (puedes cambiarlo si quieres)
    $appid = "{00112233-4455-6677-8899-AABBCCDDEEFF}"

    # Registrar el certificado SSL para HTTPS en el puerto 443 (en todas las interfaces)
    netsh http add sslcert ipport=0.0.0.0:443 certhash=$thumb appid=$appid

    # Importar módulo WebAdministration para administrar IIS (asumiendo que tienes IIS instalado)
    Import-Module WebAdministration

    # Crear binding HTTPS para el sitio predeterminado en IIS con el hostname y puerto 443
    New-WebBinding -Name "Default Web Site" -Protocol https -Port 443 -HostHeader "www.semita.sv"

    # Establecer sslFlags en 1 para indicar que requiere SSL y usar SNI (Server Name Indication)
    Get-WebBinding -Name "Default Web Site" -Protocol https | Set-WebBinding -PropertyName sslFlags -Value 1 -Name "Default Web Site"

    # Añadir nuevos bindings específicos con dirección IP y hostnames personalizados
    New-WebBinding -Name "Default Web Site" -Protocol "https" -Port 443 -IPAddress "172.16.0.2" -HostHeader "semita.sv"
    New-WebBinding -Name "Default Web Site" -Protocol "https" -Port 443 -IPAddress "172.16.0.2" -HostHeader "www.semita.sv"

    Write-Host "Configuración completada. Recuerda importar el certificado 'nayib_root_ca.cer' en los clientes para confiar en la CA."
}

Clear-Host
Write-Host "Ejecutando fase 9..." -ForegroundColor DarkYellow
CreateCertDir;
CreateCert;
