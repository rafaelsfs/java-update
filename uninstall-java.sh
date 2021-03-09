#!/bin/bash

echo -e '\033[1;31m Unstaling...'
sudo update-alternatives --remove java /opt/java/bin/java
sudo update-alternatives --remove javac /opt/java/bin/javac
cd /opt
sudo rm java
sudo rm -Rf jdk*
cd $HOME
rm openjdk*
rm -Rf java-update
mv .bashrc.bak .bashrc
source .bashrc
echo -e '\033[1;32m Uninstall complete'