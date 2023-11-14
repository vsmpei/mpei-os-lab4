#!/bin/bash 

#--------------------------------------------------------------------
# глобальные переменные для разукрашивания вывода echo
#--------------------------------------------------------------------

RED='\033[0;31m' # красный текст

YELLOW='\033[0;33m' # желтый текст

GREEN='\033[0;32m' # зеленый текст

MAGENTA='\033[0;35m' # фиолетовый текст

NORMAL='\033[0m' # атрибуты по умолчанию

#--------------------------------------------------------------------
# объявление основных глобальных переменных 
#--------------------------------------------------------------------

ok=0 # переменная-флаг для обработки ввода 

dir_path="" # переменная для хранения пути к каталогу

ch=0 # переменная для обработки выбора 

#--------------------------------------------------------------------
# функция, выводящая упорядоченный по посещаемости список группы
#--------------------------------------------------------------------
show_student_list()
{
# обнуление переменных
ok=0 # обнуление переменной проверки ввода
ch=0 # обнуление перменной выбора

# ввод группы
echo -e "${GREEN}Введите интересующую Вас группу (на латинице):${NORMAL} "

# ввод и проверка в цикле введенной группы
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0
	
	read -p "-> " group_num # читаем (вводим) номер группы 

	if [[ "$group_num" =~ A-[0][0-9]-[0-9][0-9]$ ]]; then # сравниваем с шаблоном
	     # если все ОК
		ok=1 # делаем 1 для выхода из цикла проверки
	else # ошибка при вводе 
	echo -e "\n${RED}ОШИБКА: группа введена неверно! Попробуйте еще раз!${NORMAL}\n"
	echo -e "\n${YELLOW}ПОДСКАЗКА: группа должна иметь следующий формат: A-[0][0-9]-[0-9][0-9]${NORMAL}\n"
	fi
done	

# выбор из двух предметов
echo -e  "${GREEN}Введите 1 для выбора предмета \"Криптозоология\" и 2 для \"Пивоварение\":${NORMAL}"

ok=0 # обнуление ошибки
ch=0 # обнуление выбора

# проверка выбора предмета
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0
        
	read -p "-> " ch # читаем (вводим) ключ выбора варианта

        if [[ $ch == 1 ]]; then # если выбрали первый вариант
             # все ОТЛИЧНО
                sub_name="Криптозоология"
		ok=1
	elif [[ $ch == 2 ]]; then # если выбрали второй вариант
		sub_name="Пивоварение"
                ok=1
        else # такие дела
                echo -e "\n${RED}ОШИБКА: ключ введен неверно!  Выберите 1 или 2!${NORMAL}\n"
        fi

done

# поиск файла с посещаемостью 
file_path=$(find $dir_path/$sub_name -name "$group_num-attendance") # результат записываем в переменную

#------------------------------------------------------------------------------
# проверка содержимого базы данных на предмет правильности ввода
        
	db_ok=0

	if [[ ! -z $file_path ]]; then
	# считаем количество строк совпадающих с шаблоном
	# и сравниваем их с итоговым количеством строк
	str_count_all=$(wc -l $file_path | awk '{print $1}') # wc так же выводила адрес файла, с помощью awk это было убрано
        first_str_count=$(cut -d' ' -f1 $file_path | grep -cE "^[A-Za-z]+$" )
        second_str_count=$(cut -d' ' -f2 $file_path | grep -cE "^[01]+$" )

#        echo "STR_COUNT: $str_count_all" # контроль
#        echo "FIRST_STR_COUNT: $first_str_count" # контроль
#        echo "SECOND_STR_COUNT: $second_str_count" # контроль

        if [[ $str_count_all == $first_str_count ]] && [[ $str_count_all == $second_str_count  ]]; then
        	db_ok=1
	else
                echo -e "\n${RED}ОШИБКА: файл группы $group_num поврежден!${NORMAL}\n"
        fi
fi
#------------------------------------------------------------------------------


# проверка, найден ли файл с посещаемостью
if [[ ! -z $file_path ]] && [[ -s $file_path ]] && [[ $db_ok == 1 ]]; then
	
	echo -e "${GREEN}Введите 1 для выбора сортировки по возрастанию и 2 по убыванию:${NORMAL}"

	ok=0 # обнуление ошибки
	ch=0 # обнуление выбора

	# ввод и проверка варианта сортировки
	while [[ $ok -eq 0 ]]; do # пока флаг проверки 0
        	
		read -p "-> " ch # читаем (вводим) ключ выбора варианта

        	if [[ $ch == 1 || $ch == 2 ]]; then # сравниваем с 1 или 2
        	     # все ОТЛИЧНО
                	ok=1
        	else # такие дела
                	echo -e "\n${RED}ОШИБКА: ключ введен неверно!  Выберите 1 или 2!${NORMAL}\n"
        	fi

	done

	# вывод сообщения на экран 
	echo ""
        echo "------------------------------------------------------------------------"
	echo "                     Список группы $group_num                           "
        echo "------------------------------------------------------------------------"
	echo "Пользователь БАРС |       Посещения        |  Общее количество посещений"
        echo "------------------------------------------------------------------------"
# пояснение: копируем поле $2 в поле $3 -> убираем все нули из посещаемости с помощью
# встроенной в awk функции gsub -> вычисляем количество единиц через длину строки
# c помощью встроенной в awk функции lenght () -> записываем результат в третье поле->
# -> выводим на экран 

	if [[ $ch == 1 ]]; then # снова сравниваем это что-то с ЧИСЛОМ
	     # сортировка по возрастанию
        	awk '{$3=$2; gsub(/0/, "", $3); len=length($3); gsub(/1*/, len, $3); print $1 "   " $2  "   " $3}' $file_path | sort -n -k3 | column -t -o "    |  "
# поэтапное преобразование исходного списка и сортировка

	else # сортировка по убыванию
        	awk '{$3=$2; gsub(/0/, "", $3); len=length($3); gsub(/1*/, len, $3); print $1 "   " $2  "   " $3}' $file_path | sort -nr -k3 | column -t -o "   |   " 
# сортировка с ключом -r ~ reverse

	fi

# если файл с данными пуст
elif [[ ! -z $file_path ]] && [[ ! -s $file_path ]]; then
        echo -e "\n${RED}ОШИБКА: файл с посещаемостью группы $group_num пуст!${NORMAL}\n"

# если файл не существует
elif [[ -z $file_path ]]; then	
	echo -e "\n${RED}ОШИБКА: файл с посещаемостью группы $group_num не найден!${NORMAL}\n"

fi

echo ""
}

