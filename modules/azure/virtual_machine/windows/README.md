# Azure Windows Virtual Machine Module

This Terraform module creates a Windows Virtual Machine in Azure with configurable options for networking, storage, and security.

## Features

- Windows Virtual Machine creation with customizable size and OS image
- Network Interface with optional Public IP
- Optional data disk attachments
- Boot diagnostics configuration
- Managed identity support
- Custom data and additional unattend content support
- Tags support
- Encryption at host support

## Usage

```hcl
module "windows_vm" {
  source = "./modules/azure/virtual_machine/windows"

  vm_name             = "mywinvm"
  resource_group_name = "my-rg"
  location            = "eastus"
  subnet_id           = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/xxx/subnets/xxx"
  
  vm_size         = "Standard_D2s_v3"
  admin_username  = "adminuser"
  admin_password  = "P@ssw0rd123!"

  # Optional features
  create_public_ip = true
  
  data_disks = {
    "disk1" = {
      storage_account_type = "StandardSSD_LRS"
      create_option        = "Empty"
      disk_size_gb        = 128
      lun                 = 0
      caching             = "ReadWrite"
    }
  }

  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| azurerm | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vm_name | Name of the Windows Virtual Machine | string | - | yes |
| resource_group_name | Name of the Resource Group | string | - | yes |
| location | Azure region where resources will be created | string | - | yes |
| subnet_id | ID of the subnet where the VM will be connected | string | - | yes |
| vm_size | Size of the Virtual Machine | string | "Standard_D2s_v3" | no |
| admin_username | Admin username for the Virtual Machine | string | - | yes |
| admin_password | Admin password for the Virtual Machine | string | - | yes |
| create_public_ip | Whether to create a public IP for the VM | bool | false | no |
| os_disk_size_gb | Size of the OS disk in GB | number | 128 | no |
| data_disks | Map of data disks to attach to the VM | map(object) | {} | no |
| enable_boot_diagnostics | Whether to enable boot diagnostics | bool | false | no |
| tags | Tags to apply to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| vm_id | The ID of the Windows Virtual Machine |
| vm_name | The name of the Windows Virtual Machine |
| private_ip_address | The primary private IP address of the Virtual Machine |
| public_ip_address | The public IP address of the Virtual Machine |
| network_interface_id | The ID of the Network Interface |
| data_disk_ids | Map of data disk IDs |

## License

This module is licensed under the MIT License - see the LICENSE file for details.