# packer-centos-7.2

This repository is an example of how to build machine images using [Packer](https://www.packer.io/).

In this example, a 
CentOS 7.2 Minimal ISO image 
is used to create machine images for VMware and VirtualBox.

## Build dependencies

See [build dependencies](https://github.com/docktermj/KnowledgeBase/blob/master/build-dependencies/packer.md).

## Build

Use `make help` to see targets.

### Build all versions

```console
make
```

### Build specific version

VMware

```console
make vmware-iso
```

VirtualBox

```console
make virtualbox-iso
```

## Run on VMware Workstation

1. Choose VMX file
   1. VMware Workstation > File > Open...
      1. Navigate to `.../packer-centos-7.2/output-vmware-iso-nnnnnnnnnn/`
      1. Choose `packer-centos-7.2-nnnnnnnnnn.vmx`
1. Optional: Change networking
   1. Navigate to VMware Workstation > My Computer > packer-centos-7.2-nnnnnnnnnn
   1. Right click on "packer-centos-7.2-nnnnnnnnnn" and choose "Settings"
   1. Choose "Network Adapter" > "Network Connection" > :radio_button: Bridged: Connected directly to the physical network
   1. Click "Save"
1. Run image
   1. Choose VMware Workstation > My Computer > packer-centos-7.2-nnnnnnnnnn
   1. Click "Start up this guest operating system"
1. Username: vagrant  Password: vagrant

## Run on Vagrant / VirtualBox

### Add to library

```console
vagrant box add --name="packer-centos-7.2-virtualbox" ./packer-centos-7.2-virtualbox-nnnnnnnnnn.box
```

### Run

An example of how to run in a new directory.

#### Specify directory

In this example the `/tmp/packer-centos-7.2` directory is used.

```console
export PACKER_CENTOS_72=/tmp/packer-centos-7.2
```

#### Initialize directory

Back up an old directory and initialize new directory with Vagrant image.

```console
mv ${PACKER_CENTOS_72} ${PACKER_CENTOS_72}.$(date +%s)
mkdir ${PACKER_CENTOS_72}
cd ${PACKER_CENTOS_72}
vagrant init packer-centos-7.2-virtualbox
```

#### Enable remote login

Modify Vagrantfile to allow remote login by
uncommenting `config.vm.network` in `${PACKER_CENTOS_72}/Vagrantfile`. 
Example:

```console
sed -i.$(date +'%s') \
  -e 's/# config.vm.network \"public_network\"/config.vm.network \"public_network\"/g' \
  ${PACKER_CENTOS_72}/Vagrantfile
```

#### Start guest machine

```console
cd ${PACKER_CENTOS_72}
vagrant up
```

### Login to guest machine

```console
cd ${PACKER_CENTOS_72}
vagrant ssh
```

### Find guest machine IP address

In the vagrant machine, find the IP address.

```console
ip addr show
```

### Remote login to guest machine

SSH login from a remote machine.

```console
ssh vagrant@nn.nn.nn.nn
```

Password: vagrant

### Remove image from Vagrant library

To remove Vagrant image, on host machine:

```console
vagrant box remove packer-centos-7.2-virtualbox
```

## References
1. [Build dependencies](https://github.com/docktermj/KnowledgeBase/blob/master/build-dependencies/packer.md).
1. [Bibliography](https://github.com/docktermj/KnowledgeBase/blob/master/bibliography/packer.md)
