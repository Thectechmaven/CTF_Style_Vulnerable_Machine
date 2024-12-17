# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"  # You can use this box or choose a different box. 
  config.vm.box_version = "20230607.0.5" # Specify the explicit version of the box.
  config.vm.hostname = "<your_hostname>" # Choose your hostname here.

  # Disable the default share of the current code directory. Doing this
  # provides improved isolation between the vagrant box and your host
  # by making sure your Vagrantfile isn't accessible to the vagrant box.
  # If you use this you may want to enable additional shared subfolders as
  # shown above.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  config.vm.provider "virtualbox" do |vb|
   Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
  # Customize the amount of memory on the VM:
     vb.memory = "2048"
     vb.cpus = 2
   end
  
  # Upload the install.sh script
  config.vm.provision "file", source: "C:/Path/to/your/data/install.sh", destination: "/tmp/install.sh"

  # Ensure line endings are Unix-style, make executable, and run the script
  config.vm.provision "shell", inline: <<-SHELL
    # Convert Windows line endings to Unix line endings
    sed -i 's/\\r$//' /tmp/install.sh
    # Make the script executable
    chmod +x /tmp/install.sh
    # Run the script
    /tmp/install.sh
  SHELL
end