#--------------------------------------------------------------------
# функция,  выводящая студента с лучшей посещаемостью в конкретной 
# группе, а так же количество посещенных им занятий 
#--------------------------------------------------------------------
show_best_student()
{
# обнуление переменных
ok=0 # обнуление переменной проверки ввода

# ввод группы
echo -e "${GREEN}В какой группе учится интересующий Вас студент (на латинице):${NORMAL}"

# ввод и проверка в цикле введенной группы
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0
	
	read -p "-> " group_num # читаем номер группы 

	if [[ "$group_num" =~ A-[0][0-9]-[0-9][0-9]$ ]]; then  # с шаблоном
	     # если все ОК
		ok=1 # делаем 1 для выхода из цикла проверки
	else # ошибка при ввоже
		echo -e "\n${RED}ОШИБКА: группа введена неверно! Попробуйте еще раз!${NORMAL}"
		echo -e "\n${YELLOW}ПОДСКАЗКА: группа должна иметь следующий формат: A-[0][0-9]-[0-9][0-9]${NORMAL}\n"
	fi
done	

# выбор предмета
echo -e "${GREEN}Введите 1 для выбора предмета \"Криптозоология\" и 2 для \"Пивоварение\":${NORMAL}"

# обнуление переменных
ok=0 # обнуление переменной проверки ввода
ch=0 # обнуление переменной выбора 

# проверка выбора предмета
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0
        
	read -p "-> " ch # снова вводим

        if [[ $ch == 1 ]]; then # если выбрали первый варик 
                # все ОТЛИЧНО
                sub_name="Криптозоология"
		ok=1
	elif [[ $ch == 2 ]]; then
		sub_name="Пивоварение"
                ok=1
        else # такие дела
                echo -e "\n${RED}ОШИБКА: ключ введен неверно! Выберите 1 или 2!${NORMAL}\n"
        fi

done

# поиск файла с посещаемостью 
file_path=$(find $dir_path/$sub_name -name "$group_num-attendance") # результат записываем в переменную

# проверка, найден ли файл с посещаемостью, и если найден, то пуст ли он
if [[ ! -z $file_path ]] && [[ -s $file_path ]]; then
# вывод студента с лучшей посещаемостью
	echo ""
	echo "Лучший студент по посещаемости в группе $group_num: "
	echo ""

# пояснение: убираем все нули из посещаемости с помощью функции gsub, встроенной в awk 
# -> считаем количество единиц через функцию lenght, которая встроена в awk -> заменяем 
# все 0 на посещаемость -> выводим на экран

	awk '{gsub(/0/, "", $2); len=length($2); gsub(/1*/, len, $2); print "Никнейм в БАРС: " $1 " Количество посещенных занятий: " $2  }' $file_path | sort -n -k2 | tail -n 1 # со дна берем студента

# если файл с данными пуст
elif [[ ! -z $file_path ]] && [[ ! -s $file_path ]]; then
	echo -e "\n${RED}ОШИБКА: файл с посещаемостью группы $group_num пуст!${NORMAL}\n"

# иначе 
else  
	echo -e "\n${RED}ОШИБКА: файл с посещаемостью группы $group_num не найден!${NORMAL}\n"
fi

echo ""

}

