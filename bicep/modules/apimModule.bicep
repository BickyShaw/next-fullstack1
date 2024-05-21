param location string

param tags object

param agencyCode string

param envCode string

param appName string


param numberCode string

param sku string

param skuCount int 

@description('Optional. Enables system assigned managed identity on the resource.')
param systemAssignedIdentity bool = false

@description('Optional. The ID(s) to assign to the resource.')
param userAssignedIdentities object = {}

param publisherName string

param publisherEmail string

param appInsightsInstrumentationKey string

param subnetResourceId string

param virtualNetworkType string

param publicNetworkAccess string

var identityType = systemAssignedIdentity ? (!empty(userAssignedIdentities) ? 'SystemAssigned,UserAssigned' : 'SystemAssigned') : (!empty(userAssignedIdentities) ? 'UserAssigned' : 'None')

var name = '${agencyCode}${envCode}-${appName}-${numberCode}'

var vnetRGName = '${agencyCode}${envCode}-network-rg-${numberCode}'

var VnetName = '${agencyCode}${envCode}-vnet-001'
var subnetName = '${agencyCode}${envCode}-app-snet-001'


resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  name:VnetName
  scope: resourceGroup(vnetRGName)
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' existing = {
  name:subnetName
  parent: vnet
}

resource apimService 'Microsoft.ApiManagement/service@2023-05-01-preview'={
  name: name
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  identity:{
    type:identityType
    
  }
   properties: {
  
    publisherName:publisherName
    publisherEmail:publisherEmail
    customProperties: {
      'API-MS-APPLICATION-INSIGHTS-APIKEY': appInsightsInstrumentationKey
    }
    publicNetworkAccess:  publicNetworkAccess
    virtualNetworkConfiguration: {
    subnetResourceId: subnetResourceId
    }
    virtualNetworkType: virtualNetworkType
  }
   tags:tags
}
