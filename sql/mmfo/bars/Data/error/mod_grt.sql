PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_GRT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль GRT ***
declare
  l_mod  varchar2(3) := 'GRT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Договора залога', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Договор залога не найден (%s)', '', 1, 'DEAL_NOTFOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Договір застави не знайдено (%s)', '', 1, 'DEAL_NOTFOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка при блокировке договора залога (%s)', '', 1, 'DEAL_LOCKERR');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка при блокуванні договора застави (%s)', '', 1, 'DEAL_LOCKERR');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Договор залога не связан с кредитным договором (%s)', '', 1, 'DEAL_NOTLINKED');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Договір застави не пов''язано з жодним кредитным договором (%s)', '', 1, 'DEAL_NOTLINKED');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Неподдерживаемый период событий (%s)', '', 1, 'UNSUPPORTED_FREQ');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Непідтримуємий період подій (%s)', '', 1, 'UNSUPPORTED_FREQ');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Неподдерживаемый тип события (%s)', '', 1, 'UNSUPPORTED_TYPE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Непідтримуємий тип події (%s)', '', 1, 'UNSUPPORTED_TYPE');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Для договора залога №%s не верно указан тип обеспечения', '', 1, 'DEAL_GRTTYPE_NOTFOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Для договоора застави №%s не вірно вказано тип забезпечення', '', 1, 'DEAL_GRTTYPE_NOTFOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Договор залога №%s не связан с кредитным договором', '', 1, 'DEAL_NOT_LINKED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Договір забезпечення №%s не пов`язано з кредитним договором', '', 1, 'DEAL_NOT_LINKED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Договор №%s не авторизирован', '', 1, 'DEAL_NOTAUTH');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Договір №%s не авторизовано', '', 1, 'DEAL_NOTAUTH');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_GRT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
