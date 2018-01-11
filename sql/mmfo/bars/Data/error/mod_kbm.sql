PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_KBM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль KBM ***
declare
  l_mod  varchar2(3) := 'KBM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Банківські метали', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '2.Дата+Время курсов = %s есть  М Е Н Ш Е Й  за поточную Дату+Время %s', '', 1, 'SYSDATE_AGAIN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '2.Дата+Час курсiв = %s є  М Е Н Ш О Ю  за поточну Дату+Час %s', '', 1, 'SYSDATE_AGAIN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '1.Дата+Время повторных курсов = %s есть  М Е Н Ш Е Й за Дату старых курсов =  %s', '', 1, 'LAST_DAY');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '1.Дата+Час повторних  курсiв = %s є  М Е Н Ш О Ю  за Дату старих курсiв =  %s', '', 1, 'LAST_DAY');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Курсы ценностей изменены! Введите операцию еще раз.', '', 1, 'FALSE_COURSE');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Курси цінностей змінено! Введіть операцію ще раз.', '', 1, 'FALSE_COURSE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_KBM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
