PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_IMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль IMP ***
declare
  l_mod  varchar2(3) := 'IMP';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Импорт', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'В справочнике допустимых таблиц для импорта таблица %s не обнаружена', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'В довіднику допустимих таблиць для імпорту таблиця %s не знайдена', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Недопустимый параметр MODE (%s)', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Недопустимий параметр MODE (%s)', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не указана директория', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не вказано директорію', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Не указана таблица для импорта', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Не вказано таблицю для імпорта', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Файл $(FN) ($(FDAT) уже импортировался!)', '', 1, 'FILE_ALREADY_IMPORT');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Файл $(FN) ($(FDAT) вже імпортувався!', '', 1, 'FILE_ALREADY_IMPORT');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '$(MSG)', '', 1, 'CLIENT_IN_BLOCKLIST');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '$(MSG)', '', 1, 'CLIENT_IN_BLOCKLIST');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Пользователь с таб.№ $(TABN) не найден в АБС!', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Користувача з таб.№ $(TABN) не знайдено в АБС!', '', 1, 'USER_NOT_FOUND');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Отделение $(BRANCH) не найдено!', '', 1, 'BRANCH_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Підрозділ $(BRANCH) не знайдено!', '', 1, 'BRANCH_NOT_FOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'В файле не указано подразделение!', '', 1, 'BRANCH_NOT_SET');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'В файлї не вказано підрозділ!', '', 1, 'BRANCH_NOT_SET');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Пользователь с таб.№ $(TABN) не принадлежит отделению $(BRANCH)', '', 1, 'USER_NOT_FOUND_IN_BRANCH');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Користувач з таб.№ $(TABN) не належить підрозділу $(BRANCH)', '', 1, 'USER_NOT_FOUND_IN_BRANCH');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Длина идентификационного кода не равняется 10-ти ($(OKPO))', '', 1, 'WRONG_OKPO_LENGTH');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Довжина ідентифікаційного коду не дорівнює 10-ти ($(OKPO))', '', 1, 'WRONG_OKPO_LENGTH');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Кассовые операции не могут быть информационными(dk должно 1 или 0) для док № %s, рахА %s, рахБ %s', '', 1, 'CASH_NOINFODK');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Касові операції не можуть бутиь інформаційними(dk повинно бути  1 або 0) для док № %s, рахА %s, рахБ %s', '', 1, 'CASH_NOINFODK');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Информационный кредит межбанкк пока что не поддерживается для док № %s, рахА %s, рахБ %s', '', 1, 'NO_DK3');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Інформаційний кредит міжбанк поки що не підтримується для док № %s, рахА %s, рахБ %s', '', 1, 'NO_DK3');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Документ уже был оплачен реф. БАРС: %s', '', 1, 'YET_PAYED');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Документ вже було сплачено реф. БАРС: %s', '', 1, 'YET_PAYED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_IMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 
