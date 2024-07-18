variable "vcenter_user" {
  description = "vCenter username"
  type        = string
}

variable "vcenter_password" {
  description = "vCenter password"
  type        = string
}

variable "vcenter_server" {
  description = "vCenter server IP or FQDN"
  type        = string
}

variable "template_name" {
  description = "Name of the template in vCenter"
  type        = string
  default     = "ubuntu-template"
}

variable "api_token" {
  description = "Token to connect Proxmox API"
  type        = string
  default     = "terraform-prov@pve!terraform=0362488f-fc42-4fc1-b80b-10c40e82a525"
}

// Define the target Proxmox node
variable "target_node" {
  description = "Proxmox node"
  type        = string
  default     = "pve"
}

variable "onboot" {
  description = "Auto start VM when node is start"
  type        = bool
  default     = true
}

variable "target_node_domain" {
  description = "Proxmox node domain"
  type        = string
  default     = ""
}

variable "tpl_id" {
  description = "Template VM ID"
  type        = string
  default     = "10001"
}

variable "domain" {
  description = "VM domain"
  type        = string
  default     = "vsphere.local"
}

variable "vm_tags" {
  description = "VM tags"
  type        = list(string)
  default     = ["ubuntu"]
}

variable "template_tag" {
  description = "Template tag"
  type        = string
  default     = "test"
}

variable "vm_configurations" {
  description = "Configuration for the virtual machines"
  type = map(object({
    hostname = string
    cores    = number
    memory   = number
  }))
  default = {
    vm1 = {
      hostname = "VM1"
      cores    = 1
      memory   = 1024
    }
    vm2 = {
      hostname = "VM2"
      cores    = 2
      memory   = 1536
    }
    vm3 = {
      hostname = "VM3"
      cores    = 3
      memory   = 2048
    }
  }
}

variable "disk" {
  description = "Disk (size in Gb)"
  type = object({
    storage = string
    size    = number
  })
  default = {
    storage = "local-lvm"
    size    = 10
  }
}

variable "additionnal_disks" {
  description = "Additionnal disks"
  type = list(object({
    storage = string
    size    = number
  }))
  default = []
}

// Add variables for additional configurations like storage, cpu, memory
variable "storage_size" {
  description = "Size of the storage disk in GB"
  type        = number
  default     = 20
}

variable "cpu_count" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "memory_size" {
  description = "Amount of memory in MB"
  type        = number
  default     = 2048
}
