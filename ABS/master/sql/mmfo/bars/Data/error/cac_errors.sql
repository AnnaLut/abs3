PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CAC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CAC ***
declare
  l_mod  varchar2(3) := 'CAC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Клиенты и счета', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Improper client type - %s', '', 1, 'INCORRECT_CUSTTYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Недопустимый тип клиента - %s', '', 1, 'INCORRECT_CUSTTYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Неприпустимий тип клiєнта -%s', '', 1, 'INCORRECT_CUSTTYPE');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Account in module! Impossible re-register on other contragent', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Модульный счет! Невозможно перерегистрировать на другого контрагента', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Модульний рахунок! Неможливо перереєструвати на iншого контрагента', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Group accounts update is denied!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Запрещено групповое обновление счетов!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Заборонено групове поновлення рахункiв!', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Group clients update is denied!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Запрещено групповое обновление клиентов!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Заборонено групове поновлення контрагентiв!', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible change attributes closed account N%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Невозможно изменить реквизиты закрытого счета №%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Неможливо змiнити реквiзити закритого рахунку №%s', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Improper balance account - %s', '', 1, 'INVALID_R020');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Недопустимый балансовый счет - %s', '', 1, 'INVALID_R020');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Неприпустимий балансовий рахунок - %s', '', 1, 'INVALID_R020');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Accounts parameters change other user. ACC=%s', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Параметры счета изменяются другим пользователем. ACC=%s', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Параметри рахунку змiнюються iншим користувачем. ACC=%s', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'Improper currency code - %s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Недопустимый код валюты - %s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Неприпустимий код валюти - %s', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'Unsuccessful opening/change account attributes (ACCOUNTS) N%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Неуспешное открытие/изменение реквизитов счета (ACCOUNTS) №%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Неуспiшне вiдкриття/поновлення реквiзитiв рахунку (ACCOUNTS) №%s', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Unsuccessful account link (ND_ACC) to deal N%s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Неуспешная привязка счета (ND_ACC) к сделке №%s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Неуспiшна прив''язка рахунку (ND_ACC) до угоди №%s', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Unsuccessful account of providing opening (PAWN_ACC) N%s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Неуспешное открытие счета обеспечения (PAWN_ACC) №%s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Неуспiшне вiдкриття рахунку забезпечення (PAWN_ACC) №%s', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Overdraft account already open (ACC_OVER) for account ACC=%s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Уже открыт счет овердрафта (ACC_OVER) для счета ACC=%s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Вже вiдкрито рахунок овердрафту (ACC_OVER) для рахунка ACC=%s', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_geo, 'Unsuccessfuk overdraft account opening (ACC_OVER) for account ACC=%s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Неуспешное открыие счета овердрафта (ACC_OVER) для счета ACC=%s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Неуспiшне вiдкриття рахунку овердрафта (ACC_OVER) для рахунка ACC=%s', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_geo, 'Unsuccessful account link (BANK_ACC) to MFO %s', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Неуспешная привязка счета (BANK_ACC) к МФО %s', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Неуспiшна прив''язка рахунку (BANK_ACC) до МФО %s', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_geo, 'Account %s link to few MFO', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Счет №%s привязан к нескольким МФО', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Рахунок №%s прив''язано до дек_лька МФО', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_geo, 'Unknown account opening mode - %s', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Неизвестный режим открытия счета - %s', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Невiдомий режим вiдкриття рахунку - %s', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Не найдено подразделение с кодом %s!', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Не знайдено пiдроздiлу з кодом %s!', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Невозможно однозначно идентифицировать подразд. %s!', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Неможливо однозначно iдентифiкувати пiдрозд. %s!', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'SYNC_OPEN: счёт закрыт %s!', '', 1, '19');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'SYNC_OPEN: рахунок закрито %s!', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'SYNC_OPEN: счёт %s зарегистрирован за др.подразд.!', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'SYNC_OPEN: рахунок %s зареєстровано за iнш.пiдрозд.!', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Некорректно заполнен спр-к параметров для подразд. %s!', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Некоректно заповнено довiдник параметрiв для пiдрозд. %s!', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не найден контрагент для подразд. %s!', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не знайдено контрагента для пiдрозд. %s!', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Невозможно однозначно идентифицировать контрагента для подразд. %s!', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Неможливо однозначно iдентифiкувати контрагента для пiдрозд. %s!', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Ошибка в контр.разряде счета %s МФО: %s!', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Помилка в контр.розрядi рахунку %s МФО: %s!', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Указанная валюта (%s) не найдена или закрыта!', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Вказану валюту (%s) не знайдено чи закрито!', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Нельзя модифицировать код подразделения счета', '', 1, 'UPDATE_ACCOUNTS_BRANCH');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Неможливо модифiкувати код пiдроздiлу рахунку', '', 1, 'UPDATE_ACCOUNTS_BRANCH');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Запрещено открывать счета за пределами МФО', '', 1, 'OPEN_ROOT_ACCOUNT');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Заборонено вiдкривати рахунки за межами МФО', '', 1, 'OPEN_ROOT_ACCOUNT');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Указанное значение спецпараметра закрыто или не существует', '', 1, 'SPECPARAM_CLOSED');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Вказане значення спецпараметру закрите чи не iснує', '', 1, 'SPECPARAM_CLOSED');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Для данного балансового счета необходимо заполнить альтернативный счет', '', 1, 'ACCOUNT_NBS_MUST_NLSALT');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Для вказаного балансового рахунку необхідно заповнити альтернативний рахунок', '', 1, 'ACCOUNT_NBS_MUST_NLSALT');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Заполнение альтернативного балансового счета для данного счета запрещено', '', 1, 'ACCOUNT_NBS_NOT_NLSALT');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Заповнення альтернативного рахунку для цього рахунку заборонено', '', 1, 'ACCOUNT_NBS_NOT_NLSALT');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Запрещено переносить счет в другое МФО', '', 1, 'UPDATE_ACCOUNTS_KF');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Заборонено переносити рахунок в інше МФО', '', 1, 'UPDATE_ACCOUNTS_KF');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Серия паспорта не задана', '', 1, 'PASSPORT_SERIAL_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Серія паспорта не задана', '', 1, 'PASSPORT_SERIAL_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Неверная длина серии паспорта', '', 1, 'PASSPORT_SERIAL_LENGTH');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Невірна довжина серії паспорта', '', 1, 'PASSPORT_SERIAL_LENGTH');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Недопустимые символы в серии паспорта', '', 1, 'PASSPORT_SERIAL_ERROR');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Недопустимі символи в серії паспорта', '', 1, 'PASSPORT_SERIAL_ERROR');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Номер паспорта не задан', '', 1, 'PASSPORT_NUMBER_NULL');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Номер паспорта не задано', '', 1, 'PASSPORT_NUMBER_NULL');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Неверная длина номера паспорта', '', 1, 'PASSPORT_NUMBER_LENGTH');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Невірна довжина номера паспорта', '', 1, 'PASSPORT_NUMBER_LENGTH');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Недопустимые символы в номере паспорта', '', 1, 'PASSPORT_NUMBER_ERROR');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Недопустимі символи в номері паспорта', '', 1, 'PASSPORT_NUMBER_ERROR');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Нецифровой символ в ОКПО: %s', '', 1, 'NON_NUMERIC_OKPO');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Нецифровий символ в ЗКПО: %s', '', 1, 'NON_NUMERIC_OKPO');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Уже зарегистрирован клиент с ОКПО %s', '', 1, 'CUSTOMER_WITH_OKPO');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Вже зареєстровано клієнта з ЗКПО %s', '', 1, 'CUSTOMER_WITH_OKPO');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Уже зарегистрирован клиент-СПД с ОКПО %s', '', 1, 'CUSTOMER_SPD_WITH_OKPO');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'же зареєстровано клієнта-СПД з ЗКПО %s', '', 1, 'CUSTOMER_SPD_WITH_OKPO');

    bars_error.add_message(l_mod, 41, l_exc, l_geo, 'Impossible open account / change accounts attributes - customer RNK %s closed', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Невозможно открыть счет / изменить реквизиты счета - клиент РНК %s закрыт', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Неможливо відкрити рахунок / змiнити реквiзити рахунку - клієнта РНК %s закрито', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_geo, 'Customer RNK %s not found', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Клиент РНК %s не найден', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Клієнта РНК %s не знвйдено', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Клиент с РНК %s уже существует', '', 1, 'RNK_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Клієнт з РНК %s вже існує', '', 1, 'RNK_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Счет %s не найден', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Рахунок %s не знайдено', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Дата открытия счета %s больше даты последнего движения %s', '', 1, 'ACC_DAOS_DAPP');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Дата відкриття рахунку %s більше дати останнього руху %s', '', 1, 'ACC_DAOS_DAPP');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Невозможно заблокировать/разблокировать счет кодом ФМ данным пользователем', '', 1, 'ACCOUNT_BLK_FM_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Неможливо заблокувати/розблокувати рахунок кодом ФМ даним користувачем', '', 1, 'ACCOUNT_BLK_FM_ERROR');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Запрещено блокировать/разблокировать счет кодом ''Не введен в действие''', '', 1, 'ACCOUNT_BLK_ACT_ERROR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Заборонено блокувати/розблокувати рахунок кодом ''Не введено в дію''', '', 1, 'ACCOUNT_BLK_ACT_ERROR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Некорректное значение реквизита <Мобильный телефон>', '', 1, 'MPNO_ERROR_FORMAT');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Некоректне значення реквізиту <Мобільний телефон>', '', 1, 'MPNO_ERROR_FORMAT');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Запрещено разблокировать счет до получения сообщения о регистации счета из ДПА', '', 1, 'ACCOUNT_BLK_DPA_ERROR');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Заборонено розблокувати рахунок до отримання повідомлення про реєстрацію рахунку в ДПА', '', 1, 'ACCOUNT_BLK_DPA_ERROR');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Ошибка заполнения реквизита "Арешт рахунка Сума обтяження(в копiйках)"', '', 1, 'ACCOUNTSW_LIESUM_ERROR');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Помилка заповнення реквiзита "Арешт рахунка Сума обтяження(в копiйках)"', '', 1, 'ACCOUNTSW_LIESUM_ERROR');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Проверьте данные клиента, для К110 (Вид эк. деятельности)=N9420 обычно соответствует значение К050 (орг.-правовая ф-ма хоз.)=830, 835, 180 и 440', '', 1, 'K110_N9420_CORRESPONDS_K050');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Перевірте дані клієнта, для К110 (Вид ек. діяльності)=N9420 зазвичай відповідає значення К050 (Орг.-правова ф-ма госп.)=830, 835, 180 та 440', '', 1, 'K110_N9420_CORRESPONDS_K050');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'В карточке клиента не заполнен или неверно заполнен мобильный телефон', '', 1, 'ERROR_MPNO');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'В картці клієнта не заповнено або невірно заповнено мобільний телефон', '', 1, 'ERROR_MPNO');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Код блокирвоки 11. Необходимо заполнить поле "Мінімальний залишок"', '', 1, 'ERR_BLKD11');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Код блокування 11. Необхідно заповнити поле "Мінімальний залишок"', '', 1, 'ERR_BLKD11');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Код блокирвоки 11. Не найдена процентная карточка депозитного счета', '', 1, 'ERR_BLKD11_DPT');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Код блокування 11. Не знайдено процентної картки депозитного рахунку', '', 1, 'ERR_BLKD11_DPT');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Код блокирвоки 11. Не найдено предыдущее значение ставки в процентной карточке счета до частичного ареста', '', 1, 'ERR_BLKD11_DPT_PR');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Код блокування 11. Не знайдено попереднє значення ставки в процентній картці рахунку до часткового арешту', '', 1, 'ERR_BLKD11_DPT_PR');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Не заполнен реквизит ФМ "Разрешение ПЕП"', '', 1, 'ERR_EMPTY_PEP');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Не заповнено реквізит ФМ "Дозвіл ПЕП"', '', 1, 'ERR_EMPTY_PEP');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Установка тип связи "Родственик" запрещено, разрешается присоеденять зарегестрированых клиентов физ. лиц', '', 1, 'ERR_REL_FAMILY');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Встановлення типу зв`язку "Родич" заборонено, дозволяється приєднувати зареєстрованих клієнтів фіз. осіб', '', 1, 'ERR_REL_FAMILY');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'С 01.01.2017 изъято из справочников документов идентификации клиентов временное удостоверение, что удостоверяет лицо гражданина', '', 1, 'KL_PASSP_15');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'З 01.01.2017 вилучено з довідників документів ідентифікації клієнтів тимчасове посвідчення, що підтверджує особу громадянина', '', 1, 'KL_PASSP_15');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'У клиента есть незакрытые счета: %s', '', 1, 'OPEN_ACCOUNTS_EXISTS');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'У клієнта є незакриті рахунки: %s', '', 1, 'OPEN_ACCOUNTS_EXISTS');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '<b>Помилкове значення коду ВЕД </b><br/><br/>', '', 1, 'INCORRECT_VED');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '<b>Помилкове значення коду ВЕД </b><br/><br/>', '', 1, 'INCORRECT_VED');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '<b>Помилкове значення коду сектора економіки</b><br/><br/>', '', 1, 'INCORRECT_ISE');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '<b>Помилкове значення коду сектора економіки</b><br/><br/>', '', 1, 'INCORRECT_ISE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CAC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
