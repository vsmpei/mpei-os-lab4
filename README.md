# Комплекс скриптов для обработки файловой системы преподавателя
Данный проект содержит 4 bash-скрипта, предназначенных для выполнения конкретных задач по обработке файловой системы преподователя предметов Криптозоология и Пивоварение, 1 главный скрипт, содержащий функции этих 4-х скриптов, а также дополнительный скрипт-лаунчер, непосредственно запускающий эти скрипты.  
|Название скрипта|Описание|
|-|-|
|bash_script_1.sh|Вывод списка студентов интересующей группы, упорядоченного по посещаемости|
|bash_script_2.sh|Вывод студента выбранной группы с лучшей посещаемостью|
|bash_script_3.sh|Вывод досье студента по его фамилии|
|bash_script_4.sh|Вывод студентов со средним количеством правильных ответов, начиная с наибольшего|
|lab4.sh|Главный скрипт, который содержит функции остальных скриптов (рекомендовано)|
|lab4_launcher.sh|Скрипт-лаунчер|

Ниже для каждого скрипта приведено подробное описание, пример его работы и список обработанных исключений, что необходимо для предотвращения ошибочного ввода со стороны пользователя.
## bash_script_1.sh
Скрипт, который выводит список студентов интересующей группы, упорядоченный по посещаемости. После запуска скрипта пользователю предлагается ввести название группы, выбрать предмет (криптозоология или пивоварение), а также выбрать способ сортировки (по возрастанию или по убыванию). Вывод списка группы реализован в виде таблицы с полями, содержащими имя пользователя в БАРС, двоичную строку посещаемости и общее количество посещений, добавленного для наглядности.
### Пример работы скрипта
Вывод списка группы А-09-20, упорядоченного по возрастанию посещаемости предмета Криптозоология:
```
Введите интересующую Вас группу (на латинице):
-> A-09-20
Введите 1 для выбора предмета "Криптозоология" и 2 для "Пивоварение":
-> 1
Введите 1 для выбора сортировки по возрастанию и 2 по убыванию:
-> 1

------------------------------------------------------------------------
                     Список группы A-09-20
------------------------------------------------------------------------
Пользователь БАРС |       Посещения        |  Общее количество посещений
------------------------------------------------------------------------
AslanovAF         |  101011100110011010    |  10
TikhonovAVad      |  101010110010001111    |  10
KlimkinDY         |  111101100110100011    |  11
MikhailovPA       |  110011001111110100    |  11
SukhanovVS        |  110110001111001011    |  11
KharitonovAnA     |  011111110110101100    |  12
KukinVA           |  101110011101110011    |  12
MukhamejanovAI    |  111110100101101111    |  13
FurtayevIV        |  111111110010111011    |  14
GrebeniukKS       |  001111101111101111    |  14
LabanovaMS        |  011011110011111111    |  14
MaximovRA         |  010110111011111111    |  14
TutayevAA         |  101111110101101111    |  14
DazhukAS          |  111111111111001011    |  15
BijoyA            |  111111011111111111    |  17
GumerovaEF        |  111111111111111111    |  18
```
### Обработанные исключения
- Неправильный ввод названия группы (должно соответствовать шаблону  `A-[0][0-9]-[0-9][0-9]`)
- Неправильный ввод ключа предмета (должен быть 1 или 2)
- Неправильный ввод ключа сортировки (должен быть 1 или 2)
- Ошибка нахождения файла с посещаемостью
## bash_script_2.sh
Скрипт, который выводит студента выбранной группы с лучшей посещаемостью. После запуска скрипта пользователю предлагается ввести название группы и выбрать предмет (криптозоология или пивоварение). Вывод содержит имя пользователя в БАРС и количество посещенных им занятий.
### Пример работы скрипта
Вывод студента группы А-09-20 с лучшей посещаемостью предмета Криптозоология:
```
В какой группе учится интересующий Вас студент (на латинице):
-> A-09-20
Введите 1 для выбора предмета "Криптозоология" и 2 для "Пивоварение":
-> 1

Лучший студент по посещаемости в группе A-09-20:

Никнейм в БАРС: TutayevAA Количество посещенных занятий: 14
```
### Обработанные исключения
- Неправильный ввод названия группы (должно соответствовать шаблону  `A-[0][0-9]-[0-9][0-9]`)
- Неправильный ввод ключа предмета (должен быть 1 или 2)
- Ошибка нахождения файла с посещаемостью
## bash_script_3.sh
Скрипт, который вывод досье студента по его фамилии. После запуска скрипта пользователя предлагается ввести фамилию студента на латинице. Если существует несколько студентов с введенной фамилией, выведутся все подходящие досье.
### Пример работы скрипта
Вывод досье студента с фамилией Kharitonov. Фамилия Kharitonov выбрана, потому что существует 2 студента с этой фамилией.
```
Введите фамилию студента (на латинице):
-> Kharitonov

Внимание: найдено несколько фамилий! Будет выведены все найденные студенты!

Досье студента KharitonovKY:
Подлизывается, это можно использовать! Вялый...

Досье студента KharitonovAnA:
Гипоактивный.. но вроде жив. Не поздравил с днем учителя. Спит на лекциях, носится на переменах. Записывает голосовые в чат. В среду опоздание на 4 минуты; Сидит в одноклассниках, поставил мне двойку.
```
### Обработанные исключения
- Неправильный ввод фамилии (проверка на отсутствие в ней чисел и первую заглавную букву)
- Ошибка нахождения студента с введенной фамилией
- Существует несколько студентов с введенной фамилией (выводятся все досье)
## bash_script_4.sh
Скрипт, который выводит студентов со средним количеством правильных ответов, начиная с наибольшего. После запуска скрипта пользователя предлагается выбрать предмет (криптозоология или пивоварения), ввести номер теста (от 1 до 4), а также ввести количество студентов, которые будут выведены (до 345). Вывод студентов реализован в виде таблицы с полями, содержащими место в рейтинге, имя пользователя в БАРС, название группы и среднее количество правильных ответов.
### Пример работы скрипта
Вывод первых 20 студентов с наибольшим количеством средних попыток в 3-м тесте по предмету Пивоварение:
```
Введите 1 для выбора предмета "Криптозоология" и 2 для "Пивоварение":
-> 2
Введите номер теста:
-> 3
Введите количество отображаемых студентов (до 345):
-> 20

--------------------------------------------------------------------------
           Топ студентов по среднему баллу (по попыткам)
--------------------------------------------------------------------------
Место |        Студент         |     Группа    |  Средний балл по попыткам
--------------------------------------------------------------------------
1     |    ZhidkikhYS          |    A-06-20    |    25
2     |    VitayevJY           |    A-06-10    |    25
3     |    UsovEJ              |    A-06-05    |    25
4     |    SkorkinaAI          |    A-06-14    |    25
5     |    ShebyrevaVD         |    A-06-18    |    25
6     |    LimonovAR           |    A-06-07    |    25
7     |    KrivkovVJ           |    A-06-05    |    25
8     |    KrasotkinUI         |    A-06-07    |    25
9     |    KardanevAA          |    A-06-17    |    25
10    |    KachusovUJ          |    A-06-10    |    25
11    |    GlukhovUU           |    A-06-12    |    25
12    |    ChincharovPC        |    A-06-16    |    25
13    |    BondarevUV          |    A-06-13    |    25
14    |    BolotnikovTZ        |    A-06-13    |    25
15    |    BalkarovAA          |    A-06-19    |    25
16    |    AfoninASer          |    A-09-19    |    25
17    |    AbramovBJ           |    A-06-07    |    25
18    |    TretyakovAlO        |    A-06-20    |    24
19    |    SeliukovKY          |    A-09-19    |    24
20    |    SanjiyevMJ          |    A-06-20    |    24
```
### Обработанные исключения
- Неправильный ввод ключа предмета (должен быть 1 или 2)
- Неправильный ввод номера теста (должен быть от 1 до 4)
- Неправильный ввод желаемого количества студентов (должно быть от 1 до 345)
## lab4.sh
Главный скрипт, который содержит функции вышеописанных 4-х скриптов. После запуска пользователю предлагается ввести путь к каталогу labfiles или оставить путь по умолчанию (если каталог labfiles находится в одной директории со скриптом). Далее появляется меню, в котором необходимо выбрать, какой скрипт требуется запустить. Кроме опций запуска 4-х вышеописанных скриптов, имеется опция вывода доступных файлов посещаемости групп. После выбора любой опции и завершении работы каждого скрипта, терминал возвращается в главное меню. Для выхода из меню и скрипта lab4_main.sh нужно выбрать соответствующую опцию.
### Пример работы скрипта
Поскольку выше приводились примеры работы скриптов 1-4, в этом примере показаны выбор пути к каталогу labfiles, вывод доступных файлов посещаемости групп и выход из скрипта:
```
Введите путь к каталогу labfiles или введите ключ D, чтобы использовать путь к каталогу по умолчанию:
-> d

ВНИМАНИЕ: будет использован путь по умолчанию (в текущей папке)!

Путь к каталогу labfiles: ./labfiles

Нажмите:
1 - чтобы вывести упорядоченный список группы
2 - чтобы вывести студента с наилучшей посещаемостью
3 - чтобы по фамилиям вывести досье студентов
4 - чтобы вывести студентов, давших наибольшее количество правильных ответов за попытку
5 - чтобы вывести доступные файлы групп с посещаемостью
6 - чтобы выйти из скрипта

-> 5

---------------------------------------------------
        Доступные файлы посещаемости групп
---------------------------------------------------
    Предмет      |        Группа
---------------------------------------------------
Криптозоология   |   A-06-04
Криптозоология   |   A-06-05
Криптозоология   |   A-06-06
Криптозоология   |   A-06-07
Криптозоология   |   A-06-08
Криптозоология   |   A-06-09
Криптозоология   |   A-06-10
Криптозоология   |   A-06-11
Криптозоология   |   A-06-12
Криптозоология   |   A-06-13
Криптозоология   |   A-06-14
Криптозоология   |   A-06-15
Криптозоология   |   A-06-16
Криптозоология   |   A-06-17
Криптозоология   |   A-06-18
Криптозоология   |   A-06-19
Криптозоология   |   A-06-20
Криптозоология   |   A-09-17
Криптозоология   |   A-09-18
Криптозоология   |   A-09-19
Криптозоология   |   A-09-20
Пивоварение      |   A-06-04
Пивоварение      |   A-06-05
Пивоварение      |   A-06-06
Пивоварение      |   A-06-07
Пивоварение      |   A-06-08
Пивоварение      |   A-06-09
Пивоварение      |   A-06-10
Пивоварение      |   A-06-11
Пивоварение      |   A-06-12
Пивоварение      |   A-06-13
Пивоварение      |   A-06-14
Пивоварение      |   A-06-15
Пивоварение      |   A-06-16
Пивоварение      |   A-06-17
Пивоварение      |   A-06-18
Пивоварение      |   A-06-19
Пивоварение      |   A-06-20
Пивоварение      |   A-09-17
Пивоварение      |   A-09-18
Пивоварение      |   A-09-19
Пивоварение      |   A-09-20

Нажмите:
1 - чтобы вывести упорядоченный список группы
2 - чтобы вывести студента с наилучшей посещаемостью
3 - чтобы по фамилиям вывести досье студентов
4 - чтобы вывести студентов, давших наибольшее количество правильных ответов за попытку
5 - чтобы вывести доступные файлы групп с посещаемостью
6 - чтобы выйти из скрипта

-> 6

Выходим...
```
### Обработанные исключения
- Неправильный ввод пути к каталогу
- Неправильный ввод ключа опции (должен быть от 1 до 6)
