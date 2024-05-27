param appName string
param location string
param appServicePlanId string
//param isInitialDeployment bool = false
param appSettings object ={}
param currentAppSettings object = {}




resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlanId
  }
}

resource siteconfig 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: webApp
  name: 'appsettings'
  properties: union(currentAppSettings, appSettings)
}
