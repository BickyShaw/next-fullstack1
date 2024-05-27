param appName string
param location string
param appServicePlanId string
param appSettings object
param currentAppSettings object

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlanId
  }
}

//just editing

resource siteconfig 'Microsoft.Web/sites/config@2022-03-01' = {
  parent: webApp
  name: 'appsettings'
  properties: union(appSettings, currentAppSettings)
}
