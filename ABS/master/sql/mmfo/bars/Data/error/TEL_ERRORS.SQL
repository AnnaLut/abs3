PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_TEL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль TEL ***
declare
  l_mod  varchar2(3) := 'TEL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Теллери', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '%s', '', 1, 'TELL_DOC1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '%s', '', 1, 'TELL_DOC1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '%s', '', 1, 'TELL_DOC2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '%s', '', 1, 'TELL_DOC2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Операція відсутня в довіднику "Операції Теллера та допустимі ліміти"', '', 1, 'TELL_DOC3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Операція відсутня в довіднику "Операції Теллера та допустимі ліміти"', '', 1, 'TELL_DOC3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '%s', '', 1, 'TELL_MSG1');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '%s', '', 1, 'TELL_MSG1');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '%s', '', 1, 'TEL_AMNCHECK');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '%s', '', 1, 'TEL_AMNCHECK');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Для обладнання вказаного типу необхідно вказати IP-адресу', '', 1, 'TELL_DICT1');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Для обладнання вказаного типу необхідно вказати IP-адресу', '', 1, 'TELL_DICT1');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '%s', '', 1, 'TELL_DICT2');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '%s', '', 1, 'TELL_DICT2');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Операція відсутня в довіднику "Операції Теллера та допустимі ліміти"', '', 1, 'TELL_DICT3');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Операція відсутня в довіднику "Операції Теллера та допустимі ліміти"', '', 1, 'TELL_DICT3');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_TEL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
