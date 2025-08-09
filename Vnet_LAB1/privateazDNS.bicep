@description('Name of the Private DNS zone')
param privateDnsZones_nithin_local_name string = 'nithin.local'

@description('Name of the Manufacturing VNet')
param manufacturingVnetName string = 'ManufacturingVnet'

// Build the VNet ID dynamically
var virtualNetworks_ManufacturingVnet_externalid = '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Network/virtualNetworks/${manufacturingVnetName}'

resource privateDnsZones_nithin_local_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_nithin_local_name
  location: 'global'
  properties: {}
}

resource privateDnsZones_nithin_local_name_sensorvm 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_nithin_local_name_resource
  name: 'sensorvm'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.30.20.10'
      }
    ]
  }
}

resource privateDnsZones_nithin_local_name_manufacturing_link 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_nithin_local_name_resource
  name: 'manufacturing-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworks_ManufacturingVnet_externalid
    }
  }
}
