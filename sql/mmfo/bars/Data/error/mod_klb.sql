PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_KLB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль KLB ***
declare
  l_mod  varchar2(3) := 'KLB';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Клиент-банк', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Не найден тип сообщения %s ', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Не знайдено тип повiдомлення %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'В справочнике kl_customer_params нену описания для клиента  %s ', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'В довiднику kl_customer_params незнайдено опис для клiєнта  %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Неизвестный тип сообщения  %s ', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Невiдомий тип повiдомлення  %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Ненайден branch для sab %s ', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Не знайдено branch для sab %s', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Для филиала %s не определено значение SAB', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Для фiлiї %s не знайдено значення SAB', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Ненайден номер документа', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Незнайдено номер документа', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Отсутсвует дата документа', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Вiдсутня дата документа', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Не вказано наiменування вiдправника', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Не вказано МФО банка вiдправника', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не рахунок вiдправника', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не вказано ЗКПО вiдправника', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Не вказано наiменування отримувача', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Не вказано МФО банка отримувача', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не рахунок отримувача', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не вказано ЗКПО отримувача', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Не вказано суму документу', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Не вказано валюту документу', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Не вказано дату валютування', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Не вказано тип документу(vob)', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Призначення платежу повинне бути быльше 3-х символів', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не вказано тип операцiї', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не вказано признак деб./кред.', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Не вказано код валюти Б', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Не вказано суму у валюi Б', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Даний символ кас. плану не знайдено - %s', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Некоректно вказано числове значення для %s', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Не задане значення референції відправника', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Відсутній підпис ключа відповід. виконавця', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не задане значення ключа відповід. виконавця', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Рахунок %s(%s) не знайдено', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Доп. реквiзит %s не iснує в банку', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Назва(тег) доп. реквiзиту - пусте значення', '', 1, '32');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Рахунок тимчасово зайнятий iншою транзакцiєю', '', 1, '33');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Помилка оплати документу:
