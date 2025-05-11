Clear-Host

Write-Host "Ejecutando fase 1" -ForegroundColor Yellow; 

Try {

    $folderPath = "C:\Users\Administrador\Documents\WindowsPowerShell"

    if (-not (Test-Path -Path $folderPath)) {
        New-Item -Path $folderPath -ItemType Directory | Out-Null
    }

    New-Item -Path $folderPath -Name "Microsoft.Powershell_profile.ps1" -ErrorAction Stop | Out-Null

    Write-Host "Se ha creado un pefil por defecto para Powershell" -ForegroundColor Green

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    . $profile -ErrorAction Stop

    Write-Host "Chocolatey ha sido instalado y se ha reiniciado el perfil de PS. (Se recomienda reiniciar el equipo si Chocolatey no funciona)" -ForegroundColor Green
}

Catch {
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}
