param vnetName string
param location string
param tags object

var subnetName = '${agencyCode}${envCode}-${appName}-snet-${numberCode}'

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-11-01' = {
  name: subnetName
  parent: vnet
  location: location
  tags: tags

  // Add other properties for subnet configuration
  properties: {
    delegations: []
  }
}
