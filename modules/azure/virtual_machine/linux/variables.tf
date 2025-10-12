# Required Variables
variable "vm_name" {
  description = "Name of the Linux Virtual Machine"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the VM will be connected"
  type        = string
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  description = "Admin username for the Virtual Machine"
  type        = string
}

# Authentication Variables
variable "disable_password_authentication" {
  description = "Should Password Authentication be disabled?"
  type        = bool
  default     = true
}

variable "admin_password" {
  description = "Admin password for the Virtual Machine (when password authentication is enabled)"
  type        = string
  default     = null
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for authentication (when password authentication is disabled)"
  type        = string
  default     = null
}

# Network Interface Variables
variable "nic_name" {
  description = "Name of the Network Interface. If not provided, will be generated from VM name"
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "Static private IP address. If not provided, will be dynamically allocated"
  type        = string
  default     = null
}

# Public IP Variables
variable "create_public_ip" {
  description = "Whether to create a public IP for the VM"
  type        = bool
  default     = false
}

variable "public_ip_name" {
  description = "Name of the Public IP. If not provided, will be generated from VM name"
  type        = string
  default     = null
}

variable "public_ip_sku" {
  description = "SKU of the Public IP. Basic or Standard"
  type        = string
  default     = "Standard"
}

# OS Disk Variables
variable "os_disk_caching" {
  description = "Type of caching to use for the OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for OS disk"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "os_disk_size_gb" {
  description = "Size of the OS disk in GB"
  type        = number
  default     = 64
}

# Image Reference Variables
variable "image_publisher" {
  description = "Publisher of the image used to create the VM"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the image used to create the VM"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU of the image used to create the VM"
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version of the image used to create the VM"
  type        = string
  default     = "latest"
}

# Boot Diagnostics Variables
variable "enable_boot_diagnostics" {
  description = "Whether to enable boot diagnostics"
  type        = bool
  default     = false
}

variable "boot_diagnostics_storage_account_uri" {
  description = "Storage account URI for boot diagnostics"
  type        = string
  default     = null
}

variable "boot_diagnostics_storage_account_name" {
  description = "Name of storage account for boot diagnostics. If not provided, will be generated from VM name"
  type        = string
  default     = null
}

# Identity Variables
variable "identity_type" {
  description = "Type of Managed Service Identity"
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "List of user assigned identity IDs"
  type        = list(string)
  default     = null
}

# Additional Configuration Variables
variable "custom_data" {
  description = "Base64 encoded custom data"
  type        = string
  default     = null
}

variable "encryption_at_host_enabled" {
  description = "Should encryption at host be enabled"
  type        = bool
  default     = false
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching (AutomaticByPlatform or ImageDefault)"
  type        = string
  default     = "ImageDefault"
}

variable "computer_name" {
  description = "Specifies the hostname of the Virtual Machine"
  type        = string
  default     = null
}

variable "provision_vm_agent" {
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine"
  type        = bool
  default     = true
}

variable "allow_extension_operations" {
  description = "Should Extension Operations be allowed on this Virtual Machine"
  type        = bool
  default     = true
}

# Secrets Variables
variable "secrets" {
  description = "List of certificates to install on the Virtual Machine"
  type = list(object({
    key_vault_id = string
    certificate  = list(object({
      url   = string
      store = optional(string)
    }))
  }))
  default = null
}

# Data Disks Variables
variable "data_disks" {
  description = "Map of data disks to attach to the VM"
  type = map(object({
    storage_account_type = string
    create_option        = string
    disk_size_gb        = number
    lun                 = number
    caching             = string
  }))
  default = {}
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}