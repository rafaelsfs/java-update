#!/bin/bash

# change directory to user's / home
cd /home/$USER

#Checks the main version of openjdk
MAJOR=`curl -s https://jdk.java.net/ |grep Ready |awk -F"/" '{print $2}'`

#Check the available version of openjdk
AVAILABLE=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"/" '{print $6}' |awk -F"k" '{print $2}'`

#Check the INSTALLED version of openjdk
INSTALLED=`cat /opt/java/release |grep -E 'JAVA_VERSION=' |awk -F"\"" '{print $2}'`

#Mostra as versoes instalada e disponivel no site
echo -e '\033[1;34m Installed version: '$INSTALLED
echo -e '\033[1;36m Latest version...: '$AVAILABLE '\n'

#Save download link
LINK=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"\"" '{print $2}'`

#Saves download file name
ARQ=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"/" '{print $10}' |awk -F"\"" '{print $1}'`

#Checks difference between installed and available versions
if [ "$AVAILABLE" != "$INSTALLED" ]; then

    #shows message that they are different and that will update
    echo -e '\033[1;31m The installed version is out of date downloading the new version \033[0m \n'

        #Checks download file already exists
        if [ -e "$ARQ" ]; then        

            #unpacks file in /opt
            sudo tar xf $ARQ -C /opt

            #changes to directory /opt
            cd /opt

            #saves the directory of the new version
            DIR=`ls -lt |awk -F" " '/jdk/ {print $9}' |head -n1`     

            #create symbolic link of the new version for java directory /opt/java
            sudo ln -s $DIR java 

            #Configures Ubuntu update-alteranatives to use the new version
            sudo update-alternatives --install /usr/bin/java java /opt/java/bin/java 1

            #Checks whether update-alternatives is configured
            sudo update-alternatives --display java

            #Configures Ubuntu update-alteranatives to use the new version
            sudo update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 1

            #Checks whether update-alternatives is configured
            sudo update-alternatives --display javac

            #displays java version
            java -version

            # java environment variables
            if [ -e "$HOME/.bashrc" ]; then
                echo -e "\n \033[1;32m Configuring bashrc \033[0m \n "
                cd $HOME
                cp .bashrc .bashrc.bak
                echo '#Java Eviroment' >> "$HOME/.bashrc"
                echo 'JAVA_HOME=/opt/java' >> "$HOME/.bashrc"
                echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.bashrc"
                echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.bashrc"
                echo 'export JAVA_HOME' >> "$HOME/.bashrc"
                echo 'export PATH' >> "$HOME/.bashrc"
                export 'JAVA_HOME=/opt/java'
                export 'JDK_HOME='$JAVA_HOME
                export 'PATH=$PATH:$JAVA_HOME/bin'
                echo 'JAVA_HOME '$JAVA_HOME
                echo 'JDK_HOME  '$JDK_HOME
            fi                

            if [ -e "$HOME/.zshrc" ]; then
                echo -e "\n \033[1;32m Configuring zshrc  \033[0m \n "
                cd $HOME
                cp .zshrc .zshrc.bak
                echo '#Java Eviroment' >> "$HOME/.zshrc"
                echo 'JAVA_HOME=/opt/java' >> "$HOME/.zshrc"
                echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.zshrc"
                echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.zshrc"
                echo 'export JAVA_HOME' >> "$HOME/.zshrc"
                echo 'export PATH' >> "$HOME/.zshrc"
                export 'JAVA_HOME=/opt/java'
                export 'JDK_HOME='$JAVA_HOME
                export 'PATH=$PATH:$JAVA_HOME/bin'
                echo 'JAVA_HOME '$JAVA_HOME
                echo 'JDK_HOME  '$JDK_HOME                
            fi  

        else    
            #download the file
            wget $LINK

            #unpacks file in /opt
            sudo tar xf $ARQ -C /opt

            #changes to directory /opt
            cd /opt

            #saves the directory of the new version
            DIR=`ls -lt |awk -F" " '/jdk/ {print $9}' |head -n1`     

            #create symbolic link of the new version for java directory /opt/java
            sudo ln -s $DIR java 

            #Configures Ubuntu update-alteranatives to use the new version
            sudo update-alternatives --install /usr/bin/java java /opt/java/bin/java 1

            #Checks whether update-alternatives is configu
            sudo update-alternatives --display java

            #Configures Ubuntu update-alteranatives to use the new version
            sudo update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 1

            #Checks whether update-alternatives is configured
            sudo update-alternatives --display javac

            #displays java version
            echo -e '\033[1;32m \033[0m \n'
            java -version

            # java environment variables
            if [ -e "$HOME/.bashrc" ]; then
                echo -e "\n \033[1;32m Configuring bashrc \033[0m \n "
                cd $HOME
                cp -v .bashrc .bashrc.bak
                echo '#Java Eviroment' >> "$HOME/.bashrc"
                echo 'JAVA_HOME=/opt/java' >> "$HOME/.bashrc"
                echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.bashrc"
                echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.bashrc"
                echo 'export JAVA_HOME' >> "$HOME/.bashrc"
                echo 'export PATH' >> "$HOME/.bashrc"
                export 'JAVA_HOME=/opt/java'
                export 'JDK_HOME='$JAVA_HOME
                export 'PATH=$PATH:$JAVA_HOME/bin'
                echo 'JAVA_HOME '$JAVA_HOME
                echo 'JDK_HOME  '$JDK_HOME
            fi                

            if [ -e "$HOME/.zshrc" ]; then
                echo -e "\n \033[1;32m Configuring zshrc \033[0m \n"
                cd $HOME
                cp -v .zshrc .zshrc.bak
                echo '#Java Eviroment' >> "$HOME/.zshrc"
                echo 'JAVA_HOME=/opt/java' >> "$HOME/.zshrc"
                echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.zshrc"
                echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.zshrc"
                echo 'export JAVA_HOME' >> "$HOME/.zshrc"
                echo 'export PATH' >> "$HOME/.zshrc"
                export 'JAVA_HOME=/opt/java'
                export 'JDK_HOME='$JAVA_HOME
                export 'PATH=$PATH:$JAVA_HOME/bin'
                echo 'JAVA_HOME '$JAVA_HOME
                echo 'JDK_HOME  '$JDK_HOME                
            fi                
        fi
else

    #shows that you have the latest version installed
    echo -e '\033[1;32m You have the latest version of Java'    
fi