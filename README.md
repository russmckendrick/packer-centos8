# Packer CentOS 8

Packer config for the boxes which can be found at [https://app.vagrantup.com/russmckendrick/boxes/centos8](https://app.vagrantup.com/russmckendrick/boxes/centos8).

To build both Virtualbox and VMWare boxes run;

```
packer build CentOS_8.json
```

For just VMWare;

```
packer build -only vmware-iso CentOS_8.json
```

And for Virtualbox;

```
packer build -only virtualbox-iso CentOS_8.json
```
