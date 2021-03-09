#!/bin/bash

sudo update-alternatives --remove java /opt/java/bin/java
sudo update-alternatives --remove javac /opt/java/bin/javac
cd /opt
sudo rm java
sudo rm -Rf jdk*
cd $HOME
rm openjdk*
rm -Rf java-update
rm .bashrc
mv .bashrc.bak .bashrc