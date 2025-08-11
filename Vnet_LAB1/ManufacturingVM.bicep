@description('Name of the VM')
param vmName string = 'ManufacturingVM'

@description('Location for all resources')
param location string = 'eastus'

@description('Admin username for the VM')
param adminUsername string = 'nithin'

@secure()
@description('Admin password for the VM')
param adminPassword string

@description('Name of the existing VNet')
param vnetName string = 'ManufacturingVnet'

@description('Name of the existing subnet')
param subnetName string = 'SensorSubnet1'

@description('Size of the VM')
param vmSize string = 'Standard_B2s'

@description('OS image settings')
param publisher string = 'Canonical'
param offer string = 'ubuntu-24_04-lts'
param sku string = 'server'
param version string = 'latest'


// Reference existing VNet
resource existingVnet 'Microsoft.Network/virtualNetworks@2024-03-01' existing = {
  name: vnetName
}

// Reference existing subnet inside the VNet
resource existingSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: existingVnet
  name: subnetName
}
/* Create NIC */
resource vmNic 'Microsoft.Network/networkInterfaces@2024-03-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: existingSubnet.id
          }
        }
      }
    ]
  }
}

/* Create VM */
resource linuxVM 'Microsoft.Compute/virtualMachines@2024-11-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: publisher
        offer: offer
        sku: sku
        version: version
      }
      osDisk: {
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 64
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vmNic.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}
