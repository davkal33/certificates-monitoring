#!/bin/bash

#######FUNKCJE########
waznosc()
{
	a=$data_c_sum
	b=$data_a_sum
	c=$[$a-$b]
	e=-1
	d=$[$c*$e]
	echo "$c"
	if [ "$c" -lt 0 ] || [ "$c" -eq 0 ]; then
		echo "$c">>"raport.txt"
		echo "****************Certyfikat jest niewazny od " "$d" " dni!!!****************" >>"raport.txt"

	elif [ "$c" -lt 30 ]; then
		echo "$c">>"raport.txt"
		echo "****************Certyfikat straci waznosc za " "$c" "dni!!!****************" >>"raport.txt"
	else
		echo "$c">>"raport.txt"
		echo "Certyfikat Jest wazny na" "$c" "dni." >>"raport.txt"

	fi
}



#####################

#cd /etc/ssl/certyfikaty

rm -f /root/Desktop/projekt/raport.txt


arr=(~/Desktop/projekt/certyfikaty/*) #tablica certyfikatow z danego folderu#


#aktualna data#
now=$(date)
now1=$(echo "$now" | tr -s " " | cut -d " " -f 2,3,4)
###

echo "$now1" "<--*--"
declare -a data_a #tablica z aktual. data#

data_a[0]=$(echo "$now1" | cut -d " " -f 3) #rok
data_a[1]=$(echo "$now1" | cut -d " " -f 2) #miesiac
data_a[2]=$(echo "$now1" | cut -d " " -f 1) #dzien


data_a[1]=$(echo $(date -d "${data_a[0]} ${data_a[2]} ${data_a[1]}" +%m"")) #konwersja nazw. mies. na liczbe

data_a_sum=$[$[$[${data_a[0]}-2000]*365]+$[${data_a[1]}*30]+${data_a[2]}] #liczba potrzebna do okreslenia waznosci cert.(suma)
echo "$data_a_sum"



echo  "${data_a[0]}" "${data_a[1]}" "${data_a[2]}"
echo "^^^^Aktualna_data^^^^"
             


echo "------------------------------------------">>"raport.txt"
d=-1
declare -a data_c  #tablica z data certyfikatu#

#uporzodkowanie skladowych daty cert. aby moc porownac z aktual. data#
for ((i=0; i<${#arr[@]}; i++)); do

		cala_d=$(echo $(openssl x509 -in  ${arr[$i]} -inform PEM -noout -dates) | tail -n 1 | cut -d "=" -f 3 | tr -s " " | cut -d " " -f 1,2,4)
		
		data_c[0]=$(echo "$cala_d" | cut -d " " -f 3) #rok
		data_c[1]=$(echo "$cala_d" | cut -d " " -f 1) #miesiac
		data_c[2]=$(echo "$cala_d" | cut -d " " -f 2) #dzien
		
		data_c[1]=$(echo $(date -d "${data_c[0]} ${data_c[2]} ${data_c[1]}" +%m"")) #konwersja nazwy miesiaca na liczbe
		
		
		data_c_sum=$[$[$[${data_c[0]}-2000]*365]+$[${data_c[1]}*30]+${data_c[2]}] #liczba potrzebna do obliczenia wazn cert. (suma)

		echo "${arr[$i]}" >>"raport.txt"
		
		
		echo  "${data_c[0]}" "${data_c[1]}" "${data_c[2]}" >>"raport.txt"
		waznosc $data_a_sum $data_c_sum
		echo "------------------------------------------" >>"raport.txt"
		

done

#####Certyfikaty zdalne algorytm#############################################################################################################################

declare -a adr_ip
port=443

#Przykadowe adresy ip w celu sprawdzenia zdalnych ceryfikatow
adr_ip[0]=156.17.30.65  #pst.pwr.edu.pl
adr_ip[1]=213.197.177.133


for x in ${!adr_ip[@]}; do

	cala_d=$(echo | openssl s_client -servername ${adr_ip[x]} -connect ${adr_ip[x]}:443 2>/dev/null | openssl x509 -noout -dates | tail -n 1 | cut -d "=" -f 2 | tr -s " " | cut -d " " -f 1,2,4)
	

	data_c[0]=$(echo "$cala_d" | cut -d " " -f 3) #rok
	data_c[1]=$(echo "$cala_d" | cut -d " " -f 1) #miesiac
	data_c[2]=$(echo "$cala_d" | cut -d " " -f 2) #dzien

	data_c[1]=$(echo $(date -d "${data_c[0]} ${data_c[2]} ${data_c[1]}" +%m"")) #konwersja nazwy miesiaca na liczbe
			
	data_c_sum=$[$[$[${data_c[0]}-2000]*365]+$[${data_c[1]}*30]+${data_c[2]}] #liczba potrzebna do obliczenia wazn
	echo "${adr_ip[$x]}" >>"raport.txt"

	echo  "${data_c[0]}" "${data_c[1]}" "${data_c[2]}" >>"raport.txt"
	waznosc $data_a_sum $data_c_sum
	echo "------------------------------------------" >>"raport.txt"
	
	
done

echo "Raport zostal wygenerowany i przeslany automatycznie.">>"raport.txt"











