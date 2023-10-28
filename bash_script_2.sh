#!/bin/bash

# глобальная для проверки
err=0

# ввод группы
echo "В какой группе учится интересующий Вас студент (на латинице): "

# ввод и проверка в цикле введенной группы
while [[ $err -eq 0 ]] # пока флаг проверки 0
do
	read gr_num # что-то вводим

	if [[ "$gr_num" =~ A-[0][0-9]-[0-9][0-9]$ ]] # сравниваем это что-то с шаблоном
	then # если все ОК
		err=1 # делаем 1 для выхода из цикла проверки
	else # все <3 <3 <3 <3 <3, давай по новой
		echo "Ошибка при вводе группы! Попробуйте еще раз!"
	fi
done	

# вводим интересующий предмет
echo "Введите какой предмет Вас интересует (на русском): "

err=0 # обнуляем

# ввод и проверка в цикле введенного предмета
while [[ $err -eq 0 ]] # пока флаг проверки 0
do
	read sub_n # опять вводим

	if [[ "$sub_n" == "Криптозоология" || "$sub_n" == "Пивоварение" ]] # опять сравниваем это что-то с шаблоном
	then # все ОК
		err=1
	else # почему всегда так сложно сделать все правильно? 
		echo "Ошибка при вводе предмета! Предметы для выбора: Криптозоология или Пивоварение!"
	fi

done	

# поиск файла с посещаемостью 
res=$(find ./labfiles/$sub_n -name "$gr_num-attendance") # результат записываем в переменную

# и наш победитель...
echo ""
echo "Лучший студент по посещаемости в группе $gr_num: "
echo ""

cat $res | awk '{gsub(/0/, "", $2); len=length($2); gsub(/1*/, len, $2); print "Никнейм в БАРС: " $1 " Пользователь БАРС: " $2  }' | sort -n -k2 | tail -n 1 # со дна берем студента

# ДОБРО ПОЖАЛОВАТЬ НА ДНО
