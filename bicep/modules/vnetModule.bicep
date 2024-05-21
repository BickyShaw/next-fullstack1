param location string
param tags object
param vnetName string


resource vnet 'Microsoft.Network/virtualNetworks@2021-11-01' = {
  name: vnetName
  location: location
  tags: tags
}
