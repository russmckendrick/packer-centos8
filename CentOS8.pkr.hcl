variable "headless" {
  type    = string
  default = "true"
}

variable "shutdown_command" {
  type    = string
  default = "sudo /sbin/halt -p"
}

variable "version" {
  type    = string
  default = "2105"
}

variable "url" {
  type    = string
  default = "http://mirror.pulsant.com/sites/centos/8.4.2105/isos/x86_64/CentOS-8.4.2105-x86_64-dvd1.iso"
}

variable "checksum" {
  type    = string
  default = "0394ecfa994db75efc1413207d2e5ac67af4f6685b3b896e2837c682221fd6b2"
}

source "virtualbox-iso" "virtualbox" {
  boot_command           = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  disk_size              = "100000"
  guest_additions_path   = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_additions_sha256 = "b81d283d9ef88a44e7ac8983422bead0823c825cbfe80417423bd12de91b8046"
  guest_os_type          = "RedHat_64"
  hard_drive_interface   = "sata"
  headless               = "${var.headless}"
  http_directory         = "http"
  iso_checksum           = "sha256:${var.checksum}"
  iso_url                = "${var.url}"
  shutdown_command       = "${var.shutdown_command}"
  ssh_password           = "vagrant"
  ssh_timeout            = "20m"
  ssh_username           = "vagrant"
  vboxmanage             = [[ "modifyvm", "{{ .Name }}", "--memory", "2024"], [ "modifyvm", "{{ .Name }}", "--cpus", "2" ]]
}

source "vmware-iso" "vmware" {
  boot_command                   = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  disk_size                      = "100000"
  guest_os_type                  = "centos-64"
  headless                       = "${var.headless}"
  http_directory                 = "http"
  iso_checksum                   = "sha256:${var.checksum}"
  iso_url                        = "${var.url}"
  shutdown_command               = "${var.shutdown_command}"
  ssh_password                   = "vagrant"
  ssh_timeout                    = "20m"
  ssh_username                   = "vagrant"
  tools_upload_flavor            = "linux"
  vmx_remove_ethernet_interfaces = "true"
}

build {
  sources = ["source.virtualbox-iso.virtualbox", "source.vmware-iso.vmware"]

  provisioner "shell" {
    execute_command = "sudo {{ .Vars }} sh {{ .Path }}"
    scripts         = ["scripts/vagrant.sh", "scripts/update.sh", "scripts/vmtools.sh", "scripts/zerodisk.sh"]
  }

  post-processor "vagrant" {
    output = "CentOS-8-x86_64-${var.version}-${source.name}.box"
  }
}
