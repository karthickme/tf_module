locals {
  nic_name                = coalesce(var.nic_name, "${var.vm_name}-nic")
  public_ip_name         = coalesce(var.public_ip_name, "${var.vm_name}-pip")
  boot_diagnostics_name  = coalesce(var.boot_diagnostics_storage_account_name, "${var.vm_name}bootdiag")
}

# Network Interface
resource "azurerm_network_interface" "vm_nic" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address != null ? "Static" : "Dynamic"
    private_ip_address           = var.private_ip_address
    public_ip_address_id         = var.create_public_ip ? azurerm_public_ip.vm_public_ip[0].id : null
  }
}

# Public IP (Optional)
resource "azurerm_public_ip" "vm_public_ip" {
  count               = var.create_public_ip ? 1 : 0
  name                = local.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.public_ip_sku
  tags                = var.tags
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                           = var.vm_size
  admin_username                  = var.admin_username
  network_interface_ids          = [azurerm_network_interface.vm_nic.id]
  tags                           = var.tags

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb        = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_account_uri
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  custom_data                    = var.custom_data
  encryption_at_host_enabled    = var.encryption_at_host_enabled
  patch_mode                    = var.patch_mode
  disable_password_authentication = var.disable_password_authentication
  admin_password                = var.disable_password_authentication ? null : var.admin_password
  computer_name                 = coalesce(var.computer_name, var.vm_name)
  provision_vm_agent           = var.provision_vm_agent
  allow_extension_operations   = var.allow_extension_operations

  dynamic "secret" {
    for_each = var.secrets != null ? var.secrets : []
    content {
      key_vault_id = secret.value.key_vault_id
      
      dynamic "certificate" {
        for_each = secret.value.certificate
        content {
          url   = certificate.value.url
          store = lookup(certificate.value, "store", null)
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = var.enable_boot_diagnostics ? var.boot_diagnostics_storage_account_uri != null : true
      error_message = "boot_diagnostics_storage_account_uri must be provided when enable_boot_diagnostics is true"
    }
    precondition {
      condition     = var.disable_password_authentication ? var.ssh_public_key != null : true
      error_message = "ssh_public_key must be provided when disable_password_authentication is true"
    }
  }
}

# Data Disks (Optional)
resource "azurerm_managed_disk" "data_disk" {
  for_each             = var.data_disks
  name                 = "${var.vm_name}-datadisk-${each.key}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb        = each.value.disk_size_gb
  tags                = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attachment" {
  for_each           = var.data_disks
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = each.value.caching
}