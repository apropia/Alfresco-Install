#!/bin/bash
# -------
# Script for install Alvex
#
# Copyright 2016 Apropia.co, Andres Ramirez
# Distributed under the Creative Commons Attribution-ShareAlike 3.0 Unported License (CC BY-SA 3.0)
# -------

export ALF_HOME=/opt/alfresco
export ALF_DATA_HOME=$ALF_HOME/alf_data
export CATALINA_HOME=$ALF_HOME/tomcat
export ALF_USER=alfresco
export ALF_GROUP=$ALF_USER
export APTVERBOSITY="-qq -y"
export TMP_INSTALL=/tmp/alfrescoinstall
export DEFAULTYESNO="y"


export ALVEX_DOWNLOAD=http://nexus.itdhq.com/service/local/repositories/snapshots/content/com/alvexcore/alvex/3.0-SNAPSHOT/alvex-3.0-20161117.110754-90.zip




# Color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgre=${txtbld}$(tput setaf 2) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

echoblue () {
  echo "${bldblu}$1${txtrst}"
}
echored () {
  echo "${bldred}$1${txtrst}"
}
echogreen () {
  echo "${bldgre}$1${txtrst}"
}
cd /tmp

mkdir alfrescoinstall
cd ./alfrescoinstall

echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echogreen "Alvex Installer for Alfresco Ubuntu by Apropia.co ."
echogreen "Please read the documentation at"
echogreen "https://github.com/apropia/Alfresco-Ubuntu-Apropia-Install/"
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

echo


echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Checking for the availability of the URLs inside script..."
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo

echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Preparing for install. Updating the apt package index files..."
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
sudo apt-get $APTVERBOSITY update;
echo


URLERROR=0

for REMOTE in $ALVEX_DOWNLOAD

do
        wget --spider $REMOTE --no-check-certificate >& /dev/null
        if [ $? != 0 ]
        then
                echored "In alfinstall.sh, please fix this URL: $REMOTE"
                URLERROR=1
        fi
done

if [ $URLERROR = 1 ]
then
    echo
    echored "Please fix the above errors and rerun."
    echo
    exit
fi


echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Alvex require stop Alfresco to install services "
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
read -e -p "Stop Alfresco Software?${ques} [y/n] " -i "$DEFAULTYESNO" stopAlfresco
if [ "$stopAlfresco" = "y" ]; then
	sudo service alfresco stop
fi

echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Alvex is the leading Alfresco-based open-source software solution "
echo "for adaptive case management, document management, project management "
echo "and business process management."
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
read -e -p "Install Alvex Solution${ques} [y/n] " -i "$DEFAULTYESNO" installAlvex
if [ "$installAlvex" = "y" ]; then
	echogreen "Installing Maven Services bundle..."
	sudo apt-get $APTVERBOSITY install maven 
	echogreen "Downloading Alvex Services bundle..."
	mkdir -p $TMP_INSTALL/alvex
    sudo curl -# -o $TMP_INSTALL/alvex/alfresco-alvex.zip $ALVEX_DOWNLOAD
    # Make sure we have unzip available
    sudo apt-get $APTVERBOSITY install unzip
    echogreen "Expanding file..."
    cd $TMP_INSTALL/alvex
	sudo chmod u+x alfresco-alvex.zip
   	sudo unzip -q alfresco-alvex.zip
	
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.custom*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.datagrid*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.infavorites*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.inform*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.manager*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.masterdata*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.middle*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.orgchart*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.project*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.uploader*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.utils*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/repo/com.alvexcore.repo.workflow*.jar $ALF_HOME/tomcat/webapps/alfresco/WEB-INF/lib/

	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.custom*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.datagrid*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.manager*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.masterdata*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.middle*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.orgchart*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.project*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.uploader*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.utils*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	sudo mv $TMP_INSTALL/alvex/share/com.alvexcore.share.workflow*.jar $ALF_HOME/tomcat/webapps/share/WEB-INF/lib/
	
fi


echo
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
echo "Alvex require Start Alfresco to update services "
echoblue "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
read -e -p "Start Alfresco Software?${ques} [y/n] " -i "$DEFAULTYESNO" startAlfresco
if [ "$startAlfresco" = "y" ]; then
	sudo service alfresco restart
fi
