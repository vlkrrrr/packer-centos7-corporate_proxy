# -*- mode: ruby -*-

Vagrant.require_version ">= 1.8.1"

Vagrant.configure("2") do |config|

  config.vm.box = "packer/centos7"
  config.vm.box_url = "virtualbox-CentOS-7.box"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "centos7"
    vb.cpus = "1"
    vb.memory = "2048"
    vb.gui = false
  end

end
