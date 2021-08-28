# Packer CentOS 8

Packer config for the boxes which can be found at [https://app.vagrantup.com/russmckendrick/boxes/centos8](https://app.vagrantup.com/russmckendrick/boxes/centos8).

To build both Virtualbox and VMWare boxes run;

```
packer build CentOS8.pkr.hcl
```

For just VMWare;

```
packer build -only vmware-iso.vmware CentOS8.pkr.hcl
```

And for Virtualbox;

```
packer build -only virtualbox-iso.virtualbox CentOS8.pkr.hcl
```
