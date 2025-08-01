param virtualNetworks_ManufacturingVnet_name string = 'ManufacturingVnet'

resource virtualNetworks_ManufacturingVnet_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_ManufacturingVnet_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.30.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    enableDdosProtection: false
  }
}

resource virtualNetworks_ManufacturingVnet_name_SensorSubnet1 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'SensorSubnet1'
  parent: virtualNetworks_ManufacturingVnet_name_resource
  properties: {
    addressPrefixes: [
      '10.30.20.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_ManufacturingVnet_name_SensorSubnet2 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'SensorSubnet2'
  parent: virtualNetworks_ManufacturingVnet_name_resource
  properties: {
    addressPrefixes: [
      '10.30.21.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
