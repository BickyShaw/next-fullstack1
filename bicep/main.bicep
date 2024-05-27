param isInitialDeployment bool = false
param appName string
param appServicePlanName string
param location string = resourceGroup().location
param appSettings array = []

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: appServicePlanName
}

// Module to check if the App Service exists
//module checkAppServiceExists './getAppService.bicep' = if (!isInitialDeployment) {
//  name: 'checkAppServiceExists'
//  params: {
//    appName: appName
//  }
//}

// Fetch the existing App Service properties if not initial deployment and if the resource exists
//module getAppService './getAppService.bicep' = if (!isInitialDeployment) {
//  name: 'getAppService'
//  params: {
//    appName: appName
//  }
//}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: isInitialDeployment ? appSettings : appsettingsCurrent[0].properties
    }
  }
}
