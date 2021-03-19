#!/bin/bash
#testing
#Change directory to user's / home
cd /home/$USER

#Checks the main version of openjdk
MAJOR=`curl -s https://jdk.java.net/ |grep Ready |awk -F"/" '{print $2}'`

#Check the available version of openjdk
AVAILABLE=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"/" '{print $6}' |awk -F"k" '{print $2}'`

#Check the INSTALLED version of openjdk
if [ -e "/opt/java/release" ]; then
    INSTALLED=`cat /opt/java/release |grep -E 'JAVA_VERSION=' |awk -F"\"" '{print $2}'`
else
    INSTALLED="Not installed"
fi

#Shows the versions installed and available on the website
echo -e '\n\033[1;34m Installed version: '$INSTALLED
echo -e '\033[1;36m Latest version...: '$AVAILABLE '\n'

#Save download link
LINK=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"\"" '{print $2}'`

#Saves download file name
ARQ=`curl -s https://jdk.java.net/$MAJOR/ |grep -E '*_linux-x64_bin.tar.gz">' |awk -F"/" '{print $10}' |awk -F"\"" '{print $1}'`

#Checks difference between installed and available versions
if [ "$AVAILABLE" != "$INSTALLED" ]; then

    #Shows message that they are different and that will update
    echo -e '\033[1;31m The installed version is out of date downloading the new version \033[0m \n'

    #Checks download file already exists
    if [ -e "$ARQ" ]; then   
        echo -e "$ARQ alredy exist \n"
    else
        #download the file
        wget $LINK              
    fi
    
    #Unpacks file in /opt
    sudo tar xf $ARQ -C /opt
        
    #Changes to directory /opt
    cd /opt
        
    #Saves the directory of the new version
    DIR=`ls -lt |awk -F" " '/jdk/ {print $9}' |head -n1`     
       
    #Remove symbolic link of the new version for java directory /opt/java
    sudo rm java

    #Create symbolic link of the new version for java directory /opt/java
    sudo ln -s $DIR java 
        
    #Go to home dir
    cd $HOME
            
    if [ "$INSTALLED" = "Not installed" ]; then  

        # Java environment variables
        if [ -e "$HOME/.bashrc" ]; then

            echo -e "\n \033[1;32m Configuring bashrc \033[0m"
            cp -v .bashrc .bashrc.bak
            echo " " >> "$HOME/.bashrc"
            echo '#Java Eviroment' >> "$HOME/.bashrc"
            echo 'JAVA_HOME=/opt/java' >> "$HOME/.bashrc"
            echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.bashrc"
            echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.bashrc"
            echo 'export JAVA_HOME' >> "$HOME/.bashrc"
            echo 'export PATH' >> "$HOME/.bashrc"
            echo " "

        fi                

        if [ -e "$HOME/.zshrc" ]; then

            echo -e "\n \033[1;32m Configuring zshrc \033[0m"
            cd $HOME
            cp -v .zshrc .zshrc.bak
            echo " " >> "$HOME/.zshrc"
            echo '#Java Eviroment' >> "$HOME/.zshrc"
            echo 'JAVA_HOME=/opt/java' >> "$HOME/.zshrc"
            echo 'JDK_HOME=$JAVA_HOME' >> "$HOME/.zshrc"
            echo 'PATH=$PATH:$JAVA_HOME/bin' >> "$HOME/.zshrc"
            echo 'export JAVA_HOME' >> "$HOME/.zshrc"
            echo 'export PATH' >> "$HOME/.zshrc"  
            echo " "

        fi  

        #Configures Ubuntu update-alteranatives to use the new version
        sudo update-alternatives --install /usr/bin/java java /opt/java/bin/java 1
        echo -e " "

        #Checks whether update-alternatives is configured
        #sudo update-alternatives --display java
        #echo -e " "

        #Configures Ubuntu update-alteranatives to use the new version
        sudo update-alternatives --install /usr/bin/javac javac /opt/java/bin/javac 1
        echo -e " "

        #Checks whether update-alternatives is configured
        #sudo update-alternatives --display javac
        #echo -e " "

        # Java environment variables
        export 'JAVA_HOME=/opt/java'
        export 'JDK_HOME='$JAVA_HOME
        echo -e '\nJAVA_HOME '$JAVA_HOME
        echo -e 'JDK_HOME  '$JDK_HOME

    fi        
            
    #Displays java version
    echo -e '\033[1;32m'
    java -version

    echo -e '\nJava successfully installed\n'

else

    #Shows that you have the latest version installed
    echo -e '\033[1;32m You have the latest version of Java'    
fi