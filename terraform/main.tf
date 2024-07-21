terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.1.1"
    }
  }
}

provider "vsphere" {
  user           = var.vcenter_user
  password       = var.vcenter_password
  vsphere_server = var.vcenter_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "DatacenterProjet"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "cluster-a"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "datastorehost"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count = 9

  name             = "VM${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.cpu_count
  memory   = var.memory_size
  guest_id = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = var.disk.size
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "VM${count.index + 1}"
        domain    = var.domain
      }

      network_interface {
        ipv4_address = "172.28.126.${count.index + 14}"
        ipv4_netmask = 20
      }

      ipv4_gateway = "172.28.112.1"
    }
  }

  extra_config = {
    "guestinfo.userdata"      = base64encode(templatefile("cloud-init/user_data", {hostname: "VM${count.index + 1}", domain: var.domain}))
    "guestinfo.userdata.encoding" = "base64"
  }

  tags = ["debian"]
}
