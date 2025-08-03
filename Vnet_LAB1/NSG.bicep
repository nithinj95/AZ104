param networkSecurityGroupName string = 'myNSGSecure'
param location string = 'eastus'

resource myNSG 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowAnyCustom80_443Inbound'
        properties: {
          description: 'Allow inbound web traffic on port 80 and 443 from sensor subnet 1 and 2 on Manufacturing VNet'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefixes: [
            '10.30.20.0/24'
            '10.30.21.0/24'
          ]
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAnyCustom8080Outbound'
        properties: {
          description: 'Blocking access to internet on port 8080'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '8080'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Deny'
          priority: 4096
          direction: 'Outbound'
        }
      }
    ]
  }
}
