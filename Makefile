.PHONY: generate-ssh vagrant-node base clean-playbooks docker-install
NODE_PORT := $(shell vagrant port node --guest 22)
PRIVATE_KEY := .vagrant/machines/node/virtualbox/private_key
PLAYBOOKS := kubestorage/playbooks
INVENTORY := hosts
DEPLOYMENTS := deployments
# either environment variables or kubestorage
PROJECT_NAME ?= kubestorage
ORG_NAME ?= kubestorage
REPO_NAME ?= kubestorage

DEV_COMPOSE_FILE := docker/dev/docker-compose.yml

# get colors from http://linuxmanage.com/colored-man-pages-log-files.html
YELLOW := "\e[0;33m" # yellow
RED := "\e[0;31m" # Red
NC := "\e[0m"	# no color

INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

WARN := @bash -c '\
	printf $(RED); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

remove_dangling_images:
	docker images -q -f dangling=true label=application=$(REPO_NAME) | xargs -I ARGS docker rmi -f ARGS

generate-ssh:
	$(INFO) "generating ssh file"
	ssh-keygen -t rsa -b 4096 -C "vagrant@vagrant.com" -N "" -f .ssh/id_rsa

vagrant-node:
	vagrant up node

node-down:
	vagrant destroy -f node

node-ssh:
	ssh -p $(NODE_PORT) -i $(PRIVATE_KEY) vagrant@127.0.0.1

## Ansible commands
ansible-test:
	${INFO} "Testing Ansible connection"
	ansible -i $(INVENTORY) all -m ping

base:
	${INFO} "Running base playbook"
	ansible-playbook -i $(INVENTORY) $(DEPLOYMENTS)/basic/playbooks/main.yml

deploy-consul:
	${INFO} "Running playbook to deploy consul"
	@ansible-playbook -i $(INVENTORY) $(DEPLOYMENTS)/consul/playbooks/main.yml

remove-consul:
	${INFO} "Running playbook to remove consul containers"
	@ansible-playbook -i $(INVENTORY) $(DEPLOYMENTS)/consul/playbooks/remove_consul.yml

deploy-vault:
	${INFO} "Running vault deploy playbook"
	@ansible-playbook -i $(INVENTORY)  $(DEPLOYMENTS)/vault/playbooks/main.yml

remove-vault:
	${INFO} "Running playbook to remove vault"
	@ansible-playbook -i $(INVENTORY)  $(DEPLOYMENTS)/vault/playbooks/remove_vault.yml

deploy-nomad:
	${INFO} "Running nomad deploy playbook"
	@ansible-playbook -i $(INVENTORY)  $(DEPLOYMENTS)/nomad/playbooks/main.yml

remove-nomad:
	${INFO} "Running nomad to remove vault"
	@ansible-playbook -i $(INVENTORY)  $(DEPLOYMENTS)/nomad/playbooks/remove_nomad.yml

pristine:
	${INFO} "Running playbook to remove vault"
	@ansible-playbook -i $(INVENTORY)  $(DEPLOYMENTS)/pristine/playbooks/main.yml

clean-playbooks:
	${WARN} "Deleting all *.retry files from playbooks directory"
	rm $(PLAYBOOKS)/*.retry

deploy-minio:
	${INFO} "Deploying minio"
	ansible-playbook --vault-password-file=kubestorage/.vault_pass -i $(INVENTORY) $(PLAYBOOKS)/deploy_minio_playbook.yml
