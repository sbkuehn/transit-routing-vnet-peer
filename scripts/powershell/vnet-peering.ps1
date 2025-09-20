<#
.SYNOPSIS
Creates bidirectional VNet peering with transit enabled between two VNets.

.AUTHOR
Shannon Eldridge-Kuehn

.DATE
2025-09-20

.EXAMPLE
.net-peering.ps1 -ResourceGroup "AD-Networking" -VNet1 "vnet-westus" -VNet2 "vnet-eastus"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup,

    [Parameter(Mandatory=$true)]
    [string]$VNet1,

    [Parameter(Mandatory=$true)]
    [string]$VNet2
)

$vnetWest = Get-AzVirtualNetwork -Name $VNet1 -ResourceGroupName $ResourceGroup
$vnetEast = Get-AzVirtualNetwork -Name $VNet2 -ResourceGroupName $ResourceGroup

Add-AzVirtualNetworkPeering -Name "${VNet1}To${VNet2}" -VirtualNetwork $vnetWest -RemoteVirtualNetworkId $vnetEast.Id -AllowForwardedTraffic -AllowGatewayTransit

Add-AzVirtualNetworkPeering -Name "${VNet2}To${VNet1}" -VirtualNetwork $vnetEast -RemoteVirtualNetworkId $vnetWest.Id -AllowForwardedTraffic -UseRemoteGateways
