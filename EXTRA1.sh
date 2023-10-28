#!/bin/bash

ccount=0;
res=0;
res_stud=0;
buff_res=0;

for file in A0920.txt; do
	echo "File name is $file"
	while read line; do 
			echo "$line"
			buff_res=$(echo "$line" | sed -e  's/^[a-zA-Z]* //g' -e 's/0//g' -e 's/\r$//g' | wc -m)
			(( buff_res-=1 )) # one extra character need to delete
			echo "$buff_res"
		 if [[ $buff_res -gt $res ]]; then
		 	echo "$buff_res"
			res="$buff_res"
		 	res_stud="$line"
		 fi	 
	done<"$file"
done

echo "Больше всего посещений у: $res_stud"
echo "Количество посещений: $res"