#--------------------------------------------------------------------
# функция, выводящая досье студента(ов) по фамилии на латинице
#--------------------------------------------------------------------
show_student_note()
{
# обнуление переменных
ok=0 # обнуление перменной для проверки ввода

echo -e "${GREEN}Введите фамилию студента (на латинице):${NORMAL}"

# ввод и проверка имени студента 
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0

	read -p "-> " s_sname # вводим фамилию жертвы
        
	# только с ЗАГЛАВНОЙ и никаких цифр, да
	if [[ "$s_sname" =~ ^[A-Z]{1}[a-z]{1,}$ ]]; then # сравниваем с шаблоном фамилию
	     # если все ОК
		ok=1 # делаем 1 для выхода из цикла проверки
	else # ошибка при вводе 
		echo -e "\n${RED}ОШИБКА: фамилия введена неверно! В фамилии не должно быть чисел, и фамилия должна начинаться с заглавной буквы!${NORMAL}"
		echo -e "${RED}Попробуйте еще раз!${NORMAL}\n"
	fi
done	

# заменяем все кроме первой заглавной на Names.log
# так как все лог файлы начинаются с буквы фамилии
file_name=$(echo $s_sname | sed "s/[a-z]*$/Names.log/g")

# ищем лог файл по строке, полученной выше
file_path=$(find $dir_path/ -name $file_name)

if [[ ! -z $file_path ]] && [[ -s $file_path ]]; then

# тут совпадение и номер строки
# затем убираем совпадение, чтобы остался только номер
# так же, если несколько найденных вариков, то преобразовываем их из столбца
# в строку для дальнейшей записи в массив
str_num=$(grep -n "$s_sname" $file_path | sed -z -e "s/:[A-Za-z]*//g" -e "s/[\n\r]/ /g") 

# обработка символов в найденной строке
#echo "$str_num" 
#echo "$(echo $str_num | wc -c)"

# формирование массива из номеров найденных строк
str_arr=($str_num)

# вывод сообщения, если найдено несколько людей с такой фамилией
if [[ "$str_num" =~ [[:space:]][0-9] ]]; then	# пробел перед числом => несколько чисел в строке
        # обработка ошибки
	echo ""
	echo -e "\n${YELLOW}ВНИМАНИЕ: найдено несколько фамилий! Будут выведены все найденные студенты!${NORMAL}\n"
fi

# проверка содержимого массива 
# echo "Массив номеров строк:"
# echo "${str_arr[@]}"	

# вывод сообщения, если массив ПУСТ, то есть в файлах НИЧЕГО не найдено
if [[ -z ${str_arr[@]} ]]; then
	echo ""
	echo -e "\n${YELLOW}ВНИМАНИЕ: такой студент не найден!${NORMAL}\n"
fi

# выводим досье 
for i in ${str_arr[@]}; do
echo ""
echo "Досье студента $(sed -n "${i}p" $file_path): " # берем строчку из файла с ником в БАРСе найденного студента...

# выводим на экран досье студента из лог файла
# со строки с позицией на ОДНУ НИЖЕ  и по разделитель ======
# echo $(($i-1)) # проверка индекса строки
sed -n "$(($i+1)) ,/\=/p" $file_path | sed "s/=*//g"
done

# если файл с данными пуст
elif [[ ! -z $file_path ]] && [[ ! -s $file_path ]]; then
        echo -e "\n${RED}ОШИБКА: файл с досье студентов с фамилией $s_sname пуст!${NORMAL}\n"

else
	echo -e "\n${RED}ОШИБКА: файл с досье студентов с фамилией $s_sname не найден!${NORMAL}\n"
fi
echo ""
}

