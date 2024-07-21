variable "vcenter_server" {
  description = "vCenter server IP or FQDN"
  type        = string
}

variable "vcenter_user" {
  description = "vCenter username"
  type        = string
}

variable "vcenter_password" {
  description = "vCenter password"
  type        = string
}

variable "template_name" {
  description = "Name of the template in vCenter"
  type        = string
  default     = "debian-template"
}

variable "domain" {
  description = "VM domain"
  type        = string
  default     = "vsphere.local"
}

variable "disk" {
  description = "Disk (size in Gb)"
  type = object({
    storage = string
    size    = number
  })
  default = {
    storage = "datastorehost"
    size    = 20
  }
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
