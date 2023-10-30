#!/bin/bash

err=0

echo "Введите фамилию студента (на латинице):"

# ввод и проверка имени студента 
while [[ $err -eq 0 ]] # пока флаг проверки 0
do
	read s_sname # вводим фамилию жертвы
        
	# только с ЗАГЛАВНОЙ и никаких цифр, да
	if [[ "$s_sname" =~ ^[A-Z]{1}[a-z]{1,}$ ]] # сравниваем с шаблоном фамилию
	then # если все ОК
		err=1 # делаем 1 для выхода из цикла проверки
	else # no comments...
		echo "ВНИМАНИЕ: фамилия введена неверно! В фамилии не должно быть чисел, и фамилия должна начинаться с заглавной буквы!"
		echo "Попробуйте еще раз!"
	fi
done	

# заменяем все кроме первой заглавной на Names.log
# так как все лог файлы начинаются с буквы фамилии
file_name=$(echo $s_sname | sed "s/[a-z]*$/Names.log/g")

# ищем лог файл по строке, полученной выше
res=$(find labfiles/ -name $file_name)

# тутЪ совпадение и номер строки
# затем убираем совпадение, чтобы остался только номер
# так же, если несколько найденных вариков, то преобразовываем их из столбца
# в строку для дальнейшей записи в массив
str_num=$(cat $res | grep -n "$s_sname" | sed -z -e "s/:[A-Za-z]*//g" -e "s/[\n\r]/ /g") 

# обработка символов в найденной строке
#echo "$str_num" 
#echo "$(echo $str_num | wc -c)"

# формирование массива из номеров найденных строк
str_arr=($str_num)

# вывод сообщения, если найдено несколько людей с такой фамилией
if [[ "$str_num" =~ [[:space:]][0-9] ]]	# пробел перед числом => несколько чисел в строке
then # обработка ошибки
	echo ""
	echo "Внимание: найдено несколько фамилий! Будет выведены все найденные студенты!"
fi

# проверка содержимого массива 
# echo "Массив номеров строк:"
# echo "${str_arr[@]}"	

# вывод сообщения, если массив ПУСТ, то есть в файлах НИЧЕГО не найдено
# то есть такого студента нет, его отсчислил Геннадий Александрович
if [[ -z ${str_arr[@]} ]]
then
	echo ""
	echo "Студент не найден!"
fi

# выводим досье 
for i in ${str_arr[@]}
do
echo ""
echo "Досье студента $(sed -n "${i}p" $res): " # берем строчку из файла с ником в БАРСе найденного студента...

# выводим на экран досье студента из лог файла
# со строки с позицией на ОДНУ НИЖЕ  и по разделитель ======
# echo $(($i-1)) # проверка индекса строки
sed -n "$(($i+1)) ,/\=/p" $res | sed "s/=*//g"
done

# СПАСИБО, ЧТО НЕ ОТЧИСЛИЛИ, ГЕННАДИЙ АЛЕКСАНДРОВИЧ!
