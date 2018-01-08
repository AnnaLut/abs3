PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ASN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ASN ***
declare
  l_mod  varchar2(3) := 'ASN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Модуль исинхронных запусков', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Ошибка в модуле ASYNC: %s', '', 1, 'ASYNC_ERR');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Ошибка в модуле ASYNC: %s', '', 1, 'ASYNC_ERR');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Действие ACTION_CODE = "%s" не найдено', '', 1, 'ACTION_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Действие ACTION_CODE = "%s" не найдено', '', 1, 'ACTION_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Запуск %s уже выполнен', '', 1, 'EXCLUSION_ERROR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Запуск %s вже виконаний', '', 1, 'EXCLUSION_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ASN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
