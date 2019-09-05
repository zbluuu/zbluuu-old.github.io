#! /bin/bash
# # # # # # # 
# To-DO:
# > ubuntu 18
# > Other Debains
# > Rechecking
# > Record Vid for Site


#Saves
logfiles=LOG_$RANDOM.txt
PW=""
rePW=""
#echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▯▯▯▯▯▯▯▯]"
#
##  THis isntaller is only over 16.04
echo "   -Do you want install Webmin for ubuntu? (tested on 16.04) [Y/N] "
sleep 0.5
echo -n "  > "
while read VAR1
	do case $VAR1 in
		Y*|y*)
		#echo -e ">>>Installing . . ."
		echo "###INSTALLATION STARTS HERE, today is $(date)" > $logfiles
		echo -e ">>>Before we get started, requesting SUDO..."
		sudo echo ". . . Done! "
		break
		;;
		N*|n*)
		echo -e ">>>Aborted!!"
		exit
		;;
		*)
		echo ""
		echo -n "  > "
		;;
	esac
done
sleep 1
#
## Checking before Installing
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▯▯▯▯▯▯▯▯]"
echo -en "\r\e[2m CHECKING LAMP (Apache)\e[22m"
echo "#Checking LAMP..." >> $logfiles
apache2 -v &>> /dev/null
LAMP1=$?
sleep 0.5
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▯▯▯▯▯▯▯]"
echo -en "\r\e[2m CHECKING PHP (Apache)\e[22m"
php -v &>> /dev/null
LAMP2=$?
echo "#ZEROcheck: Apache2 = $LAMP1" >> $logfiles
echo "#ZEROcheck: Php = $LAMP2" >> $logfiles
sleep 0.5
if [ $LAMP1 -eq 0 ] && [ $LAMP2 -eq 0 ]; then
        LAMPinstalled=0
        #Zero means it installed well

else
        LAMPinstalled=1
        #Non-Zero means it wasnt installed yet
fi
#
## ASKING STUFFS BEFORE START
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▯▯▯▯▯▯]"
echo -en "\r\e[2m CHECKING MYSQL\e[22m"
echo -en "\r\e[2m ..............................................  \e[22m            "
echo -en "\r\e[2m MYSQL PW for INSTALL: \e[22m"
if [ $LAMPinstalled -eq 0 ]; then
		echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▯▯▯▯▯▯]"
        echo -en "\r\e[2m MYSQL PW for INSTALL: *IGNORED*\e[22m"
        sleep 1
        echo "#MySql PW ignored">> $logfiles
        #ignored for now.
else
        echo -en "\r\e[2m MYSQL PW for INSTALL:\e[8m \e[22m"
        read PW
        sleep 0.25
        echo -en "\e[0m\r\e[2m ..............................................  \e[22m            "
        echo -en "\r\e[2m REPEAT THE PW:\e[8m \e[22m"
        read rePW
        	while [ "$PW" != "$rePW" ]
        	  do
        		echo -en "\e[0m\r\e[2m ..............................................  \e[22m            "
				echo -en "\r\e[0m\e[2m Ooops. It didnt machted \e[22m"
				sleep 2
				echo -en "\r\e[2m Try again, PW for MYSQL:\e[8m \e[22m"
				read PW
				sleep 0.25
				echo -en "\e[0m\r\e[2m ..............................................  \e[22m            "
				echo -en "\e[0m\r\e[2m REPEAT THE PW:\e[8m \e[22m"
				read rePW				
        	  done
        echo -en "\e[0m\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▯▯▯▯▯▯]"
		echo -en "\e[0m\r\e[2m MACHTED. \e[22m"
		echo "#PW-ed for MYSQL" >> $logfiles
		sleep 2
        	
fi

#
## LETS GOO!! Installation.
echo "## Ones times there was a Apt... Here goes the INSTALLATION!" >> $logfiles
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▯▯▯▯▯]"
echo -en "\r\e[2m Updating before Installing\e[22m"
sudo apt-get -yq update &>> $logfiles
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▯▯▯▯]"
echo -en "\r\e[2m Installing LAMP\e[22m"
if [ $LAMP1 -eq 0 ]; then
	echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▯▯▯▯]"
	echo -en "\r\e[2m LAMP is alread Installed.\e[22m"
	sleep 2
else
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PW"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PW"
	sudo apt-get -yq install apache2 libapache2-mod-php7.0 php7.0 php7.0-mysql mysql-server &>> $logfiles
fi
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▮▯▯▯]"
echo -en "\r\e[2m Adding Webmin in sources list\e[22m"
echo "#For WEBmin" | sudo tee --append /etc/apt/sources.list &>> $logfiles
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee --append /etc/apt/sources.list &>> $logfiles
echo "#added sources" >> $logfiles
sleep 1
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▮▮▯▯]"
echo -en "\r\e[2m Refreshing sources\e[22m"
sudo apt-get -yq update &>> $logfiles
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▮▮▮▯]"
echo -en "\r\e[2m Installing Webmin\e[22m"
sudo apt-get -yq --allow-unauthenticated install webmin &>> $logfiles
echo -en "\r\e[2m . . . . . . . . . . . . . . . . . . . . . . . . \e[22m[▮▮▮▮▮▮▮▮▮]"
echo -en "\r\e[2m Finished installed. Feel free check $logfilest\e[22m"
echo -e " "
echo "Dont forget start with the Brower as https with ur IP as port :10000 and logs in as root!! Good Luck."

