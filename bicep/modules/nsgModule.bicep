param subnetName string
param location string

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-11-01' = {
  name: nsgName
  location: location

  // Add other properties for NSG configuration
  properties: {
    securityRules: [
      {
        name: 'clientCommunication'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80,443'
          direction: 'Inbound'
          access: 'Allow'
          priority: 100
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Azure portal and PowerShell management endpoint'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3443'
          direction: 'Inbound'
          access: 'Allow'
          priority: 200
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Azure Infrastructure Load Balancer'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '6390'
          direction: 'Inbound'
          access: 'Allow'
          priority: 300
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Azure Storage for core service functionality'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          direction: 'Outbound'
          access: 'Allow'
          priority: 400
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Azure SQL for core service functionality'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '1443'
          direction: 'Outbound'
          access: 'Allow'
          priority: 500
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Azure Monitor for diagnostics and metrics'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '1886'
          direction: 'Outbound'
          access: 'Allow'
          priority: 600
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