#--------------------------------------------------------------------
# выводит лучших студентов по среднему баллу правильных ответов
# по тесту
#--------------------------------------------------------------------

show_best_students_average()
{

# обнуление переменных
ok=0 # обнуление переменной проверки ввода
ch=0 # обнуление переменной выбора

# выбор из двух предметов 
echo -e "${GREEN}Введите 1 для выбора предмета \"Криптозоология\" и 2 для \"Пивоварение\":${NORMAL}"

# выбираем предмет с проверкой ввода
while [[ $ok -eq 0 ]]; do # пока флаг проверки 0

	read -p "-> " ch # читаем (вводим) выбор варианта 

        if [[ $ch == 1 ]]; then # если выбрали первый вариант
                sub_name="Криптозоология"
		ok=1
	elif [[ $ch == 2 ]]; then # если выбрали второй вариант
		sub_name="Пивоварение"
                ok=1
        else # ошибка при вводе
                echo -e "\n${RED}ОШИБКА: ключ введен неверно! Выберите 1 или 2!${NORMAL}\n"
        fi

done

ok=0 # обнуляем переменную проверки ошибки

# выбираем тест с проверкой ввода
echo -e "${GREEN}Введите номер теста (от 1 до 4):${NORMAL}"

while [[ $ok -eq 0 ]]; do # пока флаг проверки 0

	read -p "-> " test_num # вводим

	# обязательно проверяем, что ввели именно ЦЕЛОЕ ЧИСЛО, и что оно попадает в диапазон
        if ! [[ $test_num =~ ^[^0-9]+$ || $test_num -gt 4 || $test_num -le 0 ]]; then # проверка диапазона
                # все ОК
		ok=1 # выходим из цикла
        else # ошибка при вводе
                echo -e "\n${RED}ОШИБКА: неверный формат ввода! Введите целое число в диапазоне от 1 до 4!${NORMAL}\n"
        fi

done

# поиск файла с тестом
file_path=$(find $dir_path/$sub_name -name "TEST-$test_num") # результат записываем в переменную

# контроль найденного файла
# echo "$file_path"

if [[ ! -z $file_path ]] && [[ -s $file_path  ]]; then

# считаем количество студентов в файле с тестом
stud_count=$(awk -F ";" '{count[$2]++} END {for (n in count) print n}' $file_path | wc -l) # число уникальных значений во втором столбце (фамилии) = количество студентов

ok=0 # обнуляем переменную проверки ошибки

# ввод количества отображаемых студентов
echo -e "${GREEN}Введите количество отображаемых студентов (до $stud_count):${NORMAL}"

while [[ $ok -eq 0 ]]; do # пока флаг проверки 0

	read -p "-> " line_count # вводим

	# обязательно проверяем, что ввели именно ЦЕЛОЕ ЧИСЛО, и что оно попадает в диапазон
        if ! [[ $line_count =~ ^[^0-9]+$ || $line_count -gt $stud_count || $line_count -le 0 ]]; then # проверка диапазона
             # все ОТЛИЧНО
                ok=1 # выходим из цикла
        else # ошибка при вводе
                echo -e "\n${RED}ОШИБКА: неверный формат ввода! Введите целое число в диапазоне от 1 до $stud_count!${NORMAL}\n"
        fi

done

# вывод топ студентов по среднему баллу
echo "--------------------------------------------------------------------------"
echo "           Топ студентов по среднему баллу (по попыткам)                  "
echo "--------------------------------------------------------------------------"
echo "Место |        Студент         |     Группа    |  Средний балл по попыткам"
echo "--------------------------------------------------------------------------"

# объяснение: по сути создается три массива group, sum и count перед обработкой файла
# в массив group записывается группа из поля $1 по уникальному значению во втором поле с фамилией
# в массив sum записывается сумма для каждого уникального значения из поля $2 с фамилией
# в массив count - считаем количество таких записей, чтобы потом на него поделить (среднее)
# затем в цикле просто выводим это все, потом сортируем, потом берем первые $line_count записей, такие дела
awk -F ";" '{group[$2]=$1; sum[$2]+=$4; count[$2]++; } END {for (i in sum) print "   ", i,";", group[i],";", sum[i]/count[i];}' $file_path | sort -t ";" -r -n -k3 | awk -F ";" '{print NR "    "$1"   "$2"        "$3}' | head -n $line_count | column -t -o "    |    "
# если файл с данными пуст
elif [[ ! -z $file_path ]] && [[ ! -s $file_path ]]; then
        echo -e "\n${RED}ОШИБКА: файл TEST-$test_num с тестами пуст!${NORMAL}\n"

else
	echo -e "\n${RED}ОШИБКА: файл TEST-$test_num с тестами не найден!${NORMAL}\n"
fi

echo ""
}

