param appName string

resource webApp 'Microsoft.Web/sites@2021-02-01' existing = {
  name: appName
}

output appSettings array = webApp.properties.siteConfig.appSettings
