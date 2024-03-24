param location string = 'East US' // Default location

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'MyAppServicePlan15041995'
  location: location
  properties: {
    sku: {
      name: 'B1'
      tier: 'Basic'
    }
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'MyWebApp15041995'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '14.17.0'
        }
      ]
    }
  }
}

output webAppName string = webApp.name
