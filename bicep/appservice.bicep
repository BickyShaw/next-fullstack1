param location string = 'East US'
param appName string
param skuTier string
param nodeVersion string = '14.17'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-asp'
  location: location
  properties: {
    sku: {
      tier: skuTier // Use the provided value for SKU tier
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
