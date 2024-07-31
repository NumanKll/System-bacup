#!/bin/bash

path=$(date "+%Y%m%d")

user=$1

IP=$2

rmtBckpD=$3

home=$(pwd) 

if ! [ -f $home/bacupDirectory.txt ]; then 
	
	echo "Uzak sunucu yedeği için kullanım './bacup.sh [remote-user] [remote-host] [remote-host-directory]'"

	touch $home/bacupDirectory.txt
	declare -A dizin
	while (( 1 ));do
    		echo -E "Yedeklenecek Dizinleri Girin(Çıkmak İçin 'q'):"
    		read dz
    		if [[ $dz == "q" ]]; then
        		break
    		fi
    		dizin[ $syc ]=$dz
		echo $dz >> bacupDirectory.txt
    		syc=$(( $syc + 1 ))
	done
fi

if ! [ -f /var/back/$path ]; then
	mkdir -p /var/back/$path
fi

for i in $(cat $home/bacupDirectory.txt); do
	cd $i
	cd ..
	if ! [ -f /var/back/$path/$i.tar.gz ]; then
		tar -czvf $i.tar.gz $i
	else
		rm -r $i.tar.gz $i
		tar -czvf $i.tar.gz $i
	fi
	mv *.tar.gz /var/back/$path/
	echo "Local Bacup Complete"
done 

cd /var/back

if [ -n "$user" ] && [ -n "$IP" ] && [ -n "$rmtBckpD" ]; then
	for l in $( ls ); do

		if ! [ -f /var/back/$path.tar.gz ]; then
			tar -czvf $path.tar.gz $path
			scp $path.tar.gz $user@$IP:$rmtBckpD 
			rm -r $path
			echo "Remote Complete"
		fi
	done
fi
