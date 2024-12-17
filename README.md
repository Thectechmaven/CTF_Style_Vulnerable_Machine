# CTF_Style_Vulnerable_Machine
Tools and scripts to create vulnerable lab designed for penetration testing and CTF enthusiasts.

# Vagrant Windows Installation Instructions
What is Vagrant? Found here: https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-index
## Install the latest version of Vagrant on Windows

https://developer.hashicorp.com/vagrant/install

![image](https://github.com/user-attachments/assets/7fd697e6-cdac-48b5-933a-3f116a23cb22)

## Verify the installation
https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-install
After installing Vagrant, verify the installation worked by opening a new command prompt or console and checking that `Vagrant` is available.

```
C: vagrant
Usage: vagrant [options] <command> [<args>]

    -h, --help                       Print this help.

Common commands:...
```

The default folder for `vagrant.exe` is `C:\Program Files\Vagrant\bin\`.

## Install a virtualization product like [VirtualBox](https://www.virtualbox.org/).

## Create a directory
Make a new directory for the project you will work on throughout the setup.
```
mkdir <your_new_directory>
```

Move into your new directory.
```
cd <your_new_directory>
```

Create another directory inside `<your_new_directory>` called `data` for the `install.sh` script.

```
mkdir data
```

## Installing the first virtual machine 

Select a base machine image, follow the "How to use this box with Vagrant" instructions, and start it with Vagrant.

Vagrant boxes can be found here: https://portal.cloud.hashicorp.com/vagrant/discover
![image](https://github.com/user-attachments/assets/5875f968-3168-48cd-b17e-c958e2125830)

![image](https://github.com/user-attachments/assets/e32cab43-ea69-473a-88ae-f20577989e03)

![image](https://github.com/user-attachments/assets/ce43d708-058d-4131-a5d6-bec598557265)




