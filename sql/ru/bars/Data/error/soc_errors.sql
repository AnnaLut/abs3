declare
  l_mod  varchar2(3) := 'SOC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_exc  number(6)   := -20000;
begin
  
  bars_error.add_module(l_mod, 'Счета пенсионеров и безработных', 1);
  
  --
  -- create_contract  (1 - 20)
  --
  bars_error.add_message(l_mod,  1, l_exc, l_rus, 'Не найден клиент с регистрационным № %s',   '', 1, 'CUST_NOT_FOUND');
  bars_error.add_message(l_mod,  1, l_exc, l_ukr, 'Не знайдений клієнт з регістраційним № %s', '', 1, 'CUST_NOT_FOUND');

  bars_error.add_message(l_mod,  2, l_exc, l_rus, 'Не найден орган соц защиты № %s',     '', 1, 'AGENCY_NOT_FOUND');
  bars_error.add_message(l_mod,  2, l_exc, l_ukr, 'Не знайдено органу соц.захисту № %s', '', 1, 'AGENCY_NOT_FOUND');

  bars_error.add_message(l_mod,  3, l_exc, l_rus, 'Не найден тип соц.договора № %s',    '', 1, 'SOCDEALTYPE_NOT_FOUND');
  bars_error.add_message(l_mod,  3, l_exc, l_ukr, 'Не знайдений тип соц.договору № %s', '', 1, 'SOCDEALTYPE_NOT_FOUND');

  bars_error.add_message(l_mod,  4, l_exc, l_rus, 'Не найден вид соц.договора № %s',    '', 1, 'SOCVIDD_NOT_FOUND');
  bars_error.add_message(l_mod,  4, l_exc, l_ukr, 'Не знайдений вид соц.договору № %s', '', 1, 'SOCVIDD_NOT_FOUND');

  bars_error.add_message(l_mod,  5, l_exc, l_rus, 'Не заполнен реквизит <номер пенсионного дела>',   '', 1, 'PENSNUM_IS NULL');
  bars_error.add_message(l_mod,  5, l_exc, l_ukr, 'Не заповнений реквізит <номер пенсійної справи>', '', 1, 'PENSNUM_IS NULL');

  bars_error.add_message(l_mod,  6, l_exc, l_rus, 'Ошибка поиска № соц.договора в подразделении %s: %s', '', 1, 'DEALNUM_GET_FAILED');
  bars_error.add_message(l_mod,  6, l_exc, l_ukr, 'Помилка пошуку № соц.договору в підрозділі %s: %s',   '', 1, 'DEALNUM_GET_FAILED');

  bars_error.add_message(l_mod,  7, l_exc, l_rus, 'Ошибка фиксации № соц.договора в подразделении %s: %s', '', 1, 'DEALNUM_FIX_FAILED');
  bars_error.add_message(l_mod,  7, l_exc, l_ukr, 'Помилка фіксації № соц.договору в підрозділі %s: %s',   '', 1, 'DEALNUM_FIX_FAILED');

  bars_error.add_message(l_mod,  8, l_exc, l_rus, 'Ошибка открытия счета %s/%s : %s',     '', 1, 'SOCACC_OPEN_FAILED');
  bars_error.add_message(l_mod,  8, l_exc, l_ukr, 'Помилка відкриття рахунку %s/%s : %s', '', 1, 'SOCACC_OPEN_FAILED');

  bars_error.add_message(l_mod,  9, l_exc, l_rus, 'Не найден счет процентных расходов',    '', 1, 'EXPACC_NOT_FOUND');
  bars_error.add_message(l_mod,  9, l_exc, l_ukr, 'Не знайдено рахунок процентних витрат', '', 1, 'EXPACC_NOT_FOUND');

  bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Ошибка заполнения процентной карточки по счету %s/%s: %s',  '', 1, 'FILL_INTCARD_FAILED');
  bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Помилка заповнення процентної картки по рахунку %s/%s: %s', '', 1, 'FILL_INTCARD_FAILED');

  bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Ошибка заполнения процентной ставки по счету %s/%s: %s',    '', 1, 'FILL_INTRATE_FAILED');
  bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Помилка заповнення процентної ставки по рахунку %s/%s: %s', '', 1, 'FILL_INTRATE_FAILED');

  bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Невозможно найти идентификатор соц.договора', '', 1, 'GET_CONTRACTID_FAILED');
  bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Неможливо знайти ідентифікатор соц.договору', '', 1, 'GET_CONTRACTID_FAILED');

  bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Ошибка открытия договора: %s',   '', 1, 'FILL_CONTRACT_FAILED');
  bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Помилка відкриття договору: %s', '', 1, 'FILL_CONTRACT_FAILED');

  --
  -- pay_bankfile (21 - 40)
  --
  bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не найдена операция с кодом %s',  '', 1, 'PAYTT_NOT_FOUND');
  bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Не знайдена операція з кодом %s', '', 1, 'PAYTT_NOT_FOUND');

  bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не найден файл id = %s',         '', 1, 'FILE_NOT_FOUND');
  bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не знайдений файл id = %s',      '', 1, 'FILE_NOT_FOUND');
                            
  bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не найден счет дебет.задолжености для ОСЗ № %s (acc=%s)', '', 1, 'DEBITACC_NOT_FOUND');
  bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Не знайдений дебет.заборгованості для ОСЗ № %s (acc=%s)', '', 1, 'DEBITACC_NOT_FOUND');

  bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Не найден счет кредит.задолжености (для тек.счетов) для ОСЗ № %s (acc=%s)',           '', 1, 'CREDITACC_NOT_FOUND');
  bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Не знайдений рахунок кредит.заборгованості (для поточн.рах.)  для ОСЗ № %s (acc=%s)', '', 1, 'CREDITACC_NOT_FOUND');

  bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Не найден счет кредит.задолжености (для карт.счетов)  для ОСЗ № %s (acc=%s)',       '', 1, 'CARDACC_NOT_FOUND');
  bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Не знайдений рахунок кредит.заборгованості (для картк.рах.) для ОСЗ № %s (acc=%s)', '', 1, 'CARDACC_NOT_FOUND');

  bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Не найден счет комиссионных доходов для ОСЗ № %s (acc=%s)',     '', 1, 'COMISSACC_NOT_FOUND');
  bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Не знайдений рахунок комісійних доходів для ОСЗ № %s (acc=%s)', '', 1, 'COMISSACC_NOT_FOUND');

  bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Недостаточно средств на счете %s/%s (остаток = %s, сумма начисления = %s)',  '', 1, 'RED_SALDO');
  bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Недостатньо коштів на рахунку %s/%s (залишок = %s, сума  зарахування = %s)', '', 1, 'RED_SALDO');

  bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Ошибка оплаты документа (Дт %s, Кт %s на сумму %s): %s', '', 1, 'PAYDOC_FAILED');
  bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Помилка сплати документу (Дт %s, Кт %s на суму %s): %s', '', 1, 'PAYDOC_FAILED');

  bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не найдена операция для взыскания комиссии по тарифу №%s', '', 1, 'COMISSTT_NOT_FOUND');
  bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Не знайдена операція для стягнення комісії по тарифу №%s', '', 1, 'COMISSTT_NOT_FOUND');

  bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не найден счет %s/%s клієнта %s',       '', 1, 'FILEACC_NOT_FOUND');
  bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Не знайдений рахунок %s/%s клієнта %s', '', 1, 'FILEACC_NOT_FOUND');

  bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Ошибка записи доп.реквизита %s по документу %s: %s',  '', 1, 'FILL_DOCVAL_FAILED');
  bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Помилка запису дод.реквізиту %s по документу %s: %s', '', 1, 'FILL_DOCVAL_FAILED');

  bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Не найден вид зачисления с кодом %s',     '', 1, 'FILETYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Не знайдений вид зарахування з кодом %s', '', 1, 'FILETYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Карточный счет %s не найден или недоступен',   '', 1, 'CARDACC_INVALID');
  bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Картковий рахунок %s не знайдено/заблоковано', '', 1, 'CARDACC_INVALID');

  --
  --  close_contract (41 - 60)
  --
  bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Не найден соц.договор №%s',   '', 1, 'CONTRACT_NOT_FOUND');
  bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Не знайдено соц.договір №%s', '', 1, 'CONTRACT_NOT_FOUND');

  bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Закрытие соц.договора № %s запрещено: %s', '', 1, 'CLOSE_CONTRACT_DENIED');
  bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Закриття соц.договору №%s заборонено: %s', '', 1, 'CLOSE_CONTRACT_DENIED');

  bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Ошибка закрытия счета № %s / %s',    '', 1, 'CONTRACTACC_CLOSE_FAILED');
  bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Помилка закриття рахунку № %s / %s', '', 1, 'CONTRACTACC_CLOSE_FAILED');

  bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Ошибка закрытия договора № %s (%s): %s', '', 1, 'CLOSE_CONTRACT_FAILED');
  bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Помилка закриття договору №%s (%s): %s', '', 1, 'CLOSE_CONTRACT_FAILED');

  bars_error.add_message(l_mod, 45, l_exc, l_rus, 'По договору № %s от %s не начислены проценты',  '', 1, 'INT_NOT_ACCURED');
  bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'По договору №%s від %s не нараховано відсотки', '', 1, 'INT_NOT_ACCURED');

  --
  -- p_supplementary_agreement (51 - 60)
  --
  bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Клиент-владелец договора не может біть довереннім лицом', '', 1,'TRUSTCUST_INVALID');
  bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Клієнт-власник договору не може бути довіреною особою',   '', 1,'TRUSTCUST_INVALID');

  bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не найдено доверенное лицо № %s', '', 1, 'TRUSTCUST_NOT_FOUND');
  bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не знайдена довінена особа № %s', '', 1, 'TRUSTCUST_NOT_FOUND');

  bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Запрещено заключение доп.соглашения типа %s для типа договора %s', '', 1, 'TRUSTYPE_DENIED');
  bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Заборонено заключення дод.угоди типу %s для типу договору № %s',   '', 1, 'TRUSTYPE_DENIED');

  bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Не найден тип доверенного лица (тип доп.соглашения - %s)', '', 1, 'TRUSTTYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Не знайдений тип довіреної особи (тип дод.угоди - %s)',    '', 1, 'TRUSTTYPE_NOT_FOUND');
 
  bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Не найдено первичное доп.соглашение, которое будет аннулировано данным', '', 1,'PRIMARY_TRUST_NOT_FOUND');
  bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Не знайдена первинна дод.угода, яка має бути анульована даною угодою',   '', 1,'PRIMARY_TRUST_NOT_FOUND');

  bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Ошибка оформления доп.соглашения (тип %s) к соц.договору № %s: %s', '', 1, 'TRUSTOPEN_FAILED');
  bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Помилка оформлення дод.угоди (тип %s) до соц.договору № %s: %s',    '', 1,'TRUSTOPEN_FAILED');

  bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Доп.соглашение (тип %s) о правах 3-го лица № %s к соц.договору № %s уже существует', '', 1, 'TRUSTEE_DUPLICATE');
  bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Дод.угода (тип %s) про права 3-ої особи № %s до соц.договору № %s вже існує',        '', 1, 'TRUSTEE_DUPLICATE');
  --
  -- open_social_agency (+ prepare_agency_account + get_agency_account) (61 - 80)
  --
  -- prepare_agency_account
  bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Счет №%s закреплен за другим подразделением (%s)',   '', 1, 'FOREIGN_AGENCY_ACC');
  bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Рахунок № %s закріплений за іншим підрозділом (%s)', '', 1, 'FOREIGN_AGENCY_ACC');

  bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Счет №%s был закрыт %s',       '', 1, 'AGENCY_ACC_CLOSED');
  bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Рахунок № %s було закрито %s', '', 1, 'AGENCY_ACC_CLOSED');

  bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Запрещено использование счета типа %s для ОСЗ типа %s',   '', 1, 'INVALID_AGENCY_ACC_TYPE');
  bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Заборонено використання рахунку типу %s для ОСЗ типу %s', '', 1, 'INVALID_AGENCY_ACC_TYPE');

  bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Задан недопустимый балансовый счет (%s) для данного типа счета',       '', 1, 'INVALID_AGENCY_BAL_ACC');
  bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Задано неприпустимий балансовий рахунок (%s) для даного типу рахунку', '', 1, 'INVALID_AGENCY_BAL_ACC');
  -- get_agency_account
  bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Не найден клиент, на которого открываются счета органов соц.защиты подразделения %s',   '', 1, 'AGENCY_ACC_OWNER_NOT_FOUND');
  bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Не знайдений клієнт, на якого відкриваються рахунки органів соц.захисту підрозділу %s', '', 1, 'AGENCY_ACC_OWNER_NOT_FOUND');

  bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Ошибка открытия счета %s: %s',     '', 1, 'OPEN_AGENCY_ACC_ERROR');
  bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Помилка відкриття рахунку %s: %s', '', 1, 'OPEN_AGENCY_ACC_ERROR');

  bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Указанный счет %s открыт в другом подразделении',   '', 1, 'DUPL_AGENCY_ACC');
  bars_error.add_message(l_mod, 67, l_exc, l_ukr, 'Вказаний рахунок %s відкритий в іншому підрозділі', '', 1, 'DUPL_AGENCY_ACC');
  -- open_social_agency
  bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Некорректно задан тип органа соц.защиты = %s',   '', 1, 'AGENCY_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 68, l_exc, l_ukr, 'Некоректно заданий тип органу соц.захисту = %s', '', 1, 'AGENCY_TYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Некорректно задан код подразделения = %s', '', 1, 'BRANCH_NOT_FOUND');
  bars_error.add_message(l_mod, 69, l_exc, l_ukr, 'Некоректно заданий код підрозділу = %s',   '', 1, 'BRANCH_NOT_FOUND');

  bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Ошибка поиска/открытия счета дебет.задолжености № %s: %s',       '', 1,'SOC_AGENCY_DEBIT_ACC_ERROR');
  bars_error.add_message(l_mod, 70, l_exc, l_ukr, 'Помилка пошуку/відкриття рахунку дебет.заборгованості № %s: %s', '', 1,'SOC_AGENCY_DEBIT_ACC_ERROR');
  
  bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Ошибка поиска/открытия счета кредит.задолжености № %s: %s',      '', 1,'SOC_AGENCY_CREDIT_ACC_ERROR');
  bars_error.add_message(l_mod, 71, l_exc, l_ukr, 'Помилка пошуку/відкриття рахунку кредит.заборгованості № %s: %s','', 1,'SOC_AGENCY_CREDIT_ACC_ERROR');
  
  bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Ошибка поиска/открытия кредит.задолжености (карт.) № %s: %s',              '', 1,'SOC_AGENCY_CARD_ACC_ERROR');
  bars_error.add_message(l_mod, 72, l_exc, l_ukr, 'Помилка пошуку/відкриття рахунку кредит.заборгованості (картк.) № %s: %s', '', 1,'SOC_AGENCY_CARD_ACC_ERROR');
  
  bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Ошибка поиска/открытия счета комисс.доходов № %s : %s',           '', 1,'SOC_AGENCY_COMISS_ACC_ERROR');
  bars_error.add_message(l_mod, 73, l_exc, l_ukr, 'Помилка пошуку/відкриття рахунку коміс.доходів № %s: %s',         '', 1,'SOC_AGENCY_COMISS_ACC_ERROR');
  
  -- close_agency
  bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Орган соц.защиты № %s - %s уже закрыт',    '', 1, 'AGENCY_ALREADY_CLOSED');
  bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Орган соц.захисту № %s - %s вже закритий', '', 1, 'AGENCY_ALREADY_CLOSED');

  bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Дата закрытия договора с ОСЗ меньше даты оформления договора','', 1, 'AGENCY_INVALIDCLOSDATE');
  bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Дата закриття договору с ОСЗ менше дати оформлення договору', '', 1, 'AGENCY_INVALIDCLOSDATE');
  
  --
  --
  --
  bars_error.add_message(l_mod, 81, l_exc, l_rus, 'Превышено допустимое количество строчек в файле %s за %s', '', 1, 'BF_INFO_LENGTH');
  bars_error.add_message(l_mod, 81, l_exc, l_ukr, 'Перевищена допустима кількість стрічок у файлі %s за %s', '', 1,  'BF_INFO_LENGTH');

  bars_error.add_message(l_mod, 82, l_exc, l_rus, 'Превышена сумма файла %s за %s', '', 1, 'BF_SUM');
  bars_error.add_message(l_mod, 82, l_exc, l_ukr, 'Перевищена сума файла %s за %s', '', 1, 'BF_SUM');

  bars_error.add_message(l_mod, 83, l_exc, l_rus, 'Запрещено изменение оплаченых файлов (id = %s, отделение %s)', '', 1, 'BF_IS_PAID');
  bars_error.add_message(l_mod, 83, l_exc, l_ukr, 'Заборонена зміна оплачених файлів (id = %s, відділення %s)', '', 1, 'BF_IS_PAID');
  
  bars_error.add_message(l_mod, 84, l_exc, l_rus, 'Запрещено удаление оплаченых файлов зачислений (id = %s)', '', 1, 'BF_CANT_BE_DELETED');
  bars_error.add_message(l_mod, 84, l_exc, l_ukr, 'Заборонено видалення оплачених файлів зарахувань (id = %s)', '', 1, 'BF_CANT_BE_DELETED');

  bars_error.add_message(l_mod, 85, l_exc, l_rus, 'Оплата файлов из данной функции запрещена для пользователей из отделения %s', '', 1, 'USER_NOT_ALLOWED');
  bars_error.add_message(l_mod, 85, l_exc, l_ukr, 'Оплата файлів з даної функції заборонена для користувачів із відділення %s', '', 1, 'USER_NOT_ALLOWED');

  bars_error.add_message(l_mod, 86, l_exc, l_rus, 'Не найдено орган соц. защиты в отделении %s типа %s', '', 1, 'AG_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 86, l_exc, l_ukr, 'Не знайдено орган соц. захисту у відділені %s типу %s', '', 1, 'AG_TYPE_NOT_FOUND');

  bars_error.add_message(l_mod, 87, l_exc, l_rus, 'Не найдено или найдено больше одного вида договора, связаного с органом соц. защиты %s', '', 1, 'SOC_TYPE_NOT_FOUND');
  bars_error.add_message(l_mod, 87, l_exc, l_ukr, 'Не знайдено або знайдено більше одного виду договору, повязано з органом соц. захисту %s', '', 1, 'SOC_TYPE_NOT_FOUND');

  --
  -- dpt_social.prepare2closdeal
  --
  bars_error.add_message(l_mod, 88, l_exc, l_rus, 'Соц.договор № %s еще не вступил в силу',                                 '', 1, 'PREPARE2CLOS_NOT_OPENED_YET');
  bars_error.add_message(l_mod, 88, l_exc, l_ukr, 'Соц.договір № %s ще не вступив в дію',                                   '', 1, 'PREPARE2CLOS_NOT_OPENED_YET');

  bars_error.add_message(l_mod, 89, l_exc, l_rus, 'Соц.договор № %s уже закрыт',                                            '', 1, 'PREPARE2CLOS_ALREADY_CLOSED');
  bars_error.add_message(l_mod, 89, l_exc, l_ukr, 'Соц.договір № %s вже закрито',                                           '', 1, 'PREPARE2CLOS_ALREADY_CLOSED');

  bars_error.add_message(l_mod, 90, l_exc, l_rus, 'Не найден клиент-владелец соц.договора № %s',                            '', 1, 'PREPARE2CLOS_CUST_NOT_FOUND');
  bars_error.add_message(l_mod, 90, l_exc, l_ukr, 'Не знайдений клієнт-власник соц.договору № %s',                          '', 1, 'PREPARE2CLOS_CUST_NOT_FOUND');

  bars_error.add_message(l_mod, 91, l_exc, l_rus, 'Ошибка чтения реквизитов основного счета по соц.договору № %s: %s',      '', 1, 'PREPARE2CLOS_DEPACC_NOT_FOUND');
  bars_error.add_message(l_mod, 91, l_exc, l_ukr, 'Помилка пошуку реквізитів основного рахунку по соц.договору № %s: %s',   '', 1, 'PREPARE2CLOS_DEPACC_NOT_FOUND');

  bars_error.add_message(l_mod, 92, l_exc, l_rus, 'По счету %s/%s найдены незавизированные документы',                      '', 1, 'PREPARE2CLOS_INVALID_SALDO');
  bars_error.add_message(l_mod, 92, l_exc, l_ukr, 'По рахунку %s/%s знайдено незавізовані документи',                       '', 1, 'PREPARE2CLOS_INVALID_SALDO');

  bars_error.add_message(l_mod, 93, l_exc, l_rus, 'Ошибка чтения реквизитов процентного счета по соц.договору № %s: %s',    '', 1, 'PREPARE2CLOS_INTACC_NOT_FOUND');
  bars_error.add_message(l_mod, 93, l_exc, l_ukr, 'Помилка пошуку реквізитів процентного рахунку по соц.договору № %s: %s', '', 1, 'PREPARE2CLOS_INTACC_NOT_FOUND');

  bars_error.add_message(l_mod, 94, l_exc, l_rus, 'Ошибка начисления процентов по соц.договору № %s: %s',                   '', 1, 'PREPARE2CLOS_MAKEINT_FAILED');
  bars_error.add_message(l_mod, 94, l_exc, l_ukr, 'Помилка нарахування відсотків по соц.договору № %s: %s',                 '', 1, 'PREPARE2CLOS_MAKEINT_FAILED');

  bars_error.add_message(l_mod, 95, l_exc, l_rus, 'Ошибка выплаты процентов по соц.договору № %s: %s',                      '', 1, 'PREPARE2CLOS_PAYINT_FAILED');
  bars_error.add_message(l_mod, 95, l_exc, l_ukr, 'Помилка виплативідсотків по соц.договору № %s: %s',                      '', 1, 'PREPARE2CLOS_PAYINT_FAILED');

  bars_error.add_message(l_mod, 96, l_exc, l_rus, 'В отделении %s не найден орган социальной защиты тип %s',                '', 1, 'AGENCY_BRANCH_NOT_FOUND');
  bars_error.add_message(l_mod, 96, l_exc, l_ukr, 'У відділенні %s не знайдено орган соціального захисту тип %s',           '', 1, 'AGENCY_BRANCH_NOT_FOUND');

  bars_error.add_message(l_mod, 97, l_exc, l_rus, 'Орган соц. защиты для типа %s и отделения %s уже открыт с № %s.',        '', 1, 'AGENCY_ALREADY_EXISTS');
  bars_error.add_message(l_mod, 97, l_exc, l_ukr, 'Орган соц. захисту для типу %s та відділення %s вже існує під  № %s.',   '', 1, 'AGENCY_ALREADY_EXISTS');

  bars_error.add_message(l_mod, 98, l_exc, l_rus, 'Открыто больше одного органа соц. защиты для типа %s и отделения %s.',   '', 1, 'TOO_MANY_AGENCIES_EXIST');
  bars_error.add_message(l_mod, 98, l_exc, l_ukr, 'Існує більше одного органу соц. захисту для типу %s та відділення %s.',  '', 1, 'TOO_MANY_AGENCIES_EXIST');

  l_exc := -20666;

  bars_error.add_message( l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE' );
  bars_error.add_message( l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE' );

end;
/

commit;
