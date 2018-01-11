PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SVC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль SVC ***
declare
  l_mod  varchar2(3) := 'SVC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Сервисные и технические средства', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Параметр %s не найден.', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Параметр %s не знайдено.', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Ошибка выполнения запроса: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Помилка виконання запиту: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Error: %s sending on pipe', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Error: %s sending on pipe', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Invalid currency code', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Invalid currency code', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найдена базовая валюта', '', 1, 'BASEVAL_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдена базова валюта', '', 1, 'BASEVAL_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не найден счет acc=%s', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не знайдено рахунку acc=%s', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Обновление глобального параметра запрещено!', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Оновлення глобального параметру заборонено!', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Удаление глобального параметра запрещено!', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Видалення глобального параметру заборонено!', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Создаваемый локальный параметр уже существует как глобальный!', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Створюваний локальний параметр вже існує як глобальний!', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Создаваемый глобальный параметр уже существует как локальный!', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Створюваний глобальний параметр вже існує як локальнй!', '', 1, '13');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Неверно задан параметр 1 (имя таблицы)', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Невірно заданий параметр 1 (им''я таблиці)', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Неверно задан параметр 2 (имя столбца ключа таблицы)', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Невірно заданий параметр 2 (им''я поля ключа таблиці)', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Неверно задан параметр 3 (имя столбца с LOB-объектом)', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Невірно заданий параметр 3 (им''я поля з LOB-об''єктом)', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Должен быть задан один из параметров 4 или 5', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Повинно задати один з параметрів 4 чи 5', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Неверно задан параметр 8 (допустимые значения 0/1)', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Невірно заданий параметр 8 (допустимі значення 0/1)', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Невозможно применить режим вставки при пользовательском фильтре', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Неможливо застосувати режим додання при фільтрі користувача', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Неверный формат параметра "Признак аутентификации ролей"', '', 1, 'ROLEAUTH_PARAM_FORMAT');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Невідомий формат параметру "Признак аутентифікації ролей"', '', 1, 'ROLEAUTH_PARAM_FORMAT');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Недопустимое значение параметра "Признак аутентификации ролей"', '', 1, 'ROLEAUTH_PARAM_VALUE');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Недопустиме значеняя параметру "Признак аутентифікації ролей"', '', 1, 'ROLEAUTH_PARAM_VALUE');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Неверный вызов функции установки роли [%s]', '', 1, 'ROLEAUTH_INVALID_CALL');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Помилковий виклик функції встановлення ролі [%s]', '', 1, 'ROLEAUTH_INVALID_CALL');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Роль %s не найдена или не описана', '', 1, 'ROLE_NOT_FOUND');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Роль %s не знайдена або не описана', '', 1, 'ROLE_NOT_FOUND');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Роль %s требует защищенной активации', '', 1, 'ROLEAUTH_REQUIRED');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Роль %s потребує захищеної активації', '', 1, 'ROLEAUTH_REQUIRED');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Роль %s требует активации приложением', '', 1, 'APPAUTH_REQUIRED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Роль %s потребує активації додатком', '', 1, 'APPAUTH_REQUIRED');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Доплата должна выполняться от пользователя с правами на все отделения', '', 1, 'PAYDOCFULL_INVALID_BRANCH');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Доплата должна выполняться от пользователя с правами на все отделения', '', 1, 'PAYDOCFULL_INVALID_BRANCH');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Ошибка при доплате документа (реф. %s): %s', '', 1, 'PAYDOCFULL_DOC_ERROR');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Ошибка при доплате документа (реф. %s): %s', '', 1, 'PAYDOCFULL_DOC_ERROR');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Доплата документа (реф. %s) прервана из-за ошибки', '', 1, 'PAYDOCFULL_DOC_SKIP');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Доплата документа (реф. %s) прервана из-за ошибки', '', 1, 'PAYDOCFULL_DOC_SKIP');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Создание дебетового межбанковского документа запрещено (док. реф. %s)', '', 1, 'PAYDOCFULL_EXTDOC_DEBIT');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Создание дебетового межбанковского документа запрещено (док. реф. %s)', '', 1, 'PAYDOCFULL_EXTDOC_DEBIT');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Создание дебетового документа в TransMaster запрещено (док. реф. %s)', '', 1, 'PAYDOCFULL_TRANSMASTER_DEBIT');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Создание дебетового документа в TransMaster запрещено (док. реф. %s)', '', 1, 'PAYDOCFULL_TRANSMASTER_DEBIT');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Невозможно определить сторону документа для оплаты (док. реф. %s)', '', 1, 'PAYDOCFULL_PAYSIDE_ERROR');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Невозможно определить сторону документа для оплаты (док. реф. %s)', '', 1, 'PAYDOCFULL_PAYSIDE_ERROR');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Невозможно определить одно из подразделений документа (док. реф. %s)', '', 1, 'PAYDOCFULL_BRANCH_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Невозможно определить одно из подразделений документа (док. реф. %s)', '', 1, 'PAYDOCFULL_BRANCH_ERROR');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Документ ид. %s не найден', '', 1, 'DPZTBARS_DOC_NOTFOUND');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Документ ид. %s не найден', '', 1, 'DPZTBARS_DOC_NOTFOUND');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Документ ид. %s уже проведен во внешней системе', '', 1, 'DPZTBARS_DOC_ISPAYED');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Документ ид. %s уже проведен во внешней системе', '', 1, 'DPZTBARS_DOC_ISPAYED');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Документ ид. %s не в состоянии "Отбракован"', '', 1, 'DPZTBARS_INVALID_DOCSTATE');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Документ ид. %s не в состоянии "Отбракован"', '', 1, 'DPZTBARS_INVALID_DOCSTATE');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Документ ид. %s (вн ид. %s) не может быть удален', '', 1, 'DPZTBARS_INVALID_EXTDOCSTATE');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Документ ид. %s (вн ид. %s) не может быть удален', '', 1, 'DPZTBARS_INVALID_EXTDOCSTATE');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Установлен недопустимый код блокировки счета (%s)', '', 1, 'DPZTBARS_ACCLCK_INVALIDCODE');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Установлен недопустимый код блокировки счета (%s)', '', 1, 'DPZTBARS_ACCLCK_INVALIDCODE');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Ошибка передачи эксп. проводки по документу %s в ОДБ: %s', '', 1, 'DPZTBARS_DOC2ODB_ERRSEND');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Ошибка передачи эксп. проводки по документу %s в ОДБ: %s', '', 1, 'DPZTBARS_DOC2ODB_ERRSEND');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Состояние проводок по документу ид. %s изменилось в ОДБ, документ сторнирован', '', 1, 'DPZTBARS_DOC2ODB_INCONSEXPTX');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Состояние проводок по документу ид. %s изменилось в ОДБ, документ сторнирован', '', 1, 'DPZTBARS_DOC2ODB_INCONSEXPTX');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Не задан глобальный параметр %s', '', 1, 'ODB_PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, 'Не заданий глобальний параметр %s', '', 1, 'ODB_PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Ошибка инициализации пакета dpzt_odb_init_ver с параметрами (%s, %s)', '', 1, 'ODB_INIT_FAILED');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, 'Помилка ініціалізації пакета dpzt_odb_init_ver з параметрами (%s, %s)', '', 1, 'ODB_INIT_FAILED');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Не найден открытый банковский день в ОДБ Oracle', '', 1, 'ODB_BANKDATE_NOT_FOUND');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, 'Не знайдена відкрита банк.дата в ОДБ Oracle', '', 1, 'ODB_BANKDATE_NOT_FOUND');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Банковский день %s закрыт', '', 1, 'DPZTBARS_BANKDATE_CLOSED');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, 'Банківський день %s закрит', '', 1, 'DPZTBARS_BANKDATE_CLOSED');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Банковский день %s не найден', '', 1, 'DPZTBARS_BANKDATE_NOTFOUND');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, 'Банківський день %s не знайдено', '', 1, 'DPZTBARS_BANKDATE_NOTFOUND');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Невозможно импортировать документа %s из ОДБ', '', 1, 'DPZTBARS_ERROR_IMPORTDOC');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, 'Неможливо виконати імпорт документу %s з ОДБ', '', 1, 'DPZTBARS_ERROR_IMPORTDOC');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Интерфейс с ОДБ: ошибка синхронизации спр-ка банков: %s', '', 1, 'DPZTBARS_BANKSYNC_FAILED');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, 'Інтерфейс з ОДБ: помилка синхронізації довідника банків: %s', '', 1, 'DPZTBARS_BANKSYNC_FAILED');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Интерфейс с ОДБ: ошибка синхронизации спр-ка валют: %s', '', 1, 'DPZTBARS_CURRSYNC_FAILED');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Інтерфейс з ОДБ: помилка синхронізації довідника валют: %s', '', 1, 'DPZTBARS_CURRSYNC_FAILED');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Интерфейс с ОДБ: ошибка синхронизации курсов валют: %s', '', 1, 'DPZTBARS_RATESYNC_FAILED');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Інтерфейс з ОДБ: помилка синхронізації курсів валют: %s', '', 1, 'DPZTBARS_RATESYNC_FAILED');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Интерфейс с ОДБ: ошибка синхронизации спр-ка подразделений банка: %s', '', 1, 'DPZTBARS_BRANCHSYNC_FAILED');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Інтерфейс з ОДБ: помилка синхронізації довідника підрозділів банку: %s', '', 1, 'DPZTBARS_BRANCHSYNC_FAILED');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Нарушена целостность лицензии комплекса', '', 1, 'LICENSE_INCORRECT');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Нарушена целостность лицензии комплекса', '', 1, 'LICENSE_INCORRECT');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Срок действия лицензии комплекса истек', '', 1, 'LICENSE_EXPIRED');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Срок действия лицензии комплекса истек', '', 1, 'LICENSE_EXPIRED');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'Срок действия лицензии комплекса истекает через %s дней', '', 1, 'LICENSE_GREYTIME');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'Срок действия лицензии комплекса истекает через %s дней', '', 1, 'LICENSE_GREYTIME');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Нарушена целостность лицензионной информации пользователя "%s"', '', 1, 'LICENSE_USER_INCORRECT');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Нарушена целостность лицензионной информации пользователя "%s"', '', 1, 'LICENSE_USER_INCORRECT');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Попытка входа удаленным пользователей комплекса "%s"', '', 1, 'LICENSE_USER_DELETED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Попытка входа удаленным пользователей комплекса "%s"', '', 1, 'LICENSE_USER_DELETED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Срок действия временной учетной записи "%s" истек', '', 1, 'LICENSE_USER_EXPIRED');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Срок действия временной учетной записи "%s" истек', '', 1, 'LICENSE_USER_EXPIRED');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, 'Невозможно подтвердить лицензионную информацию пользователя "%s" - превышено количество лицензий', '', 1, 'LICENSE_USER_EXCEEDLIMIT');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, 'Невозможно подтвердить лицензионную информацию пользователя "%s" - превышено количество лицензий', '', 1, 'LICENSE_USER_EXCEEDLIMIT');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, 'Нарушена целостность временной учетной "%s"', '', 1, 'LICENSE_USER_EXPIREPARAM');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, 'Нарушена целостность временной учетной "%s"', '', 1, 'LICENSE_USER_EXPIREPARAM');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, 'Невозможно подтвердить лицензионную информацию пользователя "%s" - превышено количество временных учетных записей', '', 1, 'LICENSE_USER_TEMPLIMITEXCEED');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, 'Невозможно подтвердить лицензионную информацию пользователя "%s" - превышено количество временных учетных записей', '', 1, 'LICENSE_USER_TEMPLIMITEXCEED');

    bars_error.add_message(l_mod, 110, l_exc, l_rus, 'Найдены ошибки при перепроверке пользовательских лицензий: %s', '', 1, 'LICENSE_REVALIDATE_USER_ERRORS');
    bars_error.add_message(l_mod, 110, l_exc, l_ukr, 'Найдены ошибки при перепроверке пользовательских лицензий: %s', '', 1, 'LICENSE_REVALIDATE_USER_ERRORS');

    bars_error.add_message(l_mod, 130, l_exc, l_rus, 'Не найдена учетная запись пользователя "%s"', '', 1, 'LICENSE_USERNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 130, l_exc, l_ukr, 'Не найдена учетная запись пользователя "%s"', '', 1, 'LICENSE_USERNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 131, l_exc, l_rus, 'Учетная запись удаленного пользователя "%s" найдена в БД', '', 1, 'LICENSE_USERACCOUNT_EXISTS');
    bars_error.add_message(l_mod, 131, l_exc, l_ukr, 'Учетная запись удаленного пользователя "%s" найдена в БД', '', 1, 'LICENSE_USERACCOUNT_EXISTS');

    bars_error.add_message(l_mod, 132, l_exc, l_rus, 'Код модуля %s должен быть трехзначным', '', 1, '132');
    bars_error.add_message(l_mod, 132, l_exc, l_ukr, 'Код модуля %s повинен бути тризначним', '', 1, '132');

    bars_error.add_message(l_mod, 133, l_exc, l_rus, 'Роль %s не существует. Создайте сначала данную роль', '', 1, '133');
    bars_error.add_message(l_mod, 133, l_exc, l_ukr, 'Роль %s не існує. Створіть спочатку данну роль', '', 1, '133');

    bars_error.add_message(l_mod, 134, l_exc, l_rus, 'Функции под номером %s не существует', '', 1, '134');
    bars_error.add_message(l_mod, 134, l_exc, l_ukr, 'Функції під номером %s не існує', '', 1, '134');

    bars_error.add_message(l_mod, 135, l_exc, l_rus, 'Невозможно выдать роль %s пользователю %s', '', 1, '135');
    bars_error.add_message(l_mod, 135, l_exc, l_ukr, 'Неможливо видати роль %s користувачу %s', '', 1, '135');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, 'Параметр подразделения %s не найден (подразделение %s)', '', 1, 'BRANCHPARAM_NOTEXISTS');
    bars_error.add_message(l_mod, 151, l_exc, l_ukr, 'Параметр подразделения %s не найден (подразделение %s)', '', 1, 'BRANCHPARAM_NOTEXISTS');

    bars_error.add_message(l_mod, 171, l_exc, l_rus, 'Внутренние информационные документы запрещены', '', 1, 'INPDOC_LOCAL_INFDOC_DENY');
    bars_error.add_message(l_mod, 171, l_exc, l_ukr, 'Внутрішні інформаційні документи заборонені', '', 1, 'INPDOC_LOCAL_INFDOC_DENY');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SVC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
