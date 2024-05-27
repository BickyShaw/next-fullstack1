param isInitialDeployment bool = false
param appName string
param appServicePlanName string
param location string = resourceGroup().location
param appSettings array = []

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: appServicePlanName
}

// Fetch the existing App Service properties if not initial deployment
module getAppService 'getAppService.bicep' = if (!isInitialDeployment) {
  name: 'getAppService'
  params: {
    appName: appName
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: isInitialDeployment ? appSettings : union(getAppService.outputs.appSettings, appSettings)
    }
  }
}
