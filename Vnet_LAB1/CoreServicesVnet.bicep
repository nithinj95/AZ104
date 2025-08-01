param virtualNetworks_CoreServicesVnet_name string = 'CoreServicesVnet'

resource virtualNetworks_CoreServicesVnet_name_resource 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: virtualNetworks_CoreServicesVnet_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_CoreServicesVnet_name_SharedServicesSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'SharedServicesSubnet'
  parent: virtualNetworks_CoreServicesVnet_name_resource
  properties: {
    addressPrefixes: [
      '10.20.10.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_CoreServicesVnet_name_DatabaseSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: 'DatabaseSubnet'
  parent: virtualNetworks_CoreServicesVnet_name_resource
  properties: {
    addressPrefixes: [
      '10.20.20.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
