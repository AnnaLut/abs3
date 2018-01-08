PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_OTC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль OTC ***
declare
  l_mod  varchar2(3) := 'OTC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Отчетность НБУ', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Query not found: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Запрос не найден: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Запит не знайдено: %s: %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Error during getting parameter %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка при получении параметра %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка отримання параметру %s: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Table %s not found', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не найдена таблица %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не знайдено таблицю %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Incorrect query SELECT for report', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Некорректно составлен запрос SELECT для отчета', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Некоректно задано запит SELECT для звiту', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Subsequent query is not allowed', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Повторное формирование отчета запрещено', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Повторне формування звіту заборонене', '', 1, '5');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_OTC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
