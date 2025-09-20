#!/bin/bash
# Purpose: Create bidirectional VNet peering with transit enabled.
# Author: Shannon Eldridge-Kuehn
# Date: 2025-09-20
# Usage: ./vnet-peering.sh -g AD-Networking -v1 vnet-westus -v2 vnet-eastus

set -e

while getopts g:v1:v2: flag
do
    case "${flag}" in
        g) rg=${OPTARG};;
        v1) vnet1=${OPTARG};;
        v2) vnet2=${OPTARG};;
    esac
done

if [ -z "$rg" ] || [ -z "$vnet1" ] || [ -z "$vnet2" ]; then
  echo "Usage: $0 -g <resourceGroup> -v1 <VNet1> -v2 <VNet2>"
  exit 1
fi

az network vnet peering create --name ${vnet1}To${vnet2} --resource-group $rg --vnet-name $vnet1 --remote-vnet $vnet2 --allow-forwarded-traffic --allow-gateway-transit

az network vnet peering create --name ${vnet2}To${vnet1} --resource-group $rg --vnet-name $vnet2 --remote-vnet $vnet1 --allow-forwarded-traffic --use-remote-gateways
