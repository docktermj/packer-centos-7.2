# packer-centos-7.2

This repository is an example of how to build machine images using [Packer](https://www.packer.io/).

In this example, a
CentOS 7.2 Minimal ISO image
is used to create machine images for VMware and VirtualBox.

## Build dependencies

See [build dependencies](https://github.com/docktermj/KnowledgeBase/blob/master/build-dependencies/packer.md).

## Build

Use `make help` to see targets.

### Define packer_cache directory

1. Optional: This defines a common place to keep large `*.iso` files for reuse across repository instances.
If not defined, a `packer_cache` directory will be created within each "packer-*" repository instance
and will not be reused across repository instances.

    ```console
    mkdir ~/packer_cache
    export PACKER_CACHE_DIR=~/packer_cache
    ```

### Build all versions

1. Example:

    ```console
    make
    ```

### Build specific version

1. VMware

    ```console
    make vmware-iso
    ```

1. VirtualBox

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

1. Example:

    ```console
    vagrant box add --name="packer-centos-7.2-virtualbox" ./packer-centos-7.2-virtualbox-nnnnnnnnnn.box
    ```

### Run

An example of how to run in a new directory.

#### Specify directory

1. In this example the `/tmp/packer-centos-7.2` directory is used.

    ```console
    export PACKER_CENTOS_72=/tmp/packer-centos-7.2
    ```

#### Initialize directory

1. Back up an old directory and initialize new directory with Vagrant image.

    ```console
    mv ${PACKER_CENTOS_72} ${PACKER_CENTOS_72}.$(date +%s)
    mkdir ${PACKER_CENTOS_72}
    cd ${PACKER_CENTOS_72}
    vagrant init packer-centos-7.2-virtualbox
    ```

#### Enable remote login

1. Modify Vagrantfile to allow remote login by
uncommenting `config.vm.network` in `${PACKER_CENTOS_72}/Vagrantfile`.
Example:

    ```console
    sed -i.$(date +'%s') \
      -e 's/# config.vm.network \"public_network\"/config.vm.network \"public_network\"/g' \
      ${PACKER_CENTOS_72}/Vagrantfile
    ```

#### Start guest machine

1. Example:

    ```console
    cd ${PACKER_CENTOS_72}
    vagrant up
    ```

### Login to guest machine

1. Example:

    ```console
    cd ${PACKER_CENTOS_72}
    vagrant ssh
    ```

### Find guest machine IP address

1. In the vagrant machine, find the IP address.

    ```console
    ip addr show
    ```

### Remote login to guest machine

1. SSH login from a remote machine.

    ```console
    ssh vagrant@nn.nn.nn.nn
    ```

Password: vagrant

### Remove image from Vagrant library

1. To remove Vagrant image, on host machine:

    ```console
    vagrant box remove packer-centos-7.2-virtualbox
    ```

## References

1. [Build dependencies](https://github.com/docktermj/KnowledgeBase/blob/master/build-dependencies/packer.md).
1. [Bibliography](https://github.com/docktermj/KnowledgeBase/blob/master/bibliography/packer.md)
