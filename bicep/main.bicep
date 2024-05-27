param isInitialDeployment bool = true
param appName string
param location string = resourceGroup().location
param appSettings object = {}
param appServicePlanName string


resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' existing = {
  name: appServicePlanName
}

module AppService './appservice.bicep' = {
  name: 'DeployingAppService'
  params: {
    appName: appName
    appServicePlanId: appServicePlan.id
    location: location
    appSettings: appSettings
    currentAppSettings: isInitialDeployment ? appSettings : list(resourceId('Microsoft.Web/sites/config', 'appName', 'appsettings'), '2023-01-01').properties
//    dockerImage: dockerImage
//    tags: tags
  }
}
