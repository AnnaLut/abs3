PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BRS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль BRS ***
declare
  l_mod  varchar2(3) := 'BRS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Общий', 1);

    bars_error.add_message(l_mod, 100, l_exc, l_eng, '%s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_geo, '%s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Даные не найдены: %s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Данi не знайдено: %s', '', 1, 'NO_DATA_FOUND');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Нарушено постановление НБУ №49 от 06.02.2014 (сч.деб.:%s, реф.док.:%s)', '', 1, 'BROKEN_ACT_NBU49');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Порушено постанову НБУ №49 вiд 06.02.2014 (рах.деб.:%s, реф.док.:%s)', '', 1, 'BROKEN_ACT_NBU49');

    bars_error.add_message(l_mod, 200, l_exc, l_geo, 'Impossible send to SEP. Error : %s', '', 1, '200');
    bars_error.add_message(l_mod, 200, l_exc, l_rus, 'Невозможно передать в СЭП. Ошибка : %s', '', 1, '200');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, 'Неможливо передаты у СЕП. Помилка : %s', '', 1, '200');

    bars_error.add_message(l_mod, 201, l_exc, l_geo, 'SEP document with inf.messages section. Last visa should be puted in head bank.', '', 1, '201');
    bars_error.add_message(l_mod, 201, l_exc, l_rus, 'СЭП документ с блоком информ. сообщений. Последняя виза накладывается в ГБ.', '', 1, '201');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'СЕП документ з блоком iнформ. повiдомлень. Остання віза накладається у ГБ.', '', 1, '201');

    bars_error.add_message(l_mod, 202, l_exc, l_eng, 'Modification of table %s allowed in head bank only', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_geo, 'Modification of table %s allowed in head bank only', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Модификация данных таблицы %s разрешена только в головном банке', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Модифiкацiя даних таблицi %s дозволена тiльки в головному банку', '', 1, 'UPDATE_IN_CENTER_ONLY');

    bars_error.add_message(l_mod, 203, l_exc, l_eng, 'Modification of object "%s" disabled', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_geo, 'Modification of object "%s" disabled', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Модификация данных объекта "%s" запрещена', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Модифiкацiя даних об''єкта "%s" заборонена', '', 1, 'MODIFICATION_DISABLED');

    bars_error.add_message(l_mod, 204, l_exc, l_eng, 'MFO-user does not have privilege to modify root data of an object "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_geo, 'MFO-user does not have privilege to modify root data of an object "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_rus, 'Пользователю МФО запрещена модификация корневых данных объекта "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, 'Користувачу МФО заборонена модифікація кореневих даних об''єкта "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, 'Ошибка оплаты: %s', '', 1, 'NOT_PAY_150');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, 'Помилка оплати: %s', '', 1, 'NOT_PAY_150');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, 'Превышен срок ожидания от сервера', '', 1, 'TRANSFER_TIMEOUT');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, 'Перевищено термін очікування від сервера', '', 1, 'TRANSFER_TIMEOUT');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, 'Нет соединения с сервером', '', 1, 'MISSING_CONNECTION');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, 'Відсутнє з''єднання з сервером', '', 1, 'MISSING_CONNECTION');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, 'Превышена сумма 500000. Постанова НБУ №354', '', 1, 'POSTANOVA_449');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, 'Перевищена сума 500000. Постанова НБУ №354', '', 1, 'POSTANOVA_449');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, 'В вашем подразделении %s заблокирован ввод операций по продаже наличной иностранной валюты, в связи с привышением срока визирования в 15 мин.!', '', 1, 'CHECK_TIME_VISA_TT');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, 'В вашому підрозділі %s заблоковано введення операцій з продажу готівкової іноземної валюти, в зв''язку з перевищенням терміну візування в 15 хв.!', '', 1, 'CHECK_TIME_VISA_TT');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, 'Запрет визирования документов старше 30 дней!', '', 1, 'LOCK_CHK_30DAY');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, 'Заборона візувати документи старші 30 днів!', '', 1, 'LOCK_CHK_30DAY');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, 'Реквизит "LCSDE - Описание исключения", должно быть заполнено!', '', 1, 'MUST_FILL_PROP_LCSDE');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, 'Реквізит "LCSDE - Опис винятку", має бути заповненим!', '', 1, 'MUST_FILL_PROP_LCSDE');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, 'Невозможно совершить сделку по данному паспорту. Паспорт выдан с нарушением условий действующего законодательства', '', 1, 'PASSP_MUST_BE_DESTROYED');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, 'Неможливо здійснити операцію за даним паспортом. Паспорт видано з порушенням умов чинного законодавства', '', 1, 'PASSP_MUST_BE_DESTROYED');

    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 18001, l_exc, l_geo, 'Currencies rates not loaded for bank date %s', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_rus, 'Не загружены курсы валют для банковской даты %s', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_ukr, 'Не завантажені курси валют для банківської дати %s', '', 1, '18001');

    bars_error.add_message(l_mod, 18002, l_exc, l_geo, 'Rate for currency %s not found. Date %s, Branch %s', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_rus, 'Не найден курс валюты %s. Дата %s, подразделение %s', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_ukr, 'Не знайдено курс валюти %s. Дата %s, підрозділ %s', '', 1, '18002');

    bars_error.add_message(l_mod, 18003, l_exc, l_geo, 'Impossible change currencies rates for paternal branches', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_rus, 'Нельзя изменять курсы валют родительских подразделений', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_ukr, 'Зміна курсів валют батьківських підрозділів заборонена', '', 1, '18003');

    bars_error.add_message(l_mod, 18004, l_exc, l_geo, 'Impossible visa currencies rates for paternal branches', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_rus, 'Нельзя визировать курсы валют родительских подразделений', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_ukr, 'Візування курсів валют батьківських підрозділів заборонене', '', 1, '18004');

    bars_error.add_message(l_mod, 18005, l_exc, l_geo, 'Document not found, ref = %s', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_rus, 'Документ не найден, ref = %s', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_ukr, 'Документ не знайдено, ref = %s', '', 1, '18005');

    bars_error.add_message(l_mod, 18006, l_exc, l_geo, 'Row deleting is improper', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_rus, 'Удаление записи запрещено!', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_ukr, 'Видалення запису заборонено!', '', 1, '18006');

    bars_error.add_message(l_mod, 99800, l_exc, l_geo, 'System error %s', 'You will appeal to system administrator', 1, '99800');
    bars_error.add_message(l_mod, 99800, l_exc, l_rus, 'Системная ошибка %s', 'Обратитесь к администратору системы', 1, '99800');
    bars_error.add_message(l_mod, 99800, l_exc, l_ukr, 'Системна помилка %s', 'Зверніться до адміністратора системи', 1, '99800');

    bars_error.add_message(l_mod, 99801, l_exc, l_geo, 'Undefined error %s', 'Error description is absent in error reference', 1, '99801');
    bars_error.add_message(l_mod, 99801, l_exc, l_rus, 'Ошибка %s не определена', 'Отсутствует описание данной ошибке в справочнике ошибок комплекса', 1, '99801');
    bars_error.add_message(l_mod, 99801, l_exc, l_ukr, 'Помилка %s не визначена', 'Відсутній опис даної помилки в довіднику помилок комплекса', 1, '99801');

    bars_error.add_message(l_mod, 99802, l_exc, l_geo, 'Incorrect error code format %s', 'Passed error code and/or module code fall short used format', 1, '99802');
    bars_error.add_message(l_mod, 99802, l_exc, l_rus, 'Неверный формат кода ошибки %s', 'Переданный код ошибки и/или код модуля не соответствуют используемому формату', 1, '99802');
    bars_error.add_message(l_mod, 99802, l_exc, l_ukr, 'Невірний формат коду помилки %s', 'Переданий код помилки та/або код модуля не відповідають використовуваному формату', 1, '99802');

    bars_error.add_message(l_mod, 99803, l_exc, l_geo, 'Environment development error', '', 1, '99803');
    bars_error.add_message(l_mod, 99803, l_exc, l_rus, 'Ошибка среды разработки', '', 1, '99803');
    bars_error.add_message(l_mod, 99803, l_exc, l_ukr, 'Помилка середовища розробки', '', 1, '99803');

    bars_error.add_message(l_mod, 99804, l_exc, l_geo, 'Module tuning for user %s is denied', '', 1, '99804');
    bars_error.add_message(l_mod, 99804, l_exc, l_rus, 'Пользователю %s не разрешена настройка модуля', '', 1, '99804');
    bars_error.add_message(l_mod, 99804, l_exc, l_ukr, 'Користувачу %s не дозволено налаштування модуля', '', 1, '99804');

    bars_error.add_message(l_mod, 99805, l_exc, l_geo, 'Lang with code %s not described', '', 1, '99805');
    bars_error.add_message(l_mod, 99805, l_exc, l_rus, 'Язык с кодом %s не описан', '', 1, '99805');
    bars_error.add_message(l_mod, 99805, l_exc, l_ukr, 'Мова з кодом %s не описана', '', 1, '99805');

    bars_error.add_message(l_mod, 99806, l_exc, l_geo, 'Error %s not defined in module %s', '', 1, '99806');
    bars_error.add_message(l_mod, 99806, l_exc, l_rus, 'Ошибка %s не определена в модуле %s', '', 1, '99806');
    bars_error.add_message(l_mod, 99806, l_exc, l_ukr, 'Помилка %s не визначена в модулі %s', '', 1, '99806');

    bars_error.add_message(l_mod, 99807, l_exc, l_geo, 'Incorrecr error name format %s', '', 1, '99807');
    bars_error.add_message(l_mod, 99807, l_exc, l_rus, 'Неверный формат имени ошибки %s', '', 1, '99807');
    bars_error.add_message(l_mod, 99807, l_exc, l_ukr, 'Невірний формат імені помилки %s', '', 1, '99807');

    bars_error.add_message(l_mod, 99808, l_exc, l_geo, 'Duplicated error name %s', '', 1, '99808');
    bars_error.add_message(l_mod, 99808, l_exc, l_rus, 'Дублируется имя ошибки %s', '', 1, '99808');
    bars_error.add_message(l_mod, 99808, l_exc, l_ukr, 'Дублюється ім''я помилки %s', '', 1, '99808');

    bars_error.add_message(l_mod, 99999, l_exc, l_geo, 'Internal error %s %s %s %s', '', 1, '99999');
    bars_error.add_message(l_mod, 99999, l_exc, l_rus, 'Внутренняя ошибка %s %s %s %s', '', 1, '99999');
    bars_error.add_message(l_mod, 99999, l_exc, l_ukr, 'Внутрішня помилка %s %s %s %s', '', 1, '99999');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BRS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
