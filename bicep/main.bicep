param isInitialDeployment bool = true
param appName string
param location string = resourceGroup().location
param appServicePlanName string
param value1 string
param value2 string
param value3 string
param value4 string

var newAppSettings = {
  setting1: value1
  setting2: value2
  setting3: value3
  setting4: value4
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
    appSettings: newAppSettings
    currentAppSettings: isInitialDeployment ? {} : list(resourceId('Microsoft.Web/sites/config', appName, 'appsettings'), '2022-03-01').properties
  }
}
