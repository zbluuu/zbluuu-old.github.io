#! /bin/bash
# # # # # # # 
# To-DO:
# > ubuntu 18
# > Other Debains
# > Rechecking
# > Record Vid for Site



#Request Yes/No

echo -e "\e[2m    -- shell wirtten by Blu (18.05.17-22.05.17) -- \e[22m\n"
echo " -> Welcome $USER! ( This Installer is made for Ubuntu)"
sleep 0.5
echo -e " -> Do you like install \e[1mLAMP\e[21m ? (\e[1mL\e[21minux \e[1mA\e[21mpache2 \e[1mM\e[21mySQL \e[1mP\e[21mHP) "
sleep 0.25
echo -n " [Y]es or [N]o?> "
while read lvl1
	do case $lvl1 in
		Y*|y*)
		break
		;;

	N*|n*)
		echo " -> Aborted. "
		exit
		break
		;;

		*)
		echo -n " [Y]es or [N]o?> "
		;;
	esac
done


#Checking Ubuntu's version
#quelle: https://wiki.ubuntuusers.de/LAMP/ unter 15.10 und ab 16.04
echo " -> Checking what Ubuntu are you using..."
sleep 0.5
linuxvers=$(lsb_release -rs)
linuxName=$(lsb_release -ds)
linuxvers0=${linuxvers//./}
echo " -> You currenly Linux is $linuxName (Aka $linuxvers0)"
sleep 1
#Request onces for sudo passwort proming
echo " -> Asking for sudo permission... (only onces)"
echo -n " #> "
sudo echo " -> Done."
#Create Passwort für MySQL
echo " -> Creating Password for MySQL, Please type ur password:"
echo -en " #> \e[8m"
read -s pwd1
echo -en "\e[28m"
echo " -> Retype ur password:"
echo -en " #> \e[8m"
read -s pwd01
echo -en "\e[28m"
#if password didnt machted
while [ "$pwd1" != "$pwd01" ]
   do
	echo " -> Ooops. You Password didnt machted"
	echo " -> Please type ur password again:"
	echo -en " #> \e[8m"
	read -s pwd1
	echo -en "\e[28m"
	echo " -> Retype ur password:"
	echo -en " #> \e[8m"
	read -s pwd01
	echo -en "\e[28m"
   done
#Right Version
lampinstall=2 #für ab 16.04
if [ $linuxvers0 -lt 1604 ]; then

lampinstall=1 #für bis 15.10
fi
echo " -> Choosed: $lampinstall (1 means under 15.10 & 2 means over 16.04)"
echo " -> Getting ready for the Install..."
#sleep 1
	case $lampinstall in
		1)
		echo -e " \e[40m> Installing \e[1mLAMP\e[21m ($lampinstall)...\e[49m"
		sudo apt-get -yq install apache2 libapache2-mod-php5 php5 php5-mysql mysql-server net-tools 
s=$?
		;;
		2)
		echo -e " \e[40m> Installing \e[1mLAMP\e[21m ($lampinstall)...\e[49m"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $pwd1"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $pwd1"
		sudo apt-get -yq install apache2 libapache2-mod-php7.0 php7.0 php7.0-mysql mysql-server net-tools 
s=$?
		;;
	
	esac

#Installed right?
if [ $s -ne 0 ]
then
echo "  "
echo "-----------------------------------------"
echo " Error $s: Something went not right ...  "
echo "- - - - - - - - - - - - - - - - - - - - -"
sleep 1.25
echo " -> Checking the Reason why"
# Repead why as als case
	case $s in
		100)
#Internert Kontolle
		echo " -> Checking for Internert Connects..."
		ping -q -c5 ubuntu.com > /dev/null
 
		if [ $? -ne 0 ]
		then
			echo " -> You seen, you have bad or no connection, we cant connect to Ubuntu Server. Please check ur Internert or contacts Admin for this Error. ( Error: $s $s" ' (as the check was $?)' 
			echo " -> Aborted. "
			exit

		fi
		echo " -> Internert seen okay. Please check the Install log, or check Internert about these Error. Or contacts Admin for this Error ( Error: $s $s" ' (as the check was $?)'
		echo " -> Aborted. "
		exit
		;;

		*)
		IPadress2=$(hostname -I)
		echo " -> Unknown Reason. Error Code: $s" ' (as the check was $?) Please contact Admin.' " Also that ur Error code is unknow, you may can check if the web are running: http://$IPadress2 "
		;;
	esac
fi 
#Short cleaning
sudo apt-get autoclean -q

#Output as "Sussesful"
IPadress2=$(hostname -I)
Hostname=$(hostname)
echo "  "
echo " -> Sussesful Installed. ($s)"
echo " ---------------------------------"
echo -e " -> Adresse for your Site are:"
echo -e "    -\e[1m http://$IPadress2 \e[21m"
echo -e "    -\e[1m http://$Hostname/ \e[21m"
echo " ---------------------------------"
echo " -> To change/edit HTML/etc:"
echo -e "    -\e[7m ./var/www/html/ \e[27m"
echo " ---------------------------------"







	
