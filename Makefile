CURRENT_DIR := $(shell pwd)

.PHONY: clean

help:
	@echo "Run make with:"
	@echo " > validate       ...to run packer validation"
	@echo " > build          ...to start packer build"
	@echo " > up             ...to start vagrant"
	@echo " > reload         ...to reload vagrant"
	@echo " > ssh            ...to ssh into vm"
	@echo " > clean          ...to cleanup for next build"

validate:
	packer validate $(CURRENT_DIR)/packer.json

build:
	packer build -var-file=$(CURRENT_DIR)/secrets/project.secrets $(CURRENT_DIR)/packer.json
	cp $(CURRENT_DIR)/src/Vagrantfile.tpl $(CURRENT_DIR)/target/Vagrantfile

up:
	vagrant box add packer/centos7 $(CURRENT_DIR)/target/virtualbox-CentOS-7.box
	cd $(CURRENT_DIR)/target && vagrant up

reload:
	cd $(CURRENT_DIR)/target && vagrant reload

ssh:
	cd $(CURRENT_DIR)/target && vagrant ssh

clean:
	cd $(CURRENT_DIR)/target && vagrant halt
	cd $(CURRENT_DIR)/target && vagrant destroy -f
	rm -fr $(CURRENT_DIR)/builds/
	rm -fr $(CURRENT_DIR)/target/* $(CURRENT_DIR)/target/.* 2> /dev/null
	vagrant box remove packer/centos7
