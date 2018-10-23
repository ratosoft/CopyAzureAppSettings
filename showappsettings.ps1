#PREENCHER AS VARIÁVEIS ABAIXO
$subscriptionIdSource = "eed6aaac-5bd3-4b0b-b5ba-f977353c03de"

$resourceGroupSource = "gpsrgphom"

$webAppsource = "admwebhom"


#CASO NÃO UTILIZE SLOT, DEIXAR A VARIÁVEIS REFERENTE AO SLOT EM BRANCO
$slotSource = ""
#PREENCHER AS VARIÁVEIS ACIMA

Login-AzureRmAccount

Set-AzureRmContext -subscriptionId $subscriptionIdSource

# Load Existing Web App settings for source and target
If ($slotSource -eq "") {    
    $webAppSource = Get-AzureRmWebApp -ResourceGroupName $resourceGroupSource -Name $webAppsource
}
Else {
    $webAppSource = Get-AzureRmWebAppSlot -ResourceGroupName $resourceGroupSource -Name $webAppsource -Slot $slotSource
}

# Get reference to the source app settings
$appSettingsSource = $webAppSource.SiteConfig.AppSettings


# Copy over all Existing App Settings to the Hash
ForEach ($appSettingSource in $appSettingsSource) {
    #$appSettingsTarget[$appSettingSource.Name] = $appSettingSource.Value
    Write-Output $($appSettingSource.Name + '=' + $appSettingSource.Value)
}

