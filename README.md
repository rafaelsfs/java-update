# Script to install or update Java manually on Ubuntu
[![GitHub](https://img.shields.io/github/license/rafaelsfs/java-update)](https://github.com/rafaelsfs/java-update/blob/main/LICENSE) [![Linux](https://img.shields.io/badge/System-Linux-brightgreen)](https://ubuntu.com/) [![tux](https://github.com/rafaelsfs/public_html/blob/master/Tux.png)](https://github.com/rafaelsfs) 

Script installs the latest available version of java at https://jdk.java.net/ installs in /opt and configures update-alternatives and environment variables for bash and zsh

## Install [![java](https://img.shields.io/badge/-Java-blue)](https://jdk.java.net/)

``` bash
git clone https://github.com/rafaelsfs/java-update.git
```
``` bash
cd /java-update
```
``` bash
chmod + x java-update.sh
```
``` bash
./java-update.sh
```

## Uninstall [![java](https://img.shields.io/badge/-Java-blue)](https://jdk.java.net/)
``` bash
cd /java-update
```
``` bash
chmod + x java-update.sh
```
``` bash
./uninstall-java.sh
```
