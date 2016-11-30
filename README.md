# Alfresco-Ubuntu-Apropia-Install

To start the install, in Ubuntu terminal run;

$ sudo curl -O https://raw.githubusercontent.com/apropia/Alfresco-Ubuntu-Apropia-Install/master/alfinstall.sh

$ sudo chmod u+x alfinstall.sh

$ sudo ./alfinstall.sh

-

To start Alvex Installation, in ubuntu terminal run;

$ sudo curl -O https://raw.githubusercontent.com/apropia/Alfresco-Ubuntu-Apropia-Install/master/alvexinstall.sh

$ sudo chmod u+x alvexinstall.sh

$ sudo ./alvexinstall.sh

-

To update stiles and css of Alfresco for Apropia

$ cd /opt/

$ wget https://github.com/apropia/Alfresco-Ubuntu-Apropia-Install/raw/master/alfresco-community.zip

$ sudo chmod a+x alfresco-community.zip

$ sudo chown alfresco:alfresco alfresco-community.zip

$ sudo unzip alfresco-community.zip

$ sudo rm alfresco-community.zip


