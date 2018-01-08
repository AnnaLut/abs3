PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_FX.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль FX ***
declare
  l_mod  varchar2(3) := 'FX';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Сделки Форекс', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Ошибка оплаты FXK', '', 1, 'ERR_PAY_FXK');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Помилка сплати FXK', '', 1, 'ERR_PAY_FXK');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Проверьте счета в настройке операции FXK', '', 1, 'TT_FXK_NOT_DEFINITION');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Перевiрте рахунки в операцiї FXK', '', 1, 'TT_FXK_NOT_DEFINITION');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_FX.sql =========*** Run *** ===
PROMPT ===================================================================================== 
