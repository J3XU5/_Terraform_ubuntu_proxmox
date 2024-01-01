resource "proxmox_vm_qemu" "ubuntu" {
  name        = var.instance_name
  target_node = "hugoravard"
  desc        = "ubuntu-desktop-computer"
  os_type     = "cloud-init"
  clone       = "ubuntu-ci"

  memory = var.mem_size

  sockets = var.nbSockets
  cores   = var.nbCPU

  ciuser     = "user"
  cipassword = "user"

  ssh_user = "user"
  sshkeys  = tls_private_key.ssh_host_key.public_key_openssh

  oncreate = false

  scsihw = "virtio-scsi-pci"

  disk {
    type    = "scsi"
    storage = "data"
    size    = "10G"
  }

  network {
    model = "virtio"
  }

  vga {
    type = "serial0"
  }

  serial {
    type = "socket"
    id   = 0
  }
}