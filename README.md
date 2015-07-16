```shell
# how to put this files to your home dir
# I am assuming fresh server, without keys or much other setup
# make sure you are under your user
cd ~
mkdir .ssh
chmod 700 .ssh
touch .ssh/id_rsa
chmod 600 .ssh/id_rsa
# put your private ssh key to this file
# ... done
git clone git@github.com:skaurus/debianconfig.git && cd debianconfig/
git submodule init && git pull --recurse-submodules
# WARNING! files from repository will OVERWRITE all files with same names
cd ~ && rsync -av ./debianconfig/{.bashrc,.gitconfig,.vimrc,.vim} ./
```
