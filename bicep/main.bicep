param isInitialDeployment bool = false
param appName string
param location string = resourceGroup().location
param appSettings array

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: appName
  location: location
  properties: {
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
