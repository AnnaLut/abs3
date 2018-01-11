PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль BCK ***
declare
  l_mod  varchar2(3) := 'BCK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Взаимодействие с кредитным бюро', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Параметр %s не найден', '', 1, 'PARAM_NOTFOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Параметр %s не знайдено', '', 1, 'PARAM_NOTFOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'В справочнике кредитных бюро не найдена запись с идентификатором %s', '', 1, 'BCK_NOTFOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'У довіднику кредитних бюро не знайдено запис з ідентифікатором %s', '', 1, 'BCK_NOTFOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Ошибка сохранения отчета: %s', '', 1, 'ERROR_STORE_REPORT');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Помилка збереження звіту: %s', '', 1, 'ERROR_STORE_REPORT');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Не найден отчет с идентификатором %s', '', 1, 'REPORT_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Звіт з ідентифікатором %s не знайдено', '', 1, 'REPORT_NOT_FOUND');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Неизвестный номер XML-блока %s', '', 1, 'XMLBLOCK_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Невідомий номер XML-блоку %s', '', 1, 'XMLBLOCK_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Неизвестный тэг XML %s в блоке %s отчета %s', '', 1, 'XMLTAG_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Невідомий тег XML %s в блоці %s звіту %s', '', 1, 'XMLTAG_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Ошибка сохранения результата разбора XML, отчет=%s, блок=%s, тэг=%s ( %s )', '', 1, 'RESULT_STORE_ERROR');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Помилка збереження результату розбору XML, звіт=%s, блок=%s, тег=%s ( %s )', '', 1, 'RESULT_STORE_ERROR');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Данный отчет уже обработан: %s', '', 1, 'REPORT_ALREADY_PARSED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Даний звіт вже оброблений: %s', '', 1, 'REPORT_ALREADY_PARSED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
