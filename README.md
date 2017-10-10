# README

1. Generate ssh key to be used

```sh
ssh-keygen -t rsa -b 4096 -C "vagrant@vagrant.com" -N "" -f data/ssh/id_rsa
```


It seems like your system ports are busy, do check docker ps -a, below is the process to install docker community edition :

Remove previous version of docker and docker engine
$ sudo apt-get remove docker docker-engine

Allow apt to use repo over https
$ sudo apt-get install apt-transport-https \ ca-certificates \ curl \ software-properties-common

Add Docker official's GPG Key
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

Setting up stable repository
$ sudo add-apt-repository \ "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"

$(lsb_release -cs)

Above command returns the name of Ubuntu distribution like "Xenial"

Install Docker
$ sudo apt-get update
$ sudo apt-get install docker-ce

## Install galaxy with requirements.yml

```sh
ansible-galaxy install -r requirements.yml
```

https://stackoverflow.com/a/44962723

 cat /usr/lib/systemd/system/docker.service

docker -H 192.168.33.20:2376 ps 

docker run -p 9000:9000 --name minio1 \
  -v /mnt/data:/data \
  minio/minio server /data

  ansible-vault view secrets.yml --ask-vault-pass

# create a vault-password-file
  echo 'password' > .vault_pass

  ansible-vault view secrets.yml

  echo '*/.vault_pass' >> ../.gitignore

  export ANSIBLE_VAULT_PASSWORD_FILE=./.vault_pass


  ansible --vault-password-file=.vault_pass
  
   ansible-vault view --vault-password-file=.vault_pass secrets.yml