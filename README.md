```shell
# how to put this files to your home dir
# I am assuming fresh server, without keys or much other setup
# make sure you are under your user
cd ~
mkdir .ssh && chmod 700 .ssh
touch .ssh/id_rsa && chmod 600 .ssh/id_rsa
# put your private ssh key to this file
# ... done
git clone git@github.com:skaurus/debianconfig.git && cd debianconfig/
git submodule init && git submodule update --recursive
# WARNING! files from repository will OVERWRITE all files with same names
cd ~ && rsync -av ./debianconfig/{.bashrc,.gitconfig,.vimrc,.vim} ./
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEA6+xrNVrBUc40Viybl2EX1N2b6sfOhV4UmSbK8CNA9/LSroip/Rkw0klY8npJyyeTsuCoVQg+iz4CBZwYzoAq/bD2qCqdCapjC3NcbDfn383EGBRiJxd3VUiEk9sxGRyu/86H54bhDjIFEBUoD3GO9eQsbxaNRbJJxotQjxxUwEM= rsa-key-20110301' >> .ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEApMfw2AHZ2Mpz8zNre/ZmqjIhFMb1zVWftiw6pTIeYiKg6hOXz5yG+/juWwUafo89QVhcBcueqfpSV2tWvUhJuDBTAQz3evvzkqd/qHgtlKZKJWF84zMOe91b1Vh/vEVgPxreKFHpxmz+/8b/v/aJ2mU2uhQx6WUruYpavzeJ2Ms= rsa-key-20110901' >> .ssh/authorized_keys
```
