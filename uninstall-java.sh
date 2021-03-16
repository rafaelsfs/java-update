#!/bin/bash

echo -e '\033[1;31m Unstaling...'

#Remove Ubuntu update-alteranatives
sudo update-alternatives --remove java /opt/java/bin/java
sudo update-alternatives --remove javac /opt/java/bin/javac
cd /opt

#remove symbolic link
sudo rm java

#remove java DIR
sudo rm -Rf jdk*

cd $HOME

#delete java tar.gz file
rm openjdk*

#remove java-update directory
rm -Rf java-update

#restore bashrc file
mv .bashrc.bak .bashrc

#restore bashrc file
mv .zshrc.bak .zshrc

#load bashrc original config
source .bashrc
echo -e '\033[1;32m Uninstall complete'