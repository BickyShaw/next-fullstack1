param webAppName string
param location string
param sku string = 'F1' // Free pricing tier

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${webAppName}-plan'
  location: location
  kind: 'Linux'
  sku: {
    name: sku
    tier: 'Free'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: true
      linuxFxVersion: 'DOCKER|nginx'
    }
  }
}
