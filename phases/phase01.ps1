New-Item -Path "C:\Users\Administrator\Documents\WindowsPowerShell\" -Name "Microsoft.Powershell_profile.ps1"

Write-Host "Se ha creado un pefil por defecto para Powershell" -ForegroundColor Green

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

. $profile

Write-Host "Chocolatey ha sido instalado y se ha reiniciado el perfil de PS. (Se recomienda reiniciar el equipo si Chocolatey no funciona)" -ForegroundColor Green