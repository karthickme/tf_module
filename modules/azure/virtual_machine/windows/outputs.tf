output "vm_id" {
  description = "The ID of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "vm_identity" {
  description = "The identity block of the Virtual Machine"
  value       = try(azurerm_windows_virtual_machine.vm.identity[0], null)
}

output "private_ip_address" {
  description = "The primary private IP address of the Virtual Machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the Virtual Machine"
  value       = var.create_public_ip ? azurerm_public_ip.vm_public_ip[0].ip_address : null
}

output "network_interface_id" {
  description = "The ID of the Network Interface"
  value       = azurerm_network_interface.vm_nic.id
}

output "public_ip_id" {
  description = "The ID of the Public IP"
  value       = var.create_public_ip ? azurerm_public_ip.vm_public_ip[0].id : null
}

output "data_disk_ids" {
  description = "Map of data disk IDs"
  value       = { for k, v in azurerm_managed_disk.data_disk : k => v.id }
}