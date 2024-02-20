#!/bin/bash
#VARIABLES
PACKAGES="httpd wget unzip"
SVC="httpd"
URL="https://www.tooplate.com/zip-templates/2133_moso_interior.zip"
ART_NAME="2133_moso_interior"
TEMPDIR="/tmp/"
echo "############## INSTALLING DEPENDENCIES ##################"
sudo yum install $PACKAGES  -y
echo "############## START AND ENABLE HTTPD ######################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo "############## CREATING WEBFILES DIR IN THE TEMPORAL DIR TO HOLD DOWNLOADED WEBSITE ####################"
mkdir -p  $TEMPDIR/webfiles
echo "############## CD /tmp/webfiles DOWNLOAD WEBSITE INTO IT  ####################"
cd $TEMPDIR/webfiles
wget $URL
echo "############## UNZIPPING THE DOWNLOADED ZIPPED FILE  ####################"
unzip -o $ART_NAME.zip
echo "################################################################################################################################        ##" 
ls $ART_NAME/
echo "################################################################################################################################        ##"
echo "############## COPY CONTENT OF UNZIPPED FILE INTO var/www/html/  ####################"
cp -r $TEMPDIR/webfiles/$ART_NAME/* var/www/html/
echo "############## RESTART HTTPD SERVICE  ####################"
sudo systemctl restart $SVP
echo "############## REMOVE TEMPORAL CREATED WEBFILES DIR  ####################"
#rm -rf $TEMPDIR/webfiles
echo "####################### HTTPD STATUS #########################" 
sudo systemctl status $SVC
echo "######################## DOWNLOADED WEDSITE CONTENTS ########################"