#--------------------------------------------------------------------
# выводит список доступных файлов посещаемости групп
#--------------------------------------------------------------------

show_group_list()
{
	echo -e "\n----------------------------------------------------"
	echo "        Доступные файлы посещаемости групп         "
	echo "---------------------------------------------------"
	echo "    Предмет      |        Группа        "
	echo "---------------------------------------------------"
	find $dir_path -name "*-attendance" | sed -e "s/^.*labfiles\///g" -e "s/\// /g" -e "s/-attendance$//g"| sort -k1,2 | column -t -o "   |   "
	echo ""
}

#--------------------------------------------------------------------
# обработка позиционных параметров (заглушка) 
#--------------------------------------------------------------------

if ! [[ -z "$@" ]]; then
        echo -e "\n${YELLOW}ВНИМАНИЕ: использование позиционных параметров не предусмотрено!${NORMAL}"
        echo -e "${YELLOW}ВНИМАНИЕ: скрипт $0 будет запущен в интерактивном режиме!${NORMAL}"
fi

#--------------------------------------------------------------------
# задание и проверка пути к каталогу labfiles
#--------------------------------------------------------------------

echo -e "\n${GREEN}Введите путь к каталогу labfiles или введите ключ D, чтобы использовать путь к каталогу по умолчанию:${NORMAL}"

while [[ $ok -eq 0 ]]; do

	read -p "-> " dir_path # читаем (вводим) путь к файлу или ключ 
	
	if [[ -d $dir_path && $dir_path =~ .+labfiles$ ]]; then
		ok=1
	elif [[ "$dir_path" == "D" || "$dir_path" == "d" ]]; then 
		echo -e "\n${YELLOW}ВНИМАНИЕ: будет использован путь по умолчанию (в текущей папке)!${NORMAL}"
		dir_path="./labfiles"
		ok=1
	else
	        echo -e "\n${RED}ОШИБКА: неправильно введен путь или такой каталог не существует!${NORMAL}"
                echo -e "${RED}Попробуйте ещё раз!${NORMAL}\n"
	fi
done

echo -e "${GREEN}\nПуть к каталогу labfiles: $dir_path${NORMAL} \n" # контроль адреса каталога

#--------------------------------------------------------------------
# меню скрипта через цикл while
#--------------------------------------------------------------------

while ! [[ $ch -eq 6 ]]; do # пока не ключ выхода 
	
	echo -e "${GREEN}Нажмите:"
	echo -e "${GREEN}1 - чтобы вывести упорядоченный список группы${NORMAL}"
	echo -e "${GREEN}2 - чтобы вывести студента с наилучшей посещаемостью${NORMAL}"
	echo -e "${GREEN}3 - чтобы по фамилиям вывести досье студентов${NORMAL}"
	echo -e "${GREEN}4 - чтобы вывести студентов, давших наибольшее количество правильных ответов за попытку${NORMAL}"
	echo -e "${GREEN}5 - чтобы вывести доступные файлы групп с посещаемостью${NORMAL}"
	echo -e "${GREEN}6 - чтобы выйти из скрипта${NORMAL}"
	echo " "

	read -p "-> " ch # читаем с консоли ключ 

	if [[ ch -eq 1 ]]; then # первое задание 
		show_student_list

	elif [[ ch -eq 2 ]]; then # второе задание 
		show_best_student
	        
	elif [[ ch -eq 3 ]]; then # третье задание 
       		show_student_note

	elif [[ ch -eq 4 ]]; then # четвертое задание 
		show_best_students_average

        elif [[ ch -eq 5 ]]; then # показать доступные файлы 
                show_group_list
                echo ""

       	elif [[ ch -eq 6 ]]; then # ключ выхода из цикла 
                echo -e "\n${YELLOW}Выходим...${NORMAL}"
		echo ""
	
	else # введен неправильный ключ 
		echo -e "\n${RED}ОШИБКА: ключ введен неверно! Попробуйте снова...${NORMAL}\n"
		echo""
	fi

done
