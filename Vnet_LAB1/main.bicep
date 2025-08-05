module CoreServicesVnet './CoreServicesVnet.bicep' = {
  name: 'CoreServicesVnet'
  }

module ManufacturingVnet './ManufacturingVnet.bicep' = {
  name: 'ManufactutingVnet'
}

module nsg './NSG.bicep' = {
  name: 'nsgModule'
}

module privateDNS './privateazDNS.bicep' = {
  name: 'privateDNS'
}
