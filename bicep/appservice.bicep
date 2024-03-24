param location string = 'East US'
param appName string
param skuTier string
param nodeVersion string = '14.17'

var defaultSkuTier = 'Free' // Default SKU tier if not provided in parameters

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appName}-asp'
  location: location
  properties: {
    sku: {
      tier: coalesce(skuTier, defaultSkuTier) // Use provided value or default if null
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
