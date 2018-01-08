PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_INS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль INS ***
declare
  l_mod  varchar2(3) := 'INS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Договора страхования', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Неверная дата платежа', '', 1, 'INVALID_PAYMENT_DATE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Невірна дата платежу', '', 1, 'INVALID_PAYMENT_DATE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Недопустимый статус СД (%s)', '', 1, 'INVALID_DEAL_STATE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Недопустимий статус СД (%s)', '', 1, 'INVALID_DEAL_STATE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Нельзя закрыть СД не указав номер нового СД', '', 1, 'RENEW_NEEDED');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Неможна закрити СД не вказавши номер нового СД', '', 1, 'RENEW_NEEDED');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Неверный тип атрибута', '', 1, 'ATTR_WRONG_TYPE');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Невірний тип атрибуту', '', 1, 'ATTR_WRONG_TYPE');

    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Неможливо видалити СК, знайдено залежні угоди.', '', 1, 'CNNT_DEL_PARTNER');

    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Неможливо видалити тип СК, знайдено залежні угоди.', '', 1, 'CNNT_DEL_PARTNER_TYPE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_INS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
