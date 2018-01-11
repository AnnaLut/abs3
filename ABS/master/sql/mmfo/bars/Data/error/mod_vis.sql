PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_VIS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль VIS ***
declare
  l_mod  varchar2(3) := 'VIS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Визирование', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Internal ECP absent', '', 1, 'INT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Отсутствует внутренняя ЭЦП', '', 1, 'INT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Відсутній внутрішній ЕЦП', '', 1, 'INT_SIGN_EMPTY');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'External ECP absent', '', 1, 'EXT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Отсутствует внешняя ЭЦП', '', 1, 'EXT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Відсутній зовнішній ЕЦП', '', 1, 'EXT_SIGN_EMPTY');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Visa level can not be negative.', '', 1, 'LEVEL_NEGATIV');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Уровень визы не может быть отрицательным.', '', 1, 'LEVEL_NEGATIV');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Рівень візи не може бути негативним.', '', 1, 'LEVEL_NEGATIV');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Visa of level $(VISA) not found!', '', 1, 'VISA_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Виза уровня $(VISA) не найдена!', '', 1, 'VISA_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Візу рівня $(VISA) не знайдено!', '', 1, 'VISA_NOT_FOUND');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Incorrect value of field SOS=$(SOS)', '', 1, 'INCORRECT_SOS');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA): Неверное значение поля SOS=$(SOS)', '', 1, 'INCORRECT_SOS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA): Невірне значення поля SOS=$(SOS)', '', 1, 'INCORRECT_SOS');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Incorrect value of field NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA): Неверное значение поля NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA): Невірне значення поля NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document not found in visa queue REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA): Документ не найден в очереди визирования REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA): Документ не знайдено в переліку візування REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document not found!', '', 1, 'DOC_NOT_FOUND_GENERAL');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA): Документ не найден вообще!', '', 1, 'DOC_NOT_FOUND_GENERAL');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA): Документ не знайдено!', '', 1, 'DOC_NOT_FOUND_GENERAL');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA)', '', 1, 'ERR_BLOCK_DOC');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA)', '', 1, 'ERR_BLOCK_DOC');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA)', '', 1, 'ERR_BLOCK_DOC');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document locked other user', '', 1, 'DOC_IS_BLOCKED');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Невозможно заблокировать документ REF=$(REF) на визе № $(VISA): Документ заблокирован другим пользователем', '', 1, 'DOC_IS_BLOCKED');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Неможливо заблокувати документ REF=$(REF) на візі № $(VISA): Документ заблоковано іншим користувачем', '', 1, 'DOC_IS_BLOCKED');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Document not found. REF=%$(REF)', '', 1, 'DOC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Документ не найден. REF=%$(REF)', '', 1, 'DOC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Документ не знайдено. REF=$(REF)', '', 1, 'DOC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Error on getting document parameters REF=$(REF) on visa N $(VISA)', '', 1, 'ERR_GET_PARAMS');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Ошибка получения параметров документа REF=$(REF) на визе № $(VISA)', '', 1, 'ERR_GET_PARAMS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Помилка отримання параметрів документа REF=$(REF) на візі № $(VISA)', '', 1, 'ERR_GET_PARAMS');

    bars_error.add_message(l_mod, 32, l_exc, l_geo, 'Invalid visa condition: $(COND)', '', 1, 'ERR_VIS_COND');
    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Ошибочное условие на визе: $(COND)', '', 1, 'ERR_VIS_COND');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Помилка в умові на візі: $(COND)', '', 1, 'ERR_VIS_COND');

    bars_error.add_message(l_mod, 33, l_exc, l_geo, 'Unable to execute procedure $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Невозможно выполнить процедуру $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Неможливо виконати процедуру $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_VIS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
