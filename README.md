# mpei-os-lab4

Лабораторная работа №4


Кратко про то, что тут есть:

labfiles - исходные файлы преподавателя с биографией, оценками и посещаемостью студентов.

bash_script_*.sh - предварительные скрипты, запускаются в той же директории, где находится и папка labfiles. bash_script_1.sh, bash_script_2.sh - задания 1, 2 и т.д...

lab4.sh - будущий итоговый скрипт, со временем будет залит после компиляции описанных выше скриптов.

EXTRA*.sh - скрипты с кодом уровня Б, невошедшее, "отборное". Здесь этого быть не должно, но оно тутЪ есть, смиритесь.


Теперь о самих скриптах:

bash_script_1.sh - выводит список студентов интересующей группы, упорядоченный по посещаемости

bash_script_2.sh - выводит студента выбранной группы с лучшей посещаемостью

bash_script_3.sh - выводит досье студента(ов) по фамилии на латинице

bash_script_4.sh - выводит n-ое количество (по выбору) студентов с их средним значением по правильным ответам, начиная с самых успешных

lab4_raw.sh - "сырая" версия итогового скрипта. Есть проверки на ввод, существование каталога labfiles и файлов в нем. Добавлена возможность указать путь к каталогу labfiles или использовать путь по умолчанию. Так же добавлено: подсветка вывода, обработка позиционных параметров (сообщение), возможность вывода списка групп с доступными файлами посещаемости по соответствующим предметам, подсказки при ошибочном вводе группы, приглашение ко вводу при наборе текста пользователем.

lab4.sh - в процессе... 

P.S. Рано или поздно мы сдадим эту лабу, господа, еще почти две недели, спешить некуда, правда?

⠄⠄⠄⠄⣠⣴⣿⣿⣿⣷⣦⡠⣴⣶⣶⣶⣦⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
⠄⠄⠄⣴⣿⣿⣫⣭⣭⣭⣭⣥⢹⣟⣛⣛⣛⣃⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
⠄⣠⢸⣿⣿⣿⣿⢯⡓⢻⠿⠿⠷⡜⣯⠭⢽⠿⠯⠽⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄
⣼⣿⣾⣿⣿⣿⣥⣝⠂⠐⠈⢸⠿⢆⠱⠯⠄⠈⠸⣛⡒⠄⠄⠄⠄⠄⠄⠄⠄⠄
⣿⣿⣿⣿⣿⣿⣿⣶⣶⣭⡭⢟⣲⣶⡿⠿⠿⠿⠿⠋⠄⠄⣴⠶⠶⠶⠶⠶⢶⡀
⣿⣿⣿⣿⣿⢟⣛⠿⢿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣷⡄⠄⢰⠇⠄⠄⠄⠄⠄⠈⣧
⣿⣿⣿⣿⣷⡹⣭⣛⠳⠶⠬⠭⢭⣝⣛⣛⣛⣫⣭⡥⠄⠸⡄⣶⣶⣾⣿⣿⢇⡟
⠿⣿⣿⣿⣿⣿⣦⣭⣛⣛⡛⠳⠶⠶⠶⣶⣶⣶⠶⠄⠄⠄⠙⠮⣽⣛⣫⡵⠊⠁
⣍⡲⠮⣍⣙⣛⣛⡻⠿⠿⠿⠿⠿⠿⠿⠖⠂⠄⠄⠄⠄⠄⠄⠄⠄⣸⠄⠄⠄⠄
⣿⣿⣿⣶⣦⣬⣭⣭⣭⣝⣭⣭⣭⣴⣷⣦⡀⠄⠄⠄⠄⠄⠄⠠⠤⠿⠦⠤⠄⠄
