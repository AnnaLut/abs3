PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CCK ***
declare
  l_mod  varchar2(3) := 'CCK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Кредитный модуль', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Неверно заданы параметры процедуры cck_dop.get_acc_isp. Один из параметров должен быть не пустым.', '', 1, 'INCORRECT_CCKDOP_GETACCISP_PAR');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Невірно задані параметри процедури cck_dop.get_acc_isp. Один з параметрів повинен бути непустим.', '', 1, 'INCORRECT_CCKDOP_GETACCISP_PAR');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Для инициатора код %s (%s) не заполнен справочник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП" или указанный исполнитель находится за проходной или не проадминистрирован как ответ. исполнитель.', '', 1, 'ACCISP_BY_USER_NOTFOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Для ініціатора код %s (%s) не завнено довідник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП" або вказаний виконавець знаходиться поза прохідною або не проадміністрований як відп. виконавець', '', 1, 'ACCISP_BY_USER_NOTFOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Для отделения %s не заполнен справочник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП" или указанный исполнитель находится за проходной или не проадминистрирован как ответ. исполнитель.', '', 1, 'ACCISP_BY_BRANCH_NOTFOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Для відділення %s не завнено довідник "Вiдповiдальнi виконавцi по бранчам для автом. проводок у КП" або вказаний виконавець знаходиться поза прохідною або не проадміністрований як відп. виконавець.', '', 1, 'ACCISP_BY_BRANCH_NOTFOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Полная авторизация недоступна, т.к. для даного продукта нет возможности автоматически определить счет типа %s.', '', 1, 'AUTH_ERROR_CANNT_OPEN_ACC');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Повна авторiзацiя недоступна, тому що для данного продукту немає можливостi автоматично визначити рахунок типу %s.', '', 1, 'AUTH_ERROR_CANNT_OPEN_ACC');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'КД реф=%s не найден %s', '', 1, 'ND_NOTFOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'КД реф=%s не знайдено %s', '', 1, 'ND_NOTFOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'КД реф=%s На сч.гашения %s', '', 1, 'FREE_SG');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'КД реф=%s На рах.погашення %s', '', 1, 'FREE_SG');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'КД реф=%s есть просроч.задолжен.=%s', '', 1, 'YES_SP');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'КД реф=%s є просроч.заборгован.=%s', '', 1, 'YES_SP');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'КД реф=%s сч. %s не найдены/дубли %s', '', 1, 'ACC_NOTFOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'КД реф=%s рах.%s не знайдено/дублi %s', '', 1, 'ACC_NOTFOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'КД реф=%s ош.сумма доср.погаш=%s', '', 1, 'SUM_POG');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'КД реф=%s пом.сума достр.погаш=%s', '', 1, 'SUM_POG');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'КД реф=%s Последняя дата', '', 1, 'LAST_DATE');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'КД реф=%s Остання дата', '', 1, 'LAST_DATE');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'КД реф=%s Пред.сумма 1-го пл', '', 1, 'PREV_PL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'КД реф=%s Поперед.сумм 1-го пл', '', 1, 'PREV_PL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'КД реф=%s Отсутствуют изменения ГПК за %s', '', 1, 'NO_MODI_GPK');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'КД реф=%s Вiдсутнi змiни ГПК за %s', '', 1, 'NO_MODI_GPK');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'КД реф=%s План Не=Факт, счет %s', '', 1, 'PLAN#FAKT');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'КД реф=%s План Не=Факт, рах. %s', '', 1, 'PLAN#FAKT');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'КД реф=%s Изменения ГПК за %s уже выполнены', '', 1, 'YES_MODI_GPK');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'КД реф=%s Змiни ГПК за %s уже виконанi', '', 1, 'YES_MODI_GPK');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не заполнен параметр %s "%s"', '', 1, 'NOT_FILLED_PARAM ');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Не заповнено параметер %s "%s"', '', 1, 'NOT_FILLED_PARAM ');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'При установленом значении "Наявности партнера" - "Так", не заполнен доп.реквизит "Наименование партнера"', '', 1, 'NOT_PARAM_PARTNER_ID');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'При встановленому значенні "Наявності партнера" - "Так", не заповнено дод.реквізит "Найменування партнера"', '', 1, 'NOT_PARAM_PARTNER_ID');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
