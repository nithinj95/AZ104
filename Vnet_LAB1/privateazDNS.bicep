param privateDnsZones_nithin_local_name string = 'nithin.local'
param virtualNetworks_ManufacturingVnet_externalid string = '/subscriptions/a2b28c85-1948-4263-90ca-bade2bac4df4/resourceGroups/kml_rg_main-af71f32f27ab4fa9/providers/Microsoft.Network/virtualNetworks/ManufacturingVnet'

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
