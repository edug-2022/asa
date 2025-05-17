function CreateOrganizationalUnits {
    # Unidad raiz
    New-ADOrganizationalUnit -Name "Gerencia General" -ProtectedFromAccidentalDeletion $true

    # Subunidades de Gerencia General
    New-ADOrganizationalUnit -Name "Compras" -Path "OU=Gerencia General,DC=semita,DC=sv"
    New-ADOrganizationalUnit -Name "Ventas" -Path "OU=Gerencia General,DC=semita,DC=sv"
    New-ADOrganizationalUnit -Name "Diseño" -Path "OU=Gerencia General,DC=semita,DC=sv"
}

function CreateGroupsPerOU {
    $domain = "DC=semita,DC=sv"

    # Gerencia General
    New-ADGroup -Name "Gerencia General" -GroupScope Global -GroupCategory Security -Path "OU=Gerencia General,$($domain)"

    # Compras
    New-ADGroup -Name "Compras" -GroupScope Global -GroupCategory Security -Path "OU=Compras,OU=Gerencia General,$($domain)"
    New-ADGroup -Name "Ventas" -GroupScope Global -GroupCategory Security -Path "OU=Ventas,OU=Gerencia General,$($domain)"
    New-ADGroup -Name "Diseño" -GroupScope Global -GroupCategory Security -Path "OU=Diseño,OU=Gerencia General,$($domain)"
}

function CreateUsers {
    #region GERENCIA GENERAL
    New-ADUser -Name "Benito Martinez" -SamAccountName benito.martinez -AccountPassword (ConvertTo-SecureString "Meportobonito28" -AsPlainText -Force) -Enabled $true -Path "OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity benito.martinez -Title "Presidente"
    Add-ADGroupMember -Identity "Gerencia General" -Members benito.martinez
    #endregion

    #region COMRPRAS
    New-ADUser -Name "Carolina Giraldo" -SamAccountName carolina.giraldo -AccountPassword (ConvertTo-SecureString "Bebecita28" -AsPlainText -Force) -Enabled $true -Path "OU=Compras,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity carolina.giraldo -Title "Secretaria"

    New-ADUser -Name "E. Garay" -SamAccountName garay.admin -AccountPassword (ConvertTo-SecureString "garay" -AsPlainText -Force) -Enabled $true -Path "OU=Compras,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity garay.admin -Title "Coordinador"
    
    
    Add-ADGroupMember -Identity "Compras" -Members carolina.giraldo, garay.admin
    #endregion

    #region VENTAS
    New-ADUser -Name "A. Henríquez" -SamAccountName henriquez.admin -AccountPassword (ConvertTo-SecureString "Password02" -AsPlainText -Force) -Enabled $true -Path "OU=Ventas,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity henriquez.admin -Title "Supervisor"

    New-ADUser -Name "Félix Rosales" -SamAccountName felix.rosales -AccountPassword (ConvertTo-SecureString "Password03" -AsPlainText -Force) -Enabled $true -Path "OU=Ventas,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity felix.rosales -Title "Vendedor"

    Add-ADGroupMember -Identity "Ventas" -Members mario.moreno, felix.rosales
    #endregion

    #region DISEÑO
    New-ADUser -Name "Yanira Berrios" -SamAccountName yanira.berrios -AccountPassword (ConvertTo-SecureString "Corazonbello28" -AsPlainText -Force) -Enabled $true -Path "OU=Diseño,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity yanira.berrios -Title "Secretaria"

    New-ADUser -Name "Manuel López" -SamAccountName manuel.lopez -AccountPassword (ConvertTo-SecureString "Password04" -AsPlainText -Force) -Enabled $true -Path "OU=Diseño,OU=Gerencia General,DC=semita,DC=sv"
    Set-ADUser -Identity manuel.lopez -Title "Diseñador"

    Add-ADGroupMember -Identity "Diseño" -Members yanira.berrios, manuel.lopez
    #endregion
}

CreateOrganizationalUnits;
CreateGroupsPerOU;
CreateUsers;
