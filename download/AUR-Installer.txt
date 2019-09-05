#! /bin/bash
# # # # # # #
# BTWW IT IS ONLY FOR ARCH LINUX USERER BECAUSE IT RUNS PACMAN, GIT AND MAKEPKG
# # # # # # # 
# To-DO:
# > Rechecking
# > Record Vid for Site



####Ask before begin
echo -n "===> Do you like install a AUR's Packages? [Y/N] -> "
while read YN1
   do case $YN1 in
Y|y)  #for accepting
break
;;


N|n) #for not accepting
echo "===> Aborted." 
exit
;;

*)
echo -n "===> Do you like install a AUR's Packages? [Y/N] -> "
;;
esac
done

#####Checking that not logged as ROOT because of PKGBUILD rules
if [ $USER = "root" ]; 
  then
echo "===> Please dont run as ROOT yet- Only after sudo Request."
echo "     Log in as any user that have sudo permission and" 
echo "     try run this shell again"
sleep 2
exit

else
echo "===> User is as $USER "
fi

####After YES, before Install request starts- checking is GIT and PKGBUILD installed and working
echo "===> Checking that GIT and MAKEPKG working fine..."
pacman -Qi git > /dev/null
ZZ=$?
#echo "-------> $ZZ"  #for debuggin
if [ $ZZ -ne 0 ];
  then
echo "===> Wooosh- GIT seen not installed."
echo "     WE need GIT for easier downloading safe on our"
echo "     ArchLinux Page (aka https://aur.archlinux.org/"
echo "     So do you like installing GIT? "
echo -n "===>Installing GIT? [Y/N] -> "
while read YN2 in 
do case $YN2 in
Y|y)
echo "===> Will installing.. Please wait"
echo "______________________________________"
sudo pacman -S git
echo "______________________________________"
echo "===> Finished GIT Installing."
break
;;
N|n)
echo "===> Aborted. Cant continuing without GIT"
exit
;;
*)
echo -n "===>Installing GIT? [Y/N] -> "
;;
esac
done
else 
echo "===> GIT is alread Installed. Good! "
fi


#echo "===> Checking that MAKEPKG working well... "
pacman -Qi binutils > /dev/null
ZZ=$?
#echo "-------> $ZZ"  #for debuggin
if [ $ZZ -ne 0 ];
  then
       echo "===> Wooosh- MAKEPKG seen not working well."
       echo "     Dont you minds installing binutils?"
       echo "     It will work installing some package"
echo "     You also can skipping it by saying [N]o. "
       echo -n "===>Installing binutils? [Y/N] -> "
while read YN3 in
       do case $YN3 in
               Y|y)
               echo "===> Will installing.. Please wait"
               echo "*interst installing*"
               echo "______________________________________"
sudo pacman -S binutils
               echo "______________________________________" 
               echo "===> Finished GIT Installing."
break
               ;;
               N|n)
               echo "===> Skipped."
               break
               ;;
               *)
               echo -n "===>Installing GIT? [Y/N] -> "
               ;;
       esac
done
else
echo "===> MAKEPKG is working well. Good! "
fi
echo "===> Creating Folder AURdownloadfiles.. (before end of this bash will remove)"
mkdir ~/AURdownloadfiles &>> /dev/null
cd ~/AURdownloadfiles
alias proj="cd ~/AURdownloadfiles"
echo "===> Currenly PWD: $PWD"

PAKET000=__________
####When working all fine, requesting/asking what AUR packages to install
####This person need also checked AUR Page before started
echo "#######################################################"
echo "#  GIT CLONE URL DOWNLOADER                     _ O X #"
echo "#######################################################"
echo "# PLEASE KNOW THAT: This SHELL will only installing   #"
echo "# like we always did from git to makepkg and please   #"
echo "# unterstand youself if something didnt worked well,  #"
echo "# as explame damaged etc...                Thanks you!#"
echo "#=====================================================#"
echo "# So we are ready! What do you like to install?       #"
echo "#_____________________________________________________#"
echo "#                TO CHECK: https://aur.archlinux.org/ #"
echo "#######################################################"
echo "$PWD/~  https://aur.archlinux.org/$PAKET000.git"
echo -n "$PWD/~                           $"
read PAKET000
echo "$PWD/~ Is that correct?"
echo "======================================================"
echo "# https://aur.archlinux.org/$PAKET000.git"
echo "======================================================"
echo "                 [Y]es or [N]o?"
echo -n "==> "
while read YN5 
do case $YN5 in
Y|y)
break
;;
N|n)
echo "==> Please Try again:"
echo "======================================================"
echo "$PWD/~  https://aur.archlinux.org/$PAKET000.git"
echo -n "$PWD/~                           $"
read PAKET000
echo "======================================================"
echo "======================================================"
echo "# https://aur.archlinux.org/$PAKET000.git"
echo "======================================================"
echo "                 [Y]es or [N]o?"
echo -n "==> "
;;
*)
echo "                 [Y]es or [N]o?"
      echo -n "==> "
;;
esac
done


##Requesting ROOT
echo "===> requesting SUDO..."
sudo echo "*poofs*"
echo "===> Done Requesting!"

####Ready to Download and installing
echo "===> EVERYTHING IS SETTED READY. . ." 
echo " >>> Downloading $PAKET000"
git clone https://aur.archlinux.org/$PAKET000.git

#echo "--TEST---> $PWD"
echo " >>> Entering Folder..."
cd $PWD/$PAKET000
echo "--TEST---> $PWD"


echo " >>> Starting the Installing (MAKEPKG)"
makepkg -is

echo " >>> Removing Downloaded Folder (aka \" $PAKET000 \" folder & AURdownloadfiles..."
cd ..
rm -fr $PAKET00
cd ..
rm -fr AURdownloadfiles

echo " >>> Finished!"

echo "   - - > Finished installing $PAKET000. PLEASE CHECK LOG < - -"

# # # # # # # # # # # # # # # # # # # # # # # 
#END OF FILES and here goes the exit door :P
echo "===> BuhBay!"
exit
