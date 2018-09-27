PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ZAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль ZAY ***
declare
  l_mod  varchar2(3) := 'ZAY';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Биржевые операции', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не найдена операция %s', '', 1, 'TT_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не знайдена операція %s', '', 1, 'TT_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Не описан транзитный счет Фронт-офиса (2900)', '', 1, 'ACC29_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Не описаний транзитний рахунок Фронт-офісу (2900)', '', 1, 'ACC29_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не описан транзитный счет Бэк-офиса (1819)', '', 1, 'ACC18_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не описаний транзитний рахунок Бек-офісу (1819)', '', 1, 'ACC18_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Счет %s / %s не существует или закрыт', '', 1, 'ACC_DOESNT_EXIST');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Рахунок %s / %s не існує або закритий', '', 1, 'ACC_DOESNT_EXIST');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найдены транз.счета 2900/1819', '', 1, 'TRANSIT_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдені транз.рах. 2900/1819', '', 1, 'TRANSIT_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не найдена заявка № %s', '', 1, 'ZAY_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не знайдена заявка № %s', '', 1, 'ZAY_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Запрещено формирование пакета документов по заявке № %s(статус заявки %s)', '', 1, 'INVALID_STATUS');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Заборонено формування пакету документів по заявці № %s (статус заявки %s)', '', 1, 'INVALID_STATUS');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Запрещено формирование пакета документов по форвардной заявке № %s(дата валютир.%s)', '', 1, 'INVALID_VALUEDATE');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Заборонено формування пакету документів по форвардній заявці № %s(дата валютув.%s)', '', 1, 'INVALID_VALUEDATE');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Не найдена валюта с кодом %s', '', 1, 'CUR_NOT_FOUND');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Не знайдена валюта з кодом %s', '', 1, 'CUR_NOT_FOUND');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не найден внутрибанковский счет из карточки операции %s в валюте %s', '', 1, 'TTSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Не знайдений внутрішньобанк.рахунок з картки операції %s в валюті %s', '', 1, 'TTSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Для заявки № %s не найден торговый счет клиента в валюте %s (acc = %s)', '', 1, 'CUST_TRDACC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Для заявки № %s не знайдений торговий рахунок клієнта в валюті %s (acc = %s)', '', 1, 'CUST_TRDACC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Для заявки № %s не найден расчетный счет клиента в валюте %s (acc = %s)', '', 1, 'CUST_CURTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Для заявки № %s не знайдений розрахунк.рахунок клієнта в валюті %s (acc = %s)', '', 1, 'CUST_CURTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Для заявки № %s не найден транз.счет клиента %s в нац. вал. для отчисления в Пенс.Фонд', '', 1, 'CUST_TAXTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Для заявки № %s не знайдений транз.рахунок клієнта %s в нац.вал.для відрахування в Пенс.Фонд', '', 1, 'CUST_TAXTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Для заявки № %s не найден счет клиента для списания комиссии (nls = %s)', '', 1, 'CUST_CMSTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Для заявки № %s не знайдений рахунок клієнта для списання комісії (nls = %s)', '', 1, 'CUST_CMSTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Ошибка оплаты документа (дебет %s кредит %s на сумму %s/%s, код операции %s): %s', '', 1, 'PAYDOC_FAILED');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Помилка сплати документу (дебет %s кредит %s на суму %s/%s, код операції %s): %s', '', 1, 'PAYDOC_FAILED');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Ошибка записи доп.реквизита %s для документа %s: %s', '', 1, 'INS_DOCPARAM_FAILED');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Помилка запису дод.реквізиту %s для документу %s: %s', '', 1, 'INS_DOCPARAM_FAILED');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Ошибка формирования пакета документов для заявки на покупку валюты № %s: %s', '', 1, 'PAYBUY_FAILED');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Помилка формування пакету документів для заявки на купівлю валюти № %s: %s', '', 1, 'PAYBUY_FAILED');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Ошибка формирования пакета документов для заявки на продажу валюты № %s: %s', '', 1, 'PAYSEL_FAILED');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Помилка формування пакету документів для заявки на продажу валюти № %s: %s', '', 1, 'PAYSEL_FAILED');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Ошибка при создании заявки: %s', '', 1, 'CREATE_REQUEST_FAILED');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Помилка при створенні заявки: %s', '', 1, 'CREATE_REQUEST_FAILED');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Валюта %s заблокирована Дилером', '', 1, 'KV_BLOCKED');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Валюта %s заблокована Дилером', '', 1, 'KV_BLOCKED');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не указана сумма заявки %s', '', 1, 'SUM_NULL');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Не вказана сума заявки %s', '', 1, 'SUM_NULL');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не указана дата заявки %s', '', 1, 'DAT_NULL');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не вказана дата заявки %s', '', 1, 'DAT_NULL');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не указан курс заявки %s', '', 1, 'RATE_NULL');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Не вказаний курс заявки %s', '', 1, 'RATE_NULL');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Введені суми не спідпадають з сумою заявки %s', '', 1, 'SUM_NOT_S2');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Заявка %s завізована. Зміна параметрів неможлива!', '', 1, 'UPD_FAILED_VIZA');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Не знайдений торговий рахунок %s клієнта в обраній валюті!', '', 1, 'UPD_FAILED_TR');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Не знайдений розрахунковий рахунок %s клієнта в валюті %s!', '', 1, 'UPD_FAILED_RR');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Дата заявки %s застаріла!', '', 1, 'CREATE_REQUEST_OLDDAT');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Невірний рахунок %s для МФО %s', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не визнечений сегмент клієнта %s', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Не заданий рахунок прибутків для комісії для сегменту %s', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Не указана цель заявки %s', '', 1, 'META_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Не вказана мета заявки %s', '', 1, 'META_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Не указана основание покупки заявки %s', '', 1, 'BASIS_NULL');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Не вказана підстава купівлі заявки %s', '', 1, 'BASIS_NULL');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Не указана код товарной группы заявки %s', '', 1, 'PROD_NULL');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Не вказана код товарної групи заявки %s', '', 1, 'PROD_NULL');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Для заявки № %s не найден счет 3570 клиента', '', 1, 'CUST_3570ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Для заявки № %s не знайдений рахунок 3570 клієнта', '', 1, 'CUST_3570ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Для заявки № %s не указан счет 3570 клиента для р/с %s(%s)', '', 1, 'CUST_3570ACC_NOT_REGISTERED');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Для заявки № %s не вказаний рахунок 3570 клієнта для р/р %s(%s)', '', 1, 'CUST_3570ACC_NOT_REGISTERED');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Для заявки № %s некорректно указан счет 3570 клиента для р/с %s(%s)', '', 1, 'CUST_3570ACC_ERR_REGISTERED');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Для заявки № %s некоректно вказаний рахунок 3570 клієнта для р/р %s(%s)', '', 1, 'CUST_3570ACC_ERR_REGISTERED');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Для заявки № %s не найден счет 3578 клиента', '', 1, 'CUST_3578ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Для заявки № %s не знайдений рахунок 3578 клієнта', '', 1, 'CUST_3578ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Для заявки № %s не найден однозначно счет 3578 клиента', '', 1, 'CUST_3578ACC_ONE_NOT_FOUND');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Для заявки № %s не знайдений єдиний рахунок 3578 клієнта', '', 1, 'CUST_3578ACC_ONE_NOT_FOUND');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Валюта покупки и продажи заявки на конверсию %s совпадают!', '', 1, 'CURVAL_IDENT');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Валюта купівлі та продажу заявки на конверсію %s співпадають!', '', 1, 'CURVAL_IDENT');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Для заявки № %s не найден заполненный в параметрах счет клиента для списания в ПФ (nls = %s)', '', 1, 'CUST_PFACC_NOT_FOUND');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Для заявки № %s не знайдений заповнений в параметрах рахунок клієнта для списання в ПФ (nls = %s)', '', 1, 'CUST_PFACC_NOT_FOUND');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Запрещено формирование документа списания по заявке № %s', '', 1, 'INVALID_STATUS_SPS');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Заборонено формування документу списання по заявці № %s', '', 1, 'INVALID_STATUS_SPS');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Недопустимое значение Коду купівлі за імпортом (#2C) %s для заявки %s', '', 1, 'ERROR_CODE_2C');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Неприпустиме значення Коду купівлі за імпортом (#2C) %s для заявки %s', '', 1, 'ERROR_CODE_2C');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'ВНИМАНИЕ! К клиенту применены санкции! (заявка %s)', '', 1, 'KL_SANCTION');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'УВАГА! До клієнта застосовано санкції! (заявка %s)', '', 1, 'KL_SANCTION');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Отсутствуют подтверждающие документы в банке!', '', 1, 'ERROR_SUP_DOCS');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Відсутні підтверджуючі документи в банку!', '', 1, 'ERROR_SUP_DOCS');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Не указан № контракта заявки %s', '', 1, 'CONTRACT_NULL');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Не вказано № контракта заявки %s', '', 1, 'CONTRACT_NULL');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Не указана дата контракта заявки %s', '', 1, 'DAT2_VMD_NULL');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Не вказана дата контракта заявки %s', '', 1, 'DAT2_VMD_NULL');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Не указана страна перечисления валюты заявки %s', '', 1, 'COUNTRY_NULL');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Не вказана держава перерахування валюти заявки %s', '', 1, 'COUNTRY_NULL');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не указана страна бенефециара заявки %s', '', 1, 'BENEFCOUNTRY_NULL');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не вказана держава бенефіціара заявки %s', '', 1, 'BENEFCOUNTRY_NULL');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Не указан код иностранного банка заявки %s', '', 1, 'BANK_CODE_NULL');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Не вказано код іноземного банка заявки %s', '', 1, 'BANK_CODE_NULL');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Не указано наименование иностранного банка заявки %s', '', 1, 'BANK_NAME_NULL');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Не вказано назву іноземного банка заявки %s', '', 1, 'BANK_NAME_NULL');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не указан код покупки за импортом #2C заявки %s', '', 1, 'CODE_2C_NULL');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не вказано код купівлі за імпортом #2C заявки %s', '', 1, 'CODE_2C_NULL');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Не указана ознака операции #2C заявки %s', '', 1, 'P12_2C_NULL');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Не вказано ознаку операції #2C заявки %s', '', 1, 'P12_2C_NULL');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Запрещено удовлетворять заявки в РУ!', '', 1, 'FAILED_SET_SOS');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Заборонено задовольняти заявки в РУ!', '', 1, 'FAILED_SET_SOS');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Не заполнен фактический курс дилера или дата валютирования заявки %s', '', 1, 'FAILED_KURSF_OR_VDATE');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Не вказано фактичний курс дилера або дату валютування заявки %s', '', 1, 'FAILED_KURSF_OR_VDATE');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Ошибка удовлетворения заявки дилером, заявку %s необходимо завизировать!', '', 1, 'PRIORVERIFY_FAILED');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Помилка задоволенння заявки дилером, заявку %s необхідно завізувати!', '', 1, 'PRIORVERIFY_FAILED');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Значение тэга - D1#70 должно соотвтетсвовать коду из Справочника целей покупки-продажи валюты', '', 1, 'FK_ZAYAVKA_ZAYAIMS');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Значення тега - D1#70 повинно відповідати коду із Довідника цілей покупки-продажу валюти', '', 1, 'FK_ZAYAVKA_ZAYAIMS');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Значение тэгов - D6#70/D8#70 должно соотвтетсвовать коду из Справочника стран-эмитентов валют', '', 1, 'XFK_ZAYAVKA_COUNTRY');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Значення тегів - D6#70/D8#70 повинно відповідати коду із Довідника країн-емітентів валюти', '', 1, 'XFK_ZAYAVKA_COUNTRY');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Значение тэга - DB#70 должно соотвтетсвовать коду из Справочника кодов товарных групп', '', 1, 'FK_ZAYAVKA_PRODUCT_GROUP');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Значення тега - DB#70 повинно відповідати коду із Довідника кодів товарних груп', '', 1, 'FK_ZAYAVKA_PRODUCT_GROUP');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Заявка № %s не завизирована дилером. Списание средств невозможно!');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Заявка № %s не завізована ділером. Списання коштів неможливе!');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'По заявке № %s списание средств произведено (документ REF=%s). Повторное списание средств запрещено!');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'По заявці № %s списання коштів виконано (документ REF=%s). Повторне списання коштів заборонено!');


  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ZAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 
