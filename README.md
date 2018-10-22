# Script para cópia de Application Settings de um Azure App Service para outro

## Instruções de uso:
1) PREENCHER AS VARIÁVEIS:

    $subscriptionIdSource = ""

    $subscriptionIdTarget = ""

    $resourceGroupSource = ""

    $resourceGroupTarget = ""

    $webAppsource = ""

    $webAppTarget = ""

2) Somente em caso seja um Deployment Slot, preencher abaixo. Caso contrário, deixar string vazia.

    $slotSource = ""

    $slotTarget = ""

3) Abrir Powershell e executar: 
    
     .\copyappsettings.ps1


Script adaptado de: https://github.com/JasonHaley/AzureHelp/blob/master/WebApps/CopyConnectionStringsAndAppSettings.ps1