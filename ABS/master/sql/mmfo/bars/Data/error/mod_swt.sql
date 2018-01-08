PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SWT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SWT ***
declare
  l_mod  varchar2(3) := 'SWT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Интерфейс с SWIFT', 1);

    bars_error.add_message(l_mod, 40, l_exc, l_geo, 'Transaction sum not equal to documents sum (transaction sum %s, documents sum %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');
    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Сумма транзакции не равна сумме документов (сумма транзакции %s, сумма документов %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Сумма транзакции не равна сумме документов (сумма транзакции %s, сумма документов %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');

    bars_error.add_message(l_mod, 41, l_exc, l_geo, 'Transaction and document currency code not equal (transaction currency %s, document currency %s, document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');
    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Код валюты транзакции и документа не совпадают (валюта транзакции %s, валюта документа %s, реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Код валюты транзакции и документа не совпадают (валюта транзакции %s, валюта документа %s, реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');

    bars_error.add_message(l_mod, 42, l_exc, l_geo, 'Transaction and document payment date not equal (transaction date %s, document date %s, document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');
    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Дата валютирования транзакции и документа не совпадают (дата транзакции %s, дата документа %s, реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Дата валютирования транзакции и документа не совпадают (дата транзакции %s, дата документа %s, реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');

    bars_error.add_message(l_mod, 43, l_exc, l_geo, 'Document not connected with Nostro (document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');
    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Документ не связан с корсчетом выписки (реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Документ не связан с корсчетом выписки (реф. документа %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');

    bars_error.add_message(l_mod, 50, l_exc, l_geo, 'Error on statement reconciliation ref. %s: %s', '', 1, 'STMT_PARSE_ERROR');
    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Ошибка при разборе выписки реф. %s: %s', '', 1, 'STMT_PARSE_ERROR');

    bars_error.add_message(l_mod, 51, l_exc, l_geo, 'Incorrect statement error registration mode [%s]', '', 1, 'INVALID_PARSEERROR_MODE');
    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Неверный режим регистрации ошибки выписки [%s]', '', 1, 'INVALID_PARSEERROR_MODE');

    bars_error.add_message(l_mod, 52, l_exc, l_geo, 'Line %s statement SWIFT ref. %s already linked with document(s)', '', 1, 'STMT_ROWDOC_ALREADY_LINKED');
    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Строка %s выписки SWIFT реф. %s уже связана с документом(ами)', '', 1, 'STMT_ROWDOC_ALREADY_LINKED');

    bars_error.add_message(l_mod, 53, l_exc, l_geo, 'Line %s statement SWIFT ref. %s not linked with document(s)', '', 1, 'STMT_ROWDOC_NOTLINKED');
    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Строка %s выписки SWIFT реф. %s не связана с документом(ами)', '', 1, 'STMT_ROWDOC_NOTLINKED');

    bars_error.add_message(l_mod, 60, l_exc, l_geo, 'Statement line not found (ref. %s line  %s)', '', 1, 'STMT_ROW_NOTFOUND');
    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Не найдена строка выписки (реф. %s строка  %s)', '', 1, 'STMT_ROW_NOTFOUND');

    bars_error.add_message(l_mod, 61, l_exc, l_geo, 'Statement locked other user, repeat attempt later (ref. %s line %s)', '', 1, 'STMT_ROW_LOCKED');
    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Выписка заблокирована другим пользователем, повторите попытку позже (реф. %s строка  %s)', '', 1, 'STMT_ROW_LOCKED');

    bars_error.add_message(l_mod, 62, l_exc, l_geo, 'Document ref. %s not found', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');
    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Документ реф. %s не найден', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Документ реф. %s не найден', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');

    bars_error.add_message(l_mod, 63, l_exc, l_geo, 'Statement line not linked with out message (statement %s line %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');
    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Строка выписки не связана с исх. сообщением (выписка %s строка %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Строка выписки не связана с исх. сообщением (выписка %s строка %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');

    bars_error.add_message(l_mod, 64, l_exc, l_geo, 'Statement line already linked with out message (statement %s line %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');
    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Строка выписки уже связана с исх. сообщением (выписка %s строка %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Строка выписки уже связана с исх. сообщением (выписка %s строка %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');

    bars_error.add_message(l_mod, 65, l_exc, l_geo, 'List linked document of out message and statement line not equal (statement %s line %s out.message %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');
    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Список привязанных документов исх. сообщения и строки выписки не совпадают (выписка %s строка %s исх. сооб. %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Список привязанных документов исх. сообщения и строки выписки не совпадают (выписка %s строка %s исх. сооб. %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');

    bars_error.add_message(l_mod, 66, l_exc, l_geo, 'Basic message and statement line attributes not equal (statement %s line %s out.message %s)', '', 1, 'STMT_SRCMSG_REQDIFF');
    bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Основные реквизиты сообщения и строки выписки не совпадают (выписка %s строка %s исх. сооб. %s)', '', 1, 'STMT_SRCMSG_REQDIFF');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Основные реквизиты сообщения и строки выписки не совпадают (выписка %s строка %s исх. сооб. %s)', '', 1, 'STMT_SRCMSG_REQDIFF');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Неверный формат доп. реквизита "f"', '', 1, 'GENMSG_INVALID_MTFORMAT');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, 'Неверный формат доп. реквизита "f"', '', 1, 'GENMSG_INVALID_MTFORMAT');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Неизвестный формат сообщения %s', '', 1, 'GENMSG_UNKNOWN_MT');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, 'Неизвестный формат сообщения %s', '', 1, 'GENMSG_UNKNOWN_MT');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Не найден доп. реквизит документа "f"', '', 1, 'GENMSG_REQMT_NOTFOUND');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, 'Не найден доп. реквизит документа "f"', '', 1, 'GENMSG_REQMT_NOTFOUND');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Нет обязательного поля %s', '', 1, 'DOCMSG_MANDATORYFIELD_NOTFOUND');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, 'Немае обовязкового поля %s', '', 1, 'DOCMSG_MANDATORYFIELD_NOTFOUND');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Найдено более одной опции поля %s одновременно', '', 1, 'DOCMSG_TOOMANYOPTIONS_FOUND');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Найдено более одной опции поля %s одновременно', '', 1, 'DOCMSG_TOOMANYOPTIONS_FOUND');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Неподдерживаемое тег для спецобработки (%s)', '', 1, 'DOCMSG_UNKNOWN_SPECTAG');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Неподдерживаемое тег для спецобработки (%s)', '', 1, 'DOCMSG_UNKNOWN_SPECTAG');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Не найдено описание поля (тип сообщения: %s поле :%s)', '', 1, 'DOCMSG_MSGMODEL_TAGNOTFOUND');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Не найдено описание поля (тип сообщения: %s поле :%s)', '', 1, 'DOCMSG_MSGMODEL_TAGNOTFOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'C02: Код валюты в полях 71G и 32A должен совпадать', '', 1, 'DOCMSG_MSGCHK_C02');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'C02: Код валюты в полях 71G и 32A должен совпадать', '', 1, 'DOCMSG_MSGCHK_C02');

    bars_error.add_message(l_mod, 281, l_exc, l_rus, 'C81: Поле 57a должно быть заполнено, если заполнено поле 56a', '', 1, 'DOCMSG_MSGCHK_C81');
    bars_error.add_message(l_mod, 281, l_exc, l_ukr, 'C81: Поле 57a должно быть заполнено, если заполнено поле 56a', '', 1, 'DOCMSG_MSGCHK_C81');

    bars_error.add_message(l_mod, 350, l_exc, l_rus, 'D50: Использование поля 71G запрещено при значении SHA поля 71A', '', 1, 'DOCMSG_MSGCHK_D50');
    bars_error.add_message(l_mod, 350, l_exc, l_ukr, 'D50: Использование поля 71G запрещено при значении SHA поля 71A', '', 1, 'DOCMSG_MSGCHK_D50');

    bars_error.add_message(l_mod, 351, l_exc, l_rus, 'D51: Не заполнено поле 33B при заполненном поле 71F или 71G', '', 1, 'DOCMSG_MSGCHK_D51');
    bars_error.add_message(l_mod, 351, l_exc, l_ukr, 'D51: Не заполнено поле 33B при заполненном поле 71F или 71G', '', 1, 'DOCMSG_MSGCHK_D51');

    bars_error.add_message(l_mod, 367, l_exc, l_rus, 'D67: Найдено недопустимое сочетание кодов в поле 23E (%s, %s)', '', 1, 'DOCMSG_MSGCHK_D67');
    bars_error.add_message(l_mod, 367, l_exc, l_ukr, 'D67: Найдено недопустимое сочетание кодов в поле 23E (%s, %s)', '', 1, 'DOCMSG_MSGCHK_D67');

    bars_error.add_message(l_mod, 375, l_exc, l_rus, 'D75: Не заполнено поле 36 при различном коде валюты в полях 33B и 32A или заполнено поле 36 при незаполенном 33B', '', 1, 'DOCMSG_MSGCHK_D75');
    bars_error.add_message(l_mod, 375, l_exc, l_ukr, 'D75: Не заполнено поле 36 при различном коде валюты в полях 33B и 32A или заполнено поле 36 при незаполенном 33B', '', 1, 'DOCMSG_MSGCHK_D75');

    bars_error.add_message(l_mod, 398, l_exc, l_rus, 'D98: Неверная последовательность кодов в поле 23E', '', 1, 'DOCMSG_MSGCHK_D98');
    bars_error.add_message(l_mod, 398, l_exc, l_ukr, 'D98: Неверная последовательность кодов в поле 23E', '', 1, 'DOCMSG_MSGCHK_D98');

    bars_error.add_message(l_mod, 401, l_exc, l_rus, 'E01: Недопустимый код в поле 23E при значении SPRI в поле 23B', '', 1, 'DOCMSG_MSGCHK_E01');
    bars_error.add_message(l_mod, 401, l_exc, l_ukr, 'E01: Недопустимый код в поле 23E при значении SPRI в поле 23B', '', 1, 'DOCMSG_MSGCHK_E01');

    bars_error.add_message(l_mod, 402, l_exc, l_rus, 'E02: Использование поля 23E запрещено при значенях поля 23B SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E02');
    bars_error.add_message(l_mod, 402, l_exc, l_ukr, 'E02: Использование поля 23E запрещено при значенях поля 23B SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E02');

    bars_error.add_message(l_mod, 403, l_exc, l_rus, 'E03: Использование поля 53D запрещено при значенях поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E03');
    bars_error.add_message(l_mod, 403, l_exc, l_ukr, 'E03: Использование поля 53D запрещено при значенях поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E03');

    bars_error.add_message(l_mod, 404, l_exc, l_rus, 'E04: Некорректное использование поля 53B при значенях поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E04');
    bars_error.add_message(l_mod, 404, l_exc, l_ukr, 'E04: Некорректное использование поля 53B при значенях поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E04');

    bars_error.add_message(l_mod, 405, l_exc, l_rus, 'E05: Недопустимая опция поля 54a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E05');
    bars_error.add_message(l_mod, 405, l_exc, l_ukr, 'E05: Недопустимая опция поля 54a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E05');

    bars_error.add_message(l_mod, 406, l_exc, l_rus, 'E06: Не заполнено поле 53a или 54a при заполненном поле 55a', '', 1, 'DOCMSG_MSGCHK_E06');
    bars_error.add_message(l_mod, 406, l_exc, l_ukr, 'E06: Не заполнено поле 53a или 54a при заполненном поле 55a', '', 1, 'DOCMSG_MSGCHK_E06');

    bars_error.add_message(l_mod, 407, l_exc, l_rus, 'E07: Недопустимая опция поля 55a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E07');
    bars_error.add_message(l_mod, 407, l_exc, l_ukr, 'E07: Недопустимая опция поля 55a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E07');

    bars_error.add_message(l_mod, 409, l_exc, l_rus, 'E09: При значении SSTD или SPAY в поле 23B разрешены только опции A, C, D(с подполем счет) поля 57a', '', 1, 'DOCMSG_MSGCHK_E09');
    bars_error.add_message(l_mod, 409, l_exc, l_ukr, 'E09: При значении SSTD или SPAY в поле 23B разрешены только опции A, C, D(с подполем счет) поля 57a', '', 1, 'DOCMSG_MSGCHK_E09');

    bars_error.add_message(l_mod, 410, l_exc, l_rus, 'E10: Не заполнено подполе "Счет" в поле 59a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E10');
    bars_error.add_message(l_mod, 410, l_exc, l_ukr, 'E10: Не заполнено подполе "Счет" в поле 59a при значении поля 23B SPRI, SSTD или SPAY', '', 1, 'DOCMSG_MSGCHK_E10');

    bars_error.add_message(l_mod, 412, l_exc, l_rus, 'E12: Одновременное использование полей 70 и 77T запрещено', '', 1, 'DOCMSG_MSGCHK_E12');
    bars_error.add_message(l_mod, 412, l_exc, l_ukr, 'E12: Одновременное использование полей 70 и 77T запрещено', '', 1, 'DOCMSG_MSGCHK_E12');

    bars_error.add_message(l_mod, 413, l_exc, l_rus, 'E13: Использование поля 71F запрещено при значении OUR поля 71A', '', 1, 'DOCMSG_MSGCHK_E13');
    bars_error.add_message(l_mod, 413, l_exc, l_ukr, 'E13: Использование поля 71F запрещено при значении OUR поля 71A', '', 1, 'DOCMSG_MSGCHK_E13');

    bars_error.add_message(l_mod, 415, l_exc, l_rus, 'E15: При значении BEN поля 71А поле 71F обязательное, использование поля 71G запрещено', '', 1, 'DOCMSG_MSGCHK_E15');
    bars_error.add_message(l_mod, 415, l_exc, l_ukr, 'E15: При значении BEN поля 71А поле 71F обязательное, использование поля 71G запрещено', '', 1, 'DOCMSG_MSGCHK_E15');

    bars_error.add_message(l_mod, 416, l_exc, l_rus, 'E16: Незаполнено поле 56a при значении SPRI в поле 23B', '', 1, 'DOCMSG_MSGCHK_E16');
    bars_error.add_message(l_mod, 416, l_exc, l_ukr, 'E16: Незаполнено поле 56a при значении SPRI в поле 23B', '', 1, 'DOCMSG_MSGCHK_E16');

    bars_error.add_message(l_mod, 417, l_exc, l_rus, 'E17: При значении SSTD или SPAY в поле 23B поле 56a должно использоваться с опциями А или С', '', 1, 'DOCMSG_MSGCHK_E17');
    bars_error.add_message(l_mod, 417, l_exc, l_ukr, 'E17: При значении SSTD или SPAY в поле 23B поле 56a должно использоваться с опциями А или С', '', 1, 'DOCMSG_MSGCHK_E17');

    bars_error.add_message(l_mod, 418, l_exc, l_rus, 'E18: Использование подполя "Счет" в поле 59a запрещено при наличии кода CHQB в поле 23E', '', 1, 'DOCMSG_MSGCHK_E18');
    bars_error.add_message(l_mod, 418, l_exc, l_ukr, 'E18: Использование подполя "Счет" в поле 59a запрещено при наличии кода CHQB в поле 23E', '', 1, 'DOCMSG_MSGCHK_E18');

    bars_error.add_message(l_mod, 444, l_exc, l_rus, 'E44: При отсутствии поля 56a недопустимо использование кодов TELI, PHOI в поле 23E', '', 1, 'DOCMSG_MSGCHK_E44');
    bars_error.add_message(l_mod, 444, l_exc, l_ukr, 'E44: При отсутствии поля 56a недопустимо использование кодов TELI, PHOI в поле 23E', '', 1, 'DOCMSG_MSGCHK_E44');

    bars_error.add_message(l_mod, 445, l_exc, l_rus, 'E45: При отсутствии поля 57a недопустимо использование кодов TELE, PHON в поле 23E', '', 1, 'DOCMSG_MSGCHK_E45');
    bars_error.add_message(l_mod, 445, l_exc, l_ukr, 'E45: При отсутствии поля 57a недопустимо использование кодов TELE, PHON в поле 23E', '', 1, 'DOCMSG_MSGCHK_E45');

    bars_error.add_message(l_mod, 446, l_exc, l_rus, 'E46: Найдены повторяющиеся коды в поле 23E', '', 1, 'DOCMSG_MSGCHK_E46');
    bars_error.add_message(l_mod, 446, l_exc, l_ukr, 'E46: Найдены повторяющиеся коды в поле 23E', '', 1, 'DOCMSG_MSGCHK_E46');

    bars_error.add_message(l_mod, 500, l_exc, l_rus, 'TXX: При заполенном поле 26T не заполнено поле 77B', '', 1, 'DOCMSG_MSGCHK_TXX');
    bars_error.add_message(l_mod, 500, l_exc, l_ukr, 'TXX: При заполенном поле 26T не заполнено поле 77B', '', 1, 'DOCMSG_MSGCHK_TXX');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SWT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
