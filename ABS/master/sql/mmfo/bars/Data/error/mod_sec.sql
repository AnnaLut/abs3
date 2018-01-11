PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SEC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SEC ***
declare
  l_mod  varchar2(3) := 'SEC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Безопасность', 1);

    bars_error.add_message(l_mod, 701, l_exc, l_rus, 'Неизвестный тип сообщения аудита (%s)', '', 1, '701');
    bars_error.add_message(l_mod, 701, l_exc, l_ukr, 'Невідомий тип повідомлення аудиту (%s)', '', 1, '701');

    bars_error.add_message(l_mod, 702, l_exc, l_rus, 'Неверный формат имени секции таблицы аудита', '', 1, '702');
    bars_error.add_message(l_mod, 702, l_exc, l_ukr, 'Помилка у форматі імені секції таблиці аудиту', '', 1, '702');

    bars_error.add_message(l_mod, 703, l_exc, l_rus, 'Превышено максимальное количество созданных секций за один вызов', '', 1, '703');
    bars_error.add_message(l_mod, 703, l_exc, l_ukr, 'Перевищена максимальна кількість створених секцій за один виклик', '', 1, '703');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SEC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
