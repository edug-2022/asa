Clear-Host

$rules = @(
    "CoreNet-Diag-ICMP6-EchoRequest-Out",
    "CoreNet-Diag-ICMP6-EchoRequest-Out-NoScope",
    "CoreNet-Diag-ICMP6-EchoRequest-In",
    "CoreNet-Diag-ICMP6-EchoRequest-In-NoScope",
    "CoreNet-Diag-ICMP4-EchoRequest-Out",
    "CoreNet-Diag-ICMP4-EchoRequest-Out-NoScope",
    "CoreNet-Diag-ICMP6-EchoRequest-In",
    "CoreNet-Diag-ICMP4-EchoRequest-In-NoScope"
)

foreach ($rule in $rules) {
    Enable-NetFirewallRule -Name "$rule"
    Get-NetFirewallRule -Name "$rule" | Select-Object Name, Enabled
}

Write-Host "Se han habilitado los puertos y reglas necesarias con éxito!" -ForegroundColor Green