PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CSH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CSH ***
declare
  l_mod  varchar2(3) := 'CSH';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Касса - операционный день', 1);

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Последняя открытая операционная дата %s больше текущей даты на сервере %s. Проверте корректность серверной даты.', '', 1, 'NO_VALID_OPERDAY');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Останн_й в_дкритий операц_йний день %s б_льше за поточну дату на сервер_ %s. Перев_рте коррекн_сть серверної дати', '', 1, 'NO_VALID_OPERDAY');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Внимание! Проходит открытие операционной смены, повторите оплату позже', '', 1, 'OPENING_OPERDAY');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Увага! Проходить вiдкриття операційної зміни, повторіть сплату пізніше', '', 1, 'OPENING_OPERDAY');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'За указанную дату %s и номер смены %s - не существует информации о работе кассы', '', 1, 'NO_OPER_DAY');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'За вказану дату %s и номер зміни %s - не існує інформації про роботу каси', '', 1, 'NO_OPER_DAY');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, 'Бранч %s не работает с кассой, установите нужный код (бранч) отделения для нового счета', '', 1, 'NO_CASH');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, 'Бранч %s не працює з касою, вкажіть потрібний код(бранч) відділення для нового рахунку', '', 1, 'NO_CASH');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Указан некорректный код кассового отчета %s', '', 1, 'NOT_CASH_REPORT');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Вказано некоректний код касового звiту %s', '', 1, 'NOT_CASH_REPORT');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CSH.sql =========*** Run *** ==
PROMPT ===================================================================================== 
