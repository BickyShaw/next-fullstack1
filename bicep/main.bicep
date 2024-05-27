param isInitialDeployment bool = false
param appName string
param location string = resourceGroup().location
param appServicePlanName string
param value1 string
param value2 string
param value3 string

var appSettings = {
  setting1: value1
  setting2: value2
  setting3: value3
}

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
