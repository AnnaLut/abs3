PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль DOC ***
declare
  l_mod  varchar2(3) := 'DOC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Оплата документов', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Document not found: REF=%s', '', 1, 'REF_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Документ не найден: REF=%s', '', 1, 'REF_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Документ не знайдено: REF=%s', '', 1, 'REF_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Day closed! Impossible execute operation!', '', 1, 'DAY_IS_CLOSED');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'День закрыт! Невозможно выполнить операцию!', '', 1, 'DAY_IS_CLOSED');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Банківський День закрито! Неможливо виконати операцію!', '', 1, 'DAY_IS_CLOSED');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Document on closed bank date: DAT=%s', '', 1, 'DOC_CLOSED_DAY');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Документ за закрытую банковскую дату: DAT=%s', '', 1, 'DOC_CLOSED_DAY');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Документ за закриту банківську дату: DAT=%s', '', 1, 'DOC_CLOSED_DAY');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Impossible BACK document: sent from bank in file %s', '', 1, 'BACK_FNB');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Нельзя ИЗЪЯТЬ документ: отправлен из банка в файле %s', '', 1, 'BACK_FNB');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Неможливо ВИЛУЧИТИ документ: відправлено з банку в файлі %s', '', 1, 'BACK_FNB');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible BACK document: sent to ODB', '', 1, 'BACK_ODB');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Нельзя ИЗЪЯТЬ документ: ПЕРЕДАН В ОДБ', '', 1, 'BACK_ODB');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Неможливо ВИЛУЧИТИ: ПЕРЕДАНО В ОДБ', '', 1, 'BACK_ODB');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible BACK subdocument REF=%s', '', 1, 'BACK_REFL');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Нельзя ИЗЪЯТЬ дочерний документ REF=%s', '', 1, 'BACK_REFL');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Неможливо ВИЛУЧИТИ дочірній документ REF=%s', '', 1, 'BACK_REFL');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Impossible BACK document: REF=%s - sent on ANELIC', '', 1, 'BACK_ANELIC');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Нельзя ИЗЪЯТЬ документ: REF=%s - отправлен по АНЕЛИК', '', 1, 'BACK_ANELIC');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Неможливо ВИЛУЧИТИ документ: REF=%s - відправлено по АНЕЛИК', '', 1, 'BACK_ANELIC');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Модификация реквизита ND (Номер документа) запрещена системой. Документ подписан.', '', 1, 'GUARD_ND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Модифікацію реквізиту ND (Номер документу) заборонено системою. Документ підписано.', '', 1, 'GUARD_ND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Модификация реквизита DATD (Дата документа) запрещена системой. Документ подписан.', '', 1, 'GUARD_DATD');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Модифікацію реквізиту DATD (Дата документу) заборонено системою. Документ підписано.', '', 1, 'GUARD_DATD');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Модификация реквизита VOB (Вид документа) запрещена системой. Документ подписан.', '', 1, 'GUARD_VOB');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Модифікацію реквізиту VOB (Вид документу) заборонено системою. Документ підписано.', '', 1, 'GUARD_VOB');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Модификация реквизита DK (Признак дебет/кредит) запрещена системой. Документ подписан.', '', 1, 'GUARD_DK');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Модифікацію реквізиту DK (Ознака дебет/кредит) заборонено системою. Документ підписано.', '', 1, 'GUARD_DK');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Модификация реквизита MFOA (МФО отправителя) запрещена системой. Документ подписан.', '', 1, 'GUARD_MFOA');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Модифікацію реквізиту MFOA (МФО відправника) заборонено системою. Документ підписано.', '', 1, 'GUARD_MFOA');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Модификация реквизита NLSA (Счет отправителя) запрещена системой. Документ подписан.', '', 1, 'GUARD_NLSA');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Модифікацію реквізиту NLSA (Рахунок відправника) заборонено системою. Документ підписано.', '', 1, 'GUARD_NLSA');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Модификация реквизита KV (Валюта А) запрещена системой. Документ подписан.', '', 1, 'GUARD_KV');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Модифікацію реквізиту KV (Валюта А) заборонено системою. Документ підписано.', '', 1, 'GUARD_KV');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Модификация реквизита S (Сумма) запрещена системой. Документ подписан.', '', 1, 'GUARD_S');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Модифікацію реквізиту S (Сума) заборонено системою. Документ підписано.', '', 1, 'GUARD_S');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Модификация реквизита MFOB (МФО получателя) запрещена системой. Документ подписан.', '', 1, 'GUARD_MFOB');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Модифікацію реквізиту MFOB (МФО отримувача) заборонено системою. Документ підписано.', '', 1, 'GUARD_MFOB');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Модификация реквизита NLSB (Счет получателя) запрещена системой. Документ подписан.', '', 1, 'GUARD_NLSB');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Модифікацію реквізиту NLSB (Рахунок отримувача) заборонено системою. Документ підписано.', '', 1, 'GUARD_NLSB');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Модификация реквизита KV2 (Валюта Б) запрещена системой. Документ подписан.', '', 1, 'GUARD_KV2');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Модифікацію реквізиту KV2 (Валюта Б) заборонено системою. Документ підписано.', '', 1, 'GUARD_KV2');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Модификация реквизита S2 (Сумма 2) запрещена системой. Документ подписан.', '', 1, 'GUARD_S2');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Модифікацію реквізиту S2 (Сума 2) заборонено системою. Документ підписано.', '', 1, 'GUARD_S2');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Модификация реквизита NAZN (Назначение платежа) запрещена системой. Документ подписан.', '', 1, 'GUARD_NAZN');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Модифікацію реквізиту NAZN (Призначення платежу) заборонено системою. Документ підписано.', '', 1, 'GUARD_NAZN');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'ФИНАНСОВЫЙ МОНИТОРИНГ: оплата документа $(REF) приостановлена!', '', 1, 'FM_STOPVISA');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'ФІНАНСОВИЙ МОНІТОРИНГ: оплата документа $(REF) припинена!', '', 1, 'FM_STOPVISA');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'EVAL_OP_FIELD: Доп. реквизит %s в операции %s отсутствует!', '', 1, 'OP_RULES_NOT_FOUND');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'EVAL_OP_FIELD: Дод. реквізит %s в операції %s відсутній!', '', 1, 'OP_RULES_NOT_FOUND');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'EVAL_OP_FIELD: Доп. реквизит %s не найден!', '', 1, 'OP_FIELD_NOT_FOUND');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'EVAL_OP_FIELD: Дод. реквізит %s не знайдено!', '', 1, 'OP_FIELD_NOT_FOUND');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'EVAL_OP_FIELD: Не задан параметр для вычисления значения доп. реквизита %s в операции %s!', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'EVAL_OP_FIELD: Не задано параметр для обчислення значення дод. реквізиту %s в операції %s!', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'EVAL_OP_FIELD: Не найдено значения доп. реквизита %s в операции %s!', '', 1, 'OP_FIELD_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'EVAL_OP_FIELD: Не знайдено значення дод. реквізиту %s в операції %s!', '', 1, 'OP_FIELD_NO_DATA_FOUND');

    bars_error.add_message(l_mod, 26, l_exc, l_eng, 'Transaction ''%s'' does not exist', 'Contact to administrator', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_geo, 'Transaction ''%s'' does not exist', 'Contact to administrator', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Операция ''%s'' не существует', 'Обратитесь к администратору АБС', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Операція ''%s'' не існує', 'Зверніться до адміністратора АБС', 1, 'TRANSACTION_DOES_NOT_EXIST');

    bars_error.add_message(l_mod, 27, l_exc, l_eng, 'Transaction ''%s'' not allowed', 'Contact to administrator', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_geo, 'Transaction ''%s'' not allowed', 'Contact to administrator', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Операция ''%s'' не разрешена', 'Обратитесь к администратору АБС', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Операція ''%s'' не дозволена', 'Зверніться до адміністратора АБС', 1, 'TRANSACTION_NOT_ALLOWED');

    bars_error.add_message(l_mod, 28, l_exc, l_eng, 'Tag ''%s'' not allowed', 'Contact to administrator', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_geo, 'Tag ''%s'' not allowed', 'Contact to administrator', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Тег ''%s'' не найден', 'Обратитесь к администратору АБС', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Тег ''%s'' не знайдено', 'Зверніться до адміністратора АБС', 1, 'TAG_NOT_FOUND');

    bars_error.add_message(l_mod, 29, l_exc, l_eng, 'The value of tag ''%s'' is incorrect', 'Type correct tag value', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_geo, 'The value of tag ''%s'' is incorrect', 'Type correct tag value', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Значение реквизита ''%s'' указано некорректно', 'Укажите корректное значение реквизита', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Значення реквізиту ''%s'' вказано некоректно', 'Вкажіть коректне значення реквізиту', 1, 'TAG_INVALID_VALUE');

    bars_error.add_message(l_mod, 30, l_exc, l_eng, 'Cleared pay of SEP transaction ''%s'' without visa is denied', 'Contact to administrator', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_geo, 'Cleared pay of SEP transaction ''%s'' without visa is denied', 'Contact to administrator', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Фактическая оплата операции СЭП ''%s'' без виз запрещена', 'Обратитесь к администратору АБС', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Фактична оплата операції СЕП ''%s'' без віз заборонена', 'Зверніться до адміністратора АБС', 1, 'SEP_TRANS_VISA_REQ');

    bars_error.add_message(l_mod, 31, l_exc, l_eng, 'Mandatory tag ''%s'' is absent for transaction ''%s''', 'Contact to administrator', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_geo, 'Mandatory tag ''%s'' is absent for transaction ''%s''', 'Contact to administrator', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Отсутствует обязательный реквизит ''%s'' для операции ''%s''', 'Обратитесь к администратору АБС', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Відсутній обов''язковий реквізит ''%s'' для операції ''%s''', 'Зверніться до адміністратора АБС', 1, 'MANDATORY_TAG_ABSENT');

    bars_error.add_message(l_mod, 32, l_exc, l_eng, 'Card account is incorrect!', '', 1, 'UNCORRECT_CARD_ACCT');
    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Неверно указан технический счет!', '', 1, 'UNCORRECT_CARD_ACCT');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Невірно вказано технічний рахунок!', '', 1, 'UNCORRECT_CARD_ACCT');

    bars_error.add_message(l_mod, 33, l_exc, l_geo, 'Unable to back backed document ref# %s', '', 1, 'BACK_BACK');
    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Попытка повторной операции СТОРНО реф № %s', '', 1, 'BACK_BACK');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Спроба повторного СТОРНО реф № %s', '', 1, 'BACK_BACK');

    bars_error.add_message(l_mod, 34, l_exc, l_geo, 'Unable to back document on past bank day', '', 1, 'PAST_DAY');
    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Невозможно сторнировать документ прошлой банковской датой', '', 1, 'PAST_DAY');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Неможливо сторнувати документ банківською датою, що минула', '', 1, 'PAST_DAY');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Неверное значение доп.реквизита %s - должно быть ЧИСЛО', '', 1, 'VALUE_NOT_NUMBER');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Невірне значення дод.реквізиту %s - повинно бути ЧИСЛО', '', 1, 'VALUE_NOT_NUMBER');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Неверное значение доп.реквизита %s - должна быть ДАТА', '', 1, 'VALUE_NOT_DATE');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Невірне значення дод.реквізиту %s - повинна бути ДАТА', '', 1, 'VALUE_NOT_DATE');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Документ можно сторнировать только пользователем, который его ввел!', '', 1, 'REF_STORNOUSER');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Документ можна сторнувати тільки користувачем, що його ввів!', '', 1, 'REF_STORNOUSER');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Неверное значение доп.реквизита %s - должно быть DECIMAL', '', 1, 'VALUE_NOT_DECIMAL');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Невірне значення дод.реквізиту %s - повинно бути DECIMAL', '', 1, 'VALUE_NOT_DECIMAL');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Нельзя ИЗЪЯТЬ документ %s посылки по скупке, используйте функцию расформирования посылки', '', 1, 'BACK_LOM');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Неможливо ВИЛУЧИТИ документ %s посилки по скупці, використовуйте функцію розформування посилки', '', 1, 'BACK_LOM');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Отсутствует доп. реквизит PFU!!!', '', 1, 'PFU_NOT_FOUND');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Відсутній доп. реквізит PFU!!!', '', 1, 'PFU_NOT_FOUND');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Доп. реквизит PFU пустой!!!', '', 1, 'PFU_IS_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Доп. реквізит PFU пустий!!!', '', 1, 'PFU_IS_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Превышена сумма выплаты перевода наличными за операционный день (эквивалент более 150 тыс. грн.)!', '', 1, 'SUM_IS_GREATER');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Перевищена сума виплати переказу готівкою за операційний день(еквівалент більше 150 тис. грн.)!', '', 1, 'SUM_IS_GREATER');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'ФИНАНСОВЫЙ МОНИТОРИНГ: Запрещено изменение статуса с %s на %s для документа %s', '', 1, 'FM_ERROR_STATUS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'ФІНАНСОВИЙ МОНІТОРИНГ: Заборонено зміну статусу з %s на %s для документу %s', '', 1, 'FM_ERROR_STATUS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Доп. реквизит <Наименование документа о происхождении наличных> пустой!!!', '', 1, 'NDREZ_IS_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Дод. реквізит <Найменування документу про походження готівки> пустий!!!', '', 1, 'NDREZ_IS_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Несоответсвие "Вида документа" и "Признака резидентости"', '', 1, 'NAMED_REZ');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Невідповідність "Виду документу" та "Ознаки резидентості"', '', 1, 'NAMED_REZ');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Неправильный формат серии и\или номера документа', '', 1, 'DOC_FORMAT');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Неправильний формат сериії і\чи номера документа', '', 1, 'DOC_FORMAT');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '%s. ', '', 1, 'INSIDE_ERRR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '%s. ', '', 1, 'INSIDE_ERRR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Поле %s не заповнено! ', '', 1, 'FIELD_ERRR');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Поле %s не заповнене! ', '', 1, 'FIELD_ERRR');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Ошибка данных! ', '', 1, 'DATA_ERRR');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Помилка даних! ', '', 1, 'DATA_ERRR');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Запрещено удалять референс %s по данным отправленным в ЦРНВ!', '', 1, 'BACK_IMM');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Заборонено видаляти референс %s по даних, які надіслані до ЦРНВ!', '', 1, 'BACK_IMM');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Недействующий тариф %s (дата окончания действия тарифа превышает дату операции)', '', 1, 'TARIF_DAT');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Тариф %s не є діючим (дата припинення дії тарифу перевищує дату операції)!', '', 1, 'TARIF_DAT');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не заполнен реквизит %s ', '', 1, 'DJNR_NOT_FOUND');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не заполнен реквизит %s ', '', 1, 'DJNR_NOT_FOUND');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Дополнительный реквизит "резидентность" документа (реф %s, rezid %s) не соответствует резидентности клиента %s: %s', '', 1, 'CHECK_REZID_DOC_FAILED');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Додатковий реквізит "резидентність" документу (реф %s, rezid %s) не відповідає резидентності клієнта %s: %s', '', 1, 'CHECK_REZID_DOC_FAILED');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Запрещено проведение касовых документов на уровне МФО', '', 1, 'CASH_MFO');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Заборонено проведення касових документів на рівні МФО', '', 1, 'CASH_MFO');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Ошибка вставки и оплаты докмента корп2 %s. Ошибка: %s', '', 1, 'ERROR_AUTO_PAY');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Помилка сплати документу корп2  корп2 %s. Помилка: %s ', '', 1, 'ERROR_AUTO_PAY');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Ошибка вставки документа корп2 в arc_rrp: %s. Для EXT_REF=%s, REF=%s', '', 1, 'SDO_AUTO_PAY_INSEP_ERROR');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Помилка внесення документу корп2 в arc_rrp: %s. Для EXT_REF=%s, REF=%s', '', 1, 'SDO_AUTO_PAY_INSEP_ERROR');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Ошибка сборки функции %s для автопроверки платежа СДО на автопроплату: %s', '', 1, 'ERROR_COMPILE');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Помилка копіляції функції %s для автоперевірки платежу СДО на автопроплату: %s', '', 1, 'ERROR_COMPILE');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Ошибка вставки строки бис №%s для докумнента ref=%s', '', 1, 'ERROR_IN_PUT_BIS');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Помилка вставки строки біс №%s для докумненту ref=%s', '', 1, 'ERROR_IN_PUT_BIS');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Помилка видачі гранту на функцію %s: %s', '', 1, 'ERROR_GRANT');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Помилка видачі гранту на функцію %s: %s', '', 1, 'ERROR_GRANT');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Документ EXT_REF=%s, REF=%s с будущей датой валютирования %s, будет обработан в дату валютирования', '', 1, 'FUTURE_VALUE_DATE');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Документ EXT_REF=%s, REF=%s з майбутньою датою валютування %s, буде оброблено в дату валютування', '', 1, 'FUTURE_VALUE_DATE');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Документ EXT_REF=%s, REF=%s не сплачено по факту', '', 1, 'FAILED_TO_PAY_BY_FACT');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Документ EXT_REF=%s, REF=%s не оплатено по факту', '', 1, 'FAILED_TO_PAY_BY_FACT');



  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
