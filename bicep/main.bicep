param isInitialDeployment bool = false
param appName string
param location string = resourceGroup().location
param appSettings array
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: appServicePlanName
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

module getAppService './getAppService.bicep' = if (!isInitialDeployment) {
  name: 'getAppService'
  params: {
    appName: appName
  }
}
