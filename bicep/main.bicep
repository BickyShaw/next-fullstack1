param apimName string = 'apimPocMNIT'
param vnetName string = 'apimVnetPocMNIT'
param subnetName string = 'apimSubnetPocMNIT'
param nsgName string = 'apimPocNSGMNIT'
param publicIpName string = 'apimPocPIPMNIT'
param location string = 'central us'
param tags object

param sku string
param skuCount int
param publisherName string
param publisherEmail string
param appInsightsInstrumentationKey string
param publicNetworkAccess string
param subnetResourceId string
param virtualNetworkType string


module apim './modules/apimModule.bicep' = {
  name: apimName
  params: {
    location: location
    sku: sku
    skuCount: skuCount 
    publisherName:publisherName
    publisherEmail:publisherEmail
    appInsightsInstrumentationKey: appInsightsInstrumentationKey
    publicNetworkAccess: publicNetworkAccess
    subnetResourceId: subnetResourceId
    virtualNetworkType: virtualNetworkType
    }
    tags:tags
    
  }
}

module vnet './modules/vnetModule.bicep' = {
  name: vnetName
  params: {
    location: location
    tags: tags
  }
}

module subnet './modules/subnetModule.bicep' = {
  name: subnetName
  params: {
    vnetName: vnetName
    location: location
    tags: tags
  }
}

module nsg './modules/nsgModule.bicep' = {
  name: nsgName
  params: {
    subnetName: subnetName
    location: location
  }
}

module publicIp './modules/publicIpModule.bicep' = {
  name: publicIpName
  params: {
    location: location
    tags: tags
  }
}

module logAnalytics './modules/logAnalyticsModule.bicep' = {
  name: '${apimName}-loganalytics'
  params: {
    apimName: apimName
    location: location
    tags: tags
  }
}

module appInsights './modules/appInsightsModule.bicep' = {
  name: '${apimName}-appinsights'
  params: {
    apimName: apimName
    location: location
    tags: tags
  }
}

module diagnostics './modules/diagnosticsModule.bicep' = {
  name: '${apimName}-diagnostics'
  params: {
    apimName: apimName
    location: location
    tags: tags
  }
}
