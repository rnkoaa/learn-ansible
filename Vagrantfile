# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box_check_update = false
  
    id_rsa_key_pub = File.readlines("./data/ssh/id_rsa.pub").first.strip
  
    config.vm.define "centos" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "centos"
      node.vm.network "private_network", ip: "192.168.33.20"
  
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
  
      node.vm.provision "shell", inline: <<-SHELL
        # Disable firewall
        sudo systemctl stop firewalld
        sudo systemctl disable firewalld
  
        echo "export VAGRANT_DATA=/vagrant_data" >> /home/vagrant/.profile
        # echo "export CHEF_REPO=/home/vagrant/chef-repo" >> /home/vagrant/.profile
  
        # Reload the bash_profile file so the environment variables
        # Are available to the current
        source /home/vagrant/.profile/.bash_profile
  
        # Add the workstation's public key as authorized
        # Allows the workstation to ssh into this node.
        VAGRANT_SSH_DIRECTORY="/home/vagrant/.ssh"
        if [ ! -d "$VAGRANT_SSH_DIRECTORY" ]; then
          # Control will enter here if $DIRECTORY doesn't exist.
          mkdir /home/vagrant/.ssh
        fi
  
        ROOT_SSH_DIRECTORY="/root/.ssh"
        if [ ! -d "$ROOT_SSH_DIRECTORY" ]; then
          # Control will enter here if $ROOT_SSH_DIRECTORY doesn't exist.
          mkdir /root/.ssh
        fi
  
        echo 'appending SSH Pub Key to /home/vagrant/.ssh/authorized_keys' \
          && echo '\n#{id_rsa_key_pub }' >> /home/vagrant/.ssh/authorized_keys \
          && chmod 600 /home/vagrant/.ssh/authorized_keys
  
         sudo yum update -y && sudo yum -y install vim wget git zip unzip tree
  
         file="/home/vagrant/.vimrc"
         if [ -f "$file" ]
         then
             echo ".vimrc exists, will not download again."
         else
           wget -O /home/vagrant/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
         fi
      SHELL
    end
   
    config.vm.define "ubuntu" do |node|
      node.vm.box = "ubuntu/xenial64"
      node.vm.hostname = "ubuntu"
      node.vm.network "private_network", ip: "192.168.33.30"
      node.vm.network :forwarded_port, guest: 22, host: 22020, id: 'ssh'
  
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
  
      node.vm.provision "shell", inline: <<-SHELL
        echo "export VAGRANT_DATA=/vagrant_data" >> /home/vagrant/.profile
  
        # Reload the bash_profile file so the environment variables
        # Are available to the current
        source /home/ubuntu/.profile/.bash_profile
  
        # Add the workstation's public key as authorized
        # Allows the workstation to ssh into this node.
        VAGRANT_SSH_DIRECTORY="/home/ubuntu/.ssh"
        if [ ! -d "$VAGRANT_SSH_DIRECTORY" ]; then
          # Control will enter here if $DIRECTORY doesn't exist.
          mkdir /home/ubuntu/.ssh
        fi
  
        ROOT_SSH_DIRECTORY="/root/.ssh"
        if [ ! -d "$ROOT_SSH_DIRECTORY" ]; then
          # Control will enter here if $ROOT_SSH_DIRECTORY doesn't exist.
          mkdir /root/.ssh
        fi
  
        echo 'appending SSH Pub Key to /home/ubuntu/.ssh/authorized_keys' \
          && echo '\n#{id_rsa_key_pub }' >> /home/ubuntu/.ssh/authorized_keys \
          && chmod 600 /home/ubuntu/.ssh/authorized_keys
  
         sudo apt-get update -y && sudo apt-get upgrade -y \
           && sudo apt-get -y install vim wget git zip unzip tree
  
         file="/home/ubuntu/.vimrc"
         if [ -f "$file" ]
         then
             echo ".vimrc exists, will not download again."
         else
           wget -O /home/ubuntu/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
           # curl -O /home/vagrant/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
         fi
      SHELL
    end
   
    config.vm.define "stretch" do |node|
      node.vm.box = "debian/stretch64"
      node.vm.hostname = "stretch"
      node.vm.network "private_network", ip: "192.168.33.40"
      node.vm.network :forwarded_port, guest: 22, host: 22040, id: 'ssh'
  
      node.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end
  
      node.vm.provision "shell", inline: <<-SHELL
        echo "export VAGRANT_DATA=/vagrant_data" >> /home/vagrant/.profile
  
        # Reload the bash_profile file so the environment variables
        # Are available to the current
        source /home/vagrant/.profile/.bash_profile
  
        # Add the workstation's public key as authorized
        # Allows the workstation to ssh into this node.
        VAGRANT_SSH_DIRECTORY="/home/ubuntu/.ssh"
        if [ ! -d "$VAGRANT_SSH_DIRECTORY" ]; then
          # Control will enter here if $DIRECTORY doesn't exist.
          mkdir /home/vagrant/.ssh
        fi
  
        ROOT_SSH_DIRECTORY="/root/.ssh"
        if [ ! -d "$ROOT_SSH_DIRECTORY" ]; then
          # Control will enter here if $ROOT_SSH_DIRECTORY doesn't exist.
          mkdir /root/.ssh
        fi
  
         sudo apt-get update -y && sudo apt-get upgrade -y \
           && sudo apt-get -y install vim wget git zip unzip tree
  
         file="/home/vagrant/.vimrc"
         if [ -f "$file" ]
         then
             echo ".vimrc exists, will not download again."
         else
           wget -O /home/vagrant/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
           # curl -O /home/vagrant/.vimrc https://raw.githubusercontent.com/amix/vimrc/master/vimrcs/basic.vim
         fi
      SHELL
    end
  end
  