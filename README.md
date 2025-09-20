# Azure Transitive Routing with VNet Peering

This repository demonstrates how to configure **transitive routing** between VNets in Azure using enterprise-ready Infrastructure as Code and scripts.

The use case originated from an **Active Directory replication failure** in a lab environment. A domain controller could not reach the PDC emulator because VNets in different regions were isolated behind separate site-to-site VPNs. The fix was **VNet peering with gateway transit and forwarded traffic enabled**.

This repo contains **Terraform**, **Bicep**, **PowerShell**, and **Az CLI** examples for configuring the peering.

---

## Repository Layout

- `terraform/` — Infrastructure as Code with Terraform  
- `bicep/` — Infrastructure as Code with Azure Bicep  
- `scripts/` — PowerShell and Az CLI deployment scripts  

---

## Prerequisites

- Azure subscription  
- Resource group containing two VNets (for example, `vnet-westus` and `vnet-eastus`)  
- Azure CLI or PowerShell installed locally  
- Terraform v1.6+ if using Terraform  

---

## Terraform Deployment

### Commands
```bash
cd terraform
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

---

## Bicep Deployment

### Commands
```bash
cd bicep
az deployment group create   --resource-group AD-Networking   --template-file main.bicep   --parameters main.bicepparam
```

---

## PowerShell Deployment

```powershell
cd scripts/powershell
.net-peering.ps1 -ResourceGroup "AD-Networking" -VNet1 "vnet-westus" -VNet2 "vnet-eastus"
```

---

## Az CLI Deployment

```bash
cd scripts/azcli
./vnet-peering.sh -g AD-Networking -v1 vnet-westus -v2 vnet-eastus
```

---

## License

This project is licensed under the [MIT License](./LICENSE).
