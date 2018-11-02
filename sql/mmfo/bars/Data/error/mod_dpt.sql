PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_DPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль DPT ***
declare
  l_mod  varchar2(3) := 'DPT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Депозиты физ.лиц.', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Невозможно получить идентификатор договора', '', 1, 'CANT_GET_DPTID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Неможливо отримати ідентифікатор договору', '', 1, 'CANT_GET_DPTID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Невозможно получить номер договора', '', 1, 'CANT_GET_DPTNUM');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Неможливо отримати номер договору', '', 1, 'CANT_GET_DPTNUM');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не найден ответственный исполнитель', '', 1, 'ISP_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не знайдений відповідальний виконавець', '', 1, 'ISP_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Не найден (или закрыт) вид вклада № %s', '', 1, 'VIDD_NOT_FOUND_OR_CLOSED');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Не знайдений (або закритий) вид вкладу № %s', '', 1, 'VIDD_NOT_FOUND_OR_CLOSED');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Ошибка вычисления длительности вклада', '', 1, 'INVALID_DPT_TERM');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Помилка обчислення строку вкладу', '', 1, 'INVALID_DPT_TERM');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Не найден (или закрыт) счет консолидации = %s', '', 1, 'CONSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Не знайдений (або закритий) рахунок консолідації = %s', '', 1, 'CONSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Ошибка при формировании номера счета (%s) по договору № %s/%s (вид вклада = %s, клиент № %s): %s', '', 1, 'NLS_MASK_FAILED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Помилка при формуванні номеру рахунку (%s) по договору № %s/%s (вид вкладу = %s, клієнт № %s): %s', '', 1, 'NLS_MASK_FAILED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Ошибка при формировании названия счета (%s) по договору № %s/%s (вид вклада = %s, клиент № %s): %s', '', 1, 'NMS_MASK_FAILED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Помилка при формуванні назви рахунку (%s) по договору № %s/%s (вид вкладу = %s, клієнт № %s): %s', '', 1, 'NMS_MASK_FAILED');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Ошибка при открытии счета № %s / %s : %s', '', 1, 'OPENACC_FAILED');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Помилка при відкритті рахунку № %s / %s : %s', '', 1, 'OPENACC_FAILED');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Не найден cчет амортизациии процентов для договора № %s', '', 1, 'AMRACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Не знайдений рахунок амортизації відсотків для договору № %s', '', 1, 'AMRACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не найдена операция безналичной выплаты процентов', '', 1, 'PAYINT_TT_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Не знайдена операція безготівкової виплати відсотків', '', 1, 'PAYINT_TT_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Ошибка при заполнении процентной карточки: %s', '', 1, 'FILL_INTCARD_FAILED');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Помилка при заповненні відсоткової картки: %s ', '', 1, 'FILL_INTCARD_FAILED');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Ошибка при заполнении процентной ставки: %s', '', 1, 'FILL_INTRATE_FAILED');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Помилка при заповненні відсоткової ставки: %s ', '', 1, 'FILL_INTRATE_FAILED');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не найден счет расходов для вида вклада № %s', '', 1, 'EXPACC_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Не знайдений рахунок витратів для виду вкладу № %s', '', 1, 'EXPACC_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не найден вид вклада до востребования для валюты = %s', '', 1, 'DMNDVIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Не знайдений вид вкладу до запитання для валюти = %s', '', 1, 'DMNDVIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Невозможно однозначно найти вид вклада до востребования для валюты = %s', '', 1, 'DMNDVIDD_TOO_MANY_ROWS');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Неможливо однозначно знайти вид вкладу до запитання для валюти = %s', '', 1, 'DMNDVIDD_TOO_MANY_ROWS');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Неверно указан счет для возврата депозита', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Невірно вказаний рахунок для повернення депозиту', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Не найден договор № %s', '', 1, 'DPT_NOT_FOUND');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Не знайдений договір № %s', '', 1, 'DPT_NOT_FOUND');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Не описаны параметры штрафа № %s', '', 1, 'FINEPARAMS_NOT_FOUND');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Не описані параметри штрафу № %s', '', 1, 'FINEPARAMS_NOT_FOUND');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Невозможно вычислить действующую процентную ставку по вкладу!', '', 1, 'DPTRATE_CALC_ERROR');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Неможливо підрахувати діючу відсоткову ставку по вкладу!', '', 1, 'DPTRATE_CALC_ERROR');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Невозможно получить значение базовой ставки № %s', '', 1, 'BASERATE_CALC_ERROR');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Неможливо отримати значення базової ставки № %s', '', 1, 'BASERATE_CALC_ERROR');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Не найден штраф № %s', '', 1, 'FINE_NOT_FOUND');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Не знайдений штраф № %s', '', 1, 'FINE_NOT_FOUND');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Некорректно описан штраф!', '', 1, 'INVALID_FINE');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Некоректно описаний штраф!', '', 1, 'INVALID_FINE');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Не найдена сумма первичного взноса', '', 1, 'FIRST_PAYMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Не знайдена сума первинного внеску', '', 1, 'FIRST_PAYMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Не найден счет %s / %s', '', 1, 'ACC_NOT_FOUND_2');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Не знайдений рахунок %s / %s', '', 1, 'ACC_NOT_FOUND_2');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Невозможно расчитать значение базовой ставки = %s(%s) на %s!', '', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Неможливо підрахувати значення базової ставки = %s(%s) на %s!', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Ошибка при вставке индивидуальной бонусной процентной ставки = %s, дата %s!', '', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Помилка при заповненні індивідуальної бонусної відсоткової ставки = %s, %s!', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Ошибка при вставке базовой бонусной процентной ставки = %s, дата %s!', '', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Помилка при заповненні базової бонусної відсоткової ставки = %s, дата %s!', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'Не найдена операция для учета средств при переоформлении договора (%s)', '', 1, 'CANT_GET_EXTEND_TT');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'Не знайдена операція для обліку коштів при переоформленні договору (%s)', '', 1, 'CANT_GET_EXTEND_TT');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Недопустимая комбинация параметров (DPT_EXTD=%s, DPT_EXTT=%s, DPT_EXTR=%s)', '', 1, 'INVALID_EXTPARAMS');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Неприпустима комбінація параметрів (DPT_EXTD=%s, DPT_EXTT=%s, DPT_EXTR=%s)', '', 1, 'INVALID_EXTPARAMS');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Запрещено редактирование доп.параметра %s для вида вклада %s (статус %s)', '', 1, 'VIDDPARAM_SET_DENIED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Заборонено редагування дод.параметра %s для виду вкладу %s (статус %s)', '', 1, 'VIDDPARAM_SET_DENIED');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Указанное значение доп.параметра %s (%s) не соответствует формату параметра %s', '', 1, 'VIDDPARAM_CHECK_FAILED');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Вказане значення дод.параметра %s (%s) не відповідає формату параметра %s', '', 1, 'VIDDPARAM_CHECK_FAILED');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Ошибка пересмотра процентной ставки по деп.договору № %s : %s', '', 1, 'RATE_REVIEW_FAILED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Помилка перегляду відсоткової ставки по деп.договору № %s : %s', '', 1, 'RATE_REVIEW_FAILED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Некорректная дата открытия договора (%s-выходной)', '', 1, 'INVALID_OPENDATE_HLD');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Некоректна дата відкриття договору (%s-вихідний)', '', 1, 'INVALID_OPENDATE_HLD');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Задана недопустимая дата открытия договора (%s)', '', 1, 'INVALID_OPENDATE');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Вказана неприпустима дата відкриття договору (%s)', '', 1, 'INVALID_OPENDATE');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Не найдена операция № %s', '', 1, 'OPERATION_NOT_FOUND');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Не знайдена операція № %s', '', 1, 'OPERATION_NOT_FOUND');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Запрещено выполнение операции <%s> по вкладу № %s (%s): %s', '', 1, 'CHECKOPERPERM_ACCESS_DENIED');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Заборонено виконання операції <%s> по вкладу № %s (%s): %s', '', 1, 'CHECKOPERPERM_ACCESS_DENIED');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Операция <%s> не разрешена для вида вклада <%s>', '', 1, 'OPERATION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Операція <%s> не дозволена для виду вкладу <%s>', '', 1, 'OPERATION_NOT_ALLOWED');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Не найдена операция для формирования дисконта/премии по вкладу', '', 1, 'INITVDPTT_NOT_FOUND');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Не знайдена операція для формування дисконту/преміі по вкладу', '', 1, 'INITVDPTT_NOT_FOUND');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Не найден консолид.счет расходов будующих периодов для передачи в ОДБ', '', 1, 'CONSAVANSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Не знайдений консолід.рахунок витрат майб.періодів для передачі в ОДБ', '', 1, 'CONSAVANSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Ошибка расчета даты окончания вклада (вид вклада № %s): %s', '', 1, 'GET_DATEND_FAILED');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Ошибка расчета даты окончания вклада (вид вклада № %s): %s', '', 1, 'GET_DATEND_FAILED');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Не найден вклад с указанными реквизитами', '', 1, 'CORRTERM_DEPNOTFOUND');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Не знайдений вклад з введеними реквізитами', '', 1, 'CORRTERM_DEPNOTFOUND');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Задан некорректный срок действия вклада', '', 1, 'CORRTERM_INVALIDATES');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Заданий некоректний термін дії вкладу', '', 1, 'CORRTERM_INVALIDATES');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Заданный срок идентичный действующему', '', 1, 'CORRTERM_NOTHING2CHANGE');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Заданий термін ідентичний діючому', '', 1, 'CORRTERM_NOTHING2CHANGE');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Ошибка коррекции срок действия вклада № %s: %s', '', 1, 'CORRTERM_FAILED');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Помилка корекції терміну дії вкладу  № %s: %s', '', 1, 'CORRTERM_FAILED');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Не найден вклад № %s для переноса на вклад до востребования', '', 1, 'MOVE2DMND_DPT_NOT_FOUND');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Не знайдений вклад № %s для переносу на вклад до запитання', '', 1, 'MOVE2DMND_DPT_NOT_FOUND');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Найдены незавизир.документы по депозитному счету вклада № %s', '', 1, 'MOVE2DMND_INVALID_DPTSALDO');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Знайдено незавізов.документи по депозитному рахунку вклада № %s', '', 1, 'MOVE2DMND_INVALID_DPTSALDO');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Найдены незавизир.документы по процентному счету вклада № %s', '', 1, 'MOVE2DMND_INVALID_INTSALDO');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Знайдено незавізов.документи по процентному рахунку вклада № %s', '', 1, 'MOVE2DMND_INVALID_INTSALDO');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Не найден процентный счет для текущего счета %s/%s вклада %s', '', 1, 'MOVE2DMND_INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Не знайдений процентний рахунок для поточного рахунку %s/%s вкладу %s', '', 1, 'MOVE2DMND_INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Ошибка открытия вклада до востребования для вклада № %s: %s', '', 1, 'MOVE2DMND_DMNDOPEN_FAILED');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Помилка відкриття вкладу до запитання для вкладу № %s: %s', '', 1, 'MOVE2DMND_DMNDOPEN_FAILED');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Ошибка блокировки депозитного счета вклада № %s: %s', '', 1, 'MOVE2DMND_ACCBLK_FAILED');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Помилка блокування депозитного рахунку вкладу № %s: %s', '', 1, 'MOVE2DMND_ACCBLK_FAILED');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Ошибка переноса суммы депозита для вклада № %s: %s', '', 1, 'MOVE2DMND_PAYDOCDEP_FAILED');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Помилка переносу суми депозиту для вкладу № %s: %s', '', 1, 'MOVE2DMND_PAYDOCDEP_FAILED');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Ошибка переноса суммы процентов для вклада № %s: %s', '', 1, 'MOVE2DMND_PAYDOCINT_FAILED');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Помилка переносу суми відсотків для вкладу № %s: %s', '', 1, 'MOVE2DMND_PAYDOCINT_FAILED');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Некорректно заданы мин.и макс.допустимые суммы для вида вклада № %s: %s', '', 1, 'SET_DPTLIMITS_FAILED');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Некоректно задано мін.та макс.припустимі суми для виду вкладу № %s: %s', '', 1, 'SET_DPTLIMITS_FAILED');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Ошибка восстановления фин.реквизитов деп.счета по вкладу № %s: %s', '', 1, 'RESTORE_DPTLIMITS_FAILED');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Помилка відновлення фін.реквізитів деп.рахунку по вкладу № %s: %s', '', 1, 'RESTORE_DPTLIMITS_FAILED');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Заданный срок депозита не соответствует бал.счету %s (%s != %s)', '', 1, 'NBS181_MISMATCH');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Заданий термін дії депозиту не відповідає бал.рахунку %s (%s != %s)', '', 1, 'NBS181_MISMATCH');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Ошибка проверки допустимости открытия вклада: %s', '', 1, 'VALIDATE_DPTOPEN_ERROR');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Помилка перевірки припустимості відкриття вкладу: %s', '', 1, 'VALIDATE_DPTOPEN_ERROR');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Открытие данного вклада заблокировано: %s', '', 1, 'VALIDATE_DPTOPEN_FAILED');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Відкриття даного вкладу заблоковано: %s', '', 1, 'VALIDATE_DPTOPEN_FAILED');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, 'Пополнение депозитного счета заблокировано (по вкладу 5 дней  не было движения и остаток нулевой)', '', 1, 'AUGMENTER_DEPOSIT_VETO3');
    bars_error.add_message(l_mod, 99, l_exc, l_ukr, 'Поповнення депозитного рахунку заборонено (по вклад 5 днів не було оборотів та залишок нульовий)', '', 1, 'AUGMENTER_DEPOSIT_VETO3');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Миним.допустимая сумма для данной операции - %s %s!', '', 1, '100');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Мінім.припустима сума для даної операції - %s %s!', '', 1, '100');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Макс.допустимая сумма для данной операции - %s %s!', '', 1, '101');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Макс.припустима сума для даної операції - %s %s!', '', 1, '101');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'Срок пополнения истек еще %s!', '', 1, '102');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'Термін поповнення закінчився ще %s!', '', 1, '102');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, 'Исчерпан лимит частичных снятий со вклада!', '', 1, '103');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, 'Вичерпано ліміт часткових виплат зі вкладу!', '', 1, '103');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Превышено допустимое количество частичных снятий со вклада!', '', 1, '104');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Перевищена допустима кількість часткових виплат зі вкладу!', '', 1, '104');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Исчерпан лимит частичных снятий со вклада!', '', 1, '105');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Вичерпано ліміт часткових виплат зі вкладу!', '', 1, '105');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Вклад является залогом по кредитному договору %s!', '', 1, '106');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Вклад є заставою за кредитним договором %s!', '', 1, '106');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, 'Счет заблокирован на дебет! (%s)', '', 1, 'ACCOUNT_DEBIT_DENIED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, 'Рахунок заблоковано на дебет! (%s)', '', 1, 'ACCOUNT_DEBIT_DENIED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, 'Счет заблокирован на кредит! (%s)', '', 1, 'ACCOUNT_CREDIT_DENIED');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, 'Рахунок заблоковано на кредит! (%s)', '', 1, 'ACCOUNT_CREDIT_DENIED');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, 'Не найден клиент с РНК %s!', '', 1, '109');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, 'Не знайдено клієнта з РНК %s!', '', 1, '109');

    bars_error.add_message(l_mod, 110, l_exc, l_rus, 'Не указан вид вклада!', '', 1, '110');
    bars_error.add_message(l_mod, 110, l_exc, l_ukr, 'Не вказано вид вкладу!', '', 1, '110');

    bars_error.add_message(l_mod, 111, l_exc, l_rus, 'Введенный вид вклада не соответствует фактическому (%s<>%s)!', '', 1, '111');
    bars_error.add_message(l_mod, 111, l_exc, l_ukr, 'Вказаний вид вкладу не відповідає фактичному (%s<>%s)!', '', 1, '111');

    bars_error.add_message(l_mod, 112, l_exc, l_rus, 'Введенный вид вклада не соответствует данному подразделению (vidd = %s, ins = %s)!', '', 1, '112');
    bars_error.add_message(l_mod, 112, l_exc, l_ukr, 'Вказаний вид вкладу не відповідає даному підрозділу (vidd = %s, ins = %s)!', '', 1, '112');

    bars_error.add_message(l_mod, 113, l_exc, l_rus, 'Несоответствие счета/вида вклада/подразделения (%s,%s,%s)!', '', 1, '113');
    bars_error.add_message(l_mod, 113, l_exc, l_ukr, 'Невідповідність рахунку/виду вкладу/підрозділу (%s,%s,%s)!', '', 1, '113');

    bars_error.add_message(l_mod, 114, l_exc, l_rus, 'Указанный счет (%s) не является инструментом!', '', 1, '114');
    bars_error.add_message(l_mod, 114, l_exc, l_ukr, 'Вказаний рахунок (%s) не є інструментом!', '', 1, '114');

    bars_error.add_message(l_mod, 115, l_exc, l_rus, 'Не найден счет Б для документа РЕФ = %s!', '', 1, '115');
    bars_error.add_message(l_mod, 115, l_exc, l_ukr, 'Не знайдено рахунок Б для документа РЕФ = %s!', '', 1, '115');

    bars_error.add_message(l_mod, 116, l_exc, l_rus, 'Cчет %s не является счетом загрузки!', '', 1, '116');
    bars_error.add_message(l_mod, 116, l_exc, l_ukr, 'Рахунок %s не є рахунком завантаження!', '', 1, '116');

    bars_error.add_message(l_mod, 117, l_exc, l_rus, 'Карточный счет и счет загрузки принадлежат разным клиентам!', '', 1, '117');
    bars_error.add_message(l_mod, 117, l_exc, l_ukr, 'Картковий рахунок і рахунок завантаження належать різним клієнтам!', '', 1, '117');

    bars_error.add_message(l_mod, 118, l_exc, l_rus, 'Ввод внутренних адресных платежей запрещен!', '', 1, '118');
    bars_error.add_message(l_mod, 118, l_exc, l_ukr, 'Ввод внутрішніх адресних платежів заборонено!', '', 1, '118');

    bars_error.add_message(l_mod, 119, l_exc, l_rus, 'Не описаны спецпараметры НСМЕП!', '', 1, '119');
    bars_error.add_message(l_mod, 119, l_exc, l_ukr, 'Не описані спецпараметри НСМЕП!', '', 1, '119');

    bars_error.add_message(l_mod, 120, l_exc, l_rus, 'CR не сформирован или не подтвержден!', '', 1, '120');
    bars_error.add_message(l_mod, 120, l_exc, l_ukr, 'CR не зформировано або не підтверджено!', '', 1, '120');

    bars_error.add_message(l_mod, 121, l_exc, l_rus, 'Доля доступного остатка = 0!', '', 1, '121');
    bars_error.add_message(l_mod, 121, l_exc, l_ukr, 'Частка доступного залишку = 0!', '', 1, '121');

    bars_error.add_message(l_mod, 122, l_exc, l_rus, 'Не найдена карта НСМЕП!', '', 1, '122');
    bars_error.add_message(l_mod, 122, l_exc, l_ukr, 'Не знайдено карту НСМЕП!', '', 1, '122');

    bars_error.add_message(l_mod, 123, l_exc, l_rus, 'Карта находится в стоп-листе!', '', 1, '123');
    bars_error.add_message(l_mod, 123, l_exc, l_ukr, 'Карта знаходиться в стоп-листі!', '', 1, '123');

    bars_error.add_message(l_mod, 124, l_exc, l_rus, 'Заблокирован лимит!', '', 1, '124');
    bars_error.add_message(l_mod, 124, l_exc, l_ukr, 'Заблоковано ліміт!', '', 1, '124');

    bars_error.add_message(l_mod, 125, l_exc, l_rus, 'Карта находится в плановом стоп-листе!', '', 1, '125');
    bars_error.add_message(l_mod, 125, l_exc, l_ukr, 'Карта знаходиться в плановому стоп-листі!', '', 1, '125');

    bars_error.add_message(l_mod, 126, l_exc, l_rus, 'Остаток на счете меньше неснижаемого (%s %s)', '', 1, '126');
    bars_error.add_message(l_mod, 126, l_exc, l_ukr, 'Залишок на рахунку менше незнижувального (%s %s)', '', 1, '126');

    bars_error.add_message(l_mod, 127, l_exc, l_rus, 'Досрочное снятие средств с депозитного счета заблокировано', '', 1, 'ADVANCE_PAYMENT_VETO');
    bars_error.add_message(l_mod, 127, l_exc, l_ukr, 'Дострокове зняття коштів з депозитного рахунку заблоковано', '', 1, 'ADVANCE_PAYMENT_VETO');

    bars_error.add_message(l_mod, 128, l_exc, l_rus, 'Пополнение депозитного счета заблокировано (срок вклада закончился %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO1');
    bars_error.add_message(l_mod, 128, l_exc, l_ukr, 'Поповнення депозитного рахунку заборонено (термін вкладу закінчився %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO1');

    bars_error.add_message(l_mod, 129, l_exc, l_rus, 'Пополнение депозитного счета заблокировано (по вкладу было проведено досрочное расторжение %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO2');
    bars_error.add_message(l_mod, 129, l_exc, l_ukr, 'Поповнення депозитного рахунку заборонено (вклад було достроково розторгнуто %s)', '', 1, 'AUGMENTER_DEPOSIT_VETO2');

    bars_error.add_message(l_mod, 130, l_exc, l_rus, 'Активация технического вида вклада запрещена!', '', 1, '130');
    bars_error.add_message(l_mod, 130, l_exc, l_ukr, 'Активацію техничного виду вкладу заборонено!', '', 1, '130');

    bars_error.add_message(l_mod, 131, l_exc, l_rus, 'Не найдены контрсчета для дисконта/премии (%s, %s, %s)', '', 1, 'IRRACCS_NOT_FOUND');
    bars_error.add_message(l_mod, 131, l_exc, l_ukr, 'Не знайдені контрахунки для дисконту/преміі (%s, %s, %s)', '', 1, 'IRRACCS_NOT_FOUND');

    bars_error.add_message(l_mod, 132, l_exc, l_rus, 'Не найдена эффективная ставка для вклада № %s (%s), вид вклада № %s', '', 1, 'IRR_NOT_FOUND');
    bars_error.add_message(l_mod, 132, l_exc, l_ukr, 'Не знайдена ефективна ставка для вкладу № %s (%s), вид вкладу № %s', '', 1, 'IRR_NOT_FOUND');

    bars_error.add_message(l_mod, 133, l_exc, l_rus, 'Ошибка открытия процентной карточки для амортизации дисконта/премии по вкладу № %s (%s): %s', '', 1, 'IRRCARDOPEN_FAILED');
    bars_error.add_message(l_mod, 133, l_exc, l_ukr, 'Помилка відкриття процентної картки для амортизації дисконту/преміі по вкладу № %s (%s): %s', '', 1, 'IRRCARDOPEN_FAILED');

    bars_error.add_message(l_mod, 134, l_exc, l_rus, 'Ошибка формирования дисконта/премии по вкладу № %s (%s): %s', '', 1, 'IRR_INITDR_FAILED');
    bars_error.add_message(l_mod, 134, l_exc, l_ukr, 'Помилка формування дисконту/преміі по вкладу № %s (%s): %s', '', 1, 'IRR_INITDR_FAILED');

    bars_error.add_message(l_mod, 135, l_exc, l_rus, 'Ошибка расчета єффективной ставки: %s', '', 1, 'IRR_CALCULATION_FAILED');
    bars_error.add_message(l_mod, 135, l_exc, l_ukr, 'Помилка розрахункуефективної ставки: %s', '', 1, 'IRR_CALCULATION_FAILED');

    bars_error.add_message(l_mod, 136, l_exc, l_rus, 'Не задана рыночная ставка для вида вклада № %s', '', 1, 'MRATE_NOT_FOUND');
    bars_error.add_message(l_mod, 136, l_exc, l_ukr, 'Не задана ринкова ставка для виду вкладу № %s', '', 1, 'MRATE_NOT_FOUND');

    bars_error.add_message(l_mod, 137, l_exc, l_rus, 'Не корректно задана рыночная ставка (%s)', '', 1, 'MRATE_INVALID_VALUE');
    bars_error.add_message(l_mod, 137, l_exc, l_ukr, 'Не коректно задана ринкова ставка (%s)', '', 1, 'MRATE_INVALID_VALUE');

    bars_error.add_message(l_mod, 138, l_exc, l_rus, 'Ошибка удаления вклада № %s из очереди на расчет дисконта/премии', '', 1, 'IRR_DELQUEREC_FAILED');
    bars_error.add_message(l_mod, 138, l_exc, l_ukr, 'Помилка видалення вкладу № %s з черги на розрахунок дисконту/премії', '', 1, 'IRR_DELQUEREC_FAILED');

    bars_error.add_message(l_mod, 139, l_exc, l_rus, 'Ошибка записи текста ошибки при расчете дисконта/премии по вкладу № %s', '', 1, 'IRR_UPDQUEREC_FAILED');
    bars_error.add_message(l_mod, 139, l_exc, l_ukr, 'Помилка запису тексту помилки при розрахунку дисконту/премії по вкладу № %s', '', 1, 'IRR_UPDQUEREC_FAILED');

    bars_error.add_message(l_mod, 140, l_exc, l_rus, 'Не найдены актуальные рыночные ставки для вида вклада № %s', '', 1, 'IRR_MKTRATE_NOT_FOUND');
    bars_error.add_message(l_mod, 140, l_exc, l_ukr, 'Не знайдено актуальні ринкові ставки для виду вкладу № %s', '', 1, 'IRR_MKTRATE_NOT_FOUND');

    bars_error.add_message(l_mod, 141, l_exc, l_rus, 'Не найден бал.счет дисконта/премии для вклада № %s', '', 1, 'IRR_DPNBS_NOT_FOUND');
    bars_error.add_message(l_mod, 141, l_exc, l_ukr, 'Не знайдений бал.рахунок дисконту/премії для вкладу № %s', '', 1, 'IRR_DPNBS_NOT_FOUND');

    bars_error.add_message(l_mod, 142, l_exc, l_rus, 'Ошибка при формировании номера cчета типа %s для вклада № %s: %s', '', 1, 'IRR_DPACCGETMASK_FAILED');
    bars_error.add_message(l_mod, 142, l_exc, l_ukr, 'Помилка при формуванні номеру рахунку типу %s для вкладу № %s: %s', '', 1, 'IRR_DPACCGETMASK_FAILED');

    bars_error.add_message(l_mod, 143, l_exc, l_rus, 'Ошибка при открытии счета дисконта/премии № %s/%s : %s', '', 1, 'IRR_DPACCOPEN_FAILED');
    bars_error.add_message(l_mod, 143, l_exc, l_ukr, 'Помилка при відкритті рахунку дисконту/премії № %s/%s : %s', '', 1, 'IRR_DPACCOPEN_FAILED');

    bars_error.add_message(l_mod, 144, l_exc, l_rus, 'Не найден контрсчет для счета типа %s (БС %s, ВАЛ %s, ОТД %s)', '', 1, 'IRR_CONTRACC_NOT_FOUND');
    bars_error.add_message(l_mod, 144, l_exc, l_ukr, 'Не знайдений контррахунок для рахунку типу %s (БР %s, ВАЛ %s, ВІДД %s)', '', 1, 'IRR_CONTRACC_NOT_FOUND');

    bars_error.add_message(l_mod, 145, l_exc, l_rus, 'Ошибка формирования дисконта/премии по вкладу № %s : %s', '', 1, 'IRR_PAYDP_FAILED');
    bars_error.add_message(l_mod, 145, l_exc, l_ukr, 'Помилка формування дисконту/премії по вкладу № %s : %s', '', 1, 'IRR_PAYDP_FAILED');

    bars_error.add_message(l_mod, 146, l_exc, l_rus, 'Ошибка привязки счета %s к вкладу № %s: %s', '', 1, 'IRR_DPACCBINDING_FAILED');
    bars_error.add_message(l_mod, 146, l_exc, l_ukr, 'Помилка зв''язування рахунку %s зі вкладом № %s : %s', '', 1, 'IRR_DPACCBINDING_FAILED');

    bars_error.add_message(l_mod, 147, l_exc, l_rus, 'Ошибка при заполнении процентной карточки для счета № %s/%s : %s', '', 1, 'IRR_DPACCINTCARD_FAILED');
    bars_error.add_message(l_mod, 147, l_exc, l_ukr, 'Помилка при заповненні процентної картки для рахунку № %s/%s : %s', '', 1, 'IRR_DPACCINTCARD_FAILED');

    bars_error.add_message(l_mod, 148, l_exc, l_rus, 'Ошибка при окончат.амортизации счетов дисконта/премии по вкладу № %s: %s', '', 1, 'IRR_FINALAMRT_FAILED');
    bars_error.add_message(l_mod, 148, l_exc, l_ukr, 'Помилка при остат.амортизації рахунків дисконту/премії по вкладу № %s: %s', '', 1, 'IRR_FINALAMRT_FAILED');

    bars_error.add_message(l_mod, 149, l_exc, l_rus, 'Ошибка при закрытии счета № %s', '', 1, 'IRR_CLOSDPACC_FAILED');
    bars_error.add_message(l_mod, 149, l_exc, l_ukr, 'Помилка при закритті рахунку № %s', '', 1, 'IRR_CLOSDPACC_FAILED');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, 'Закрытие счета № %s недопустимо', '', 1, 'IRR_CLOSDPACC_DENIED');
    bars_error.add_message(l_mod, 150, l_exc, l_ukr, 'Закриття рахунку № %s неприпустиме', '', 1, 'IRR_CLOSDPACC_DENIED');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, 'Некорректное значение флага отказа от расчета эффект.ставки', '', 1, 'IRRDENIED_INVALID_VALUE');
    bars_error.add_message(l_mod, 151, l_exc, l_ukr, 'Некоректне значення ознаки відмови від розрахунку ефект.ставки', '', 1, 'IRRDENIED_INVALID_VALUE');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, 'Не найден вид вклада № %s', '', 1, 'VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, 'Не знайдений вид вкладу № %s', '', 1, 'VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'Не найден клиент-владелец вклада № %s', '', 1, 'CUSTOMER_NOT_FOUND');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'Не знайдений клієнт, на якого відкрито вклад № %s', '', 1, 'CUSTOMER_NOT_FOUND');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, 'Не найден глобальный параметр "Код нашей страны"', '', 1, 'COUNTY_NOT_FOUND');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, 'Не знайдений глобальний параметр "Код нашої країни"', '', 1, 'COUNTY_NOT_FOUND');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, 'Не найден глобальный параметр "Код группы депозитных счетов"', '', 1, 'DPTGRP_NOT_FOUND');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, 'Не знайдений глобальний параметр "Код групи депозитних рахунків"', '', 1, 'DPTGRP_NOT_FOUND');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, 'Текст дополнительного соглашения №%s по депозитному договору №%s с шаблоном %s уже существует!', '', 1, 'TEXT_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, 'Текст додаткової угоди №%s по депозитному договору №%s з шаблоном %s вже існує!', '', 1, 'TEXT_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, 'Ошибка при закрытии депозитного договора №%s', '', 1, 'DPT_CLOSE_ERR');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, 'Помилка при закритті депозитного договору №%s', '', 1, 'DPT_CLOSE_ERR');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, 'Ошибка при закрытии счета (внутр.№ %s)', '', 1, 'ACC_CLOSE_ERR');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, 'Помилка при закритті рахунку (внутр.№ %s)', '', 1, 'ACC_CLOSE_ERR');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, 'Удаление депозитного договора №%s запрещено: %s', '', 1, 'DPT_CLOSE_VETO');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, 'Видалення депозитного договору №%s заборонено: %s', '', 1, 'DPT_CLOSE_VETO');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, 'Счет не найден (внутр.№ %s)', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, 'Рахунок не знайдений (внутр.№ %s)', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, 'Задана недостаточное количество параметров для поиска депозитного договора. Конкретизируйте условия поиска!', '', 1, 'NOT_ENOUGH_PARAMS');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, 'Задана недостатня кількість параметрів для пошуку депозитного договору. Конкретизуйте умови пошуку!', '', 1, 'NOT_ENOUGH_PARAMS');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, 'Заблокирован поиск депозитного договора только по ФИО клиента. Конкретизируйте условия поиска!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTNAME');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, 'Заблоковано пошук депозитного договору тільки по ПІБ клієнта. Конкретизуйте умови пошуку!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTNAME');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, 'Заблокирован поиск депозитного договора по маске идент.кода (или по 00000...). Задайте ид.код полностью или конкретизируйте условия поиска!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTCODE');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, 'Заблоковано пошук депозитного договору по масці ідент.коду (або по 00000...). Введіть ід.код повністю або конкретизуйте умови пошуку!', '', 1, 'NOT_ENOUGH_PARAMS_CUSTCODE');

    bars_error.add_message(l_mod, 213, l_exc, l_rus, 'Изменение вида договора для договора № %s запрещено', '', 1, 'CHG_DPTYPE_DENIED');
    bars_error.add_message(l_mod, 213, l_exc, l_ukr, 'Зміна виду договору для договору № %s заборонена', '', 1, 'CHG_DPTYPE_DENIED');

    bars_error.add_message(l_mod, 214, l_exc, l_rus, 'Изменение вида договора для договора № %s запрещено: несовпадают осн.характеристики видов вкладов № %s - %s и № %s - %s', '', 1, 'CHG_DPTYPE_INVALID');
    bars_error.add_message(l_mod, 214, l_exc, l_ukr, 'Зміна виду договору для договору № %s заборонена: неспівпадають осн.характеристики видів вкладів № %s - %s та № %s - %s', '', 1, 'CHG_DPTYPE_INVALID');

    bars_error.add_message(l_mod, 215, l_exc, l_rus, 'Ошибка при изменении вида договора для договора № %s: %s', '', 1, 'CHG_DPTYPE_ERROR');
    bars_error.add_message(l_mod, 215, l_exc, l_ukr, 'Помилка при зміні виду договору для договору № %s: %s', '', 1, 'CHG_DPTYPE_ERROR');

    bars_error.add_message(l_mod, 216, l_exc, l_rus, 'Найден необработанный запрос (№ %s) на удаление договора № %s', '', 1, 'REQCLOSE_DENIED');
    bars_error.add_message(l_mod, 216, l_exc, l_ukr, 'Знайдений необроблений запит (№ %s) на видалення договору № %s', '', 1, 'REQCLOSE_DENIED');

    bars_error.add_message(l_mod, 221, l_exc, l_rus, 'Некорректно заданы параметры перечисления депозита/процентов (МФО %s, счет %s)', '', 1, 'INVALID_PAYOFF_PARAMS');
    bars_error.add_message(l_mod, 221, l_exc, l_ukr, 'Некоректно задані параметри перерахування депозиту/відсотків (МФО %s, рахунок %s)', '', 1, 'INVALID_PAYOFF_PARAMS');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, 'Некорректно заданы параметры выплаты процентов (МФО %s, счет %s)', '', 1, '222');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, 'Некоректно задані параметри сплати відсотків (МФО %s, рахунок %s)', '', 1, '222');

    bars_error.add_message(l_mod, 223, l_exc, l_rus, 'Ошибка в контр.разряде счета %s, открытом  в банке с МФО %s', '', 1, 'INVALID_PAYOFF_ACCOUNT');
    bars_error.add_message(l_mod, 223, l_exc, l_ukr, 'Помилка в контольному розряді рахунку %s, відкритому в банку з МФО %s', '', 1, 'INVALID_PAYOFF_ACCOUNT');

    bars_error.add_message(l_mod, 224, l_exc, l_rus, 'Ошибка сохранения параметров перечисления суммы депозита по вкладу № %s, (МФО %s, счет %s)', '', 1, 'UPD_DEPPAYOFFPARAMS_FAILED');
    bars_error.add_message(l_mod, 224, l_exc, l_ukr, 'Помилка зберігання параметрів перерахування  депозитних коштів по вкладу № %s, (МФО %s, рах.%s)', '', 1, 'UPD_DEPPAYOFFPARAMS_FAILED');

    bars_error.add_message(l_mod, 225, l_exc, l_rus, 'Ошибка сохранения параметров выплаты процентов по вкладу № %s, (МФО %s, счет %s)', '', 1, 'UPD_INTPAYOFFPARAMS_FAILED');
    bars_error.add_message(l_mod, 225, l_exc, l_ukr, 'Помилка зберігання параметрів сплати відсотків по вкладу № %s, (МФО %s, рах. %s)', '', 1, 'UPD_INTPAYOFFPARAMS_FAILED');

    bars_error.add_message(l_mod, 226, l_exc, l_rus, 'Тип указанного доп.соглашения (= %s) не является доп.соглашением о 3-их лицах', '', 1, '226');
    bars_error.add_message(l_mod, 226, l_exc, l_ukr, 'Тип вказаної додаткової угоди (= %s) не є додатковою угодою про 3-іх осіб', '', 1, '226');

    bars_error.add_message(l_mod, 227, l_exc, l_rus, 'Отсутствует активное доп.соглашение для 3-го лица №%s по договору %s', '', 1, '227');
    bars_error.add_message(l_mod, 227, l_exc, l_ukr, 'Відсутня активна додаткова угода для 3-ї особи №%s по договору %s', '', 1, '227');

    bars_error.add_message(l_mod, 228, l_exc, l_rus, 'Ошибка при записи данных о 3-ем лице: %s', '', 1, '228');
    bars_error.add_message(l_mod, 228, l_exc, l_ukr, 'Помилка при запису даних про 3-тю особу: %s', '', 1, '228');

    bars_error.add_message(l_mod, 230, l_exc, l_rus, 'Неверно указан тип доп.соглашения = %s', '', 1, '230');
    bars_error.add_message(l_mod, 230, l_exc, l_ukr, 'Невірно вказаний тип додаткової угоди = %s', '', 1, '230');

    bars_error.add_message(l_mod, 231, l_exc, l_rus, 'Не найдено доп.соглашение с типом № %s', '', 1, '231');
    bars_error.add_message(l_mod, 231, l_exc, l_ukr, 'Не знайдена додаткова угода з типом № %s', '', 1, '231');

    bars_error.add_message(l_mod, 232, l_exc, l_rus, 'Не найден шаблон доп.соглашения типа %s для вида вклада № %s', '', 1, '232');
    bars_error.add_message(l_mod, 232, l_exc, l_ukr, 'Не знайдений шаблон додаткової угоди типу %s для вида вкладу № %s', '', 1, '232');

    bars_error.add_message(l_mod, 233, l_exc, l_rus, 'Невозможно однозначно определить шаблон доп.соглашения типа %s для вида вклада № %s', '', 1, '233');
    bars_error.add_message(l_mod, 233, l_exc, l_ukr, 'Неможливо однозначно визначити шаблон додаткової угоди типу %s для вида вкладу № %s', '', 1, '233');

    bars_error.add_message(l_mod, 234, l_exc, l_rus, 'Не найдено довернное лицо с № %s', '', 1, '234');
    bars_error.add_message(l_mod, 234, l_exc, l_ukr, 'Не знайдена довірена особа з № %s', '', 1, '234');

    bars_error.add_message(l_mod, 235, l_exc, l_rus, 'Неверно указаны суммы пополнения/снятия наличностью = %s и безналичным перечислением = %s', '', 1, '235');
    bars_error.add_message(l_mod, 235, l_exc, l_ukr, 'Невірно вказані суми попвнення/няття готівкою = %s та беготівковим шляхом = %s', '', 1, '235');

    bars_error.add_message(l_mod, 236, l_exc, l_rus, 'Запрещено заключение доп.соглашение по запросу № %s на изменение процентной ставки по договору № %s', '', 1, '236');
    bars_error.add_message(l_mod, 236, l_exc, l_ukr, 'Заборонено оформлення дод.угоди по запиту № %s на зміну відсоткової ставки по договору № %s', '', 1, '236');

    bars_error.add_message(l_mod, 237, l_exc, l_rus, 'Невозможно установить новую %-ную ставку по договору № %s с %s, (баз,инд) = (%s, %s)', '', 1, 'SET_RATE_FAILED');
    bars_error.add_message(l_mod, 237, l_exc, l_ukr, 'Неможливо встановити нову %-ву ставку по договору № %s з %s, (баз,інд) = (%s, %s)', '', 1, 'SET_RATE_FAILED');

    bars_error.add_message(l_mod, 238, l_exc, l_rus, 'Неверно указана дата начала действия новой процентной ставки = %s', '', 1, '238');
    bars_error.add_message(l_mod, 238, l_exc, l_ukr, 'Невірно вказана дата початку дії нової відсоткової ставки = %s', '', 1, '238');

    bars_error.add_message(l_mod, 239, l_exc, l_rus, 'Неверно задан периода действия договора: %s - %s', '', 1, '239');
    bars_error.add_message(l_mod, 239, l_exc, l_ukr, 'Невірно заданий період дії договору: %s - %s', '', 1, '239');

    bars_error.add_message(l_mod, 240, l_exc, l_rus, 'Не найдены счета, обслуживающие вклад #%s!', '', 1, '240');
    bars_error.add_message(l_mod, 240, l_exc, l_ukr, 'Не знайдені рахунки, що обслуговують вклад №%s', '', 1, '240');

    bars_error.add_message(l_mod, 241, l_exc, l_rus, 'Ошибка при изменении срока действия договора № %s', '', 1, '241');
    bars_error.add_message(l_mod, 241, l_exc, l_ukr, 'Помилка при зміні терміну дії договору № %s', '', 1, '241');

    bars_error.add_message(l_mod, 242, l_exc, l_rus, 'Ошибка при изменении даты погашения для счета (#%s) по вкладу № %s', '', 1, '242');
    bars_error.add_message(l_mod, 242, l_exc, l_ukr, 'Помилка при зміні дати погашення для рахунку (#%s) по вкладу № %s', '', 1, '242');

    bars_error.add_message(l_mod, 243, l_exc, l_rus, 'Ошибка при изменении стоп-даты по начислению процентов для вклада № %s', '', 1, '243');
    bars_error.add_message(l_mod, 243, l_exc, l_ukr, 'Помилка при зміні стоп-дати по нарахуванню відсотків для вкладу № %s', '', 1, '243');

    bars_error.add_message(l_mod, 244, l_exc, l_rus, 'Не найдено доп.соглашение о 3-их лицах № %s', '', 1, '244');
    bars_error.add_message(l_mod, 244, l_exc, l_ukr, 'Не знайдена додаткова угода про 3-іх осіб № %s', '', 1, '244');

    bars_error.add_message(l_mod, 245, l_exc, l_rus, 'Не корректно задан идентификатор доп.соглашения о 3-их лицах № %s: %s', '', 1, '245');
    bars_error.add_message(l_mod, 245, l_exc, l_ukr, 'Не коректно заданий ідентифікатор додаткової угоди про 3-іх осіб № %s: %s', '', 1, '245');

    bars_error.add_message(l_mod, 246, l_exc, l_rus, 'Ошибка при перерегистрации счета (#%s) на клиента № %s', '', 1, '246');
    bars_error.add_message(l_mod, 246, l_exc, l_ukr, 'Помилка при перерегістрації рахунку (#%s) на клієнта № %s', '', 1, '246');

    bars_error.add_message(l_mod, 247, l_exc, l_rus, 'Ошибка при перерегистрации вклада № %s на клиента № %s', '', 1, '247');
    bars_error.add_message(l_mod, 247, l_exc, l_ukr, 'Помилка при перерегістрації вкладу № %s на клієнта № %s', '', 1, '247');

    bars_error.add_message(l_mod, 248, l_exc, l_rus, 'Невозможно закрыть дополнительное соглашение № %s к депозитному договору № %s', '', 1, 'AGRMT_TERM_VETO');
    bars_error.add_message(l_mod, 248, l_exc, l_ukr, 'Неможливо закрити додаткову угоду № %s до депозитного договору № %s', '', 1, 'AGRMT_TERM_VETO');

    bars_error.add_message(l_mod, 249, l_exc, l_rus, 'Невозможно закрыть дополнительное соглашение о 3-их лицах № %s к депозитному договору № %s', '', 1, 'TRUST_TERM_VETO');
    bars_error.add_message(l_mod, 249, l_exc, l_ukr, 'Неможливо закрити додаткову угоду про 3-іх осіб № %s до депозитного договору № %s', '', 1, 'TRUST_TERM_VETO');

    bars_error.add_message(l_mod, 250, l_exc, l_rus, 'Ошибка при расчете тарифа №%s для %s/%s', '', 1, '250');
    bars_error.add_message(l_mod, 250, l_exc, l_ukr, 'Помилка при розрахунку тарифу №%s для %s/%s', '', 1, '250');

    bars_error.add_message(l_mod, 251, l_exc, l_rus, 'Невозможно найти ставку по вкладу № %s на %s', '', 1, '251');
    bars_error.add_message(l_mod, 251, l_exc, l_ukr, 'Неможливо знайти ставку по вкладу № %s на %s', '', 1, '251');

    bars_error.add_message(l_mod, 252, l_exc, l_rus, 'Не найдена базовая ставка № %s по вкладу № %s', '', 1, '252');
    bars_error.add_message(l_mod, 252, l_exc, l_ukr, 'Не знайдена базова ставка № %s по вкладу № %s', '', 1, '252');

    bars_error.add_message(l_mod, 253, l_exc, l_rus, 'Не найдено новое значение базовой ставки № %s по вкладу № %s', '', 1, '253');
    bars_error.add_message(l_mod, 253, l_exc, l_ukr, 'Не знайдено нове значення базової ставки № %s по вкладу № %s', '', 1, '253');

    bars_error.add_message(l_mod, 261, l_exc, l_rus, 'Процерура частичного снятия не предусмотрена!', '', 1, '261');
    bars_error.add_message(l_mod, 261, l_exc, l_ukr, 'Процерура часткового зняття не передбачена!', '', 1, '261');

    bars_error.add_message(l_mod, 262, l_exc, l_rus, 'Срок вклада истек -> воспользуйтесь процедурой возврата депозита!', '', 1, '262');
    bars_error.add_message(l_mod, 262, l_exc, l_ukr, 'Термін вкладу закінчився -> скористайтеся процедурою повернення депозиту!', '', 1, '262');

    bars_error.add_message(l_mod, 263, l_exc, l_rus, 'Остаток депозита меньше допустимого!', '', 1, '263');
    bars_error.add_message(l_mod, 263, l_exc, l_ukr, 'Залишок депозиту менше допустимого!', '', 1, '263');

    bars_error.add_message(l_mod, 264, l_exc, l_rus, 'Ошибка начисления %% по счету %s/%s (#%s): %s', '', 1, 'MAKE_INT_ERROR');
    bars_error.add_message(l_mod, 264, l_exc, l_ukr, 'Помилка нарахування %% по рахунку %s/%s (#%s): %s', '', 1, 'MAKE_INT_ERROR');

    bars_error.add_message(l_mod, 265, l_exc, l_rus, 'Не найден депозитный счет по договору № %s', '', 1, 'DPTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 265, l_exc, l_ukr, 'Не знайдений депозитний рахунок по договору № %s', '', 1, 'DPTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 266, l_exc, l_rus, 'Не найден счет начисленных процентов по договору № %s', '', 1, 'INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 266, l_exc, l_ukr, 'Не знайдений рахунок нарахованих відсотків по договору № %s', '', 1, 'INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 267, l_exc, l_rus, 'Не найден счет процентных расходов по договору № %s', '', 1, 'ACC7_NOT_FOUND');
    bars_error.add_message(l_mod, 267, l_exc, l_ukr, 'Не знайдений рахунок процентних видатків по договору № %s', '', 1, 'ACC7_NOT_FOUND');

    bars_error.add_message(l_mod, 268, l_exc, l_rus, 'Ошибка оплаты документа  : %s', '', 1, 'PAYDOC_ERROR');
    bars_error.add_message(l_mod, 268, l_exc, l_ukr, 'Помилка сплати документа : %s', '', 1, 'PAYDOC_ERROR');

    bars_error.add_message(l_mod, 269, l_exc, l_rus, 'Невозможно выполнить операцию взыскания штрафа за досрочное расторжение договора № %s от %s: по счету %s/%s есть незавизированные документы', '', 1, 'PENALTY_NOT_ALLOWED');
    bars_error.add_message(l_mod, 269, l_exc, l_ukr, 'Неможливо виконати операцію стягнення штрафу за дострокове розторгнення договору № %s від %s: по рахунку %s/%s є незавізовані документи', '', 1, 'PENALTY_NOT_ALLOWED');

    bars_error.add_message(l_mod, 271, l_exc, l_rus, 'Ошибка выплаты процентов: %s', '', 1, 'PAYOUT_ERR');
    bars_error.add_message(l_mod, 271, l_exc, l_ukr, 'Помилка сплати відсотків: %s', '', 1, 'PAYOUT_ERR');

    bars_error.add_message(l_mod, 291, l_exc, l_rus, 'Указан несуществующий тип закрытия технического счета  #%s', '', 1, '291');
    bars_error.add_message(l_mod, 291, l_exc, l_ukr, 'Вказано неіснуючий тип закриття технічного рахунку #%s', '', 1, '291');

    bars_error.add_message(l_mod, 292, l_exc, l_rus, 'Недопустимо закрытие технического счета #%s', '', 1, '292');
    bars_error.add_message(l_mod, 292, l_exc, l_ukr, 'Недозволене закриття технічного рахунку #%s', '', 1, '292');

    bars_error.add_message(l_mod, 293, l_exc, l_rus, 'Ошибка при заполнении даты планового закрытия технического счета  #%s', '', 1, '293');
    bars_error.add_message(l_mod, 293, l_exc, l_ukr, 'Помилка при заповненні дати планового закриття технічного рахунку #%s', '', 1, '293');

    bars_error.add_message(l_mod, 294, l_exc, l_rus, 'Невозможно связать платеж-пополнение техн.счета (ref = %s) с документом-комиссией (ref = %s)', '', 1, '294');
    bars_error.add_message(l_mod, 294, l_exc, l_ukr, 'Неможливо звязати платіж-поповнення техн.рахунку (ref = %s) з документом-комісією (ref = %s)', '', 1, '294');

    bars_error.add_message(l_mod, 295, l_exc, l_rus, 'Не найден документ безналичного пополнения технического счета, референс = %s', '', 1, '295');
    bars_error.add_message(l_mod, 295, l_exc, l_ukr, 'Не знайдений документ безготівкового поповнения технічного рахунку, референс = %s', '', 1, '295');

    bars_error.add_message(l_mod, 296, l_exc, l_rus, 'Не найдена операция по взысканию комиссии за безналичное пополнение технического счета, референс = %s', '', 1, '296');
    bars_error.add_message(l_mod, 296, l_exc, l_ukr, 'Не знайдена операція по стягненню комісії за безготівкове поповнення технічного рахунку, референс = %s', '', 1, '296');

    bars_error.add_message(l_mod, 297, l_exc, l_rus, 'Невозможно однозначно определить операцию по взысканию комиссии за безналичное пополнение технического счета, референс = %s', '', 1, '297');
    bars_error.add_message(l_mod, 297, l_exc, l_ukr, 'Неможливо однозначно визначити операцію по стягненню штрафу за безготівкове поповнення технічного рахунку, референс = %s', '', 1, '297');

    bars_error.add_message(l_mod, 298, l_exc, l_rus, 'Невозможно рассчитать счет-получатель (счет доходов) по формуле из карточки операции %s', '', 1, '298');
    bars_error.add_message(l_mod, 298, l_exc, l_ukr, 'Неможливо визначити рахунок-отримувач (рахунок доходів) за формулою з картки операції %s', '', 1, '298');

    bars_error.add_message(l_mod, 299, l_exc, l_rus, 'Не найден счет-получатель (счет доходов) %s/%s', '', 1, '299');
    bars_error.add_message(l_mod, 299, l_exc, l_ukr, 'Не знайдений рахунок-отримувач (рахунок доходів) %s/%s', '', 1, '299');

    bars_error.add_message(l_mod, 300, l_exc, l_rus, 'Не описана формула назначения платежа для операции %s', '', 1, '300');
    bars_error.add_message(l_mod, 300, l_exc, l_ukr, 'Не описано формулу призначення платежу для операції %s', '', 1, '300');

    bars_error.add_message(l_mod, 301, l_exc, l_rus, 'Невозможно рассчитать назначение платежа по формуле из карточки операции %s (%s)', '', 1, '301');
    bars_error.add_message(l_mod, 301, l_exc, l_ukr, 'Неможливо визначити призначення платежу за формулою з картки операції %s (%s)', '', 1, '301');

    bars_error.add_message(l_mod, 302, l_exc, l_rus, 'Не описана формула вычисления суммы комиссии для операции %s', '', 1, '302');
    bars_error.add_message(l_mod, 302, l_exc, l_ukr, 'Не описано формулу розрахунку суми комісії для операції %s', '', 1, '302');

    bars_error.add_message(l_mod, 303, l_exc, l_rus, 'Невозможно рассчитать сумму комиссии по формуле из карточки операции %s', '', 1, '303');
    bars_error.add_message(l_mod, 303, l_exc, l_ukr, 'Неможливо визначити суму комісії за формулою з картки операції %s', '', 1, '303');

    bars_error.add_message(l_mod, 304, l_exc, l_rus, 'Ошибка преобразования (в число) при расчете суммы комиссии по формуле из карточки операции (%s)', '', 1, '304');
    bars_error.add_message(l_mod, 304, l_exc, l_ukr, 'Помилка при конвертації (в число) при розрахунку суми комісії за формулою з картки операції (%s)', '', 1, '304');

    bars_error.add_message(l_mod, 305, l_exc, l_rus, 'Ошибка оплаты документа по взысканию комиссии за безналичное пополнение техн.счета - %s', '', 1, '305');
    bars_error.add_message(l_mod, 305, l_exc, l_ukr, 'Помилка при оплаті документа по стягенню комісії за безготівкове поповнення техн.рахунку - %s', '', 1, '305');

    bars_error.add_message(l_mod, 311, l_exc, l_rus, 'Данный документ (реф %s) уже связан с депозитным договором № %s', '', 1, '311');
    bars_error.add_message(l_mod, 311, l_exc, l_ukr, 'Даний документ (реф %s) вже зв''язаний з депозитним договором № %s', '', 1, '311');

    bars_error.add_message(l_mod, 312, l_exc, l_rus, 'Невозможно связать документ (реф %s) с депозитным договором № %s: %s', '', 1, '312');
    bars_error.add_message(l_mod, 312, l_exc, l_ukr, 'Неможливо зв''язати документ (реф %s) з депозитним договором № %s: %s', '', 1, '312');

    bars_error.add_message(l_mod, 313, l_exc, l_rus, 'Невозможно сторнировать документ (реф %s) по депозитному договору № %s: %s', '', 1, 'DPT_KILLDOC_ERROR');
    bars_error.add_message(l_mod, 313, l_exc, l_ukr, 'Неможливо сторнувати документ (реф %s) по депозитному договору № %s: %s', '', 1, 'DPT_KILLDOC_ERROR');

    bars_error.add_message(l_mod, 314, l_exc, l_rus, 'Запрещено сторнирование документа (реф %s) по депозитному договору № %s', '', 1, 'DPT_KILLDOC_DENIED');
    bars_error.add_message(l_mod, 314, l_exc, l_ukr, 'Заборонено сторнування документу (реф %s) по депозитному договору № %s', '', 1, 'DPT_KILLDOC_DENIED');

    bars_error.add_message(l_mod, 320, l_exc, l_rus, 'Не найдено доп. соглашение %s', '', 1, 'AGREEMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 320, l_exc, l_ukr, 'Не знайдено додаткову угоду %s', '', 1, 'AGREEMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 321, l_exc, l_rus, 'Невозможно сторнировать доп.соглашение № %s от %s к договору № %s (статус - %s, оформлен %s, тип ДС - %s, кол-во оплач.док-тов - %s)', '', 1, 'CANT_REVERSE_AGREEMENT');
    bars_error.add_message(l_mod, 321, l_exc, l_ukr, 'Неможливо сторнувати додаткову угоду № %s від %s до договору № %s(статус - %s, оформлена %s, тип ДУ - %s, кіл-ть оплач.док-тів - %s)', '', 1, 'CANT_REVERSE_AGREEMENT');

    bars_error.add_message(l_mod, 322, l_exc, l_rus, 'Доп. соглашение %s некорректное. Не найдено соглашение, которое отменяется данным.', '', 1, 'INCORRECT_CANCEL_AGREEMENT');
    bars_error.add_message(l_mod, 322, l_exc, l_ukr, 'Додаткова угода %s некоректна. Не знайдено угоду, що скасовується даною.', '', 1, 'INCORRECT_CANCEL_AGREEMENT');

    bars_error.add_message(l_mod, 323, l_exc, l_rus, 'Не найден клиент № %s', '', 1, 'CUST_NOT_FOUND');
    bars_error.add_message(l_mod, 323, l_exc, l_ukr, 'Не знайдений клієнт № %s', '', 1, 'CUST_NOT_FOUND');

    bars_error.add_message(l_mod, 324, l_exc, l_rus, 'Запись о довереном лице (ид. = %s) не найдена.', '', 1, 'TRUSTEE_NOT_FOUND');
    bars_error.add_message(l_mod, 324, l_exc, l_ukr, 'Запис про довірену особу (ід. = %s) не знайдено.', '', 1, 'TRUSTEE_NOT_FOUND');

    bars_error.add_message(l_mod, 325, l_exc, l_rus, 'Ошибка сторнирования документа № %s : %s', '', 1, 'BACK_DOC_ERROR');
    bars_error.add_message(l_mod, 325, l_exc, l_ukr, 'Помилка сторнування документу № %s : %s', '', 1, 'BACK_DOC_ERROR');

    bars_error.add_message(l_mod, 339, l_exc, l_rus, 'Не задан признак дохода по выплате депозита наследнику', '', 1, 'INVALID_INHERIT_INCOME');
    bars_error.add_message(l_mod, 339, l_exc, l_ukr, 'Не вказано ознаку доходу по виплаті депозиту спадкоємцю', '', 1, 'INVALID_INHERIT_INCOME');

    bars_error.add_message(l_mod, 340, l_exc, l_rus, 'Не заданы реквизиты свидетельства о праве на наследство', '', 1, 'INVALID_INHERIT_CERT');
    bars_error.add_message(l_mod, 340, l_exc, l_ukr, 'Не задані реквізити свідоцтва про права на спадок', '', 1, 'INVALID_INHERIT_CERT');

    bars_error.add_message(l_mod, 341, l_exc, l_rus, 'Не заданы реквизиты наследника (доля и дата вступления в права наследования)', '', 1, 'INVALID_INHERIT_PARAMS');
    bars_error.add_message(l_mod, 341, l_exc, l_ukr, 'Не задані реквізити спадкоємця (доля і дата вступлення в права спадкування)', '', 1, 'INVALID_INHERIT_PARAMS');

    bars_error.add_message(l_mod, 342, l_exc, l_rus, 'Не найдена запись о наследнике № %s по договору № %s', '', 1, 'INHERITOR_NOT_FOUND');
    bars_error.add_message(l_mod, 342, l_exc, l_ukr, 'Не знайдений запис про спадкоємця № %s по договору № %s', '', 1, 'INHERITOR_NOT_FOUND');

    bars_error.add_message(l_mod, 343, l_exc, l_rus, 'Ошибка изменения реквизитов наследника № %s по договору № %s', '', 1, 'INHERIT_UPDATE_FAILED');
    bars_error.add_message(l_mod, 343, l_exc, l_ukr, 'Помилка зміни реквізитів спадкоємця № %s по договору № %s', '', 1, 'INHERIT_UPDATE_FAILED');

    bars_error.add_message(l_mod, 344, l_exc, l_rus, 'Неверно заданы доли наследования по договору № %s', '', 1, 'INVALID_INHERIT_SHARE');
    bars_error.add_message(l_mod, 344, l_exc, l_ukr, 'Невірно задані частки спадку по договору № %s', '', 1, 'INVALID_INHERIT_SHARE');

    bars_error.add_message(l_mod, 345, l_exc, l_rus, 'Наследник № %s еще не вступил в права наследования договора № %s', '', 1, 'INHERIT_NOT_ACTIVE');
    bars_error.add_message(l_mod, 345, l_exc, l_ukr, 'Спадкоємець ще не вступив в права наслідування договору № %s', '', 1, 'INHERIT_NOT_ACTIVE');

    bars_error.add_message(l_mod, 346, l_exc, l_rus, 'Невозможно расчитать допустимую сумму выплаты по счету %s / %s - есть незавизир.документы', '', 1, 'INHERIT_CALC_DENIED');
    bars_error.add_message(l_mod, 346, l_exc, l_ukr, 'Неможливо розрахувати допустиму суму виплати по рахунку %s / %s - є незавіз.документи', '', 1, 'INHERIT_CALC_DENIED');

    bars_error.add_message(l_mod, 347, l_exc, l_rus, 'Невозможно рассчитать остаток на счете %s / %s на %s', '', 1, 'SALDO_CALC_ERROR');
    bars_error.add_message(l_mod, 347, l_exc, l_ukr, 'Неможливо обчислити залишок по рахунку %s / %s на %s', '', 1, 'SALDO_CALC_ERROR');

    bars_error.add_message(l_mod, 348, l_exc, l_rus, 'Наследник уже вступил в права наследования, изменение реквизитов недопустимо', '', 1, 'INHERIT_UPDATE_DENIED');
    bars_error.add_message(l_mod, 348, l_exc, l_ukr, 'Спадкоємець вже вступив в права наслідування, зміна реквізитів неприпустима', '', 1, 'INHERIT_UPDATE_DENIED');

    bars_error.add_message(l_mod, 349, l_exc, l_rus, 'Свидетельства о праве наследования договора № %s уже активированы', '', 1, 'INHERIT_ALREADY_ACTIVATED');
    bars_error.add_message(l_mod, 349, l_exc, l_ukr, 'Свідоцтва про права спадкування договору № %s вже активовано', '', 1, 'INHERIT_ALREADY_ACTIVATED');

    bars_error.add_message(l_mod, 350, l_exc, l_rus, 'Ошибка активации свидетельства о правах наследования договора № %s', '', 1, 'INHERIT_ACTIVATION_FAILED');
    bars_error.add_message(l_mod, 350, l_exc, l_ukr, 'Помилка активізації свідоцтва про права спадкування договору № %s', '', 1, 'INHERIT_ACTIVATION_FAILED');

    bars_error.add_message(l_mod, 351, l_exc, l_rus, 'Дата вступления в права должна быть больше даты выдачи свидетельства!', '', 1, 'INVALID_INHERIT_DATES');
    bars_error.add_message(l_mod, 351, l_exc, l_ukr, 'Дата вступу в права має бути більша за дату видачі свідоцтва!', '', 1, 'INVALID_INHERIT_DATES');

    bars_error.add_message(l_mod, 352, l_exc, l_rus, 'Не указаны все реквизиты  уплаты налога!', '', 1, 'INVALID_TAX_DETAILS');
    bars_error.add_message(l_mod, 352, l_exc, l_ukr, 'Не вказано всі реквізити докумета про сплату податку!', '', 1, 'INVALID_TAX_DETAILS');

    bars_error.add_message(l_mod, 353, l_exc, l_rus, 'Не найдены реквизиты для уплаты налога по подразделениям: %s', '', 1, 'NOT_FOUND_TAX_TRANSFER_DETAILS');
    bars_error.add_message(l_mod, 353, l_exc, l_ukr, 'Не знайдено реквізити для перерахування податку по підрозділам: %s', '', 1, 'NOT_FOUND_TAX_TRANSFER_DETAILS');

    bars_error.add_message(l_mod, 354, l_exc, l_rus, 'Запрещено редактирование кода подразделения (счет пренадлежит депозиту)', '', 1, 'BRANCH_EDIT_DENIED');
    bars_error.add_message(l_mod, 354, l_exc, l_ukr, 'Заборонено редагування коду підрозділу (рахунок належить депозиту)', '', 1, 'BRANCH_EDIT_DENIED');

    bars_error.add_message(l_mod, 355, l_exc, l_rus, 'Запрещено редактирование кода блокировки счета депозитной линии!', '', 1, 'BLK_EDIT_DENIED');
    bars_error.add_message(l_mod, 355, l_exc, l_ukr, 'Заборонено редагування коду блокування рахунка депозитної лінії!', '', 1, 'BLK_EDIT_DENIED');

    bars_error.add_message(l_mod, 369, l_exc, l_rus, 'Указан неверный код депозитного модуля - %s', '', 1, 'INVALID_PENALTY_MODCODE');
    bars_error.add_message(l_mod, 369, l_exc, l_ukr, 'Вказаний невірний код депозитного модуля - %s', '', 1, 'INVALID_PENALTY_MODCODE');

    bars_error.add_message(l_mod, 370, l_exc, l_rus, 'Указан неизвестный тип выплаты депозита - %s', '', 1, 'INVALID_PENALTY_TYPE');
    bars_error.add_message(l_mod, 370, l_exc, l_ukr, 'Вказаний невідомий тип виплати депозиту - %s', '', 1, 'INVALID_PENALTY_TYPE');

    bars_error.add_message(l_mod, 371, l_exc, l_rus, 'Указан неизвестный режим выполнения процедуры - %s', '', 1, 'INVALID_PENALTY_MODE');
    bars_error.add_message(l_mod, 371, l_exc, l_ukr, 'Вказаний невідомий режим виконання процедури - %s', '', 1, 'INVALID_PENALTY_MODE');

    bars_error.add_message(l_mod, 372, l_exc, l_rus, 'Расчет штрафа для договора № %s заблокирован: %s', '', 1, 'PENALTY_DENIED');
    bars_error.add_message(l_mod, 372, l_exc, l_ukr, 'Розрахунок штрафу для договору № %s заблоковано: %s', '', 1, 'PENALTY_DENIED');

    bars_error.add_message(l_mod, 373, l_exc, l_rus, 'Ошибка расчета штрафной ставки для договора № %s', '', 1, 'PENALTY_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 373, l_exc, l_ukr, 'Помилка розрахунку штрафної ставки для договору № %s', '', 1, 'PENALTY_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 374, l_exc, l_rus, 'Операция заблокирована: сумма договора № %s после снятия указанной суммы (%s), списания комиссий (%s + %s) и возврата излишне выплач.процентов (%s) меньше минимально допустимой (%s)', '', 1, 'PENALTY_EXCESSAMOUNT');
    bars_error.add_message(l_mod, 374, l_exc, l_ukr, 'Операція заблокована: сума договору № %s після зняття вказаної суми (%s), стягнення комісій (%s + %s) і повернення зайво сплач.відсотків (%s) менше мінімально допустимої (%s)', '', 1, 'PENALTY_EXCESSAMOUNT');

    bars_error.add_message(l_mod, 375, l_exc, l_rus, 'Для вклада № %s от %s (№ %s) не предусмотрено авансовое начисление процентов', '', 1, 'ADVANCE_MAKEINT_DENIED');
    bars_error.add_message(l_mod, 375, l_exc, l_ukr, 'Для вкладу № %s від %s (№ %s) не передбачене авансове нарахування відсотків', '', 1, 'ADVANCE_MAKEINT_DENIED');

    bars_error.add_message(l_mod, 376, l_exc, l_rus, 'Ошибка авансового начисления процентов по вкладу № %s от %s (№ %s): %s', '', 1, 'ADVANCE_MAKEINT_FAILED');
    bars_error.add_message(l_mod, 376, l_exc, l_ukr, 'Помилка авансового нарахування відсотків по вкладу № %s від %s (№ %s): %s', '', 1, 'ADVANCE_MAKEINT_FAILED');

    bars_error.add_message(l_mod, 377, l_exc, l_rus, 'Отказ от переоформления вклада №%s разрешен только до %s числа месяца', '', 1, 'FIX_EXTCANCEL_DENIED');
    bars_error.add_message(l_mod, 377, l_exc, l_ukr, 'Відмова від переоформлення вкладу №%s дозволена лише до %s числа місяця', '', 1, 'FIX_EXTCANCEL_DENIED');

    bars_error.add_message(l_mod, 378, l_exc, l_rus, 'Запрос на отказ клиента от переоформления вклада №%s от %s (%s) уже сформирован', '', 1, 'FIX_EXTCANCEL_DUPLICATE');
    bars_error.add_message(l_mod, 378, l_exc, l_ukr, 'Запит на відмову клієнта від переоформлення вкладу №%s від %s (%s) вже сформований', '', 1, 'FIX_EXTCANCEL_DUPLICATE');

    bars_error.add_message(l_mod, 379, l_exc, l_rus, 'Ошибка формирования запроса на отказ клиента от переоформления вклада №%s от %s (%s): %s', '', 1, 'FIX_EXTCANCEL_FAILED');
    bars_error.add_message(l_mod, 379, l_exc, l_ukr, 'Помилка формування запиту на відмову клієнта від переоформлення вкладу №%s від %s (%s): %s', '', 1, 'FIX_EXTCANCEL_FAILED');

    bars_error.add_message(l_mod, 380, l_exc, l_rus, 'Ошибка переоформления договора №%s (%s): %s', '', 1, 'AUTOEXT_FAILED');
    bars_error.add_message(l_mod, 380, l_exc, l_ukr, 'Помилка переоформлення договору №%s (%s): %s', '', 1, 'AUTOEXT_FAILED');

    bars_error.add_message(l_mod, 381, l_exc, l_rus, 'Ошибка установки бонуса для пролонгированных договоров подразделения %s (тип %s, процедура %s, деп.№ %s): %s', '', 1, 'AUTOEXTBONUS_FAILED');
    bars_error.add_message(l_mod, 381, l_exc, l_ukr, 'Помилка встановлення бонусу для пролонгованих договорів підрозділу %s (тип %s, процедура %s, деп.№ %s): %s', '', 1, 'AUTOEXTBONUS_FAILED');

    bars_error.add_message(l_mod, 382, l_exc, l_rus, 'Не найдена процедура расчета бонуса для метода пролонгации № %s', '', 1, 'EXTBONUS_TYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 382, l_exc, l_ukr, 'Не знайдена процедура розрахунку бонуса для методу пролонгації № %s', '', 1, 'EXTBONUS_TYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 383, l_exc, l_rus, 'Не найдены счета для начисления бонуса за пролонгацию договора № %s от %s (%s)', '', 1, 'EXTBONUS_PAYACC_NOT_FOUND');
    bars_error.add_message(l_mod, 383, l_exc, l_ukr, 'Не знайдено рахунки для нарахування бонусу за пролонгацію договору № %s від %s (%s)', '', 1, 'EXTBONUS_PAYACC_NOT_FOUND');

    bars_error.add_message(l_mod, 384, l_exc, l_rus, 'Ошибка оплаты документа по начислению бонуса за пролонгацию договора № %s от %s (%s): %s', '', 1, 'EXTBONUS_PAYDOC_FAILED');
    bars_error.add_message(l_mod, 384, l_exc, l_ukr, 'Помилка сплати документа по нарахуванню бонуса за пролонгації договора № %s від %s (%s): %s', '', 1, 'EXTBONUS_PAYDOC_FAILED');

    bars_error.add_message(l_mod, 385, l_exc, l_rus, 'Ошибка расчета и начисления бонуса за пролонгацию договора № %s от %s (%s): %s', '', 1, 'EXTBONUS_FAILED');
    bars_error.add_message(l_mod, 385, l_exc, l_ukr, 'Помилка розрахунку і нарахування бонусу за пролонгацію договора № %s від %s (%s): %s', '', 1, 'EXTBONUS_FAILED');

    bars_error.add_message(l_mod, 386, l_exc, l_rus, 'Ошибка обновления параметра R013 для счетов по вкладу № %s: %s', '', 1, 'SYNCR013_FAILED');
    bars_error.add_message(l_mod, 386, l_exc, l_ukr, 'Помилка оновлення параметру R013 для рахунків по вкладу № %s: %s', '', 1, 'SYNCR013_FAILED');

    bars_error.add_message(l_mod, 387, l_exc, l_rus, 'Не найден необработанный запрос на отказ клиента от переоформления вклада № %s от %s (%s)', '', 1, 'VERIFY_EXTCANCEL_NOT_FOUND');
    bars_error.add_message(l_mod, 387, l_exc, l_ukr, 'Не знайдений необроблений запит на відмову кліента від переоформлення вкладу № %s від %s (%s)', '', 1, 'VERIFY_EXTCANCEL_NOT_FOUND');

    bars_error.add_message(l_mod, 388, l_exc, l_rus, 'Запрос на отказ клиента от переоформления вклада № %s от %s (%s) должен быть подтвержден др.пользователем', '', 1, 'VERIFY_EXTCANCEL_DENIED');
    bars_error.add_message(l_mod, 388, l_exc, l_ukr, 'Запит на відмову клієнта від переоформлення вкладу № %s від %s (%s) повинен бути підтверджений інш.користувачем', '', 1, 'VERIFY_EXTCANCEL_DENIED');

    bars_error.add_message(l_mod, 389, l_exc, l_rus, 'Некорректный статус (%s) запроса на отказ клиента от переоформления вклада № %s от %s (%s)', '', 1, 'VERIFY_EXTCANCEL_INVALIDSTATE');
    bars_error.add_message(l_mod, 389, l_exc, l_ukr, 'Некоректний статус (%s) запиту на відмову клієнта від переоформлення вкладу № %s від %s (%s)', '', 1, 'VERIFY_EXTCANCEL_INVALIDSTATE');

    bars_error.add_message(l_mod, 390, l_exc, l_rus, 'Ошибка подтверждения запроса на отказ вкладчика от переоформления вклада № %s от %s (%s): %s', '', 1, 'VERIFY_EXTCANCEL_FAILED');
    bars_error.add_message(l_mod, 390, l_exc, l_ukr, 'Помилка підтвердження запиту на відмову кліента від переоформлення вкладу № %s від %s (%s): %s', '', 1, 'VERIFY_EXTCANCEL_FAILED');

    bars_error.add_message(l_mod, 391, l_exc, l_rus, 'Возврат депозита/выплата процентов заблокированы: ожидается пролонгация вклада № %s', '', 1, 'DEPRETURN_DENID');
    bars_error.add_message(l_mod, 391, l_exc, l_ukr, 'Поверення депозиту/виплата відсотків заблоковано: очікується пролонгація вкладу № %s', '', 1, 'DEPRETURN_DENID');

    bars_error.add_message(l_mod, 392, l_exc, l_rus, 'Для вычисления %% ставки при автопереоформлении вклада указан неизвестный метод с кодом %s.', '', 1, 'INVALID_EXTENSION_METHOD');
    bars_error.add_message(l_mod, 392, l_exc, l_ukr, 'Для обчислення %% ставки при автопереоформленні депозиту вказано невідомий метод з кодом %s.', '', 1, 'INVALID_EXTENSION_METHOD');

    bars_error.add_message(l_mod, 393, l_exc, l_rus, 'Не найдено ДС с %% ставкой для автопереоформления вклада № %s.', '', 1, 'EXTENSION_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 393, l_exc, l_ukr, 'Не знайдена ДУ з %% ставкою для автопереоформлення депозиту № %s.', '', 1, 'EXTENSION_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 401, l_exc, l_rus, 'Не найдена операция: %s', '', 1, 'TT_NOT_FOUND');
    bars_error.add_message(l_mod, 401, l_exc, l_ukr, 'Не знайдена операція: %s', '', 1, 'TT_NOT_FOUND');

    bars_error.add_message(l_mod, 402, l_exc, l_rus, 'Ошибка вычисления формулы суммы: %s', '', 1, 'SUM_EVAL_ERR');
    bars_error.add_message(l_mod, 402, l_exc, l_ukr, 'Помилка обчислення формули суми: %s', '', 1, 'SUM_EVAL_ERR');

    bars_error.add_message(l_mod, 403, l_exc, l_rus, 'Неизвестный режим тип выполнения (%s)', '', 1, 'CTRLDEPAMNT_INVALID_MODE');
    bars_error.add_message(l_mod, 403, l_exc, l_ukr, 'Невідомий режим виконання (%s)', '', 1, 'CTRLDEPAMNT_INVALID_MODE');

    bars_error.add_message(l_mod, 404, l_exc, l_rus, 'Превышение максимальной суммы портфеля', '', 1, 'CTRLDEPAMNT_BROKEN_LIMIT');
    bars_error.add_message(l_mod, 404, l_exc, l_ukr, 'Перевищення максимальної суми портфеля', '', 1, 'CTRLDEPAMNT_BROKEN_LIMIT');

    bars_error.add_message(l_mod, 405, l_exc, l_rus, 'Ошибка контроля суммы привлеченного вклада № %s: %s', '', 1, 'CTRLDEPAMNT_FAILED');
    bars_error.add_message(l_mod, 405, l_exc, l_ukr, 'Помилка контроля суми залученого вкладу № %s: %s', '', 1, 'CTRLDEPAMNT_FAILED');

    bars_error.add_message(l_mod, 410, l_exc, l_rus, '%s', '', 1, 'BONUS_CHECK_ERROR');
    bars_error.add_message(l_mod, 410, l_exc, l_ukr, '%s', '', 1, 'BONUS_CHECK_ERROR');

    bars_error.add_message(l_mod, 411, l_exc, l_rus, 'Ошибка вычисления активности привязки льготы №%s - %s к виду вклада № %s: %s', '', 1, 'BONUS_CHECK_FAILED');
    bars_error.add_message(l_mod, 411, l_exc, l_ukr, 'Помилка обчислення активності прив''язки пільги №%s - %s до виду вкладу № %s: %s', '', 1, 'BONUS_CHECK_FAILED');

    bars_error.add_message(l_mod, 412, l_exc, l_rus, ' %s', '', 1, 'BONUS_CALC_ERROR');
    bars_error.add_message(l_mod, 412, l_exc, l_ukr, ' %s', '', 1, 'BONUS_CALC_ERROR');

    bars_error.add_message(l_mod, 413, l_exc, l_rus, 'Ошибка вычисления размера льготы №%s - %s: %s', '', 1, 'BONUS_CALC_FAILED');
    bars_error.add_message(l_mod, 413, l_exc, l_ukr, 'Помилка обчислення розміру пільги №%s - %s: %s', '', 1, 'BONUS_CALC_FAILED');

    bars_error.add_message(l_mod, 414, l_exc, l_rus, 'Ошибка записи запроса на получение льготы № %s по договору №%s: %s', '', 1, 'FIX_BONUS_REQUEST_ERROR');
    bars_error.add_message(l_mod, 414, l_exc, l_ukr, 'Помилка запису запита на отримання пільги № %s по договору №%s: %s', '', 1, 'FIX_BONUS_REQUEST_ERROR');

    bars_error.add_message(l_mod, 415, l_exc, l_rus, 'Ошибка вставки запросов на получение льготы в очередь запросов по договору № %s: %s', '', 1, 'INS_BONUS_QUERY_ERROR');
    bars_error.add_message(l_mod, 415, l_exc, l_ukr, 'Помилка запису запитів на отримання пільги в чергу запитів по договору № %s: %s', '', 1, 'INS_BONUS_QUERY_ERROR');

    bars_error.add_message(l_mod, 416, l_exc, l_rus, 'В очереди запросов на получение льгот не найдена инф-ция по договору № %s', '', 1, 'BONUS_REQUE_NOT_FOUND');
    bars_error.add_message(l_mod, 416, l_exc, l_ukr, 'В черзі запитів на отримання пільг не знайдена інф-ція по договору № %s', '', 1, 'BONUS_REQUE_NOT_FOUND');

    bars_error.add_message(l_mod, 417, l_exc, l_rus, 'Ошибка удаления запросов на получение льготы по договору № %s из очереди запросов: %s', '', 1, 'DEL_BONUS_QUERY_ERROR');
    bars_error.add_message(l_mod, 417, l_exc, l_ukr, 'Помилка видалення запитів на отримання пільг по договору № %s з черги запитів: %s', '', 1, 'DEL_BONUS_QUERY_ERROR');

    bars_error.add_message(l_mod, 418, l_exc, l_rus, '%s', '', 1, 'BONUS_EXCLUSION_ERROR');
    bars_error.add_message(l_mod, 418, l_exc, l_ukr, '%s', '', 1, 'BONUS_EXCLUSION_ERROR');

    bars_error.add_message(l_mod, 419, l_exc, l_rus, 'Ошибка при выполнении процедуры исключения льгот по договору № %s: %s', '', 1, 'BONUS_EXCLUSION_FAILED');
    bars_error.add_message(l_mod, 419, l_exc, l_ukr, 'Помилка при виконанні процедури виключення пільг по договору № %s: %s', '', 1, 'BONUS_EXCLUSION_FAILED');

    bars_error.add_message(l_mod, 420, l_exc, l_rus, 'Ошибка управления привязкой льготы № %s к виду договора № %s (ранг %s): %s', '', 1, 'ADD_VIDD2BONUS_FAILED');
    bars_error.add_message(l_mod, 420, l_exc, l_ukr, 'Помилка управління прив''язкою пільги № %s до виду договору № %s (ранг %s): %s', '', 1, 'ADD_VIDD2BONUS_FAILED');

    bars_error.add_message(l_mod, 421, l_exc, l_rus, 'Не найден запрос на получение льготы № %s по договору № %s', '', 1, 'BONUS_REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 421, l_exc, l_ukr, 'Не знайдений запит на отримання пільги № %s по договору № %s', '', 1, 'BONUS_REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 422, l_exc, l_rus, 'Запрещено удаление запроса на получение льготы № %s по договору № %s (статус = %s, флаг подтверждения = %s)', '', 1, 'INVALID_BONUS_REQUEST_4DEL');
    bars_error.add_message(l_mod, 422, l_exc, l_ukr, 'Заборонено видалення запиту на отримання пільги № %s по договору № %s (статус = %s, флаг підтвердження = %s)', '', 1, 'INVALID_BONUS_REQUEST_4DEL');

    bars_error.add_message(l_mod, 423, l_exc, l_rus, 'Ошибка удаления запроса на получение льготы № %s по договору № %s: %s', '', 1, 'BONUS_REQUEST_DEL_ERROR');
    bars_error.add_message(l_mod, 423, l_exc, l_ukr, 'Помилка видалення запиту на отримання пільги № %s по договору № %s: %s', '', 1, 'BONUS_REQUEST_DEL_ERROR');

    bars_error.add_message(l_mod, 424, l_exc, l_rus, 'Невозможно рассчитать итоговую льготу: по договору № %s есть необработанные запросы', '', 1, 'DPT_BONUS_IN_WORK');
    bars_error.add_message(l_mod, 424, l_exc, l_ukr, 'Неможливо розрахувати підсумкову пільгу: по договору  № %s є необроблені запити', '', 1, 'DPT_BONUS_IN_WORK');

    bars_error.add_message(l_mod, 425, l_exc, l_rus, 'Не найдена базовая %-ная ставка по договору № %s на %s', '', 1, 'DPT_RATE_NOT FOUND');
    bars_error.add_message(l_mod, 425, l_exc, l_ukr, 'Не знайдена базова %-вя ставка по договору № %s на %s', '', 1, 'DPT_RATE_NOT FOUND');

    bars_error.add_message(l_mod, 426, l_exc, l_rus, 'Невозможно установить льготную %-ную ставку по договору № %s (размер = %s, дата = %s)', '', 1, 'SET_BONUS_RATE_FAILED');
    bars_error.add_message(l_mod, 426, l_exc, l_ukr, 'Неможливо встановити пільгову %-ву ставку по договору № %s (розмір = %s, дата = %s)', '', 1, 'SET_BONUS_RATE_FAILED');

    bars_error.add_message(l_mod, 427, l_exc, l_rus, 'Подтверждение запроса на получение льготы № %s по договору № %s недопустимо (статус = %s, необх-ть подтвержд. = %s, признак удал. = %s, план.знач. = %s)', '', 1, 'INVALID_BONUS_REQUEST_2CONFIRM');
    bars_error.add_message(l_mod, 427, l_exc, l_ukr, 'Підтвердження запиту на отримання пільги № %s по договору № %s неприпустиме (статус = %s, необх-ть подтвержд. = %s, признак удал. = %s, план.знач. = %s)', '', 1, 'INVALID_BONUS_REQUEST_2CONFIRM');

    bars_error.add_message(l_mod, 428, l_exc, l_rus, 'Ошибка подтверждения запроса на получение льготы № %s по договору № %s: %s', '', 1, 'BONUS_REQUEST_CONFIRM_ERROR');
    bars_error.add_message(l_mod, 428, l_exc, l_ukr, 'Помилка підтвердження запиту на отримання пільги № %s по договору № %s: %s', '', 1, 'BONUS_REQUEST_CONFIRM_ERROR');

    bars_error.add_message(l_mod, 429, l_exc, l_rus, 'Ошибка перерасчета размера льготы № %s-%s по договору № %s: %s', '', 1, 'BONUS_RECALC_FAILED');
    bars_error.add_message(l_mod, 429, l_exc, l_ukr, 'Помилка перерахунку розміру пільги № %s-%s по договору № %s: %s', '', 1, 'BONUS_RECALC_FAILED');

    bars_error.add_message(l_mod, 430, l_exc, l_rus, 'Ошибка сохранения перерассчитанного значения льготы № %s по договору № %s: %s', '', 1, 'BONUS_RECALC_ERROR');
    bars_error.add_message(l_mod, 430, l_exc, l_ukr, 'Помилка збереження перерахованого значення пільги № %s по договору № %s: %s', '', 1, 'BONUS_RECALC_ERROR');

    bars_error.add_message(l_mod, 431, l_exc, l_rus, 'Есть необработанные записи в закрытом запросе № %s на получение льгот по договору № %s', '', 1, 'BONUS_QUERY_DISBALANCE');
    bars_error.add_message(l_mod, 431, l_exc, l_ukr, 'Є необроблені записи в закритому запиті № %s на отримання пільг по договору № %s', '', 1, 'BONUS_QUERY_DISBALANCE');

    bars_error.add_message(l_mod, 500, l_exc, l_rus, 'Задание с кодом № %s не описано в справочнике автоматических операций!', '', 1, '500');
    bars_error.add_message(l_mod, 500, l_exc, l_ukr, 'Завдання з кодом № %s не описане в довіднику автоматичних операцій!', '', 1, '500');

    bars_error.add_message(l_mod, 501, l_exc, l_rus, 'Ошибка при записи в журнал выполнения задания № %s - %s', '', 1, '501');
    bars_error.add_message(l_mod, 501, l_exc, l_ukr, 'Помилка при запису в журнал виконання завдання № %s - %s', '', 1, '501');

    bars_error.add_message(l_mod, 502, l_exc, l_rus, 'Не найдено задание № %s', '', 1, 'JOB_RUNID_NOT_FOUND');
    bars_error.add_message(l_mod, 502, l_exc, l_ukr, 'Не знайдене завдання № %s', '', 1, 'JOB_RUNID_NOT_FOUND');

    bars_error.add_message(l_mod, 503, l_exc, l_rus, 'Ошибка записи в журнал выполнения задания № %s информации по договору № %s - %s', '', 1, '503');
    bars_error.add_message(l_mod, 503, l_exc, l_ukr, 'Помилка запису в журнал виконання завдання № %s інформації по договору № %s - %s', '', 1, '503');

    bars_error.add_message(l_mod, 504, l_exc, l_rus, 'Ошибка фиксации окончания выполнения задания № %s - %s', '', 1, '504');
    bars_error.add_message(l_mod, 504, l_exc, l_ukr, 'Помилка фіксації закінчення виконання завдання № %s - %s', '', 1, '504');

    bars_error.add_message(l_mod, 505, l_exc, l_rus, 'Ошибка формирования очереди выполнения автоматических операций для OFFLINE-отделений - %s', '', 1, '505');
    bars_error.add_message(l_mod, 505, l_exc, l_ukr, 'Помилка формування черги виконання автоматичних операцій для OFFLINE-відділень - %s', '', 1, '505');

    bars_error.add_message(l_mod, 506, l_exc, l_rus, 'Не найдено автоматическое задание № %s для OFFLINE-отделения № %s', '', 1, '506');
    bars_error.add_message(l_mod, 506, l_exc, l_ukr, 'Не знайдене автоматичне завдання № %s для OFFLINE-відділення № %s', '', 1, '506');

    bars_error.add_message(l_mod, 510, l_exc, l_rus, 'Автоматическое задание с кодом %s не описано в справочнике автоматических операций!', '', 1, 'JOB_NOT_FOUND');
    bars_error.add_message(l_mod, 510, l_exc, l_ukr, 'Автоматичне завдання з кодом %s не описане в довіднику автоматичних операцій!', '', 1, 'JOB_NOT_FOUND');

    bars_error.add_message(l_mod, 511, l_exc, l_rus, 'Ошибка создания сценария для экспорта вида вклада № %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');
    bars_error.add_message(l_mod, 511, l_exc, l_ukr, 'Помилка створення сценарію для експорту виду вкладу № %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');

    bars_error.add_message(l_mod, 520, l_exc, l_rus, 'Неизвестный тип запроса %s', '', 1, 'REQTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 520, l_exc, l_ukr, 'Невідомий тип запиту %s', '', 1, 'REQTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 521, l_exc, l_rus, 'Запрос с идент. %s не найден', '', 1, 'REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 521, l_exc, l_ukr, 'Запит з ідент. %s не знайдено', '', 1, 'REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 522, l_exc, l_rus, 'Запрос с идент. %s уже обработан', '', 1, 'REQUEST_PROCESSED');
    bars_error.add_message(l_mod, 522, l_exc, l_ukr, 'Запит з ідент. %s вже оброблено', '', 1, 'REQUEST_PROCESSED');

    bars_error.add_message(l_mod, 523, l_exc, l_rus, 'Удаление деп. договора %s невозможно', '', 1, 'DELETE_DEAL_DISALLOWED');
    bars_error.add_message(l_mod, 523, l_exc, l_ukr, 'Видалення деп. договору %s неможливе', '', 1, 'DELETE_DEAL_DISALLOWED');

    bars_error.add_message(l_mod, 524, l_exc, l_rus, 'Невозможно определить пользователя, создавшего деп.договор %s', '', 1, 'DPTCREATOR_NOT_EXISTS');
    bars_error.add_message(l_mod, 524, l_exc, l_ukr, 'Неможливо знайти користувача, який створив договір', '', 1, 'DPTCREATOR_NOT_EXISTS');

    bars_error.add_message(l_mod, 525, l_exc, l_rus, 'Пользователь уже обработал запрос', '', 1, 'REQUEST_USER_CHECK_PUT');
    bars_error.add_message(l_mod, 525, l_exc, l_ukr, 'Користувач вже обробив запит', '', 1, 'REQUEST_USER_CHECK_PUT');

    bars_error.add_message(l_mod, 526, l_exc, l_rus, 'Запрос не подтвержден', '', 1, 'CANCEL_COMMIS_REFUSED');
    bars_error.add_message(l_mod, 526, l_exc, l_ukr, 'Запит не підтверджений', '', 1, 'CANCEL_COMMIS_REFUSED');

    bars_error.add_message(l_mod, 527, l_exc, l_rus, 'Для данного вида доп.соглашения комиссия обязательна', '', 1, 'REQUIRED_COMMISSDOC');
    bars_error.add_message(l_mod, 527, l_exc, l_ukr, 'Для даного виду дод.угоди комісія обов''язкова', '', 1, 'REQUIRED_COMMISSDOC');

    bars_error.add_message(l_mod, 528, l_exc, l_rus, 'Сумма ветхих купюр превышает сумму договора', '', 1, 'INVALID_DENOM_AMOUNT');
    bars_error.add_message(l_mod, 528, l_exc, l_ukr, 'Сума зношених купюр більша за суму договору', '', 1, 'INVALID_DENOM_AMOUNT');

    bars_error.add_message(l_mod, 529, l_exc, l_rus, 'Запрос на доступ с указанными параметрами уже существует под номером #%s!', '', 1, 'REQ_ACCESS_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 529, l_exc, l_ukr, 'Запит на доступ з вказаними параметрами вже існує під номером #%s!', '', 1, 'REQ_ACCESS_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 530, l_exc, l_rus, 'Регистрация доверенности на вклад по которому есть зарегистрированные наследники запрещена!', '', 1, 'REQ_ACCESS_REGISTRATION_DENIED');
    bars_error.add_message(l_mod, 530, l_exc, l_ukr, 'Реєстрація довіреності на вклад по якому є зареєстровані спадкоємці заборонена!', '', 1, 'REQ_ACCESS_REGISTRATION_DENIED');

    bars_error.add_message(l_mod, 531, l_exc, l_rus, 'Доля наследства должна быть в пределах от 1 до 100%!', '', 1, 'INVALID_INHERIT_SHARE_RANGE');
    bars_error.add_message(l_mod, 531, l_exc, l_ukr, 'Частка спадку має бути в межах від 1 до 100%!', '', 1, 'INVALID_INHERIT_SHARE_RANGE');

    bars_error.add_message(l_mod, 532, l_exc, l_rus, 'По вкладу уже существуют зарегистрированные наследники с долей %s !', '', 1, 'REGISTERED_INHERITORS_EXISTS');
    bars_error.add_message(l_mod, 532, l_exc, l_ukr, 'По вкладу вже існують зареєстровані спадкоємці з часткою %s !', '', 1, 'REGISTERED_INHERITORS_EXISTS');

    bars_error.add_message(l_mod, 533, l_exc, l_rus, 'Не найдена копия документа удостоверяющего личность подписанная клиентом с РНК% s!', '', 1, 'DOC_SIGNED_CLIENT_NOT_FOUND');
    bars_error.add_message(l_mod, 533, l_exc, l_ukr, 'Не знайдена копія документу, що посвідчує особу підписана клієнтом з РНК %s !', '', 1, 'DOC_SIGNED_CLIENT_NOT_FOUND');

    bars_error.add_message(l_mod, 534, l_exc, l_rus, 'Не указана причина отказа в доступе!', '', 1, 'REQ_NOT_VALID_REASON_REJECT');
    bars_error.add_message(l_mod, 534, l_exc, l_ukr, 'Не вказано причину відмови у доступі!', '', 1, 'REQ_NOT_VALID_REASON_REJECT');

    bars_error.add_message(l_mod, 535, l_exc, l_rus, 'Причина отказа содержит недостаточное кол-во символов!', '', 1, 'REQ_NOT_ENOUGH_CHARS_REASONS');
    bars_error.add_message(l_mod, 535, l_exc, l_ukr, 'Причина відмови містить недостатню к-ть символів!', '', 1, 'REQ_NOT_ENOUGH_CHARS_REASONS');

    bars_error.add_message(l_mod, 536, l_exc, l_rus, 'Данный тип действия уже привязан к другому шаблону для данного вида договора', '', 1, 'ERROR_TEMPLATES');
    bars_error.add_message(l_mod, 536, l_exc, l_ukr, 'Даний тип дії вже привязано до іншого шаблону для даного виду договору', '', 1, 'ERROR_TEMPLATES');

    bars_error.add_message(l_mod, 537, l_exc, l_rus, 'GLPENALTY_MAINTAXDET', '(за период с %s по %s /%s дн./ на сумму %s)', 1, 'GLPENALTY_MAINTAXDET');

    bars_error.add_message(l_mod, 538, l_exc, l_rus, 'GLPENALTY_PENYATAX', 'По основной ставке начислено %s %', 1, 'GLPENALTY_PENYATAX');

    bars_error.add_message(l_mod, 539, l_exc, l_rus, 'GLPENALTY_PENYATAXDET', '(за период с %s по %s /%s дн./ на сумму %s)', 1, 'GLPENALTY_PENYATAXDET');

    bars_error.add_message(l_mod, 540, l_exc, l_rus, 'Функция %s не используется', '', 1, 'PROCEDURE_DEPRECATED');
    bars_error.add_message(l_mod, 540, l_exc, l_ukr, 'Функція %s не використовується', '', 1, 'PROCEDURE_DEPRECATED');

    bars_error.add_message(l_mod, 701, l_exc, l_rus, 'Депозит на акционных условиях не может быть открыт: По состоянию на %s у клиента нет депозитов на сумму более 200 тыс. грн. (в наличии %s)', '', 1, 'NOT_ENOUGH_BALANCE');
    bars_error.add_message(l_mod, 701, l_exc, l_ukr, 'Депозит на акційних умовах не може бути відкрито: Станом на %s у клієнта немає депозитів на суму більше ніж 200 тис. грн. (в наявності %s)', '', 1, 'NOT_ENOUGH_BALANCE');
    
    bars_error.add_message(l_mod, 702, l_exc, l_rus, 'Депозит на акционных условиях не может быть открыт: Фактический остаток действующих депозитов (%s) меньше остатка на %s (%s)', '', 1, 'CURRENT_BALANCE_LESS_CONTROL');
    bars_error.add_message(l_mod, 702, l_exc, l_ukr, 'Депозит на акційних умовах не може бути відкрито: Фактичний залишок діючих депозитів (%s) менше ніж залишок на %s (%s)', '', 1, 'CURRENT_BALANCE_LESS_CONTROL');

    bars_error.add_message(l_mod, 703, l_exc, l_rus, 'Для вида вклада %s не указана мин.допустимая сумма на деп.счетах клиента!', '', 1, 'MIN_DEPBALANCE_FAILED');
    bars_error.add_message(l_mod, 703, l_exc, l_ukr, 'Для виду вклада %s не вказана мін.припустима сума на деп.рахунках клієнта!', '', 1, 'MIN_DEPBALANCE_FAILED');    
    
    bars_error.add_message(l_mod, 704, l_exc, l_rus, 'Для вида вклада %s не указана дата начала действия вклада!', '', 1, 'VIDD_DATN_NOT_FOUND');
    bars_error.add_message(l_mod, 704, l_exc, l_ukr, 'Для виду вклада %s не вказана дата початку дії вклада!', '', 1, 'VIDD_DATN_NOT_FOUND');    
    
    bars_error.add_message(l_mod, 705, l_exc, l_rus, 'Параметр %s не найден', '', 1, 'VIDDPARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 705, l_exc, l_ukr, 'Параметр %s не знайдено', '', 1, 'VIDDPARAM_NOT_FOUND');    

    bars_error.add_message(l_mod, 706, l_exc, l_rus, 'По депозитному портфелю клиента есть незавизированные платежи. Завершите визирование и повторите попытку открытия депозита!', '', 1, 'FUTURE_BALANCE_LESS_CURRENT');
    bars_error.add_message(l_mod, 706, l_exc, l_ukr, 'Для депозитного портфелю клієнта є незавізовані операції. Треба завершити візування та повторити спробу відкриття депозита!', '', 1, 'FUTURE_BALANCE_LESS_CURRENT');
    
    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 999, l_exc, l_rus, 'Ошибка выполнения автомат.операции - %s', '', 1, 'AUTOJOB_ERROR');
    bars_error.add_message(l_mod, 999, l_exc, l_ukr, 'Помилка виконання автомат.операції - %s', '', 1, 'AUTOJOB_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
