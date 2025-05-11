#region Variables

$phasesPath = Join-Path -Path $PSScriptRoot -ChildPath "phases"
# Obtener todos los scripts de fase ordenados por nombre
$phaseScripts = Get-ChildItem -Path $phasesPath -Filter *.ps1 | Sort-Object Name
$menuOptions = @(
    "1. Instalar Chocolatey (requiere reinicio)",
    "2. Configurar red",
    "3. Configurar reglas de firewall",
    "0. Salir"
)

#endregion

Clear-Host
Write-Host "
 ░▒▓██████▓▒░ ░▒▓███████▓▒░░▒▓██████▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░ 
░▒▓████████▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░       
░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░ 
Autobuild a Server Automatically (ASA! <3)
by: name
" -ForegroundColor Cyan

foreach ($option in $menuOptions) {
    Write-Host $option
}

$_input = Read-Host -Prompt "Ingrese el número de la fase a ejecutar"
$selectedPhase = ""

switch ($_input) {
    0 { clear; exit }
    1 { $selectedPhase = "phase01.ps1"; }
    2 { $selectedPhase = "phase02.ps1"; }
    3 { $selectedPhase = "phase03.ps1"}
    Default { Write-Host "Opcion no válida! Programa finalizado..." -ForegroundColor Red}
}

foreach ($script in $phaseScripts) {
    if ($script.Name -eq $selectedPhase) {
        . $script.FullName
    }
}