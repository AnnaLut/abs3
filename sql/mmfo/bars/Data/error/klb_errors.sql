declare
  l_mod  varchar2(3) := 'KLB';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_exc  number(6)   := -20000;
begin
  
  bars_error.add_module(l_mod, 'Клиент-банк', 1);

  bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не найден тип сообщения %s ','', 1);
  bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не знайдено тип повiдомлення %s','', 1);

  bars_error.add_message(l_mod, 2, l_exc, l_rus, 'В справочнике kl_customer_params нену описания для клиента  %s ','', 1);
  bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'В довiднику kl_customer_params незнайдено опис для клiєнта  %s','', 1);

  bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Ненайден branch для sab %s ','', 1);
  bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Не знайдено branch для sab %s','', 1);

  bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Для филиала %s не определено значение SAB','', 1);
  bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Для фiлiї %s не знайдено значення SAB','', 1);
  
  -- ошибки отсутсвия реквизитов док-та  6 - 30

  bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Ненайден номер документа','', 1);
  bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Незнайдено номер документа','', 1);

  bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Отсутсвует дата документа','', 1);
  bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Вiдсутня дата документа','', 1);

  bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Не указано наименование отправителя','', 1);
  bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Не вказано наiменування вiдправника','', 1);

  bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Не указано МФО банка отправителя','', 1);
  bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Не вказано МФО банка вiдправника','', 1);

  bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не указан счет отправителя','', 1);
  bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не рахунок вiдправника','', 1);

  bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не указано ОКПО отправителя','', 1);
  bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не вказано ЗКПО вiдправника','', 1);

  bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Не указано наименование получателя','', 1);
  bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Не вказано наiменування отримувача','', 1);

  bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Не указано МФО банка получателя','', 1);
  bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Не вказано МФО банка отримувача','', 1);

  bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не указан счет получателя','', 1);
  bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не рахунок отримувача','', 1);

  bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не указано ОКПО получателя','', 1);
  bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не вказано ЗКПО отримувача','', 1);

  bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Не указана сумма документа','', 1);
  bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Не вказано суму документу','', 1);

  bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Не указана валюта','', 1);
  bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Не вказано валюту документу','', 1);

  bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Не указана дата валютирования','', 1);
  bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Не вказано дату валютування','', 1);

  bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Не указан тип документа(vob)','', 1);
  bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Не вказано тип документу(vob)','', 1);

  bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Назначение платежа должно біть более 3-х символов','', 1);
  bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Призначення платежу повинне бути быльше 3-х символів','', 1);

  bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не указан тип операции(TT)','', 1);
  bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не вказано тип операцiї','', 1);

  bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не указан признак деб./кред.','', 1);
  bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не вказано признак деб./кред.','', 1);

  bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не указан код валюты Б','', 1);
  bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не вказано код валюти Б','', 1);

  bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Не указана сумма в валюте Б','', 1);
  bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Не вказано суму у валюi Б','', 1);

  bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Данный символ кас. плана не найден - %s','', 1);
  bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Даний символ кас. плану не знайдено - %s','', 1);

  bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Некорректно указано числовое значение для %s','', 1);
  bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Некоректно вказано числове значення для %s','', 1);

  bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Не задано значение референции отправителя','', 1);
  bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Не задане значення референції відправника','', 1);

  bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Отсутсвует подпись ответ-исполнителя','', 1);
  bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Відсутній підпис ключа відповід. виконавця','', 1);

  bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не задано значение ключа ответ-исполнителя','', 1);
  bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не задане значення ключа відповід. виконавця','', 1);

  bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не задано значение ключа ответ-исполнителя','', 1);
  bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Не задане значення ключа в_дпов_д. виконавця','', 1);

  -----

  bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Счет %s(%s) не найден','', 1);
  bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Рахунок %s(%s) не знайдено','', 1);

  bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Доп. реквизит %s не сущесвует в банке','', 1);
  bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Доп. реквiзит %s не iснує в банку','', 1);

  bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Название(тег) доп. реквизита - пустое значение','', 1);
  bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Назва(тег) доп. реквiзиту - пусте значення','', 1);

  bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Счет временно занят другой транзакцией','', 1);
  bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Рахунок тимчасово зайнятий iншою транзакцiєю','', 1);

  bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Ошибка оплаты документа:'||chr(13)||chr(10)||'%s','', 1);
  bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Помилка оплати документу:'||chr(13)||chr(10)||'%s','', 1);

  bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s','', 1);
  bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s','', 1);

  bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Ошибка подписи: %s: %S','', 1);
  bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Помилка пiдпису: %s: %s','', 1);

  bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Ошибка при оплате in_sep - %s','', 1);
  bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Помилка при оплатi in_sep - %s','', 1);

  bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Операция %s, описанная в платеже - не описана в банке','', 1);
  bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Операцiя %s, що оисана в палатежі - не описана в банку','', 1);

  bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Вид документа %s - не описан в банке','', 1);
  bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Вид документу %s - не описано в банку','', 1);

  bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Не синхронизирован параментр <счет кассы> с банком. Передан счет-%s, в банке-%s','', 1);
  bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Не синхронiзованj параментр <рахунок каси> с банком. Передано рахунок-%s, в банку-%s','', 1);

  bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Некорректно задана дата в поле %s','', 1);
  bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Некоректно задано дату в полі %s','', 1);

  bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Банковская дата %s закрыта. Работа невозможна.','', 1);
  bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Банкiвську дату %s закрито. Робота неможлива.','', 1);
  
  bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Для МФО %s не указан параметр RRPDAY в params$base','', 1);
  bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Для МФО %s не вказано параметр RRPDAY в params$base','', 1);

  bars_error.add_message(l_mod, 44, l_exc, l_rus, 'В документе для вставки очередного оплаченного рефа не найден тег Body','', 1);
  bars_error.add_message(l_mod, 44, l_exc, l_rus, 'В документі для вставки послідуючого сплаченого рефу н знайдено тег Body','', 1);

  bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Для документа % не предусмотрена обработка','', 1);
  bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Для докумнету % не передбачено обробку пакетом','', 1);

  bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Для сообщения % Неизвестный тип % ','', 1);
  bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Для повідомлення % Невідомий тип % ','', 1);

  bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Первый параметр для типа сообщения % должен быть датой, стоит значение- % ','', 1);
  bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Перший параметр для типу повідомлення % повинен бути датою, стоїть значення - %','', 1);

  bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Для типа сообщения % не описана схма ответа ','', 1);
  bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Для типу повыдомлення не описано схему вілповіді','', 1);

  bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не найден тип сервиса %s ','', 1);
  bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не знайдено тип сервiсу %s','', 1);

  bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Ответ для номера запроса %s для партиции %s не найден','', 1);
  bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Відповідь для номеру запиту %s для партиції %s не знайдено','', 1);

  bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Ошибка вып. процедуры %s для вставки значения тега %s - %s','', 1);
  bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Помилка при кикон. процедури %s для вставки значення тегу %s - %s','', 1);

  bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не найден номер депозита - %s','', 1);
  bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не знайдено номер депозиту - %s','', 1);

  bars_error.add_message(l_mod, 53, l_exc, l_rus, 'В параметрах для бранча не описан параметр TRDPT (транзит для пополнения депозитов)','', 1);
  bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'В параметрах для бранчу не описано параметр TRDPT (транзит для поповнення депозиту)','', 1);

  bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Не существует транзитного счета %s для пополнения деп. вкладов в ТВБВ','', 1);
  bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Не існує транзитного рахунку %s для поповнення деп.вкладу в ТВБВ','', 1);

  bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Для главной операции не найден доп. реквизит номер договаро в ТВБВ (CNTR)','', 1);
  bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Для головної операції не знайдено доп.реквізит номер угоди в ТВБВ (CNTR)','', 1);

  bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Не найден номер депозита %s для бранча %s','', 1);
  bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Не знайдено номер депозиту %s для бранча %s','', 1);

  bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Не найдена запись в int_accn для счета с асс = %s','', 1);
  bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Не знайдено запис в таблиці int_accn для рахунку з асс = %s','', 1);

  bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Не найден счет %s, определяемый параметром GetTOBOParam(''TRDPT'') для бранча %s','', 1);
  bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Не знайдено рахунок %s, що визначається параметром GetTOBOParam(''TRDPT'') для бранча %s','', 1);

  bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Номер депозита %s уже сущестует','', 1);
  bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Номер депозиту %s вже існує','', 1);

  bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Не наден лицевой счет доходов по асс = %s','', 1);
  bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Не знайдено рахунок доходів по асс = %s','', 1);

  bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Не наден лицевой счет начисленных %% по асс = %s','', 1);
  bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Не знайдено рахунок нарахованих %%  по асс = %s','', 1);

  bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Доп. реквизит %s для реф. %s уже существует','', 1);
  bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Доп. реквізит %s для реф. %s вже існує','', 1);

  bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Для док-та отсутствует доп. реквизит %s ','', 1);
  bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Для док-ту відсутній доп. реквізит %s'   ,'', 1);

  bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Пакета с типом %s должен содержать лишь один запрос','', 1);
  bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Пакет з типом %s повинен мвстити лише один запит'   ,'', 1);

  bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Доп. реквизит %s не прошел валидацию','', 1);
  bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Доп. реквізит %s не прйшов валідацію'   ,'', 1);

  bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Входящая информация из пакета - пустая','', 1);
  bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Вхідна інформація із пакету - пуста'   ,'', 1);

  bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Наш счет %s(%s) не найден или для чужого счета не указано ОКПО отправителя (поз.392-405)','', 1);
  bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не знайдено ЗКПО вiдправника(поз.392-405)','', 1);

  bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Наш счет %s(%s) не найден или для чужого счета не указано МФО отправителя','', 1);
  bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не знайдено МФО вiдправника','', 1);

  bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Наш счет %s(%s) не найден или для чужого счета не указано наименование отправителя','', 1);
  bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не вказано наыменування вiдправника','', 1);

  bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Для операции %s(депозитной) не установлен доп.реквизит DPTOP(тип операции)','', 1);
  bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Для операції %s(депозитної) не встановлено  доп.реквізит DPTOP(тип операції)','', 1);

  bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Для операции %s(депозитной) не установлено значение доп.реквизита DPTOP по-умолчанию','', 1);
  bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Для операції %s(депозитної) не встановлено значення доп.реквізиту DPTOP по-замовчуванню','', 1);

  bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Для синхронизации в описании справочника %s в выборке SELECT_STMT отсутствует выбор поля ACTION','', 1);
  bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Для синхронізації в описі довідника %s в вибірці SELECT_STMT відсутнє поле ACTION','', 1);

  bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Справочник %s не описан в табл. xml_reflist или не включен в синхронизацию','', 1);
  bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Довідник %s не описано в табл.  xml_reflist або не включено в синхронызацію','', 1);

  bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Для только что вставленного док-та с реф = %s не найден доп. реквизит CNTR','', 1);
  bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Для только что вставленного док-та с реф = %s не найден доп. реквизит CNTR','', 1);

  bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Депозит %s було відкрито, але платіж на первинний внесо не було зареєстровано в xml_reaque','', 1);
  bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Депозит %s был открыт, но платеж на первичный взнос не был зарегистрирован в очереди  xml_refque','', 1);

  bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Неккоректное описание справочника % для синхронизации (пустое значение для синхроних част. и зарегистрирован в ORACLE STREAMS)','', 1);
  bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Неккоректное описание справочника % для синхронизации (пустое значение для синхроних част. и зарегистрирован в ORACLE STREAMS','', 1);

  bars_error.add_message(l_mod, 77, l_exc, l_rus, 'Для отделения(бранча) %s не указан параметр RNK в branch_parameters','', 1);
  bars_error.add_message(l_mod, 77, l_exc, l_ukr, 'Для відділення(БРАНЧУ) %s не вказано параметр RNK в branch_parameters','', 1);

  bars_error.add_message(l_mod, 78, l_exc, l_rus, 'Клиент с RNK = %s не описан как участник оффлайн ','', 1);
  bars_error.add_message(l_mod, 78, l_exc, l_ukr, 'Клієнт з RNK = %s не описано як участник оффлайн','', 1);

  bars_error.add_message(l_mod, 79, l_exc, l_rus, 'Ни для одного справочника xml_reflist_reqv не прописан тип сообщения %s ','', 1);
  bars_error.add_message(l_mod, 79, l_exc, l_ukr, 'Ни для одного справочника xml_reflist_reqv не прописан тип сообщения %s','', 1);

  bars_error.add_message(l_mod, 80, l_exc, l_rus, 'Пользователь %s не описан как пользователь АБС в staff$base','', 1);
  bars_error.add_message(l_mod, 80, l_exc, l_ukr, 'Пользователь %s не описан как пользователь АБС в staff$base','', 1);

  bars_error.add_message(l_mod, 81, l_exc, l_rus, 'Невозможно найти клиента с РНК %s','', 1);
  bars_error.add_message(l_mod, 81, l_exc, l_ukr, 'Невозможно найти клиента с РНК %s','', 1);

  bars_error.add_message(l_mod, 82, l_exc, l_rus, 'Для клиента с РНК %s не описан САБ','', 1);
  bars_error.add_message(l_mod, 82, l_exc, l_ukr, 'Для клиента с РНК %s не описан САБ','', 1);

  bars_error.add_message(l_mod, 83, l_exc, l_rus, 'Файл "%s" уже был импортирован %s.', '', 1, 'FILE_ALREADY_IMPORTED' );
  bars_error.add_message(l_mod, 83, l_exc, l_ukr, 'Файл "%s" вже було імпортовано %s.', '', 1, 'FILE_ALREADY_IMPORTED' );

  bars_error.add_message(l_mod, 84, l_exc, l_rus, 'Символ кассплана %s не существует','', 1);
  bars_error.add_message(l_mod, 84, l_exc, l_ukr, 'Символ касплану %s не icнує','', 1);

  bars_error.add_message(l_mod, 85, l_exc, l_rus, 'Неверный контр.разряд для счтеа отправителя %s','', 1);
  bars_error.add_message(l_mod, 85, l_exc, l_ukr, 'Некоректний контр.розряд для рах. вiдправника  %s ','', 1);

  bars_error.add_message(l_mod, 86, l_exc, l_rus, 'Неверный контр.разряд для счтеа получателя %s','', 1);
  bars_error.add_message(l_mod, 86, l_exc, l_ukr, 'Некоректний контр.розряд для рах. отримувача  %s ','', 1);

  bars_error.add_message(l_mod, 87, l_exc, l_rus, 'Некорректное значение ОКПО отправителя %s','', 1);
  bars_error.add_message(l_mod, 87, l_exc, l_ukr, 'Некоректне значення ЗКПО вiдправника %s','', 1);

  bars_error.add_message(l_mod, 88, l_exc, l_rus, 'Значение ОКПО отправителя %s не числовой код','', 1);
  bars_error.add_message(l_mod, 88, l_exc, l_ukr, 'Значення ЗКПО вiдправника %s не числовий код','', 1);

  bars_error.add_message(l_mod, 89, l_exc, l_rus, 'Длинна ОКПО отправиьеля %s меншье за 8 символов','', 1);
  bars_error.add_message(l_mod, 89, l_exc, l_ukr, 'Довжина ЗКПО вiдправника %s менша за 8 символiв','', 1);

  bars_error.add_message(l_mod, 90, l_exc, l_rus, 'МФО отрправителя %s не существует','', 1);
  bars_error.add_message(l_mod, 90, l_exc, l_ukr, 'МФО вiдправника %s не iснуе','', 1);

  bars_error.add_message(l_mod, 91, l_exc, l_rus, 'МФО отрправителя %s блокировано','', 1);
  bars_error.add_message(l_mod, 91, l_exc, l_ukr, 'МФО вiдправника %s блоковано','', 1);

  bars_error.add_message(l_mod, 92, l_exc, l_rus, 'Значение ОКПО получателя %s не числовой код','', 1);
  bars_error.add_message(l_mod, 92, l_exc, l_ukr, 'Значення ЗКПО отримувача %s не числовий код','', 1);

  bars_error.add_message(l_mod, 93, l_exc, l_rus, 'Длинна ОКПО получателя %s меншье за 8 символов','', 1);
  bars_error.add_message(l_mod, 93, l_exc, l_ukr, 'Довжина ЗКПО отримувача %s менша за 8 символiв','', 1);

  bars_error.add_message(l_mod, 94, l_exc, l_rus, 'Некорректное значение ОКПО получателя %s','', 1);
  bars_error.add_message(l_mod, 94, l_exc, l_ukr, 'Некоректне значення ЗКПО отримувача %s','', 1);

  bars_error.add_message(l_mod, 96, l_exc, l_rus, 'МФО получателя %s не существует','', 1);
  bars_error.add_message(l_mod, 96, l_exc, l_ukr, 'МФО отримувача %s не iснуе','', 1);

  bars_error.add_message(l_mod, 95, l_exc, l_rus, 'МФО получателя %s блокировано','', 1);
  bars_error.add_message(l_mod, 95, l_exc, l_ukr, 'МФО отримувача %s блоковано','', 1);

  bars_error.add_message(l_mod, 97, l_exc, l_rus, 'Для прихода кассы неверный символ кас.плана %s (должнен быть 2-39)','', 1);
  bars_error.add_message(l_mod, 97, l_exc, l_ukr, 'Для прихiда касы невiрний символ %s кас.плану (повиненн бути 2-39)','', 1);

  bars_error.add_message(l_mod, 98, l_exc, l_rus, 'Для расхода кассы неверный символ кас.плана %s (должнен быть 40-73)','', 1);
  bars_error.add_message(l_mod, 98, l_exc, l_ukr, 'Для видатку каси невiрний символ %s кас.плану (повиненн бути 40-73)','', 1);


  bars_error.add_message(l_mod, 99, l_exc, l_rus,  'Не указано ОКПО получателя','', 1);
  bars_error.add_message(l_mod, 99, l_exc, l_rus,  'Не вказано ЗКПО отримувача','', 1);

  bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Не указано МФО получателя','', 1);
  bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Не вказано МФО отримувача','', 1);

  bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Не указано наименование получателя','', 1);
  bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Не вказано наiменування отримувача','', 1);

  -- помилки кл_єнтської частини (они повинн_ бути описани_ в bars.kltoss.common.BarsError)
                                                  
  -- Помилка перев_рки п_дпису на документ_ %s для ключа %s
  bars_error.add_message(l_mod, 102, l_exc, l_rus, '%s','', 1);  
  bars_error.add_message(l_mod, 102, l_exc, l_ukr, '%s','', 1);

  bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Входящее направление блокировано','', 1);
  bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Вх_дний напрямок блоковано','', 1);

  bars_error.add_message(l_mod, 111, l_exc, l_rus, 'Тип сообщения не описан в главном банке %s ','', 1);
  bars_error.add_message(l_mod, 111, l_exc, l_ukr, 'Тип пов_домлення не описано в головному банку %s','', 1);

  bars_error.add_message(l_mod, 112, l_exc, l_rus, 'Неизвестный тип поска корреспондента %s ','', 1);
  bars_error.add_message(l_mod, 112, l_exc, l_ukr, 'Нев_домий тип пошуку корреспонденту %s','', 1);

  bars_error.add_message(l_mod, 113, l_exc, l_rus, 'Неизвестный справочник для синхронизации %s ','', 1);
  bars_error.add_message(l_mod, 113, l_exc, l_ukr, 'Невiдомий дов_дник для синхрон_зац_ї %s','', 1);

  bars_error.add_message(l_mod, 114, l_exc, l_rus, 'Неизвестный справочник для синхронизации %s ','', 1);
  bars_error.add_message(l_mod, 114, l_exc, l_ukr, 'Невiдомий дов_дник для синхрон_зац_ї %s','', 1);

  -- ошибки вставки докуи-та при импорте
  
  bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s','', 1);
  bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s','', 1);

  bars_error.add_message(l_mod, 151, l_exc, l_rus, 'Неккоректный формат даты в поле даты документа - %s','', 1);
  bars_error.add_message(l_mod, 151, l_exc, l_rus, 'Некоректний формат дати в полі дати документу - %s','', 1);

  bars_error.add_message(l_mod, 152, l_exc, l_rus, 'Неккоректный формат суммы платежа - %s','', 1);
  bars_error.add_message(l_mod, 152, l_exc, l_rus, 'Некоректний формат суми платежу - %s','', 1);

  bars_error.add_message(l_mod, 153, l_exc, l_rus, 'Невозможно привести к числу значение кода валюты А - %s','', 1);
  bars_error.add_message(l_mod, 153, l_exc, l_rus, 'Неможливо привести до числа значення коду валюти А - %s','', 1);

  bars_error.add_message(l_mod, 154, l_exc, l_rus, 'Неккоректный формат даты валютирования - %s','', 1);
  bars_error.add_message(l_mod, 154, l_exc, l_rus, 'Некоректний формат дати валютування - %s','', 1);

  bars_error.add_message(l_mod, 155, l_exc, l_rus, 'Невозможно привести к числу значение вида обработки - %s','', 1);
  bars_error.add_message(l_mod, 155, l_exc, l_rus, 'Неможливо привести до числа значення виду обробки - %s','', 1);

  bars_error.add_message(l_mod, 156, l_exc, l_rus, 'Невозможно привести к числу значение симв.кассплана - %s','', 1);
  bars_error.add_message(l_mod, 156, l_exc, l_rus, 'Неможливо привести до числа значення симв.касплану - %s','', 1);

  bars_error.add_message(l_mod, 157, l_exc, l_rus, 'Невозможно привести к числу значение ДК - %s','', 1);
  bars_error.add_message(l_mod, 157, l_exc, l_rus, 'Неможливо привести до числа значення ДК - %s','', 1);

  bars_error.add_message(l_mod, 158, l_exc, l_rus, 'Невозможно привести к числу значение кода валюты Б - %s','', 1);
  bars_error.add_message(l_mod, 158, l_exc, l_rus, 'Неможливо привести до числа значення коду валюти Б - %s','', 1);

  bars_error.add_message(l_mod, 159, l_exc, l_rus, 'Неккоректный формат суммы Б платежа - %s','', 1);
  bars_error.add_message(l_mod, 159, l_exc, l_rus, 'Некоректний формат суми Б платежу - %s','', 1);

  bars_error.add_message(l_mod, 160, l_exc, l_rus, 'Неккоректный формат даты платежа - %s','', 1);
  bars_error.add_message(l_mod, 160, l_exc, l_rus, 'Некоректний формат дати платежу - %s','', 1);

  bars_error.add_message(l_mod, 161, l_exc, l_rus, 'Для операции %s не описан тип документа vob','', 1);
  bars_error.add_message(l_mod, 161, l_exc, l_rus, 'Для операції %s не описано тип документу vob','', 1);

  bars_error.add_message(l_mod, 162, l_exc, l_rus, 'Импортированный документ с реф.импорта %s не найден','', 1);
  bars_error.add_message(l_mod, 162, l_exc, l_rus, 'Імпортований документ з реф.імпорту %s не знайдено','', 1);

  bars_error.add_message(l_mod, 163, l_exc, l_rus, 'Значение доп. реквизита %s - пустое','', 1);
  bars_error.add_message(l_mod, 163, l_exc, l_rus, 'Значення доп. реквiзиту %s - пусте','', 1);

  bars_error.add_message(l_mod, 164, l_exc, l_rus, 'Файл %s за дату %s не был проимпортирован','', 1);
  bars_error.add_message(l_mod, 164, l_exc, l_rus, 'Файл %s за дату %s не був проiмпортований','', 1);

  bars_error.add_message(l_mod, 165, l_exc, l_rus, 'Не задан символ касс плана','', 1);
  bars_error.add_message(l_mod, 165, l_exc, l_rus, 'Не задано символ кас.плану','', 1);

  bars_error.add_message(l_mod, 166, l_exc, l_rus, 'Невозможно удалить уже удаленный или оплаченный документ','', 1);
  bars_error.add_message(l_mod, 166, l_exc, l_rus, 'Неможливо видалити вже видалений або сплачений документ','', 1);

  bars_error.add_message(l_mod, 167, l_exc, l_rus, 'Невозможно изменить реквизиты уже удаленного или оплаченного документа','', 1);
  bars_error.add_message(l_mod, 167, l_exc, l_rus, 'Неможливо змінити реквізити вже видаленого або сплаченого документу','', 1);

  bars_error.add_message(l_mod, 168, l_exc, l_rus, 'Счет отправителя %s не существует в нашем банке','', 1);
  bars_error.add_message(l_mod, 168, l_exc, l_rus, 'Рахунок відправника %s не існує в нашому банку','', 1);

  bars_error.add_message(l_mod, 169, l_exc, l_rus, 'Счет получателя %s не существует в нашем банке','', 1);
  bars_error.add_message(l_mod, 169, l_exc, l_rus, 'Рахунок отримувача %s не існує в нашому банку','', 1);

  bars_error.add_message(l_mod, 170, l_exc, l_rus, 'В глобальных параметрах (params$global) не описан параметр SNCLOCAL - группа счетов(локальная) для синхронизации offline','', 1);
  bars_error.add_message(l_mod, 170, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCLOCAL - група рахунків(локальна) для синхронізації offline','', 1);

  bars_error.add_message(l_mod, 171, l_exc, l_rus, 'В глобальных параметрах (params$global) не описан параметр SNCPARNT - группа счетов(выше на уровень) для синхронизации offline','', 1);
  bars_error.add_message(l_mod, 171, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCPARNT - група рахунків(вище на рівень) для синхронізації offline','', 1);

  bars_error.add_message(l_mod, 172, l_exc, l_rus, 'В глобальных параметрах (params$global) не описан параметр SNCGLBL - группа счетов(глобальная) для синхронизации offline','', 1);
  bars_error.add_message(l_mod, 172, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCGLBL - група рахунків(глобальна) для синхронізації offline','', 1);

  bars_error.add_message(l_mod, 173, l_exc, l_rus, 'Значение счета А равно значению счета Б','', 1);
  bars_error.add_message(l_mod, 173, l_exc, l_rus, 'Значення рахунку А рівне значенню рахунка Б','', 1);

  bars_error.add_message(l_mod, 174, l_exc, l_rus, 'Пустое значение БИС строки для реквизита %s','', 1);
  bars_error.add_message(l_mod, 174, l_exc, l_rus, 'Пусте значення БІС стрічки для реквизиту %s','', 1);

  bars_error.add_message(l_mod, 175, l_exc, l_rus, 'Реквизит %s - не существует','', 1);
  bars_error.add_message(l_mod, 175, l_exc, l_rus, 'Реквізит %s - не існує','', 1);

  bars_error.add_message(l_mod, 176, l_exc, l_rus, 'Реквизит %s уже существует для даного документа','', 1);
  bars_error.add_message(l_mod, 176, l_exc, l_rus, 'Реквізит %s вже існує для даного документу','', 1);

  bars_error.add_message(l_mod, 177, l_exc, l_rus, 'Для платежа по депозиту № %s (операция %s ) не указан тип депозита (доп. реквизит DPTPR)','', 1);
  bars_error.add_message(l_mod, 177, l_exc, l_rus, 'Для платежу по депозиту № %s (операція %s ) не вказано тип депозиту (доп. реквізит DPTPR)','', 1);

  bars_error.add_message(l_mod, 178, l_exc, l_rus, 'Для платежу по депозиту № %s не вказано або вказано невірно тип депозиту DPTPR (повинно буьт DPT1 або DPT2)','', 1);
  bars_error.add_message(l_mod, 178, l_exc, l_rus, 'Для платежа по депозиту № %s не указано или указано неправильно тип депозита DPTPR (должно быть DPT1 или DPT2)','', 1);

  bars_error.add_message(l_mod, 179, l_exc, l_rus, 'Не найдены данные для стороны B по реквизитам: %s','', 1);
  bars_error.add_message(l_mod, 179, l_exc, l_rus, 'Не знайдено данi по реквiзитам: %s','', 1);

  bars_error.add_message(l_mod, 180, l_exc, l_rus, 'Не найдено МФО %s','', 1);
  bars_error.add_message(l_mod, 180, l_exc, l_rus, 'Не знайдене МФО %s','', 1);

  bars_error.add_message(l_mod, 181, l_exc, l_rus, 'Тип сообщения %s не обрабатывается для заключения доп.соглашений','', 1);
  bars_error.add_message(l_mod, 181, l_exc, l_rus, 'Тип повідомлення %s не оброблюється для заключення доп. угод','', 1);

  bars_error.add_message(l_mod, 182, l_exc, l_rus, 'Номер договора(уникальный номер главного банка) %s не найден в главном банке','', 1);
  bars_error.add_message(l_mod, 182, l_exc, l_rus, 'Номер угоди(унікальний номер головного банку) %s не знайдено в головному банку ','', 1);

  bars_error.add_message(l_mod, 183, l_exc, l_rus, 'Дата выдачи документа %s, больше даты рождения %s','', 1);
  bars_error.add_message(l_mod, 183, l_exc, l_rus, 'Дата видачі документу %s, більша за дату народження %s','', 1);

  bars_error.add_message(l_mod, 183, l_exc, l_rus, 'Дата выдачи документа %s, меньше даты рождения %s','', 1);
  bars_error.add_message(l_mod, 183, l_exc, l_rus, 'Дата видачі документу %s, менша за дату народження %s','', 1);

  bars_error.add_message(l_mod, 184, l_exc, l_rus, 'Кол-во записей в таблице изменений aq_refsync_tbl превышает 10000. Автоматическая работа джоба может не отработать. Очистите таблицу или сформируйте пакеты для JBOSS вручную', '', 1);
  bars_error.add_message(l_mod, 184, l_exc, l_ukr, 'Кол-во записей в таблице изменений aq_refsync_tbl превышает 10000. Автоматическая работа джоба может не отработать. Очистите таблицу или сформируйте пакеты для JBOSS вручную', '', 1);    

  bars_error.add_message(l_mod, 185, l_exc, l_rus, 'Длинна номера счета для %s не может привышать 14-ти символов', '', 1);
  bars_error.add_message(l_mod, 185, l_exc, l_ukr, 'Довжина номеру рахунку для %s не може перевищувати 14-ти символів', '', 1);    

  bars_error.add_message(l_mod, 186, l_exc, l_rus, 'Длинна наименования клиента: %s не должна превышать 38-ми символов', '', 1);
  bars_error.add_message(l_mod, 186, l_exc, l_ukr, 'Довжина назви клієнта: %s не повинна перевищувати 38-ми символів', '', 1);    

  bars_error.add_message(l_mod, 187, l_exc, l_rus, 'Длинна назначения платежа не должна превышать 160 симовлов(для продовження призначення платежу використовуйте доп. реквізити С)', '', 1);
  bars_error.add_message(l_mod, 187, l_exc, l_ukr, 'Довжина призначення платежу не повинна перевищувати 160-ти символів(для продовження призначення платежу використовуйте доп.реквізити С)', '', 1);    

  bars_error.add_message(l_mod, 188, l_exc, l_rus, 'Номер депозита %s не соответствует маске xxxxxx/N (xxxxxx-код отд., N-числовой № деп.) ', '', 1);
  bars_error.add_message(l_mod, 188, l_exc, l_ukr, 'Номер депозиту %s не відповідає масці xxxxxx/N (xxxxxx-код відділ., N-числовий № деп.)', '', 1);    

  bars_error.add_message(l_mod, 189, l_exc, l_rus, 'Параметр DPTNUM для %s - должен быть числом, а его значение сейчас равно %s ', '', 1);
  bars_error.add_message(l_mod, 189, l_exc, l_ukr, 'Параметр DPTNUM для %s - повинен бути числом, а його значення зараз дорівнює %s', '', 1);    

  bars_error.add_message(l_mod, 190, l_exc, l_rus, 'Некорректний номер депозиту: %s. Оперцію було введено не через депозитний портфель', '', 1);
  bars_error.add_message(l_mod, 190, l_exc, l_ukr, 'Некорректный номер депозита: %s. Оперцию ввели не через депозитный портфель', '', 1);    

  bars_error.add_message(l_mod, 191, l_exc, l_rus, 'Для операции с депозитом %s - не описана соответствующая операция для офлайн отделения', '', 1, 'NOTEXISTS_OFFLINE_TT');
  bars_error.add_message(l_mod, 191, l_exc, l_ukr, 'Для операції з депозитом %s - не описано відповідну операцію для офлайн відділення', '', 1, 'NOTEXISTS_OFFLINE_TT');    

  bars_error.add_message(l_mod, 192, l_exc, l_rus, 'Указанное значение РНК %s не найдено',   '', 1, 'NO_SUCH_RNK');
  bars_error.add_message(l_mod, 192, l_exc, l_ukr, 'Вказане значення  РНК %s не найдене', '', 1,    'NO_SUCH_RNK');    

  bars_error.add_message(l_mod, 193, l_exc, l_rus, 'Указанное значение бранча %s не найдено', '', 1, 'NO_SUCH_BRANCH');
  bars_error.add_message(l_mod, 193, l_exc, l_ukr, 'Вказане значення  бранчу %s не найдене', '', 1,  'NO_SUCH_BRANCH');    

  bars_error.add_message(l_mod, 194, l_exc, l_rus, 'Не указано значение бранча для отделения', '', 1,   'NO_BRANCH');
  bars_error.add_message(l_mod, 194, l_exc, l_ukr, 'Не вказано значення бранчу для відділення', '', 1,  'NO_BRANCH');    
  
  bars_error.add_message(l_mod, 195, l_exc, l_rus, 'Не указано значение электронного идентификатора(САБ) для %s', '', 1,  'NO_SAB');
  bars_error.add_message(l_mod, 195, l_exc, l_ukr, 'Не вказано значення електронного ідентифікатора(САБ) для %s', '', 1,  'NO_SAB');    

  bars_error.add_message(l_mod, 196, l_exc, l_rus, 'Не указано значение ключа технолога для %s', '', 1, 'NO_TECHKEY');
  bars_error.add_message(l_mod, 196, l_exc, l_ukr, 'Не вказано значення ключа технолога для %s', '', 1,  'NO_TECHKEY');    

  bars_error.add_message(l_mod, 197, l_exc, l_rus, 'Для указанного РНК %s, вы указали бранч %s, а для него проставлен бранч %s', '', 1, 'NOT_CORRECT_BRANCH');
  bars_error.add_message(l_mod, 197, l_exc, l_ukr, 'Для вказаного РНК %s, ви вказали бранч %s, а для нього проставлено бранч %s', '', 1, 'NOT_CORRECT_BRANCH');    

  bars_error.add_message(l_mod, 198, l_exc, l_rus, 'Указнный бранч %s должен быть второго или третьего уровня', '', 1, 'NOT_CORRECT_BRANCH2');
  bars_error.add_message(l_mod, 198, l_exc, l_ukr, 'Вказаний бранч %s повинен бути другого або третього рівня', '', 1, 'NOT_CORRECT_BRANCH2');    

  bars_error.add_message(l_mod, 199, l_exc, l_rus, 'Электронный идентификатор(САБ) %s для отделения %s должен состоять из 6-ти символов', '', 1,  'NOT_CORRECT_SAB');
  bars_error.add_message(l_mod, 199, l_exc, l_ukr, 'Електронний ідентифікатор(САБ) %s для відділення %s повинен містити 6-ть символів', '', 1,    'NOT_CORRECT_SAB');    

  bars_error.add_message(l_mod, 200, l_exc, l_rus, 'Электронный идентификатор(САБ) файла %s для отделения %s должен состоять из 6-ти символов', '', 1,  'NOT_CORRECT_FILESAB');
  bars_error.add_message(l_mod, 200, l_exc, l_ukr, 'Електронний ідентифікатор(САБ) файлу %s для відділення %s повинен містити 6-ть символів', '', 1,    'NOT_CORRECT_FILESAB');    

  bars_error.add_message(l_mod, 201, l_exc, l_rus, 'Ключ технолога %s для отделения %s должен состоять из 5-ти символов', '', 1,  'NOT_CORRECT_TECHKEY');
  bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'Ключ технолога %s для відділення %s повинен містити 5-ть символів', '', 1,    'NOT_CORRECT_TECHKEY');    

  bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Указанный САБ %s уже существует у другого клиента', '', 1,  'SUCH_SAB_EXISTS');
  bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Вказаний САБ %s вже існує у іншого клієнта', '', 1,    'SUCH_SAB_EXISTS');    

  bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Сбился сиквенс %s, возвратив значение %s, которое уже есть в staff$base', '', 1,  'BROKEN_SEQUENCE');
  bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Сбился сиквенс %s, возвратив значение %s, которое уже есть в staff$base', '', 1,  'BROKEN_SEQUENCE');    

  bars_error.add_message(l_mod, 204, l_exc, l_rus, 'Доп.реквизит <тип операции с депозитом> (DPTOP) - нечисловое значение %s', '', 1,  'DPTOP_NOT_NUMBER');
  bars_error.add_message(l_mod, 204, l_exc, l_ukr, 'Доп.реквізит <тип операції з депозитом> (DPTOP) - не числове значення %s', '', 1,  'PTOP_NOT_NUMBER');    

  bars_error.add_message(l_mod, 205, l_exc, l_rus, 'Дата валютирования больше или меншье банк.даты на 1 месяц %s', '', 1,   'NOT_CORRECT_PAYDATE');
  bars_error.add_message(l_mod, 205, l_exc, l_ukr, 'Дата валютування більша або менша за банк.дату на 1 місяць %s', '', 1,  'NOT_CORRECT_PAYDATE');    

  bars_error.add_message(l_mod, 206, l_exc, l_rus, 'Тип доп. соглашения %s не обрабатывается', '', 1,   'NOT_AGREEMENT_TYPE');
  bars_error.add_message(l_mod, 206, l_exc, l_ukr, 'Тип доп. угоди %s не обробляється ', '', 1,         'NOT_AGREEMENT_TYPE');    

  bars_error.add_message(l_mod, 207, l_exc, l_rus, 'Недопускаются внутренние информационные платежи', '', 1,              'INNER_INFO_NOTALLOWED');
  bars_error.add_message(l_mod, 207, l_exc, l_ukr, 'Недозволено проводити внутрішні інформаційні платежі', '', 1,         'INNER_INFO_NOTALLOWED');    
  
  bars_error.add_message(l_mod, 208, l_exc, l_rus, 'Ни одно из МФО не равно МФО нашего банка', '', 1,              'NO_OUR_MFO');
  bars_error.add_message(l_mod, 208, l_exc, l_ukr, 'Жодне з МФО не дорівнює МФО нашого банку', '', 1,                        'NO_OUR_MFO');    
  
  bars_error.add_message(l_mod, 209, l_exc, l_rus, 'Счет %s(%s) не существует в нашем банке', '', 1,           'NO_ACCOUNT_FOUND');
  bars_error.add_message(l_mod, 209, l_exc, l_ukr, 'Рахунок %s(%s) не існує в нашому банку', '', 1, 'NO_ACCOUNT_FOUND');    
  
  bars_error.add_message(l_mod, 210, l_exc, l_rus, 'Для МФО-%s, счет %s(%s) не найдено реквизити в справочнике внешних контрагентов', '', 1,        'NO_ALIEN_FOUND');
  bars_error.add_message(l_mod, 210, l_exc, l_ukr, 'Для МФО-%s, рахунок %s(%s) не знайдено реквізити в довіднику зовнішніх контрагентів', '', 1, 'NO_ALIEN_FOUND');    
      
  bars_error.add_message(l_mod, 211, l_exc, l_rus, 'Найденное значение ОКПО для клиента с рнк=%s (для счета %s-%s) некорректно: %s', '', 1,  'CUST_OKPO_NOTCORRECT');
  bars_error.add_message(l_mod, 211, l_exc, l_ukr, 'Знайдене значення ЗКРО для клієнта з рнк=%s (для рахунку %s-%s) некорректне: %s', '', 1, 'CUST_OKPO_NOTCORRECT');    
  
  --bars_error.add_message(l_mod, 212, l_exc, l_rus, 'Для документа - недостаточно реквизитов. При поиске ОКПО для счета %s(%s) в справочнике конрагентов некорректно: %s', '', 1,  'ALIEN_OKPO_NOTCORRECT');
  --bars_error.add_message(l_mod, 212, l_exc, l_ukr, 'Для докумнету - недостатньо реквізитів. При пошуку ЗКПО для рахунку %s(%s) в довіднику конрагентів(ALIEN) некорректне: %s', '', 1,   'ALIEN_OKPO_NOTCORRECT');    
  
  bars_error.add_message(l_mod, 212, l_exc, l_rus, 'Ошибка при поиске ОКПО для счета %s(%s) в справочнике других конрагентов(ALIEN): %s', '', 1,  'ALIEN_OKPO_NOTCORRECT');
  bars_error.add_message(l_mod, 212, l_exc, l_ukr, 'Помилка при пошуку ЗКПО для рахунку %s(%s) в довіднику інших конрагентів(ALIEN): %s', '', 1,   'ALIEN_OKPO_NOTCORRECT');    
  
  bars_error.add_message(l_mod, 213, l_exc, l_rus, 'В документі є реквізити для первинного внеску для депозиту %s. Але первинний внесок вже було зроблено', '', 1,   'SUCH_DRECDPT_WASPAYED');
  bars_error.add_message(l_mod, 213, l_exc, l_ukr, 'В документі є реквізити для первинного внеску для депозиту %s. Але первинний внесок вже було зроблено', '', 1,   'SUCH_DRECDPT_WASPAYED');    
  
  bars_error.add_message(l_mod, 214, l_exc, l_rus, 'Недостаточно прав на дебет счета %s(%s)', '', 1,    'NO_DEBET_RIGHTS');
  bars_error.add_message(l_mod, 214, l_exc, l_ukr, 'Недостатньо прав на дебет рахунку %s(%s)', '', 1,   'NO_DEBET_RIGHTS');    

  bars_error.add_message(l_mod, 215, l_exc, l_rus, 'Недостаточно прав на кредит счета %s(%s)', '', 1,    'NO_KREDIT_RIGHTS');
  bars_error.add_message(l_mod, 215, l_exc, l_ukr, 'Недостатньо прав на кредит рахунку %s(%s)', '', 1,   'NO_KREDIT_RIGHTS');    

  bars_error.add_message(l_mod, 216, l_exc, l_rus, 'Дебет со счета не своего МФО %s', '', 1, 'NOT_OUR_MFO');
  bars_error.add_message(l_mod, 216, l_exc, l_ukr, 'Дебет з рахунку не свого МФО %s', '', 1, 'NOT_OUR_MFO');    

  bars_error.add_message(l_mod, 217, l_exc, l_rus, 'Не указан саб для клиента для выгрузки справочника %s (нужен для версии одного МФО)', '', 1, 'NO_SAB_FORREF');
  bars_error.add_message(l_mod, 217, l_exc, l_ukr, 'Не вказано саб для клiєнту для вигрузки довiдника %s (потрiбен для версii одного МФО)', '', 1, 'NO_SAB_FORREF');    

  bars_error.add_message(l_mod, 218, l_exc, l_rus, 'Не существует такого идентификатора клиента для выгрузки справочника %s', '', 1, 'NO_SUCHSAB_FORREF');
  bars_error.add_message(l_mod, 218, l_exc, l_ukr, 'Не icyє такого iдентифiкатору клiєнта для  вигрузки довiдника %s (потрiбен для версii одного МФО)', '', 1, 'NO_SUCHSAB_FORREF');    

  bars_error.add_message(l_mod, 219, l_exc, l_rus, 'Значение символа касс плана не должно быть больше 99', '', 1, 'NOTCORRECT_SK');
  bars_error.add_message(l_mod, 219, l_exc, l_ukr, 'Значення символу кас плану не повино бути быльшим за 99', '', 1, 'NOTCORRECT_SK');    

  bars_error.add_message(l_mod, 220, l_exc, l_rus, 'Значение электронного идентификатора саб = %s неуникально и присвоено нескольким контрагентам ', '', 1, 'SAB_DUBLS');
  bars_error.add_message(l_mod, 220, l_exc, l_ukr, 'Значення електроного iдентифiкатора саб =  %s неунiкальне i належить декiльком контрагентам'   , '', 1, 'SAB_DUBLS');    

  bars_error.add_message(l_mod, 221, l_exc, l_rus, '%s','',1,'INSEP_ERROR');
  bars_error.add_message(l_mod, 221, l_exc, l_ukr, '%s','',1,'INSEP_ERROR');    

  bars_error.add_message(l_mod, 222, l_exc, l_rus, 'Некорректное значение даты докумнта (больше/меньше месяца от банк.даты): %s', '', 1, 'NOTVALID_DATD');
  bars_error.add_message(l_mod, 222, l_exc, l_ukr, 'Некоректе значення дати документу (бiльше/менше мiсяця вiд банкiвської дати): %s'   , '', 1, 'NOTVALID_DATD');    

  bars_error.add_message(l_mod, 223, l_exc, l_rus, 'В платеже реф %s счет отправителя равен счету получателя: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');
  bars_error.add_message(l_mod, 223, l_exc, l_ukr, 'В платежi реф %s рахунок вiдправника та отримувача - однаковi: %s'   , '', 1, 'NLSA_NLSB_ARE_EQUAL');    

  bars_error.add_message(l_mod, 224, l_exc, l_rus, 'Длинна имени импортируемого файла не должна превышать 30 символов: %s', '', 1, 'FILENAME_TOO_LONG');
  bars_error.add_message(l_mod, 224, l_exc, l_ukr, 'Довжина iменi файлу не повинна перевищувати 30 символiв: %s'   , '', 1, 'FILENAME_TOO_LONG');    

  bars_error.add_message(l_mod, 225, l_exc, l_rus, 'Назначение платежа содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAZN');
  bars_error.add_message(l_mod, 225, l_exc, l_ukr, 'Призначення платежу мiстить недрукованi символи(напр.перехiд каретки)'     , '', 1, 'NOPRINT_CHAR_NAZN');    

  bars_error.add_message(l_mod, 226, l_exc, l_rus, 'Наименование плательщика содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAMA');
  bars_error.add_message(l_mod, 226, l_exc, l_ukr, 'Назва платника мiстить недрукованi символи(напр.перехiд каретки)'     , '', 1, 'NOPRINT_CHAR_NAMA');    

  bars_error.add_message(l_mod, 227, l_exc, l_rus, 'Наименование получателя содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAMB');
  bars_error.add_message(l_mod, 227, l_exc, l_ukr, 'Назва отримувача мiстить недрукованi символи(напр.перехiд каретки)'     , '', 1, 'NOPRINT_CHAR_NAMB');    

  bars_error.add_message(l_mod, 228, l_exc, l_rus, 'Балансовый для дебета счета %s и ob22=%s недопустим для операции %s', '', 1,        'NOTALLOWED_NBSOB22_D');
  bars_error.add_message(l_mod, 228, l_exc, l_ukr, 'Балансовий для дебету рахунку %s та ob22=%s недоступний для операцiї %s'     , '', 1, 'NOTALLOWED_NBSOB22_D');    

  bars_error.add_message(l_mod, 229, l_exc, l_rus, 'Балансовый для кредита для счета %s и ob22=%s недопустим для операции %s', '', 1,        'NOTALLOWED_NBSOB22_K');
  bars_error.add_message(l_mod, 229, l_exc, l_ukr, 'Балансовий для кредиту рахунку %s та ob22=%s недоступний для операцiї %s'     , '', 1, 'NOTALLOWED_NBSOB22_K');    

end;
/

commit;
