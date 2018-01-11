PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_TIC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль TIC ***
declare
  l_mod  varchar2(3) := 'TIC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Тикеты', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Not succeeded read information for Ref N%s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не удалось прочитать данные для Реф №%s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не вдалося прочитати дані для Реф №%s', '', 1, '1');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_TIC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