%s', '', 1, '34');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s', '', 1, '35');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Помилка пiдпису: %s: %s', '', 1, '36');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Помилка при оплатi in_sep - %s', '', 1, '37');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Операцiя %s, що оисана в палатежі - не описана в банку', '', 1, '38');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Вид документу %s - не описано в банку', '', 1, '39');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Не синхронiзованj параментр <рахунок каси> с банком. Передано рахунок-%s, в банку-%s', '', 1, '40');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Некоректно задано дату в полі %s', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Банкiвську дату %s закрито. Робота неможлива.', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Для МФО %s не вказано параметр RRPDAY в params$base', '', 1, '43');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'В документі для вставки послідуючого сплаченого рефу н знайдено тег Body', '', 1, '44');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Для докумнету % не передбачено обробку пакетом', '', 1, '45');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Для повідомлення % Невідомий тип % ', '', 1, '46');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Перший параметр для типу повідомлення % повинен бути датою, стоїть значення - %', '', 1, '47');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Для типу повыдомлення не описано схему вілповіді', '', 1, '48');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не найден тип сервиса %s ', '', 1, '49');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не знайдено тип сервiсу %s', '', 1, '49');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Ответ для номера запроса %s для партиции %s не найден', '', 1, '50');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Відповідь для номеру запиту %s для партиції %s не знайдено', '', 1, '50');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Ошибка вып. процедуры %s для вставки значения тега %s - %s', '', 1, '51');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Помилка при кикон. процедури %s для вставки значення тегу %s - %s', '', 1, '51');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не найден номер депозита - %s', '', 1, '52');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не знайдено номер депозиту - %s', '', 1, '52');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'В параметрах для бранча не описан параметр TRDPT (транзит для пополнения депозитов)', '', 1, '53');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'В параметрах для бранчу не описано параметр TRDPT (транзит для поповнення депозиту)', '', 1, '53');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Не существует транзитного счета %s для пополнения деп. вкладов в ТВБВ', '', 1, '54');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Не існує транзитного рахунку %s для поповнення деп.вкладу в ТВБВ', '', 1, '54');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Для главной операции не найден доп. реквизит номер договаро в ТВБВ (CNTR)', '', 1, '55');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Для головної операції не знайдено доп.реквізит номер угоди в ТВБВ (CNTR)', '', 1, '55');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Не найден номер депозита %s для бранча %s', '', 1, '56');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Не знайдено номер депозиту %s для бранча %s', '', 1, '56');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Не найдена запись в int_accn для счета с асс = %s', '', 1, '57');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Не знайдено запис в таблиці int_accn для рахунку з асс = %s', '', 1, '57');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Не найден счет %s, определяемый параметром GetTOBOParam(''TRDPT'') для бранча %s', '', 1, '58');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Не знайдено рахунок %s, що визначається параметром GetTOBOParam(''TRDPT'') для бранча %s', '', 1, '58');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Номер депозита %s уже сущестует', '', 1, '59');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Номер депозиту %s вже існує', '', 1, '59');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Не наден лицевой счет доходов по асс = %s', '', 1, '60');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Не знайдено рахунок доходів по асс = %s', '', 1, '60');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Не наден лицевой счет начисленных %% по асс = %s', '', 1, '61');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Не знайдено рахунок нарахованих %%  по асс = %s', '', 1, '61');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Доп. реквизит %s для реф. %s уже существует', '', 1, '62');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Доп. реквізит %s для реф. %s вже існує', '', 1, '62');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Для док-та отсутствует доп. реквизит %s ', '', 1, '63');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Для док-ту відсутній доп. реквізит %s', '', 1, '63');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Пакета с типом %s должен содержать лишь один запрос', '', 1, '64');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Пакет з типом %s повинен мвстити лише один запит', '', 1, '64');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Доп. реквизит %s не прошел валидацию', '', 1, '65');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Доп. реквізит %s не прйшов валідацію', '', 1, '65');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Входящая информация из пакета - пустая', '', 1, '66');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Вхідна інформація із пакету - пуста', '', 1, '66');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не знайдено ЗКПО вiдправника(поз.392-405)', '', 1, '67');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не знайдено МФО вiдправника', '', 1, '68');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Наш рах. %s(%s) не знайдено або для чужого рах. не вказано наыменування вiдправника', '', 1, '69');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Для операції %s(депозитної) не встановлено  доп.реквізит DPTOP(тип операції)', '', 1, '70');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Для операції %s(депозитної) не встановлено значення доп.реквізиту DPTOP по-замовчуванню', '', 1, '71');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Для синхронізації в описі довідника %s в вибірці SELECT_STMT відсутнє поле ACTION', '', 1, '72');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Довідник %s не описано в табл.  xml_reflist або не включено в синхронызацію', '', 1, '73');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Для только что вставленного док-та с реф = %s не найден доп. реквизит CNTR', '', 1, '74');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Для только что вставленного док-та с реф = %s не найден доп. реквизит CNTR', '', 1, '74');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Депозит %s було відкрито, але платіж на первинний внесо не було зареєстровано в xml_reaque', '', 1, '75');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Депозит %s был открыт, но платеж на первичный взнос не был зарегистрирован в очереди  xml_refque', '', 1, '75');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Неккоректное описание справочника % для синхронизации (пустое значение для синхроних част. и зарегистрирован в ORACLE STREAMS)', '', 1, '76');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Неккоректное описание справочника % для синхронизации (пустое значение для синхроних част. и зарегистрирован в ORACLE STREAMS', '', 1, '76');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, 'Для отделения(бранча) %s не указан параметр RNK в branch_parameters', '', 1, '77');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, 'Для відділення(БРАНЧУ) %s не вказано параметр RNK в branch_parameters', '', 1, '77');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, 'Клиент с RNK = %s не описан как участник оффлайн ', '', 1, '78');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, 'Клієнт з RNK = %s не описано як участник оффлайн', '', 1, '78');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, 'Ни для одного справочника xml_reflist_reqv не прописан тип сообщения %s ', '', 1, '79');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, 'Ни для одного справочника xml_reflist_reqv не прописан тип сообщения %s', '', 1, '79');

    bars_error.add_message(l_mod, 80, l_exc, l_rus, 'Пользователь %s не описан как пользователь АБС в staff$base', '', 1, '80');
    bars_error.add_message(l_mod, 80, l_exc, l_ukr, 'Пользователь %s не описан как пользователь АБС в staff$base', '', 1, '80');

    bars_error.add_message(l_mod, 81, l_exc, l_rus, 'Невозможно найти клиента с РНК %s', '', 1, '81');
    bars_error.add_message(l_mod, 81, l_exc, l_ukr, 'Невозможно найти клиента с РНК %s', '', 1, '81');

    bars_error.add_message(l_mod, 82, l_exc, l_rus, 'Для клиента с РНК %s не описан САБ', '', 1, '82');
    bars_error.add_message(l_mod, 82, l_exc, l_ukr, 'Для клиента с РНК %s не описан САБ', '', 1, '82');

    bars_error.add_message(l_mod, 83, l_exc, l_rus, 'Файл "%s" уже был импортирован %s.', '', 1, 'FILE_ALREADY_IMPORTED');
    bars_error.add_message(l_mod, 83, l_exc, l_ukr, 'Файл "%s" вже було імпортовано %s.', '', 1, 'FILE_ALREADY_IMPORTED');

    bars_error.add_message(l_mod, 84, l_exc, l_rus, 'Символ кассплана %s не существует', '', 1, '84');
    bars_error.add_message(l_mod, 84, l_exc, l_ukr, 'Символ касплану %s не icнує', '', 1, '84');

    bars_error.add_message(l_mod, 85, l_exc, l_rus, 'Неверный контр.разряд для счтеа отправителя %s', '', 1, '85');
    bars_error.add_message(l_mod, 85, l_exc, l_ukr, 'Некоректний контр.розряд для рах. вiдправника  %s ', '', 1, '85');

    bars_error.add_message(l_mod, 86, l_exc, l_rus, 'Неверный контр.разряд для счтеа получателя %s', '', 1, '86');
    bars_error.add_message(l_mod, 86, l_exc, l_ukr, 'Некоректний контр.розряд для рах. отримувача  %s ', '', 1, '86');

    bars_error.add_message(l_mod, 87, l_exc, l_rus, 'Некорректное значение ОКПО отправителя %s', '', 1, '87');
    bars_error.add_message(l_mod, 87, l_exc, l_ukr, 'Некоректне значення ЗКПО вiдправника %s', '', 1, '87');

    bars_error.add_message(l_mod, 88, l_exc, l_rus, 'Значение ОКПО отправителя %s не числовой код', '', 1, '88');
    bars_error.add_message(l_mod, 88, l_exc, l_ukr, 'Значення ЗКПО вiдправника %s не числовий код', '', 1, '88');

    bars_error.add_message(l_mod, 89, l_exc, l_rus, 'Длинна ОКПО отправиьеля %s меншье за 8 символов', '', 1, '89');
    bars_error.add_message(l_mod, 89, l_exc, l_ukr, 'Довжина ЗКПО вiдправника %s менша за 8 символiв', '', 1, '89');

    bars_error.add_message(l_mod, 90, l_exc, l_rus, 'МФО отрправителя %s не существует', '', 1, '90');
    bars_error.add_message(l_mod, 90, l_exc, l_ukr, 'МФО вiдправника %s не iснуе', '', 1, '90');

    bars_error.add_message(l_mod, 91, l_exc, l_rus, 'МФО отрправителя %s блокировано', '', 1, '91');
    bars_error.add_message(l_mod, 91, l_exc, l_ukr, 'МФО вiдправника %s блоковано', '', 1, '91');

    bars_error.add_message(l_mod, 92, l_exc, l_rus, 'Значение ОКПО получателя %s не числовой код', '', 1, '92');
    bars_error.add_message(l_mod, 92, l_exc, l_ukr, 'Значення ЗКПО отримувача %s не числовий код', '', 1, '92');

    bars_error.add_message(l_mod, 93, l_exc, l_rus, 'Длинна ОКПО получателя %s меншье за 8 символов', '', 1, '93');
    bars_error.add_message(l_mod, 93, l_exc, l_ukr, 'Довжина ЗКПО отримувача %s менша за 8 символiв', '', 1, '93');

    bars_error.add_message(l_mod, 94, l_exc, l_rus, 'Некорректное значение ОКПО получателя %s', '', 1, '94');
    bars_error.add_message(l_mod, 94, l_exc, l_ukr, 'Некоректне значення ЗКПО отримувача %s', '', 1, '94');

    bars_error.add_message(l_mod, 95, l_exc, l_rus, 'МФО получателя %s блокировано', '', 1, '95');
    bars_error.add_message(l_mod, 95, l_exc, l_ukr, 'МФО отримувача %s блоковано', '', 1, '95');

    bars_error.add_message(l_mod, 96, l_exc, l_rus, 'МФО получателя %s не существует', '', 1, '96');
    bars_error.add_message(l_mod, 96, l_exc, l_ukr, 'МФО отримувача %s не iснуе', '', 1, '96');

    bars_error.add_message(l_mod, 97, l_exc, l_rus, 'Для прихода кассы неверный символ кас.плана %s (должнен быть 2-39)', '', 1, '97');
    bars_error.add_message(l_mod, 97, l_exc, l_ukr, 'Для прихiда касы невiрний символ %s кас.плану (повиненн бути 2-39)', '', 1, '97');

    bars_error.add_message(l_mod, 98, l_exc, l_rus, 'Для расхода кассы неверный символ кас.плана %s (должнен быть 40-73)', '', 1, '98');
    bars_error.add_message(l_mod, 98, l_exc, l_ukr, 'Для видатку каси невiрний символ %s кас.плану (повиненн бути 40-73)', '', 1, '98');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, 'Не вказано ЗКПО отримувача', '', 1, '99');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Не вказано МФО отримувача', '', 1, '100');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Не вказано наiменування отримувача', '', 1, '101');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '%s', '', 1, '102');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '%s', '', 1, '102');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Входящее направление блокировано', '', 1, '106');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Вх_дний напрямок блоковано', '', 1, '106');

    bars_error.add_message(l_mod, 111, l_exc, l_rus, 'Тип сообщения не описан в главном банке %s ', '', 1, '111');
    bars_error.add_message(l_mod, 111, l_exc, l_ukr, 'Тип пов_домлення не описано в головному банку %s', '', 1, '111');

    bars_error.add_message(l_mod, 112, l_exc, l_rus, 'Неизвестный тип поска корреспондента %s ', '', 1, '112');
    bars_error.add_message(l_mod, 112, l_exc, l_ukr, 'Нев_домий тип пошуку корреспонденту %s', '', 1, '112');

    bars_error.add_message(l_mod, 113, l_exc, l_rus, 'Неизвестный справочник для синхронизации %s ', '', 1, '113');
    bars_error.add_message(l_mod, 113, l_exc, l_ukr, 'Невiдомий дов_дник для синхрон_зац_ї %s', '', 1, '113');

    bars_error.add_message(l_mod, 114, l_exc, l_rus, 'Неизвестный справочник для синхронизации %s ', '', 1, '114');
    bars_error.add_message(l_mod, 114, l_exc, l_ukr, 'Невiдомий дов_дник для синхрон_зац_ї %s', '', 1, '114');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s', '', 1, '150');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, 'Некоректний формат дати в полі дати документу - %s', '', 1, '151');

    bars_error.add_message(l_mod, 152, l_exc, l_rus, 'Некоректний формат суми платежу - %s', '', 1, '152');

    bars_error.add_message(l_mod, 153, l_exc, l_rus, 'Неможливо привести до числа значення коду валюти А - %s', '', 1, '153');

    bars_error.add_message(l_mod, 154, l_exc, l_rus, 'Некоректний формат дати валютування - %s', '', 1, '154');

    bars_error.add_message(l_mod, 155, l_exc, l_rus, 'Неможливо привести до числа значення виду обробки - %s', '', 1, '155');

    bars_error.add_message(l_mod, 156, l_exc, l_rus, 'Неможливо привести до числа значення симв.касплану - %s', '', 1, '156');

    bars_error.add_message(l_mod, 157, l_exc, l_rus, 'Неможливо привести до числа значення ДК - %s', '', 1, '157');

    bars_error.add_message(l_mod, 158, l_exc, l_rus, 'Неможливо привести до числа значення коду валюти Б - %s', '', 1, '158');

    bars_error.add_message(l_mod, 159, l_exc, l_rus, 'Некоректний формат суми Б платежу - %s', '', 1, '159');

    bars_error.add_message(l_mod, 160, l_exc, l_rus, 'Некоректний формат дати платежу - %s', '', 1, '160');

    bars_error.add_message(l_mod, 161, l_exc, l_rus, 'Для операції %s не описано тип документу vob', '', 1, '161');

    bars_error.add_message(l_mod, 162, l_exc, l_rus, 'Імпортований документ з реф.імпорту %s не знайдено', '', 1, '162');

    bars_error.add_message(l_mod, 163, l_exc, l_rus, 'Значення доп. реквiзиту %s - пусте', '', 1, '163');

    bars_error.add_message(l_mod, 164, l_exc, l_rus, 'Файл %s за дату %s не був проiмпортований', '', 1, '164');

    bars_error.add_message(l_mod, 165, l_exc, l_rus, 'Не задано символ кас.плану', '', 1, '165');

    bars_error.add_message(l_mod, 166, l_exc, l_rus, 'Неможливо видалити вже видалений або сплачений документ', '', 1, '166');

    bars_error.add_message(l_mod, 167, l_exc, l_rus, 'Неможливо змінити реквізити вже видаленого або сплаченого документу', '', 1, '167');

    bars_error.add_message(l_mod, 168, l_exc, l_rus, 'Рахунок відправника %s не існує в нашому банку', '', 1, '168');

    bars_error.add_message(l_mod, 169, l_exc, l_rus, 'Рахунок отримувача %s не існує в нашому банку', '', 1, '169');

    bars_error.add_message(l_mod, 170, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCLOCAL - група рахунків(локальна) для синхронізації offline', '', 1, '170');

    bars_error.add_message(l_mod, 171, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCPARNT - група рахунків(вище на рівень) для синхронізації offline', '', 1, '171');

    bars_error.add_message(l_mod, 172, l_exc, l_rus, 'В глобальних параметрах (params$global) не описано параметр SNCGLBL - група рахунків(глобальна) для синхронізації offline', '', 1, '172');

    bars_error.add_message(l_mod, 173, l_exc, l_rus, 'Значення рахунку А рівне значенню рахунка Б', '', 1, '173');

    bars_error.add_message(l_mod, 174, l_exc, l_rus, 'Пусте значення БІС стрічки для реквизиту %s', '', 1, '174');

    bars_error.add_message(l_mod, 175, l_exc, l_rus, 'Реквізит %s - не існує', '', 1, '175');

    bars_error.add_message(l_mod, 176, l_exc, l_rus, 'Реквізит %s вже існує для даного документу', '', 1, '176');

    bars_error.add_message(l_mod, 177, l_exc, l_rus, 'Для платежу по депозиту № %s (операція %s ) не вказано тип депозиту (доп. реквізит DPTPR)', '', 1, '177');

    bars_error.add_message(l_mod, 178, l_exc, l_rus, 'Для платежа по депозиту № %s не указано или указано неправильно тип депозита DPTPR (должно быть DPT1 или DPT2)', '', 1, '178');

    bars_error.add_message(l_mod, 179, l_exc, l_rus, 'Не знайдено данi по реквiзитам: %s', '', 1, '179');

    bars_error.add_message(l_mod, 180, l_exc, l_rus, 'Не знайдене МФО %s', '', 1, '180');

    bars_error.add_message(l_mod, 181, l_exc, l_rus, 'Тип повідомлення %s не оброблюється для заключення доп. угод', '', 1, '181');

    bars_error.add_message(l_mod, 182, l_exc, l_rus, 'Номер угоди(унікальний номер головного банку) %s не знайдено в головному банку ', '', 1, '182');

    bars_error.add_message(l_mod, 183, l_exc, l_rus, 'Дата видачі документу %s, менша за дату народження %s', '', 1, '183');

    bars_error.add_message(l_mod, 184, l_exc, l_rus, 'Кол-во записей в таблице изменений aq_refsync_tbl превышает 10000. Автоматическая работа джоба может не отработать. Очистите таблицу или сформируйте пакеты для JBOSS вручную', '', 1, '184');
    bars_error.add_message(l_mod, 184, l_exc, l_ukr, 'Кол-во записей в таблице изменений aq_refsync_tbl превышает 10000. Автоматическая работа джоба может не отработать. Очистите таблицу или сформируйте пакеты для JBOSS вручную', '', 1, '184');

    bars_error.add_message(l_mod, 185, l_exc, l_rus, 'Длинна номера счета для %s не может привышать 14-ти символов', '', 1, '185');
    bars_error.add_message(l_mod, 185, l_exc, l_ukr, 'Довжина номеру рахунку для %s не може перевищувати 14-ти символів', '', 1, '185');

    bars_error.add_message(l_mod, 186, l_exc, l_rus, 'Длинна наименования клиента: %s не должна превышать 38-ми символов', '', 1, '186');
    bars_error.add_message(l_mod, 186, l_exc, l_ukr, 'Довжина назви клієнта: %s не повинна перевищувати 38-ми символів', '', 1, '186');

    bars_error.add_message(l_mod, 187, l_exc, l_rus, 'Длинна назначения платежа не должна превышать 160 симовлов(для продовження призначення платежу використовуйте доп. реквізити С)', '', 1, '187');
    bars_error.add_message(l_mod, 187, l_exc, l_ukr, 'Довжина призначення платежу не повинна перевищувати 160-ти символів(для продовження призначення платежу використовуйте доп.реквізити С)', '', 1, '187');

    bars_error.add_message(l_mod, 188, l_exc, l_rus, 'Номер депозита %s не соответствует маске xxxxxx/N (xxxxxx-код отд., N-числовой № деп.) ', '', 1, '188');
    bars_error.add_message(l_mod, 188, l_exc, l_ukr, 'Номер депозиту %s не відповідає масці xxxxxx/N (xxxxxx-код відділ., N-числовий № деп.)', '', 1, '188');

    bars_error.add_message(l_mod, 189, l_exc, l_rus, 'Параметр DPTNUM для %s - должен быть числом, а его значение сейчас равно %s ', '', 1, '189');
    bars_error.add_message(l_mod, 189, l_exc, l_ukr, 'Параметр DPTNUM для %s - повинен бути числом, а його значення зараз дорівнює %s', '', 1, '189');

    bars_error.add_message(l_mod, 190, l_exc, l_rus, 'Некорректний номер депозиту: %s. Оперцію було введено не через депозитний портфель', '', 1, '190');
    bars_error.add_message(l_mod, 190, l_exc, l_ukr, 'Некорректный номер депозита: %s. Оперцию ввели не через депозитный портфель', '', 1, '190');

    bars_error.add_message(l_mod, 191, l_exc, l_rus, 'Для операции с депозитом %s - не описана соответствующая операция для офлайн отделения', '', 1, 'NOTEXISTS_OFFLINE_TT');
    bars_error.add_message(l_mod, 191, l_exc, l_ukr, 'Для операції з депозитом %s - не описано відповідну операцію для офлайн відділення', '', 1, 'NOTEXISTS_OFFLINE_TT');

    bars_error.add_message(l_mod, 192, l_exc, l_rus, 'Указанное значение РНК %s не найдено', '', 1, 'NO_SUCH_RNK');
    bars_error.add_message(l_mod, 192, l_exc, l_ukr, 'Вказане значення  РНК %s не найдене', '', 1, 'NO_SUCH_RNK');

    bars_error.add_message(l_mod, 193, l_exc, l_rus, 'Указанное значение бранча %s не найдено', '', 1, 'NO_SUCH_BRANCH');
    bars_error.add_message(l_mod, 193, l_exc, l_ukr, 'Вказане значення  бранчу %s не найдене', '', 1, 'NO_SUCH_BRANCH');

    bars_error.add_message(l_mod, 194, l_exc, l_rus, 'Не указано значение бранча для отделения', '', 1, 'NO_BRANCH');
    bars_error.add_message(l_mod, 194, l_exc, l_ukr, 'Не вказано значення бранчу для відділення', '', 1, 'NO_BRANCH');

    bars_error.add_message(l_mod, 195, l_exc, l_rus, 'Не указано значение электронного идентификатора(САБ) для %s', '', 1, 'NO_SAB');
    bars_error.add_message(l_mod, 195, l_exc, l_ukr, 'Не вказано значення електронного ідентифікатора(САБ) для %s', '', 1, 'NO_SAB');

    bars_error.add_message(l_mod, 196, l_exc, l_rus, 'Не указано значение ключа технолога для %s', '', 1, 'NO_TECHKEY');
    bars_error.add_message(l_mod, 196, l_exc, l_ukr, 'Не вказано значення ключа технолога для %s', '', 1, 'NO_TECHKEY');

    bars_error.add_message(l_mod, 197, l_exc, l_rus, 'Для указанного РНК %s, вы указали бранч %s, а для него проставлен бранч %s', '', 1, 'NOT_CORRECT_BRANCH');
    bars_error.add_message(l_mod, 197, l_exc, l_ukr, 'Для вказаного РНК %s, ви вказали бранч %s, а для нього проставлено бранч %s', '', 1, 'NOT_CORRECT_BRANCH');

    bars_error.add_message(l_mod, 198, l_exc, l_rus, 'Указнный бранч %s должен быть второго или третьего уровня', '', 1, 'NOT_CORRECT_BRANCH2');
    bars_error.add_message(l_mod, 198, l_exc, l_ukr, 'Вказаний бранч %s повинен бути другого або третього рівня', '', 1, 'NOT_CORRECT_BRANCH2');

    bars_error.add_message(l_mod, 199, l_exc, l_rus, 'Электронный идентификатор(САБ) %s для отделения %s должен состоять из 6-ти символов', '', 1, 'NOT_CORRECT_SAB');
    bars_error.add_message(l_mod, 199, l_exc, l_ukr, 'Електронний ідентифікатор(САБ) %s для відділення %s повинен містити 6-ть символів', '', 1, 'NOT_CORRECT_SAB');

    bars_error.add_message(l_mod, 200, l_exc, l_rus, 'Электронный идентификатор(САБ) файла %s для отделения %s должен состоять из 6-ти символов', '', 1, 'NOT_CORRECT_FILESAB');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, 'Електронний ідентифікатор(САБ) файлу %s для відділення %s повинен містити 6-ть символів', '', 1, 'NOT_CORRECT_FILESAB');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, 'Ключ технолога %s для отделения %s должен состоять из 5-ти символов', '', 1, 'NOT_CORRECT_TECHKEY');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'Ключ технолога %s для відділення %s повинен містити 5-ть символів', '', 1, 'NOT_CORRECT_TECHKEY');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Указанный САБ %s уже существует у другого клиента', '', 1, 'SUCH_SAB_EXISTS');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Вказаний САБ %s вже існує у іншого клієнта', '', 1, 'SUCH_SAB_EXISTS');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Сбился сиквенс %s, возвратив значение %s, которое уже есть в staff$base', '', 1, 'BROKEN_SEQUENCE');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Сбился сиквенс %s, возвратив значение %s, которое уже есть в staff$base', '', 1, 'BROKEN_SEQUENCE');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, 'Доп.реквизит <тип операции с депозитом> (DPTOP) - нечисловое значение %s', '', 1, 'PTOP_NOT_NUMBER');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, 'Доп.реквізит <тип операції з депозитом> (DPTOP) - не числове значення %s', '', 1, 'PTOP_NOT_NUMBER');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, 'Дата валютирования больше или меншье банк.даты на 1 месяц %s', '', 1, 'NOT_CORRECT_PAYDATE');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, 'Дата валютування більша або менша за банк.дату на 1 місяць %s', '', 1, 'NOT_CORRECT_PAYDATE');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, 'Тип доп. соглашения %s не обрабатывается', '', 1, 'NOT_AGREEMENT_TYPE');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, 'Тип доп. угоди %s не обробляється ', '', 1, 'NOT_AGREEMENT_TYPE');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, 'Недопускаются внутренние информационные платежи', '', 1, 'INNER_INFO_NOTALLOWED');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, 'Недозволено проводити внутрішні інформаційні платежі', '', 1, 'INNER_INFO_NOTALLOWED');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, 'Ни одно из МФО не равно МФО нашего банка', '', 1, 'NO_OUR_MFO');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, 'Жодне з МФО не дорівнює МФО нашого банку', '', 1, 'NO_OUR_MFO');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, 'Счет %s(%s) не существует в нашем банке', '', 1, 'NO_ACCOUNT_FOUND');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, 'Рахунок %s(%s) не існує в нашому банку', '', 1, 'NO_ACCOUNT_FOUND');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, 'Для МФО-%s, счет %s(%s) не найдено реквизити в справочнике внешних контрагентов', '', 1, 'NO_ALIEN_FOUND');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, 'Для МФО-%s, рахунок %s(%s) не знайдено реквізити в довіднику зовнішніх контрагентів', '', 1, 'NO_ALIEN_FOUND');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, 'Найденное значение ОКПО для клиента с рнк=%s (для счета %s-%s) некорректно: %s', '', 1, 'CUST_OKPO_NOTCORRECT');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, 'Знайдене значення ЗКРО для клієнта з рнк=%s (для рахунку %s-%s) некорректне: %s', '', 1, 'CUST_OKPO_NOTCORRECT');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, 'Ошибка при поиске ОКПО для счета %s(%s) в справочнике других конрагентов(ALIEN): %s', '', 1, 'ALIEN_OKPO_NOTCORRECT');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, 'Помилка при пошуку ЗКПО для рахунку %s(%s) в довіднику інших конрагентів(ALIEN): %s', '', 1, 'ALIEN_OKPO_NOTCORRECT');

    bars_error.add_message(l_mod, 213, l_exc, l_rus, 'В документі є реквізити для первинного внеску для депозиту %s. Але первинний внесок вже було зроблено', '', 1, 'SUCH_DRECDPT_WASPAYED');
    bars_error.add_message(l_mod, 213, l_exc, l_ukr, 'В документі є реквізити для первинного внеску для депозиту %s. Але первинний внесок вже було зроблено', '', 1, 'SUCH_DRECDPT_WASPAYED');

    bars_error.add_message(l_mod, 214, l_exc, l_rus, 'Недостаточно прав на дебет счета %s(%s)', '', 1, 'NO_DEBET_RIGHTS');
    bars_error.add_message(l_mod, 214, l_exc, l_ukr, 'Недостатньо прав на дебет рахунку %s(%s)', '', 1, 'NO_DEBET_RIGHTS');

    bars_error.add_message(l_mod, 215, l_exc, l_rus, 'Недостаточно прав на кредит счета %s(%s)', '', 1, 'NO_KREDIT_RIGHTS');
    bars_error.add_message(l_mod, 215, l_exc, l_ukr, 'Недостатньо прав на кредит рахунку %s(%s)', '', 1, 'NO_KREDIT_RIGHTS');

    bars_error.add_message(l_mod, 216, l_exc, l_rus, 'Дебет со счета не своего МФО %s', '', 1, 'NOT_OUR_MFO');
    bars_error.add_message(l_mod, 216, l_exc, l_ukr, 'Дебет з рахунку не свого МФО %s', '', 1, 'NOT_OUR_MFO');

    bars_error.add_message(l_mod, 217, l_exc, l_rus, 'Не указан саб для клиента для выгрузки справочника %s (нужен для версии одного МФО)', '', 1, 'NO_SAB_FORREF');
    bars_error.add_message(l_mod, 217, l_exc, l_ukr, 'Не вказано саб для клiєнту для вигрузки довiдника %s (потрiбен для версii одного МФО)', '', 1, 'NO_SAB_FORREF');

    bars_error.add_message(l_mod, 218, l_exc, l_rus, 'Не существует такого идентификатора клиента для выгрузки справочника %s', '', 1, 'NO_SUCHSAB_FORREF');
    bars_error.add_message(l_mod, 218, l_exc, l_ukr, 'Не icyє такого iдентифiкатору клiєнта для  вигрузки довiдника %s (потрiбен для версii одного МФО)', '', 1, 'NO_SUCHSAB_FORREF');

    bars_error.add_message(l_mod, 219, l_exc, l_rus, 'Значение символа касс плана не должно быть больше 99', '', 1, 'NOTCORRECT_SK');
    bars_error.add_message(l_mod, 219, l_exc, l_ukr, 'Значення символу кас плану не повино бути быльшим за 99', '', 1, 'NOTCORRECT_SK');

    bars_error.add_message(l_mod, 220, l_exc, l_rus, 'Значение электронного идентификатора саб = %s неуникально и присвоено нескольким контрагентам ', '', 1, 'SAB_DUBLS');
    bars_error.add_message(l_mod, 220, l_exc, l_ukr, 'Значення електроного iдентифiкатора саб =  %s неунiкальне i належить декiльком контрагентам', '', 1, 'SAB_DUBLS');

    bars_error.add_message(l_mod, 221, l_exc, l_rus, '%s', '', 1, 'INSEP_ERROR');
    bars_error.add_message(l_mod, 221, l_exc, l_ukr, '%s', '', 1, 'INSEP_ERROR');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, 'Некорректное значение даты докумнта (больше/меньше месяца от банк.даты): %s', '', 1, 'NOTVALID_DATD');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, 'Некоректе значення дати документу (бiльше/менше мiсяця вiд банкiвської дати): %s', '', 1, 'NOTVALID_DATD');

    bars_error.add_message(l_mod, 223, l_exc, l_rus, 'В платеже реф %s счет отправителя равен счету получателя: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');
    bars_error.add_message(l_mod, 223, l_exc, l_ukr, 'В платежi реф %s рахунок вiдправника та отримувача - однаковi: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');

    bars_error.add_message(l_mod, 224, l_exc, l_rus, 'Длинна имени импортируемого файла не должна превышать 30 символов: %s', '', 1, 'FILENAME_TOO_LONG');
    bars_error.add_message(l_mod, 224, l_exc, l_ukr, 'Довжина iменi файлу не повинна перевищувати 30 символiв: %s', '', 1, 'FILENAME_TOO_LONG');

    bars_error.add_message(l_mod, 225, l_exc, l_rus, 'Назначение платежа содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAZN');
    bars_error.add_message(l_mod, 225, l_exc, l_ukr, 'Призначення платежу мiстить недрукованi символи(напр.перехiд каретки)', '', 1, 'NOPRINT_CHAR_NAZN');

    bars_error.add_message(l_mod, 226, l_exc, l_rus, 'Наименование плательщика содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAMA');
    bars_error.add_message(l_mod, 226, l_exc, l_ukr, 'Назва платника мiстить недрукованi символи(напр.перехiд каретки)', '', 1, 'NOPRINT_CHAR_NAMA');

    bars_error.add_message(l_mod, 227, l_exc, l_rus, 'Наименование получателя содержит непечатные символы(напр.перевод каретки)', '', 1, 'NOPRINT_CHAR_NAMB');
    bars_error.add_message(l_mod, 227, l_exc, l_ukr, 'Назва отримувача мiстить недрукованi символи(напр.перехiд каретки)', '', 1, 'NOPRINT_CHAR_NAMB');

    bars_error.add_message(l_mod, 228, l_exc, l_rus, 'Балансовый для дебета счета %s и ob22=%s недопустим для операции %s', '', 1, 'NOTALLOWED_NBSOB22_D');
    bars_error.add_message(l_mod, 228, l_exc, l_ukr, 'Балансовий для дебету рахунку %s та ob22=%s недоступний для операцiї %s', '', 1, 'NOTALLOWED_NBSOB22_D');

    bars_error.add_message(l_mod, 229, l_exc, l_rus, 'Балансовый для кредита для счета %s и ob22=%s недопустим для операции %s', '', 1, 'NOTALLOWED_NBSOB22_K');
    bars_error.add_message(l_mod, 229, l_exc, l_ukr, 'Балансовий для кредиту рахунку %s та ob22=%s недоступний для операцiї %s', '', 1, 'NOTALLOWED_NBSOB22_K');

    bars_error.add_message(l_mod, 230, l_exc, l_rus, 'Сумма не может быть нулевой для документа', '', 1, 'NULLABLE_SUM');
    bars_error.add_message(l_mod, 230, l_exc, l_ukr, 'Сума не може бути нульовою для документу', '', 1, 'NULLABLE_SUM');

    bars_error.add_message(l_mod, 231, l_exc, l_rus, 'Дубль документа #%s', '', 1, 'DUPLICATE_DOCUMENT');
    bars_error.add_message(l_mod, 231, l_exc, l_ukr, 'Дубль документу #%s', '', 1, 'DUPLICATE_DOCUMENT');

    bars_error.add_message(l_mod, 232, l_exc, l_rus, 'Дата документу больше или меншье банк.даты на 1 месяц %s', '', 1, 'NOT_CORRECT_DATD');
    bars_error.add_message(l_mod, 232, l_exc, l_ukr, 'Дата валютування більша або менша за банк.дату на 1 місяць %s', '', 1, 'NOT_CORRECT_DATD');

    bars_error.add_message(l_mod, 233, l_exc, l_rus, 'Не указан номер паспорта', '', 1, 'NOT_CORRECT_PASSP');
    bars_error.add_message(l_mod, 233, l_exc, l_ukr, 'Не вказано номер паспорту', '', 1, 'NOT_CORRECT_PASSP');

    bars_error.add_message(l_mod, 234, l_exc, l_rus, 'Невірна послідовність дат в платежі (рекв 10,11 і поточна) %s', '', 1, 'NOT_CORRECT_DATP');
    bars_error.add_message(l_mod, 234, l_exc, l_ukr, 'Невірна послідовність дат в платежі (рекв 10,11 і поточна) %s', '', 1, 'NOT_CORRECT_DATP');

    bars_error.add_message(l_mod, 235, l_exc, l_rus, 'Оплата документов закрыта технологом', '', 1, 'CLOSE_PAY_DOCS');
    bars_error.add_message(l_mod, 235, l_exc, l_ukr, 'Оплату документів заблоковано технологом', '', 1, 'CLOSE_PAY_DOCS');

    bars_error.add_message(l_mod, 236, l_exc, l_rus, 'Счет плательщика %s(%s) - закрыт', '', 1, 'CLOSE_PAYER_ACCOUNT');
    bars_error.add_message(l_mod, 236, l_exc, l_ukr, 'Рахунок платника %s(%s) - закрито', '', 1, 'CLOSE_PAYER_ACCOUNT');

    bars_error.add_message(l_mod, 237, l_exc, l_rus, 'Счет получателя %s(%s) - закрыт', '', 1, 'CLOSE_PAYEE_ACCOUNT');
    bars_error.add_message(l_mod, 237, l_exc, l_ukr, 'Рахунок отримувача %s(%s) - закрито', '', 1, 'CLOSE_PAYEE_ACCOUNT');

    bars_error.add_message(l_mod, 238, l_exc, l_rus, 'В документе не должно быть более 99-ти строк BIS', '', 1, 'MORE_THAN_99_BIS');
    bars_error.add_message(l_mod, 238, l_exc, l_ukr, 'В документі не повинно бути більш ніж 99-ть BIS строк', '', 1, 'MORE_THAN_99_BIS');

    bars_error.add_message(l_mod, 239, l_exc, l_rus, 'Для опреации загрузки банкомата из кассы, символ касс. плана = 66, а проставлен %s', '', 1, 'NOT_CORRECT_CASH66');
    bars_error.add_message(l_mod, 239, l_exc, l_ukr, 'Для операції завантаження банкомату із каси, символ кас. плану = 66, а проставлено %s', '', 1, 'NOT_CORRECT_CASH66');

    bars_error.add_message(l_mod, 240, l_exc, l_rus, 'Для опреации отгрузки из банкомата в кассу, символ касс. плана = 39, а проставлен %s', '', 1, 'NOT_CORRECT_CASH39');
    bars_error.add_message(l_mod, 240, l_exc, l_ukr, 'Для операції вивантаження з банкомату в касу, символ кас. плану = 39, а проставлено %s', '', 1, 'NOT_CORRECT_CASH39');

    bars_error.add_message(l_mod, 241, l_exc, l_rus, 'Некорректный контрольный разряд для счета отправителя %s', '', 1, 'NOTCORECT_CHECK_DIGIT_A');
    bars_error.add_message(l_mod, 241, l_exc, l_ukr, 'Некоректний контрольний розряд для рахунку відправника %s', '', 1, 'NOTCORECT_CHECK_DIGIT_A');

    bars_error.add_message(l_mod, 242, l_exc, l_rus, 'Некорректный контрольный разряд для счета получателя %s', '', 1, 'NOTCORECT_CHECK_DIGIT_B');
    bars_error.add_message(l_mod, 242, l_exc, l_ukr, 'Некоректний контрольний розряд для рахунку отпримувача %s', '', 1, 'NOTCORECT_CHECK_DIGIT_B');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_KLB.sql =========*** Run *** ==
PROMPT ===================================================================================== 
