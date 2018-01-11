PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SYN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SYN ***
declare
  l_mod  varchar2(3) := 'SYN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Синхронизация справочников', 1);

    bars_error.add_message(l_mod, 18001, l_exc, l_rus, 'Подписчик %s не найден', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_ukr, 'Отримувача %s не знайдено', '', 1, '18001');

    bars_error.add_message(l_mod, 18002, l_exc, l_rus, 'Таблица %s не найдена в списке таблиц для синхронизации', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_ukr, 'Таблиця %s не знайдена у списку таблиць для синхронізації', '', 1, '18002');

    bars_error.add_message(l_mod, 18003, l_exc, l_rus, 'Ошибка компиляции объекта %s', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_ukr, 'Помилка компіляції об`єкта %s', '', 1, '18003');

    bars_error.add_message(l_mod, 18004, l_exc, l_rus, 'Таблица %s уже существует в списке таблиц для синхронизации', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_ukr, 'Таблиця %s вже існує у списку таблиць для синхронізації', '', 1, '18004');

    bars_error.add_message(l_mod, 18005, l_exc, l_rus, 'Ошибка вставки данных во временную таблицу %s ', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_ukr, 'Помилка при додаванні даних в тимчасову таблицю %s ', '', 1, '18005');

    bars_error.add_message(l_mod, 18006, l_exc, l_rus, 'Таблица %s содержит не поддерживаемые типы полей (CLOB, BLOB, BFILE)', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_ukr, 'Таблиця %s містить колонки, типи яких не підтримуються (CLOB, BLOB, BFILE)', '', 1, '18006');

    bars_error.add_message(l_mod, 18007, l_exc, l_rus, 'Для старта(останова) процесса используй значения "STOP" или "START"', '', 1, '18007');
    bars_error.add_message(l_mod, 18007, l_exc, l_ukr, 'Для старту(останову) процесу використовуй значення "STOP" або "START"', '', 1, '18007');

    bars_error.add_message(l_mod, 18008, l_exc, l_rus, 'Таблица %s не внесена в список синхронизируемых', '', 1, '18008');
    bars_error.add_message(l_mod, 18008, l_exc, l_ukr, 'Таблицю %s не внесено в список синхронізуючих', '', 1, '18008');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SYN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
