PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ACM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ACM ***
declare
  l_mod  varchar2(3) := 'ACM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Накопление данных', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Неверно задан режим накопления (%s)', '', 1, 'INVALID_SNAPMODE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Неверно задан режим накопления (%s)', '', 1, 'INVALID_SNAPMODE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Не указана банковская дата накопления', '', 1, 'UNDEFINED_SNAP_BANKDATE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Не указана банковская дата накопления', '', 1, 'UNDEFINED_SNAP_BANKDATE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Указанная дата не является банковской (%s)', '', 1, 'BANKDATE_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Указанная дата не является банковской (%s)', '', 1, 'BANKDATE_NOT_FOUND');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Неверно задан тип синхронизации', '', 1, 'INVALID_SYNCMODE');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Неверно задан тип синхронизации', '', 1, 'INVALID_SYNCMODE');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Неизвестный объект %s (тип: %s)', '', 1, 'INVALID_OBJECT_NAME');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Неизвестный объект %s (тип: %s)', '', 1, 'INVALID_OBJECT_NAME');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Не определена начальная дата в календаре', '', 1, 'CALENDAR_FIRSTDATE_NOTDEFINED');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Не определена начальная дата в календаре', '', 1, 'CALENDAR_FIRSTDATE_NOTDEFINED');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'Не указана одна из дат (календарная, банковская, отчетная)', '', 1, 'CALENDAR_DATES_NOTDEFINED');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'Не указана одна из дат (календарная, банковская, отчетная)', '', 1, 'CALENDAR_DATES_NOTDEFINED');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, 'Счет #%s не найден', '', 1, 'ACCOUNT_BYID_NOTFOUND');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'Рахунок #%s не знайдено', '', 1, 'ACCOUNT_BYID_NOTFOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Банковская дата не найдена по идентификатору #%s', '', 1, 'BANKDATE_BYID_NOTFOUND');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Банківську дату не знайдено по ідентифікатору #%s', '', 1, 'BANKDATE_BYID_NOTFOUND');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Не удалось заблокировать счет %s за %s секунд. Попытайтесь позже.', '', 1, 'WAIT_TIMEOUT_EXPIRED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Не вдалося заблокувати рахунок %s за %s секунд. Спробуйте пізніше.', '', 1, 'WAIT_TIMEOUT_EXPIRED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ACM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
