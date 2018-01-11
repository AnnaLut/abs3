PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль BPK ***
declare
  l_mod  varchar2(3) := 'BPK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'БПК', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Неверный тип счета для карточного счета', '', 1, 'INCORRECT_BPK_TIP');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Невірний тип рахунку для карткового рахунку', '', 1, 'INCORRECT_BPK_TIP');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Счета для закрытия блокированы другими пользователями. Выполните процедуру еще раз.', '', 1, 'LOCKED_ACCOUNT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Рахунки для закриття блоковані іншими користувачами. Виконайте процедуру ще раз.', '', 1, 'LOCKED_ACCOUNT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Ошибка оплаты документа: %s', '', 1, 'PAY_ERORR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Помилка оплати документа: %s', '', 1, 'PAY_ERORR');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Неизвестный файл для импорта: %s', '', 1, 'UNKNOWN_FILE_TO_IMPORT');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Невідомий файл для імпорту: %s', '', 1, 'UNKNOWN_FILE_TO_IMPORT');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найден транзитный счет для отделения %s для выполнения операции', '', 1, 'TRCASH_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдено транзитний рахунок для відділення %s для виконання операції', '', 1, 'TRCASH_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не указана группа технической визы для плановых операций!', '', 1, 'CHK_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не вказано групу технічної візи для планових операцій!', '', 1, 'CHK_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Для дополнительной проводки по транзакции %s допустимы только счета %s класса!', '', 1, 'ONLY_67_IN_TRANSIT');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Для додаткової проводки по транзакції %s допустимі тільки рахунки %s класу!', '', 1, 'ONLY_67_IN_TRANSIT');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Необходимо ввести счет 2924 для транзита!', '', 1, 'ONLY_2924_IN_TRANSIT');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Необхідно ввести рахунок 2924 для транзиту!', '', 1, 'ONLY_2924_IN_TRANSIT');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Запрещено выдавать пользователям %s группу визирования!', '', 1, 'BPK_CHK');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Заборонено видавати користувачам %s групу візування!', '', 1, 'BPK_CHK');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не указан транзитный счет для операции %s', '', 1, 'TRANSITACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Не вказано транзитний рахунок для операції %s', '', 1, 'TRANSITACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не заполнен обязательный реквизит файла: %s', '', 1, 'XML_TAG_EMPTY');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Не заповнено обов''язковий реквізит файлу: %s', '', 1, 'XML_TAG_EMPTY');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Счет не найден: %s (%s)', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Рахунок не знайдено: %s (%s)', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Счет %s (%s) зарегистрирован на другого клиента (РНК %s)', '', 1, 'ACC_REG_RNK');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Рахунок %s (%s) зареєстровано на іншого клієнта (РНК %s)', '', 1, 'ACC_REG_RNK');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Неверно указан БС для кредитного счета (%s)', '', 1, 'INCORRECT_NBS_OVR');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Невірно вказано БР для кредитного рахунку (%s)', '', 1, 'INCORRECT_NBS_OVR');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Неверно указан БС для счета неисп. лимита (%s)', '', 1, 'INCORRECT_NBS_9129');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Невірно вказано БР для рахунку невикористаного ліміту (%s)', '', 1, 'INCORRECT_NBS_9129');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Неверно указан БС для счета тех.овердрафта (%s)', '', 1, 'INCORRECT_NBS_TOVR');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Невірно вказано БР для рахунку тех.овердрафту (%s)', '', 1, 'INCORRECT_NBS_TOVR');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Неверно указан БС для счета комиссии (%s)', '', 1, 'INCORRECT_NBS_3570');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Невірно вказано БР для рахунку комісії (%s)', '', 1, 'INCORRECT_NBS_3570');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Неверно указан БС для счета нач.дох. за кредит (%s)', '', 1, 'INCORRECT_NBS_2208');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Невірно вказано БР для рахунку нарах.дох.за кредит (%s)', '', 1, 'INCORRECT_NBS_2208');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Не заполнен параметр <Наименование продукта>', '', 1, 'NAME_NOT_SET');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Не заповнено параметр <Назва продукту>', '', 1, 'NAME_NOT_SET');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не заполнен параметр <Тип карточки>', '', 1, 'TYPE_NOT_SET');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Не заповнено параметр <Тип картки>', '', 1, 'TYPE_NOT_SET');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не заполнен параметр <Валюта>', '', 1, 'KV_NOT_SET');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Не заповнено параметр <Валюта>', '', 1, 'KV_NOT_SET');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Не заполнен параметр <Категория клиента>', '', 1, 'KK_NOT_SET');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Не заповнено параметр <Категорія клієнта>', '', 1, 'KK_NOT_SET');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Не заполнен параметр <Код условия счета>', '', 1, 'CONDSET_NOT_SET');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Не заповнено параметр <Код умови рахунку>', '', 1, 'CONDSET_NOT_SET');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Не заполнен параметр <Балансовый счет>', '', 1, 'NBS_NOT_SET');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Не заповнено параметр <Балансовий рахунок>', '', 1, 'NBS_NOT_SET');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Не заполнен параметр <ОБ22>', '', 1, 'OB22_NOT_SET');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Не заповнено параметр <ОБ22>', '', 1, 'OB22_NOT_SET');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Не найдена карточная система', '', 1, 'CARDTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Не знайдено карткову систему', '', 1, 'CARDTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Для карточки %s нет кода условия %s', '', 1, 'CONDSET_CARDTYPE_INCORRECT');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Для картки %s не існує коду умови %s', '', 1, 'CONDSET_CARDTYPE_INCORRECT');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Для карточки %s и кода условия %s не соответствует код валюты %s', '', 1, 'CONDSET_KV_INCORRECT');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Для картки %s і коду умови %s не відповідає код валюти %s', '', 1, 'CONDSET_KV_INCORRECT');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Для карточки %s нет кода условия %s', '', 1, 'CONDSET_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Для картки %s не існує коду умови %s', '', 1, 'CONDSET_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Продукт с заданными параметрами уже существует', '', 1, 'DUBL_PRODUCT');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Продукт з вказаними параметрами вже існує', '', 1, 'DUBL_PRODUCT');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Пользователю отделения %s запрещено выполнять данную функцию', '', 1, 'EXEC_FUNCTION_DENIED');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Користувачу відділення %s заборонено виконувати дану функцію', '', 1, 'EXEC_FUNCTION_DENIED');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Ошибка импорта файла %s: %s', '', 1, 'REF_IMPORT_ERROR');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Помилка імпорту файлу %s: %s', '', 1, 'REF_IMPORT_ERROR');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Несоответствие типа клиента и выбранного продукта', '', 1, 'CTYPE_ERROR');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Невідповідність типу клієнта і вибраного продукту', '', 1, 'CTYPE_ERROR');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Договор %s не найден', '', 1, 'DEAL_NOT_FOUND');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Угоду %s не знайдено', '', 1, 'DEAL_NOT_FOUND');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Неверно указан БС для счета просроченной задолженности (%s)', '', 1, 'INCORRECT_NBS_DEBT');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Невірно вказано БР для рахунку простроченої заборгованості (%s)', '', 1, 'INCORRECT_NBS_DEBT');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Редактирование оплаченых документов запрещено!!!', '', 1, 'ALTBPK_EDIT_ERROR');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Редагування оплачених документів заборонено!!! ', '', 1, 'ALTBPK_EDIT_ERROR');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Удаление оплаченых документов запрещено!!!', '', 1, 'ALTBPK_DEL_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Видалення оплачених документів заборонено!!!', '', 1, 'ALTBPK_DEL_ERROR');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Длина назначения платежа максимум 160 символов, длина счета 14!!!', '', 1, 'ALTBPK_INS_ERROR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Довжина призначення платежу максимум 160 символів, довжина рахунку 14!!!', '', 1, 'ALTBPK_INS_ERROR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Счет ACC=%s не найден в портфеле БПК-Way4', '', 1, 'W4ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Рахунок ACC=%s не знайдено в портфелі БПК-Way4', '', 1, 'W4ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Для режима %s не найден счет ACC=%s', '', 1, 'MODEANDACC_NOT_FOUND');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Для режима %s не знайдено рахунок ACC=%s', '', 1, 'MODEANDACC_NOT_FOUND');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Неизвестный режим счета %s', '', 1, 'UNKNOWN_MODE');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Невідомий режим рахунку %s', '', 1, 'UNKNOWN_MODE');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Неизвестный тип карточки %s', '', 1, 'CARDCODE_NOT_FOUND');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Невідомий тип картки %s', '', 1, 'CARDCODE_NOT_FOUND');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не заполнены обязательные реквизиты клиента (РНК %s) / карточки: %s', '', 1, 'CUSTOMERPARAMS_ERROR');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не заповнено обов`язкові реквізити клієнта (РНК %s) / картки: %s', '', 1, 'CUSTOMERPARAMS_ERROR');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Не найден клиент RNK=%s', '', 1, 'CUSTOMER_NOT_FOUND');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Не знайдено клієнта RNK=%s', '', 1, 'CUSTOMER_NOT_FOUND');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Запрос %s не найден', '', 1, 'REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Запит %s не знайдено', '', 1, 'REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Запрос %s со статусом %s: переформирование невозможно', '', 1, 'REQUEST_REFORM_IMPOSSIBLE');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Запит %s зі статусом %s: переформування неможливе', '', 1, 'REQUEST_REFORM_IMPOSSIBLE');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'На запрос %s уже отправлен исправительный запрос %s', '', 1, 'REQUEST_YET_FORM');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'На запит %s вже відправлено виправний запит %s', '', 1, 'REQUEST_YET_FORM');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Не найден З/П проект с кодом %s', '', 1, 'PROECT_NOT_FOUND');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Не знайдено З/П проект з кодом %s', '', 1, 'PROECT_NOT_FOUND');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Запрос %s со статусом %s: удаление невозможно', '', 1, 'REQUEST_DELETE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Запит %s зі статусом %s: видалення неможливе', '', 1, 'REQUEST_DELETE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Некорректная серия документа', '', 1, 'PASSP_SERIES_ERROR');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Некоректна серія документу', '', 1, 'PASSP_SERIES_ERROR');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Некорректный номер документа', '', 1, 'PASSP_NUM_ERROR');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Некоректний номер документу', '', 1, 'PASSP_NUM_ERROR');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Счет %s/%s закрыт', '', 1, 'ACC_CLOSED');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Рахунок %s/%s закрито', '', 1, 'ACC_CLOSED');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Карточка еще не перевыпущена', '', 1, 'CARD_NOT_REOPEN_YET');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Картку ще не перевипущено', '', 1, 'CARD_NOT_REOPEN_YET');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Не совпадают валюты счетов старого и нового ПЦ', '', 1, 'KV_PKW4_ERROR');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Не співпадають валюти рахунків старого і нового ПЦ', '', 1, 'KV_PKW4_ERROR');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Карточка %s/%s уже перевыпущена', '', 1, 'CARD_ALREADY_REOPEN');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Картку %s/%s вже перевипущено', '', 1, 'CARD_ALREADY_REOPEN');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'На счете просрочки есть остаток, миграция карточки %s/%s невозможна', '', 1, 'DEBTACC_OST');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'На рахунку прострочки є залишок, міграція картки %s/%s неможлива', '', 1, 'DEBTACC_OST');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Запрос по счету %s с типом %s уже добавлен к передаче в CardMake %s', '', 1, 'REQUEST_OPERTYPE1');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Запит по рахунку %s з типом %s вже додано до передачі в CardMake %s', '', 1, 'REQUEST_OPERTYPE1');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Запрос по счету %s с типом %s уже обрабатывается в CardMake %s', '', 1, 'REQUEST_OPERTYPE2');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, 'Запит по рахунку %s з типом %s вже обробляэться в CardMake %s', '', 1, 'REQUEST_OPERTYPE2');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Запрос по счету %s с типом %s уже успешно обработан в CardMake %s', '', 1, 'REQUEST_OPERTYPE3');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, 'Запит по рахунку %s з типом %s вже успішно оброблено %s', '', 1, 'REQUEST_OPERTYPE3');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Настроен маршрут создания карточек через Way4', '', 1, 'W4LC_0');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, 'Налаштовано маршрут створення карток через Way4', '', 1, 'W4LC_0');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Настроен маршрут создания карточек через CardMake', '', 1, 'W4LC_1');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, 'Налаштовано маршрут створення карток через CardMake', '', 1, 'W4LC_1');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Контроль на дебетовое сальдо: запрещено проведение операции', '', 1, 'CHECK_DEBIT_BALANCE');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, 'Контроль на дебетове сальдо: заборонено проведення операції', '', 1, 'CHECK_DEBIT_BALANCE');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Указанный срок действия карты не соответствует типу карты или продукта', '', 1, 'TERM_ERROR');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, 'Вказаний срок дії картки не відповідає типу картки чи продукту', '', 1, 'TERM_ERROR');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Валюта счета не совпадает с валютой карточки', '', 1, 'KVACC_KVCARD_ERROR');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, 'Валюта рахунку не співпадає з валютою картки', '', 1, 'KVACC_KVCARD_ERROR');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, 'БС не совпадает с БС карточки', '', 1, 'NBSACC_NBSCARD_ERROR');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'БР не співпадає з БР картки', '', 1, 'NBSACC_NBSCARD_ERROR');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Некорректный формат даты для поля <%s> (РНК %s)', '', 1, 'FORMAT_DATE_ERROR');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Некоректний формат дати для поля <%s> (РНК %s)', '', 1, 'FORMAT_DATE_ERROR');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Недопустимый тип карты %s для З/П проекта %s/%s/%s', '', 1, 'UNCURRECT_SALARY_CARD');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Недопустимий тип карти %s для З/П проекту %s/%s/%s', '', 1, 'UNCURRECT_SALARY_CARD');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, 'Тип карты Instant не совпадает с типом карты', '', 1, 'SUBCARDACC_SUBCARDCARD_ERROR');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, 'Тип карти Instant не співапдає з типом картки', '', 1, 'SUBCARDACC_SUBCARDCARD_ERROR');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, 'Отсутствует дата выдачи карты держателю по счету %s', '', 1, 'IDAT_NOT_FOUND');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, 'Відсутня дата видачі карти держателю по рахунку %s', '', 1, 'IDAT_NOT_FOUND');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, 'Не найдена карта %s', '', 1, 'CARD_NOT_FOUND');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, 'Не знайдено карту %s', '', 1, 'CARD_NOT_FOUND');

    bars_error.add_message(l_mod, 80, l_exc, l_rus, 'Договор с номером %s уже зарегистрирован', '', 1, 'AGR_DUPVAL');
    bars_error.add_message(l_mod, 80, l_exc, l_ukr, 'Угоду з номером %s вже зареєстровано', '', 1, 'AGR_DUPVAL');

    bars_error.add_message(l_mod, 81, l_exc, l_rus, 'Номера телефона для отсылки SMS должен быть в формате +380ZZXXXYYPP', '', 1, 'SMS_PHONE_INVALID');
    bars_error.add_message(l_mod, 81, l_exc, l_ukr, 'Номер телефона для відправки SMS повинен бути в форматі +380ZZXXXYYPP', '', 1, 'SMS_PHONE_INVALID');

    bars_error.add_message(l_mod, 82, l_exc, l_rus, 'Не заполнено имя', '', 1, 'FNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 82, l_exc, l_ukr, 'Не заповнено ім"я', '', 1, 'FNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 83, l_exc, l_rus, 'Не заполнена фамилия', '', 1, 'LNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 83, l_exc, l_ukr, 'Не заповнено прізвище', '', 1, 'LNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 84, l_exc, l_rus, 'Не заполнено отчество', '', 1, 'MNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 84, l_exc, l_ukr, 'Не заповнено по-батькові', '', 1, 'MNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 85, l_exc, l_rus, 'Не заполнено имя латиницей', '', 1, 'FNAME_LAT_NOT_FOUND');
    bars_error.add_message(l_mod, 85, l_exc, l_ukr, 'Не заповнено ім"я латиницею', '', 1, 'FNAME_LAT_NOT_FOUND');

    bars_error.add_message(l_mod, 86, l_exc, l_rus, 'Не заполнена фамилия латиницей', '', 1, 'LNAME_LAT_NOT_FOUND');
    bars_error.add_message(l_mod, 86, l_exc, l_ukr, 'Не заповнено прізвище латиницею', '', 1, 'LNAME_LAT_NOT_FOUND');

    bars_error.add_message(l_mod, 87, l_exc, l_rus, 'Не заполнено ОКПО', '', 1, 'OKPO_NOT_FOUND');
    bars_error.add_message(l_mod, 87, l_exc, l_ukr, 'Не заповнено ОКПО', '', 1, 'OKPO_NOT_FOUND');

    bars_error.add_message(l_mod, 88, l_exc, l_rus, 'Не заполнено тип документа', '', 1, 'DOCTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 88, l_exc, l_ukr, 'Не заповнено тип документу', '', 1, 'DOCTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 89, l_exc, l_rus, 'Не заполнено серию документа', '', 1, 'PASP_SER_NOT_FOUND');
    bars_error.add_message(l_mod, 89, l_exc, l_ukr, 'Не заповнено серію документу', '', 1, 'PASP_SER_NOT_FOUND');

    bars_error.add_message(l_mod, 90, l_exc, l_rus, 'Не заполнено номер документа', '', 1, 'PASP_NUM_NOT_FOUND');
    bars_error.add_message(l_mod, 90, l_exc, l_ukr, 'Не заповнено номер документу', '', 1, 'PASP_NUM_NOT_FOUND');

    bars_error.add_message(l_mod, 91, l_exc, l_rus, 'Не заполнено орган который выдал документ', '', 1, 'PASP_ORG_NOT_FOUND');
    bars_error.add_message(l_mod, 91, l_exc, l_ukr, 'Не заповнено орган що видав документ', '', 1, 'PASP_ORG_NOT_FOUND');

    bars_error.add_message(l_mod, 92, l_exc, l_rus, 'Не заполнена дата выдачи документа', '', 1, 'PASP_DATE_NOT_FOUND');
    bars_error.add_message(l_mod, 92, l_exc, l_ukr, 'Не заповнено дату видачі документу', '', 1, 'PASP_DATE_NOT_FOUND');

    bars_error.add_message(l_mod, 93, l_exc, l_rus, 'Не заполнена дата рождения', '', 1, 'BDAY_NOT_FOUND');
    bars_error.add_message(l_mod, 93, l_exc, l_ukr, 'Не заповнено дату народження', '', 1, 'BDAY_NOT_FOUND');

    bars_error.add_message(l_mod, 94, l_exc, l_rus, 'Не заполнено место рождения', '', 1, 'BPLACE_NOT_FOUND');
    bars_error.add_message(l_mod, 94, l_exc, l_ukr, 'Не заповнено місце народження', '', 1, 'BPLACE_NOT_FOUND');

    bars_error.add_message(l_mod, 95, l_exc, l_rus, 'Не заполнено индекс', '', 1, 'ADRCODE_NOT_FOUND');
    bars_error.add_message(l_mod, 95, l_exc, l_ukr, 'Не заповнено індекс', '', 1, 'ADRCODE_NOT_FOUND');

    bars_error.add_message(l_mod, 96, l_exc, l_rus, 'Не заполнено область', '', 1, 'ADRDOMAIN_NOT_FOUND');
    bars_error.add_message(l_mod, 96, l_exc, l_ukr, 'Не заповнено область', '', 1, 'ADRDOMAIN_NOT_FOUND');

    bars_error.add_message(l_mod, 97, l_exc, l_rus, 'Не заполнено район', '', 1, 'ADRREGION_NOT_FOUND');
    bars_error.add_message(l_mod, 97, l_exc, l_ukr, 'Не заповнено район', '', 1, 'ADRREGION_NOT_FOUND');

    bars_error.add_message(l_mod, 98, l_exc, l_rus, 'Не заполнено населенный пункт', '', 1, 'ADRCITY_NOT_FOUND');
    bars_error.add_message(l_mod, 98, l_exc, l_ukr, 'Не заповнено населений пункт', '', 1, 'ADRCITY_NOT_FOUND');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, 'Не заполнено улица,дом,квартира', '', 1, 'ADRSTREET_NOT_FOUND');
    bars_error.add_message(l_mod, 99, l_exc, l_ukr, 'Не заповнено вулиця, будинок, квартира', '', 1, 'ADRSTREET_NOT_FOUND');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Запрос %s по счету Instant: формирование запроса другого типа невозможно', '', 1, 'REQUEST_INSTREFORM_IMPOSSIBLE');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Запит %s по рахунку Instant: формування запиту іншого типу неможливе', '', 1, 'REQUEST_INSTREFORM_IMPOSSIBLE');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Запрос %s по счету Instant: удаление невозможно', '', 1, 'REQUEST_INSTDELETE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Запит %s по рахунку Instant: видалення неможливе', '', 1, 'REQUEST_INSTDELETE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'По счету %s есть несквитованные заявки, необходимо сквитовать ранее созданные заявки', '', 1, 'REQUEST_STATUS2');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'По рахунку %s є несквитовані заявки, для продовження рекомендуємо сквитувати раніше створені заявки', '', 1, 'REQUEST_STATUS2');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, 'Невозможно удалить файл %s: есть оплаченные документы по файлу.', '', 1, 'IMPOSSIBLE_DELETE_FILE');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, 'Неможливо видалити файл %s: є оплачені документи по файлу.', '', 1, 'IMPOSSIBLE_DELETE_FILE');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Пароль для Карты киевлянина должен отличаться от пароля карты', '', 1, 'KK_SECRET_WORD_PIND_ERROR');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Таємне слово для Картки киянина має відрізнятися від таємного слова картки', '', 1, 'KK_SECRET_WORD_PIND_ERROR');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Запрещен выпуск именных карт по субпродукту %s', '', 1, 'FLAGINSTANT_ERROR');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Заборонено випуск іменних карток по субпродукту %s', '', 1, 'FLAGINSTANT_ERROR');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Запрещено выполнение операций по счетам мобильных сбережений!', '', 1, 'ERROR_NLS2625D_PAY');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Заборонено виконання операцій по рахунках мобільних заощаджень!', '', 1, 'ERROR_NLS2625D_PAY');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, 'Запрещено формировать запрос с типом %s для карт %s', '', 1, 'REQUEST_TYPE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, 'Заборонено формувати запит з типом %s для карт %s', '', 1, 'REQUEST_TYPE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, 'Клиенту РНК %s уже открыта Карта киевлянина', '', 1, 'KK_ALREADY_OPEN');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, 'Клієнту РНК %s вже відкрито Карту киянина', '', 1, 'KK_ALREADY_OPEN');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '%s содержит символы отличающиеся от: %s', '', 1, 'KK_FORBIDDEN_CHARACTERS');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '%s містить символи відмінні від: %s', '', 1, 'KK_FORBIDDEN_CHARACTERS');

    bars_error.add_message(l_mod, 200, l_exc, l_rus, 'Не найден файл', '', 1, 'FILE_NOT_FOUND');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, 'Не знайдений файл', '', 1, 'FILE_NOT_FOUND');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
