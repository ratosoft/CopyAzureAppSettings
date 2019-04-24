#PREENCHER AS VARIÁVEIS ABAIXO
$tenantIdSource = "3737ddf7-0b60-4f73-a0ce-2abe5bb94cf4"
$tenantIdTarget = "3737ddf7-0b60-4f73-a0ce-2abe5bb94cf4"

$subscriptionIdSource = ""
$subscriptionIdTarget = ""

$resourceGroupSource = ""
$resourceGroupTarget = ""

$webAppsource = ""
$webAppTarget = ""

#CASO NÃO UTILIZE SLOT, DEIXAR A VARIÁVEIS REFERENTE AO SLOT EM BRANCO
$slotSource = ""
$slotTarget = ""
#PREENCHER AS VARIÁVEIS ACIMA

Login-AzureRmAccount -TenantId $tenantIdSource -SubscriptionId $subscriptionIdSource 

#Set-AzureRmContext -subscriptionId $subscriptionIdSource

# Load Existing Web App settings for source and target
If($slotSource -eq "") {    
    $webAppSource = Get-AzureRmWebApp -ResourceGroupName $resourceGroupSource -Name $webAppsource
}
Else {
    $webAppSource = Get-AzureRmWebAppSlot -ResourceGroupName $resourceGroupSource -Name $webAppsource -Slot $slotSource
}

# Get reference to the source Connection Strings
#$connectionStringsSource = $webAppSource.SiteConfig.ConnectionStrings


# Create Hash variable for Connection Strings
#$connectionStringsTarget = @{}

# Copy over all Existing Connection Strings to the Hash
#ForEach ($connStringSource in $connectionStringsSource) {
    #$connectionStringsTarget[$connStringSource.Name] = @{ Type = $connStringSource.Type.ToString(); Value = $connStringSource.ConnectionString }
#}
    

# Save Connection Strings to Target
#If($slotTarget -eq "") {
    #Set-AzureRmWebApp -ResourceGroupName $resourceGroupTarget -Name $webAppTarget ConnectionStrings $connectionStringsTarget
#}
#Else {
    #Set-AzureRmWebAppSlot -ResourceGroupName $resourceGroupTarget -Name $webAppTarget -Slot $slotTarget -ConnectionStrings $connectionStringsTarget
#}

# Get reference to the source app settings
$appSettingsSource = $webAppSource.SiteConfig.AppSettings


Set-AzureRmContext -SubscriptionId $subscriptionIdTarget

# Create Hash variable for App Settings
$appSettingsTarget = @{}


# Copy over all Existing App Settings to the Hash
ForEach ($appSettingSource in $appSettingsSource) {
    $appSettingsTarget[$appSettingSource.Name] = $appSettingSource.Value
}

# Save Connection Strings to Target
If($slotTarget -eq "") {
    Set-AzureRmWebApp -ResourceGroupName $resourceGroupTarget -Name $webAppTarget -AppSettings $appSettingsTarget
}
Else {
    Set-AzureRmWebAppSlot -ResourceGroupName $resourceGroupTarget -Name $webAppTarget -Slot $slotTarget -AppSettings $appSettingsTarget
}
