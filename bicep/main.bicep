// Author: Shannon Eldridge-Kuehn
// Date: 2025-09-20
// Description: Bicep template to create VNet peering with transit enabled.

@description('Name of the resource group')
param resourceGroupName string

@description('Name of the West US VNet')
param vnetWestName string

@description('Name of the East US VNet')
param vnetEastName string

resource vnetWest 'Microsoft.Network/virtualNetworks@2023-09-01' existing = {
  name: vnetWestName
}

resource vnetEast 'Microsoft.Network/virtualNetworks@2023-09-01' existing = {
  name: vnetEastName
}

resource westToEast 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  name: '${vnetWestName}To${vnetEastName}'
  parent: vnetWest
  properties: {
    remoteVirtualNetwork: {
      id: vnetEast.id
    }
    allowForwardedTraffic: true
    allowGatewayTransit: true
  }
}

resource eastToWest 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-09-01' = {
  name: '${vnetEastName}To${vnetWestName}'
  parent: vnetEast
  properties: {
    remoteVirtualNetwork: {
      id: vnetWest.id
    }
    allowForwardedTraffic: true
    useRemoteGateways: true
  }
}
