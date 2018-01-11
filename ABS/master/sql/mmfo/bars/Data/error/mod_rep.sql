PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_REP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль REP ***
declare
  l_mod  varchar2(3) := 'REP';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Отчетность, кат.запросы', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Запрос не найден: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Запит не знайдено: %s: %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка при получении параметра %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка отримання параметру %s: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не найдена таблица %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не знайдено таблицю %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Некорректно составлен запрос SELECT для отчета', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Некоректно задано запит SELECT для звiту', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Некорректно задан тип поля %s - %s, должено быть одним из (DATE, VARCHAR2, CHAR, NUMBER) ', 'Пересмотрите выражение на создание структуры DBF', 1, 'NOTCORRECT_DATATYPE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Некоректно задано тип поля %s - %s, повинно бути одним з (DATE, VARCHAR2, CHAR, NUMBER)', 'Перегляньте вираз на створення структури DBF    ', 1, 'NOTCORRECT_DATATYPE');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Ключ нового кат.запроса должен включать информацию или о модуле или о банке', '1', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Ключ нового кат.запиту повинен включати _нформац_ю або про модуль або про банк', '1', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Неизвестный или неподдерживаемый тип DBF поля %s', '1', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Нев_домий тип DBF поля %s або цей тип не п_дтримується ', '1', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Невозможно перевести значение %s в число в строке %s колонке %s для вставки в таблицу %s', '1', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Неможливо перевести значення %s в число в рядку %s колонцi %s для вставки в таблицю %s', '1', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Невозможно перевести значение %s к формату даты в строке %s, колонке %s для вставки в таблицу %s', '1', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Неможливо перевести значення %s до формату дати в рядку %s, колонцi %s  для вставки в таблицю %s', '1', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Логическое поле %s, не F и не T в строке %s колонке %s  для вставки в таблицу %s', '1', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Лог_чне поле %s, не F _ не T в рядку %s колонцi %s  для вставки в таблицю %s', '1', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Указанное число полей в SQL выборке не совпадает с кол-вом полей в описании структуры', '1', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Вказане число пол_в в SQL запит_ не сп_впадає з к_л-тю пол_в в опис_ структури', '1', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Указанная кодировка %s - некорректна. Должна быть одной из (WIN,DOS,UKG)', '1', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Вказане кодування %s - некоректне. Повино бути одним з (WIN,DOS,UKG)', '1', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Некорректно вычисленно значение следующего печатного отчета %s', '1', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Некоректно обраховано наступне значення друк.звіту %s ', '1', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Номер печтного отчета %s -  уже существует', '1', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Номер друк. звіту %s -  всже існує', '1', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Невозможно получить тип печатного отчета по номеру кат. запроса № %s', '1', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'На номер кат. запроса %s не ссылается ни один печатный отчет', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'На номер кат.запиту %s не силається ні один друкований звіт', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Некорректно задана маска файла: %s', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Некоректно задано маску файла: %s', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Некорректно указан формат даты: %s', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Некоректно задано формат дати: %s', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Кол-во полей в SQL-е (%s) не совпадает с кол-вом полей описанных в структуре DBF (%s)', '', 1, 'WRONG_COLCNT');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Кільк-ть полів в SQL (%s) не співпадає з кільк-тю полів, щл лписана в структурі DBF (%s)', '', 1, 'WRONG_COLCNT');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Тип колонки %s(%s) в описании DBF структуры не совпадает с типом колонки в SQL-е(%s)', '', 1, 'WRONG_COLTYPES');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Тип колонки %s(%s) в описі DBF структури не співпадає с типом колонки в SQL-і(%s)', '', 1, 'WRONG_COLTYPES');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'При чтении данных поле LOGICAL не равно ни одному из символов (0,1,F,T). Содержит значение-%s', '1', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'При читанні данних поле LOGICAL не рівне ні одному із символів(0,1,F,T). Мыстить значення-%s', '1', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не инициализирована переменнвя файла', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не ініційовано змінну для файлу', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Неккоректное имя таблицы %s для ORACLE', '1', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Неккоректне им`я таблиці %s для ORACLE', '1', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Невозможно открыть файл %s в оракл директории %s ', '1', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Неможливо відкрити файл %s в оракл директорії %s', '1', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Указан несущ. параметр %s для дейсвия, если таблица существует (возможные варианты - 0,1,2,3)', '1', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Вказано неіснуючий параметр %s для дії якщо таблиця існує (можливі варіанти - 0,1,2,3)', '1', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Указанный номер блока %s для memo поля не существует для таблицы %s', '1', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Вказанний номер блоку %s для memo поля не існує  для таблицi %s', '1', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Размер файла memo %s не кратен 512. Структура - некорректна', '1', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Розмір файлу memo %s не кратен 512. Структура - некорректна', '1', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'В файле DBF находится более одного поля МЕМО - не поддерживается', '1', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'В файлі DBF знаходиться більше одного поля МЕМО - не підтримується', '1', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не определен тип поиска контрагента', '', 1, '29');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Не определен тип поиска контрагента', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не выполнена процедура переценки для %s за %s', '', 1, '30');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Не виконано процедуру переоцiнки для %s за %s', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'На выбранный период отчета не просчитана переоценка для счета %s', '1', 1, '31');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'На вибраний період звіту не обраховано переоцінку  для рахунку %s', '1', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Задайте код конкретного исполнителя', '', 1, '32');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Задайте код конкретного виконавця', '', 1, '32');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Нет   такого  исполнителя', '', 1, '33');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Немає такого  виконавця', '', 1, '33');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Допустимые коды операции - PO1, PO3 ', '', 1, '34');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Допустимі  коди операції - PO1, PO3 ', '', 1, '34');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Маска счета %s не должна начинаться с символов % и _ ', '1', 1, '35');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Маска рахунку %s не повинна починатися з символів % та _', '1', 1, '35');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Установите маску счета(минимум 3 символа балансового)', '1', 1, '36');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Введіть маску рахунку(мінімум 3 символи з балансового)', '1', 1, '36');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Маска счета %s долна содержать минимум %s символа слева', '', 1, '37');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Маска рахунку  %s повинна містити мінімум %s символи зліва', '', 1, '37');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Период может быть не больше 30 дней', '', 1, '38');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Період може  бути не більше 30 днів', '', 1, '38');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Для проверки двух масок счета неоюходимо указать AND или OR в вызове ф-ции validate_two_nlsmasks', '', 1, '39');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Для валідації двох масок рахунку необхідно вказати AND або OR у визові ф-ції validate_two_nlsmasks', '', 1, '39');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Ошибка при вводе маски первого счета: ', '', 1, '40');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Помилка при вводі маски першого рахунку:', '', 1, '40');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Ошибка при вводе маски второго счета: %s', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Помилка при вводі маски другого рахунку: %s', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Хотя бы для одного счета в параметрах маска должна содержать минимум %s символа слева', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Хоча б для одного рахунку в параметрах маска повинна містити мінімум %s симіолів зліва', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Для указаного отчетного периода дата начала %s больше конечной даты %s', '', 1, '43');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Для вказаного звітного періоду дата початку %s більша за кінцеву дату %s', '', 1, '43');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Для данного отчета, период заданых дат не должен превышать %s дней, указанный вами период охватывает %s дней', '', 1, '44');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Для даного звіту, період заданих дат не повинен перевищувати %s днів, вказаний вами період охоплює %s днів', '', 1, '44');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Не указан код подразделения', '', 1, 'BRANCH_IS_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Не вказано код підрозділу', '', 1, 'BRANCH_IS_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Для перекредитованного документа %s не найден первичный документ с реф = %s', '', 1, 'NO_ORIGIN_DOC');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Для перекредитованого документe %s не знайджено первинний документ з реф = %s', '', 1, 'NO_ORIGIN_DOC');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'В описании структуры DBF нету закрывающей скобки для указания размерности поля', '', 1, 'NO_CLOSE_BRACKET');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'В описі структури DBF немає закриваючої скобки для опису розміру поля', '', 1, 'NO_CLOSE_BRACKET');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'В описании dbf файла существует более одно поля мемо', '', 1, 'NOT_CORRECT_DBFSTRUCT');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'В описании dbf файла существует более одно поля мемо', '', 1, 'NOT_CORRECT_DBFSTRUCT');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Неизвестная версия DBF файла %s не существует(первый байт в заголовке файла)', '', 1, 'NOT_CORRECT_DBFTYPE');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Невідома версія DBF файлу %s не існує(перший байт в заголовку файла)', '', 1, 'NOT_CORRECT_DBFTYPE');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Указанная версия DBF файла %s (первый байт в заголовке) не поддерживает МЕМО тип, хотя в описании структуры присутствует поле типа МЕМО для таблицы %s', '', 1, 'NOT_CORRECT_DBFMEMO');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Вказана версія DBF файлу %s (перший байт в заголовку файла) не підтрирмує МЕМО тип, хоч в описі структури файлу присутнє поле типу МЕМО для таблиці %s', '', 1, 'NOT_CORRECT_DBFMEMO');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Невозможно перевести значение %s в число(ссылка на мемо поле) в строке %s колонке %s для вставки в таблицу %s', '', 1, 'NOT_CORRECT_MEMOREF');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Неможливо перевести значення %s в число(посилання на мемо поле)  в рядку %s колонцi %s для вставки в таблицю %s', '', 1, 'NOT_CORRECT_MEMOREF');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Импорт поддерживает не более 4-х полей МЕМО, в импортируемой структуре %s в файле', '', 1, 'TO_MANY_MEMOS');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Імпорт підтримує не більше 4-х полів МЕМО, в імпортованій структуре %s в файлі %s', '', 1, 'TO_MANY_MEMOS');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Переменная результата запроса - путсая', '', 1, 'RESULT_ISEMPTY');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Змінна результату запиту - порожня', '', 1, 'RESULT_ISEMPTY');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Не существует такого номера динамического запроса для выписок %s', '', 1, 'NO_SUCH_SQLID');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Не існує такого номера динамічного запиту для виписок %s', '', 1, 'NO_SUCH_SQLID');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Не существует пользователя с учетной записью %s', '', 1, 'NO_SUCH_USERNAME');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Не існує користувача  %s', '', 1, 'NO_SUCH_USERNAME');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Некорректно указана кодировка %s - должна быть одной из WIN, UKG', '', 1, 'UNKNOWN_ENCODE');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Некорректно вказано кодування %s - повинно бути одним із WIN, UKG', '', 1, 'UNKNOWN_ENCODE');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Для перекодування було вказано список символів %s, але некоректно вказано список символів заміни %s (значення пусте, або к-ть символыв не дорівнює кількості в першому списку', '', 1, 'NOTCORRECT_LIST');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Для перекодування було вказано список символів %s, але некоректно вказано список символів заміни %s (значення пусте, або к-ть символыв не дорівнює кількості в першому списку', '', 1, 'NOTCORRECT_LIST');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Некорректное значение для включения или віключения в віписку %s. Должно быть одно из N или Y', '', 1, 'NOT_CORRECT_USEVP');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Некорректе значення для включення аба виключення із виписки %s. Повинне бути одним з N або Y', '', 1, 'NOT_CORRECT_USEVP');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Значения кода установы %s не существует в справочнике', '', 1, 'NOT_SUCH_KODU');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Значення кода установы %s не існує в довіднику', '', 1, 'NOT_SUCH_KODU');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '%s, ошибка: s%', '', 1, 'CANNOT_EXEC_SQL');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '%s, помилка: s%', '', 1, 'CANNOT_EXEC_SQL');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Невозможно произвести вставку: %s', '', 1, 'CANNOT_INSERT_DATA');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Неможливо виконати вставку: %s', '', 1, 'CANNOT_INSERT_DATA');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Длинна одного из полей больше, чем описано структурой для : %s', '', 1, 'LARGE_VALUE');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Довжина одного iз полiв быльша нiж описано в структурi для : s%', '', 1, 'LARGE_VALUE');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '%s', '', 1, 'GENERIC_ERROR');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '%s', '', 1, 'GENERIC_ERROR');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Несоответсвие структур: кол-во полей в таблице не совпадает с кол-вом полей описанных в структуре DBF файла', '', 1, 'CH_WRONG_COLCNT');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Невідповідність структур: кільк-ть полів в таблиці не співпадає з кільк-тю полів, що описана в структурі DBF файлу', '', 1, 'CH_WRONG_COLCNT');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Несоответсвие структур: тип колонки в описании DBF файла не совпадает с типом колонки в таблице', '', 1, 'CH_WRONG_COLTYPES');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Невідповідність структур: тип колонки в описі DBF файлу не співпадає с типом колонки в таблиці', '', 1, 'CH_WRONG_COLTYPES');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_REP.sql =========*** Run *** ==
PROMPT ===================================================================================== 
