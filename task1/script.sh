#! /bin/bash

file=$1

IFS=";"

amount=$(wc -l < $file)

echo " You are to add $amount users from $1, do you wish to proceed?"

read -n1 -p "(y/n)" answer

echo

if [[ $answer == "Y" || $answer == "y" ]];

then
        
        echo >> userLog.txt
        
        echo "Add users" >> userLog.txt
        
        (TZ="NZ" date) >> userLog.txt #add current time stamp to userLog
        
        while read  -r email dob groupys folder
        
        do
		#create username
		lastName=$(echo $email | awk -F'[@.]' '{print $2}')
		username=${email:0:1}$lastName

		#create password
		password=$(echo $dob |awk -F '[/:]' '{print $2.$1}')

		#create first group if not exist
		fgroup=$(echo $groupys | awk -F '[,]' '{print $1}')
		grep -q "\b$fgroup\b" /etc/group >> /dev/null
		if [ $? -eq 0 ]; 
		then
			echo >> /dev/null
		else
			echo >> /dev/null
			echo "--------------------"
			sudo groupadd -f "$fgroup"
		fi
        


		#create secondary group if not exist
		sgroup=$(echo $groupys | awk -F '[,]' '{print $2}')
		grep -q "\b$sgroup\b" /etc/group >> /dev/null
		if [ $? -eq 0 ];
		then
			echo >> /dev/null
		else
			echo >> /dev/null
			sudo groupadd -f $sgroup
		fi

		#cerate users
		if [ -z "$groupys" ]
		then
			useradd -d /home/$username -m -s /bin/bash $username
		else
			useradd -d /home/$username -m -s /bin/bash -G $groupys $username
		fi


		#create password for user and force change on first login
		echo $username:$password | chpasswd
		chage --lastday 0 $username


		#seperate groups
		Groups=$(echo $groupys | awk -F '[,]' '{print $1.$2}')

		echo "Added user $username, with the password $password, in group(s) $Groups"
		echo "Added user $username, with the password $password, in group(s) $Groups" >> userLog.txt


		#create sharedfolder group
		if [ -z "$folder" ]
		then
			echo "They are not a part of any folder group" >> userLog.txt
		else
			#creating specified name for shareGroup dependent on folder
			share=$(echo $folder | awk -F '[/]' '{print $2}')
			shared=${share::-4}
			shareGroup=${share::-3}
			sudo groupadd -f $shareGroup
			sudo usermod -a -G $shareGroup $username
			echo "Folder group is $shareGroup" >> userLog.txt
		fi
		#create shared folder
		if [ -d "$folder" ] || [ -z "$folder" ]
			then echo >> /dev/null
		else
			echo >> /dev/null
			sudo mkdir -m 770 $folder
			sudo chgrp -R $shareGroup $folder
		fi

		#create symbolic link for sudo users 
		if [ -z "$folder" ]
		then
			echo "no shared folder" >> userLog.txtelse
		else
			sudo ln -s $folder /home/$username/shared
 		fi


		#create alias for sudo
 		if getent group sudo | grep -q "\b${username}\b";
 		then
 			echo "User is part of sudo" >> userLog.txt
 			touch /home/$username/.bash_aliases
 			sudo chown $username /home/$username/.bash_aliases
 			sudo chmod 700 /home/$username/.bash_aliases

 			echo "alias myls='ls -lisa'" >> /home/$username/.bash_aliases
 			source /home/$username/.bash_aliases
 		else
 			echo "user is not part of sudo" >> userLog.txt
 		fi

 		echo
 		echo >> userLog.txt

	  #FINISH READING FILE
        
        done < $file

fi
