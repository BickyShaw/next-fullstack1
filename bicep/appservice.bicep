param location string = 'East US'
param appName string
param skuTier string = 'Free' // Default SKU tier
param nodeVersion string = '14.17'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-asp'
  location: location
  properties: {
    sku: {
      tier: skuTier
      size: 'F1' // Default size for example purposes
    }
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: nodeVersion
        }
      ]
    }
  }
}

output webAppName string = webApp.name
output appServicePlanName string = appServicePlan.name
