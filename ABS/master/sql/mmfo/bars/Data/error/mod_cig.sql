PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CIG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль CIG ***
declare
  l_mod  varchar2(3) := 'CIG';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Взаимодействие с ПВБКИ (кредитное бюро)', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Значение поля "Описание роли субьекта" не найдено в справочнике D02', '', 1, 'PARENT_KEY_NOT_ROLEID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Значення поля "Опис ролі субєкта" не знайдено в довіднику D02', '', 1, 'PARENT_KEY_NOT_ROLEID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Значение поля "Описание роли субьекта" не может быть пустым', '', 1, 'CIG_ROLEID_NULL');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Значення поля "Опис ролі субєкта" не може бути пустим', '', 1, 'CIG_ROLEID_NULL');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Значение поля "Имя" не может быть пустым', '', 1, 'CIG_FIRST_NAME_NULL');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Значення поля "Ім"я" не може бути пустим', '', 1, 'CIG_FIRST_NAME_NULL');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Значение поля "Фамилия" не может быть пустым', '', 1, 'CIG_SURNAME_NULL');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Значення поля "Прізвище" не може бути пустим', '', 1, 'CIG_SURNAME_NULL');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Значение поля "Класификация субьекта" не найдено в справочнике D01', '', 1, 'PARENT_KEY_NOT_CLASSIF');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Значення поля "Класифікація  субєкта" не знайдено в довіднику D01', '', 1, 'PARENT_KEY_NOT_CLASSIF');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Значение поля "Класификация субьекта" не может быть пустым', '', 1, 'CIG_CLASSIFICATION_NULL');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Значення поля "Класифікація  субєкта" не може бути пустим', '', 1, 'CIG_CLASSIFICATION_NULL');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Значение поля "Дата рождения" не может быть пустым', '', 1, 'CIG_DATEBIRTH_NULL');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Значення поля "Дата народження" не може бути пустим', '', 1, 'CIG_DATEBIRTH_NULL');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Значение поля "Резидент" не найдено в справочнике D03', '', 1, 'PARENT_KEY_NOT_RESIDENCY');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Значення поля "Резидент" не знайдено в довіднику D03', '', 1, 'PARENT_KEY_NOT_RESIDENCY');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Значение поля "Резидент" не может быть пустым', '', 1, 'CIG_RESIDENCY_NULL');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Значення поля "Резидент" не може бути пустим', '', 1, 'CIG_RESIDENCY_NULL');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Значение поля "Гражданство" не найдено в справочнике KL_K040', '', 1, 'PARENT_KEY_NOT_CITIZENSHIP');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Значення поля "Громадянство" не знайдено в довіднику KL_K040', '', 1, 'PARENT_KEY_NOT_CITIZENSHIP');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Значение поля "Гражданство" не может быть пустым', '', 1, 'CIG_CITIZENSHIP_NULL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Значення поля "Громадянство" не може бути пустим', '', 1, 'CIG_CITIZENSHIP_NULL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Значение поля "Негативный статус" не найдено в справочнике D05', '', 1, 'PARENT_KEY_NOT_NEG_STATUS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Значення поля "Негативний статус" не знайдено в довіднику D05', '', 1, 'PARENT_KEY_NOT_NEG_STATUS');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Значение поля "Статус занятости лица" не может быть пустым', '', 1, 'CIG_POSITION_NULL');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Значення поля "Статус зайнятості особи" не може бути пустим', '', 1, 'CIG_POSITION_NULL');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Значение поля "Идентификационный код" не может быть пустым', '', 1, 'CIG_CUST_CODE_NULL');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Значення поля "Ідентифікаційний код" не може бути пустим', '', 1, 'CIG_CUST_CODE_NULL');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Значение поля "Составленный ключ ("имя" + "фамилия" + "дата рождения ")" не может быть пустым', '', 1, 'CIG_CUST_KEY_NULL');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Значення поля "Складений ключ ("імя" + "прізвище" + "дата народження") не може бути пустим', '', 1, 'CIG_CUST_KEY_NULL');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Значение поля "Серия паспорта" не может быть пустым', '', 1, 'CIG_PASSP_SER_NULL');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Значення поля "Серія паспорта" не може бути пустим', '', 1, 'CIG_PASSP_SER_NULL');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Значение поля "Номер паспорта" не может быть пустым', '', 1, 'CIG_PASSP_NUM_NULL');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Значення поля "Номер паспорта" не може бути пустим', '', 1, 'CIG_PASSP_NUM_NULL');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Значение поля "Дата выдачи паспорта" не может быть пустым', '', 1, 'CIG_PASSP_ISS_NULL');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Значення поля "Дата видачі паспорта" не може бути пустим', '', 1, 'CIG_PASSP_ISS_NULL');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Значение поля "Кем выдан документ" не может быть пустым', '', 1, 'CIG_PASSP_ORGAN_NULL');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Значення поля "Ким видано документ" не може бути пустим', '', 1, 'CIG_PASSP_ORGAN_NULL');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Значение поля "Код населенного пункта (Факт. адрес)" не может быть пустым', '', 1, 'CIG_FACT_TERRIT_NULL');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Значення поля "Код населеного пункту (Фактична адреса)" не може бути пустим', '', 1, 'CIG_FACT_TERRIT_NULL');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Значение поля "Улица, № дома, буква дома, этаж (Факт. адрес)" не может быть пустым', '', 1, 'CIG_FACT_STREET_NULL');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Значення поля "Вулиця, № будинку, літера будинку, поверх (Фактична адреса)" не може бути пустим', '', 1, 'CIG_FACT_STREET_NULL');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Значение поля "Образование" не найдено в справочнике D07', '', 1, 'PARENT_KEY_NOT_EDUCATION');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Значення поля "Освіта" не знайдено в довіднику D07', '', 1, 'PARENT_KEY_NOT_EDUCATION');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Значение поля "Семейное положение" не найдено в справочнике D08', '', 1, 'PARENT_KEY_NOT_MARITAL');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Значення поля "Сімейний стан" не знайдено в довіднику D08', '', 1, 'PARENT_KEY_NOT_MARITAL');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Значение поля "Статус занятости лица" не найдено в справочнике D09', '', 1, 'PARENT_KEY_NOT_POSITION');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Значення поля "Статус зайнятості особи" не знайдено в довіднику D09', '', 1, 'PARENT_KEY_NOT_POSITION');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Значение поля "Код населенного пункта" не найдено в справочнике Territory', '', 1, 'PARENT_KEY_NOT_FACT_TERRIT');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Значення поля "Код населеного пункту" не знайдено в довіднику Territory', '', 1, 'PARENT_KEY_NOT_FACT_TERRIT');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Запись с таким РНК уже существует', '', 1, 'PK_DUPL_RNK');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Запис з таким РНК вже існує', '', 1, 'PK_DUPL_RNK');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Значение поля "Статус деятельности" не может быть пустым', '', 1, 'CIG_STATUSID_NULL');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Значення поля "Статус діяльності" не може бути пустим', '', 1, 'CIG_STATUSID_NULL');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Значение поля "Язык написания полного наименования предприятия" не может быть пустым', '', 1, 'CIG_LANGNAME_NULL');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Значення поля "Мова написання повного найменування підприємства " не може бути пустим', '', 1, 'CIG_LANGNAME_NULL');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Значение поля "Полное наименование предприятия" не может быть пустым', '', 1, 'CIG_NAME_NULL');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Значення поля "Повна назва підприємства " не може бути пустим', '', 1, 'CIG_NAME_NULL');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Значение поля "Язык написания сокращенного наименования предприятия" не может быть пустым', '', 1, 'CIG_LANGABBREV_NULL');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Значення поля "Мова написання скороченого найменування підприємства" не може бути пустим', '', 1, 'CIG_LANGABBREV_NULL');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Значение поля "Сокращенное наименование предприятия" не может быть пустым', '', 1, 'CIG_ABBREV_NULL');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Значення поля "Скорочена назва підприємства" не може бути пустим', '', 1, 'CIG_ABBREV_NULL');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Значение поля "Форма собственности" не может быть пустым', '', 1, 'CIG_OWNERSHIP_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Значення поля "Форма власності" не може бути пустим', '', 1, 'CIG_OWNERSHIP_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Значение поля "Дата государственной регистрации" не может быть пустым', '', 1, 'CIG_REGISTRDATE_NULL');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Значення поля "Дата державної  реєстрації" не може бути пустим', '', 1, 'CIG_REGISTRDATE_NULL');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Значение поля "Улица, № дома, буква дома, этаж(Юр. адрес)" не может быть пустым', '', 1, 'CIG_REG_STREET_NULL');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Значення поля "Вулиця, № будинку, літера будинку, поверх(Юридична адреса)" не може бути пустим', '', 1, 'CIG_REG_STREET_NULL');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Значение поля "Форма собственности" не найдено в справочнике D10', '', 1, 'PARENT_KEY_NOT_OWNER');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Значення поля "Форма власності" не знайдено в довіднику D10', '', 1, 'PARENT_KEY_NOT_OWNER');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Значение поля "Классификатор экономической деятельности" не найдено в справочнике D11', '', 1, 'PARENT_KEY_NOT_ECONACTIV');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Значення поля "Класифікатор економічної діяльності" не знайдено в довіднику D11', '', 1, 'PARENT_KEY_NOT_ECONACTIV');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Значение поля "Статус деятельности" не найдено в справочнике D12', '', 1, 'PARENT_KEY_NOT_STATUSID');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Значення поля "Статус діяльності" не знайдено в довіднику D12', '', 1, 'PARENT_KEY_NOT_STATUSID');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Значение поля "Количество работающих" не найдено в справочнике D22', '', 1, 'PARENT_KEY_NOT_EMPCOUNT');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Значення поля "Кількість працюючих" не знайдено в довіднику D22', '', 1, 'PARENT_KEY_NOT_EMPCOUNT');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Значение поля "Код населенного пункта(Юр. адрес)" не найдено в справочнике Territory', '', 1, 'PARENT_KEY_NOT_REG_TERRIT');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Значення поля "Код населеного пункту(Юр. адреса)" не знайдено в довіднику Territory', '', 1, 'PARENT_KEY_NOT_REG_TERRIT');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Неопределенная ошибка', '', 1, 'ERR_NOT_DEFINED');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Помилка не визначена', '', 1, 'ERR_NOT_DEFINED');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Не указан реквизит cig_15 - фаза договора', '', 1, 'CIGDOG_PHASEID_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Не вказано реквізит cig_15 - фаза договора', '', 1, 'CIGDOG_PHASEID_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Не указана дата заключения договора', '', 1, 'CIGDOG_SDATE_NULL');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Не вказана дата укладення договора', '', 1, 'CIGDOG_SDATE_NULL');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Не указана дата начала действия договора', '', 1, 'CIGDOG_BDATE_NULL');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Не вказана дата початку дії договора', '', 1, 'CIGDOG_BDATE_NULL');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Не указана валюта договора', '', 1, 'CIGDOG_CURRENCY_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Не вказана валюта договора', '', 1, 'CIGDOG_CURRENCY_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Не указана дата ожидаемого окончания действия договора', '', 1, 'CIGDOG_ENDDATE_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Не вказана дата очікуваного закінчення договору', '', 1, 'CIGDOG_ENDDATE_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Не указан пол клиента', '', 1, 'CIG_GENDER_NULL');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Не вказано стать клієнта', '', 1, 'CIG_GENDER_NULL');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Для договора %s не найден счет с типом LIM', '', 1, 'CIG_ACCLIM_NOTFOUND');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Для договору %s не знайдено рахунок з типом LIM', '', 1, 'CIG_ACCLIM_NOTFOUND');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Данные по клиенту %s отсутствуют', '', 1, 'CIG_CUST_NOTFOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Дані по клієнту %s відсутні', '', 1, 'CIG_CUST_NOTFOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не указан реквизит cig_18 - периодичность платежей', '', 1, 'CIGDOG_PAYPERIODID_NULL');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не вказано реквізит cig_18 - періодичність платежів', '', 1, 'CIGDOG_PAYPERIODID_NULL');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Не указан реквизит cig_14 - цели финансирования', '', 1, 'CIGDOG_CREDITPURPOSE_NULL');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Не вказано реквізит cig_14 - цілі фінансування', '', 1, 'CIGDOG_CREDITPURPOSE_NULL');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Не верно указан пол физ. лица', '', 1, 'PARENT_KEY_NOT_GENDER');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Не вірно вказано стать фіз особи', '', 1, 'PARENT_KEY_NOT_GENDER');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Значение поля "Код населенного пункта(Юр. адрес)" не может быть пустым', '', 1, 'CIG_REG_TERRIT_NULL');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Значення поля "Код населеного пункту(Юридична адреса)" не може бути пустим', '', 1, 'CIG_REG_TERRIT_NULL');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Значение поля "Код населенного пункта (Факт. адрес)" не может быть пустым, если заполнено поле "Улица, № дома, буква дома, этаж (Факт. адрес)"', '', 1, 'CIG_FACT_TER_N_STR_NN');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Значення поля "Код населеного пункту (Фактична адреса)" не може бути пустим, якщо заповнено поле "Вулиця, № будинку, літера будинку, поверх (Фактична адреса)"', '', 1, 'CIG_FACT_TER_N_STR_NN');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Значение поля "Улица, № дома, буква дома, этаж (Факт. адрес)" не может быть пустым, если заполнено поле "Код населенного пункта (Факт. адрес)"', '', 1, 'CIG_FACT_TER_NN_STR_N');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Значення поля "Вулиця, № будинку, літера будинку, поверх (Фактична адреса)" не може бути пустим, якщо заповнено поле "Код населеного пункту (Фактична адреса)"', '', 1, 'CIG_FACT_TER_NN_STR_N');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Значение поля "Дата рождения" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_BDATE_VAL');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Значення поля "Дата народження" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_BDATE_VAL');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Не верно указан код почтового индекса (Юр. адрес)', '', 1, 'CIG_REG_POST_INDEX_VAL');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Не вірно вказано код поштового індексу (Юридична адреса)', '', 1, 'CIG_REG_POST_INDEX_VAL');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Не верно указан код почтового индекса (Факт. адрес)', '', 1, 'CIG_FACT_POST_INDEX_VAL');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Не вірно вказано код поштового індексу (Фактична адреса)', '', 1, 'CIG_FACT_POST_INDEX_VAL');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Значение поля "Дата подписания договора" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_STARTDT_VAL');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Значення поля "Дата підписання договору" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_STARTDT_VAL');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Значение поля "Дата начала действия договора" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_BDT_VAL');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Значення поля "Дата початку дії договору" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_BDT_VAL');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Значение поля "Ожидаемая дата окончания договора" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_ENDDT_VAL');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Значення поля "Очікувана дата закінчення договору" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_ENDDT_VAL');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Значение поля "Дата фактического окончания действия договора" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_DAZS_VAL');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Значення поля "Дата фактичного закінчення дії договору" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_DAZS_VAL');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Значение поля "Дата гос. регистрации" не может быть меньше 01.01.1900 или больше 01.01.2098', '', 1, 'CIG_REGDT_VAL');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Значення поля "Дата державної  реєстрації" не може бути менше 01.01.1900 або більше 01.01.2098', '', 1, 'CIG_REGDT_VAL');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CIG.sql =========*** Run *** ==
PROMPT ===================================================================================== 
