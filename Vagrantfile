# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION  = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vincent.dev"

  #config.vm.network "public_network"

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
     vb.name   = "vincent.dev"
     vb.memory = 4096
     vb.cpus   = 2
     vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-interval', 10000]
     vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-min-adjust', 100]
     vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-on-restore', 1]
     vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 1000]
     vb.customize ["modifyvm", :id, "--usb", "on"]
     vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 4000, host: 4000
  config.vm.network :forwarded_port, guest: 6543, host: 6543
  config.vm.network :forwarded_port, guest: 5555, host: 5555 
  config.vm.network :forwarded_port, guest: 15672, host: 15672
  config.vm.network :forwarded_port, guest: 27017, host: 27017, guest_ip: "0.0.0.0", host_ip: "0.0.0.0"

  config.vm.synced_folder "../app27", "/var/www/ideaevolver.com", :mount_options => ['dmode=777,fmode=777']
end
