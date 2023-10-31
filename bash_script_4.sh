#!/bin/bash

# глобальные перменные 
ok=0 # переменная для обработки ошибок 

ch=0 # переменная для обработки выбора 

# красная или синяя
echo "Введите 1 для выбора предмета \"Криптозоология\" и 2 для \"Пивоварение\":"

# выбираем предмет с проверкой ввода
while [[ $ok -eq 0 ]] # пока флаг проверки 0
do
        read ch # вводим

        if [[ $ch == 1 ]] # если выбрали первый варик 
        then # все ОТЛИЧНО
                sub_name="Криптозоология"
		ok=1
	elif [[ $ch == 2 ]]
	then
		sub_name="Пивоварение"
                ok=1
        else # бывает...
                echo "Ошибка при вводе ключа! Выберите 1 или 2!"
        fi

done

ok=0 # обнуляем переменную проверки ошибки

# выбираем тест с проверкой ввода
echo "Введите номер теста: "

while [[ $ok -eq 0 ]] # пока флаг проверки 0
do
        read test_num # вводим

        if ! [[ $test_num -gt 4 || $test_num -le 0 ]] # проверка диапазона
        then # все ОТЛИЧНО
                ok=1 # выходим из цикла 
        else # бывает...
                echo "Ошибка при вводе номера теста! Введите в диапазоне от 1 до 4!"
        fi

done

# поиск файла с тестом  
file_path=$(find ./labfiles/$sub_name -name "TEST-$test_num") # результат записываем в переменную

# контроль найденного файла 
# echo "$file_path"

# считаем количество студентов в файле с тестом
stud_count=$(awk -F ";" '{count[$2]++} END {for (n in count) print n}' $file_path | wc -l) # число уникальных значений во втором столбце (фамилии) = количество студентов

ok=0 # обнуляем переменную проверки ошибки

# ввод количества отображаемых студентов
echo "Введите количество отображаемых студентов (до $stud_count): "

while [[ $ok -eq 0 ]] # пока флаг проверки 0
do
        read line_count # вводим

        if ! [[ $line_count -gt $stud_count || $line_count -le 0 ]] # проверка диапазона
        then # все ОТЛИЧНО
                ok=1 # выходим из цикла 
        else # ну как так то...
                echo "Ошибка: выход за диапазон! Введите в диапазоне от 1 до $stud_count!"
        fi

done

# вывод топ студентов по среднему баллу 
# с awk это прям очень просто...
echo "Место | Студент | Группа |Средний балл по попыткам"

# объяснение: по сути создается три массива group, sum и count перед обработкой файла
# в массив group записывается группа из поля $1 по уникальному значению во втором поле с фамилией
# в массив sum записывается сумма для каждого уникального значения из поля $2 с фамилией
# в массив count - считаем количество таких записей, чтобы потом на него поделить (среднее)
# затем в цикле просто выводим это все, потом сортируем, потом берем первые $line_count записей, такие дела
awk -F ";" '{group[$2]=$1; sum[$2]+=$4; count[$2]++; } END {for (i in sum) print "   ", i,"   ", group[i],"   ", sum[i]/count[i]}' $file_path | sort -r -k3 | awk -F ";" '{print NR " " $1}' | head -n $line_count
