PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_DPU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль DPU ***
declare
  l_mod  varchar2(3) := 'DPU';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Депозиты юр.лиц', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Ошибка определения референса договора', '', 1, 'CANT_GET_DPUID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Помилка визначення референсу договору!', '', 1, 'CANT_GET_DPUID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'Не найден клиент № %s', '', 1, 'RNK_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'Не знайдений клієнт № %s', '', 1, 'RNK_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Не найден вид договора № %s', '', 1, 'VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Не знайдений вид договору № %s', '', 1, 'VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Ошибка вычисления № счета (РНК %s, вид %s): %s', '', 1, 'ACCNUM_GENERATION_FAILED');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Помилка розрахунку № рахунку (РНК %s, вид %s): %s', '', 1, 'ACCNUM_GENERATION_FAILED');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'Не найден счет проц.расходов для вида договора № %s и подразделения %s: %s', '', 1, 'EXPENSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'Не знайдений рахунок проц.витрат для виду договору № %s і підрозділу %s: %s', '', 1, 'EXPENSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'Ошибка при открытии связанного договора № %s: %s', '', 1, 'OPENCOMBDEAL_FAILED');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'Помилка при відкритті зв''язаного договору № %s: %s', '', 1, 'OPENCOMBDEAL_FAILED');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'Ошибка при заполнении процентной карточки по счету %s/%s: %s', '', 1, 'OPENINTCARD_FAILED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'Помилка при заповненні відсоткової картки по рахунку %s/%s: %s', '', 1, 'OPENINTCARD_FAILED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'Ошибка при открытии счета %s/%s: %s', '', 1, 'OPENACC_FAILED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'Помилка при відкритті рахунку %s/%s: %s', '', 1, 'OPENACC_FAILED');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'Ошибка при открытии договора № %s: %s', '', 1, 'OPENDPUDEAL_FAILED');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'Помилка при відкритті договору № %s: %s', '', 1, 'OPENDPUDEAL_FAILED');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'Задан некорректный номер доп.соглашения %s', '', 1, 'ERR_ND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'Заданий некоректний номер додаткової угоди %s', '', 1, 'ERR_ND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'Не найдены счета генерального договора № %s', '', 1, 'GENACC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'Не знайдено рахунки генерального договору № %s', '', 1, 'GENACC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'Ошибка при открытии счетов для доп.соглашения №%s к договору реф.№%s: %s', '', 1, 'AGROPENACC_FAILED');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'Пимилка при відкритті рахунків для дод.угоди №%s до договору реф.№%s: %s', '', 1, 'AGROPENACC_FAILED');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'Номер договора (%s) содержит нечисл.символы', '', 1, 'DEALNUM_VALUE_ERROR');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'Номер договору (%s) містить нечисл.сімволи', '', 1, 'DEALNUM_VALUE_ERROR');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'Не определена маска открытия счетов!', '', 1, 'ACCMASK_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'Не визначена маска відкриття рахунків!', '', 1, 'ACCMASK_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'Не найден код арифметической операции умножения', '', 1, 'OP_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'Не знайдено код для аріфметичної операції множення', '', 1, 'OP_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, 'Не найден депозитный договор %s', '', 1, 'DPUID_NOT_FOUND');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, 'Не знайдений депозитний договір %s', '', 1, 'DPUID_NOT_FOUND');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, 'Депозитный договор %s - не предусмотрено штрафование', '', 1, 'DPUID_IDSTOP_0');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, 'Депозитний договір %s - не передбачено штрафування', '', 1, 'DPUID_IDSTOP_0');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, 'Депозитный договор %s - не вступил в силу', '', 1, 'DPUID_NOT_BEGIN');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, 'Депозитний договір %s - не вступив в силу', '', 1, 'DPUID_NOT_BEGIN');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'Депозитный договор %s - бессрочный', '', 1, 'DPUID_DATO_IS_NULL');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'Депозитний договір %s - безстроковий', '', 1, 'DPUID_DATO_IS_NULL');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'Депозитный договор %s - просрочен', '', 1, 'DPUID_END');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'Депозитний договір %s - прострочений', '', 1, 'DPUID_END');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'Не описаны параметры штрафа № %s', '', 1, 'IDSTOP_PARAMS_NOT_FOUND');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Не описані параметри штрафу № %s', '', 1, 'IDSTOP_PARAMS_NOT_FOUND');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'Невозможно вычислить действующую процентную ставку по договору!', '', 1, 'ACTUALRATE_IS_NULL');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'Неможливо визначити діючу відсоткову ставку по договору!', '', 1, 'ACTUALRATE_IS_NULL');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'Невозможно получить значение базовой ставки № %s', '', 1, 'SHPROC_NOT_FOUND');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'Неможливо визначити значення базової ставки № %s', '', 1, 'SHPROC_NOT_FOUND');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'Некорректно описан штраф!', '', 1, 'SH_IS_UNCORRECT');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'Некоректно описаний штраф!', '', 1, 'SH_IS_UNCORRECT');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'Не установлен неснижаемый остаток!', '', 1, 'MINSUM_0');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'Не встановлений незнижуваний залишок!', '', 1, 'MINSUM_0');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, 'Не найден документ № %s', '', 1, 'COMB_INPAYMENT_NOT_FOUND');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, 'Не знайдений документ № %s', '', 1, 'COMB_INPAYMENT_NOT_FOUND');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, 'Не найден договор (реф.%s)', '', 1, 'COMB_DEAL_NOT_FOUND');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, 'Не знайдений договір (реф.%s)', '', 1, 'COMB_DEAL_NOT_FOUND');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, 'Не найден деп.счет договору № %s', '', 1, 'COMB_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, 'Не знайдений деп.рахунок договору № %s', '', 1, 'COMB_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, 'По счету %s/%s есть незавизированные документы', '', 1, 'COMB_SALDOCHECK_FAILED');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, 'По рахунку %s/%s є незавізовані документи', '', 1, 'COMB_SALDOCHECK_FAILED');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, 'Счет %s/%s закрыт', '', 1, 'COMB_ACCOPENCHECK_FAILED');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, 'Рахунок %s/%s закритий', '', 1, 'COMB_ACCOPENCHECK_FAILED');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, 'Валюта документа(%s) не совпадает с валютой счета %s/%s', '', 1, 'COMB_CURRENCYCHECK_FAILED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, 'Валюта документу(%s) не спывпадає з валютою рахунку %s/%s', '', 1, 'COMB_CURRENCYCHECK_FAILED');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, 'Договора № %s и № %s принадлежат разным клиентам', '', 1, 'COMB_CUSTCHECK_FAILED');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, 'Договори № %s і № %s належать різним клієнтам', '', 1, 'COMB_CUSTCHECK_FAILED');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, 'Договор № %s не активный', '', 1, 'COMB_DEALDAT_FAILED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, 'Договір № %s не активний', '', 1, 'COMB_DEALDAT_FAILED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, 'Договора № %s и № %s - не комбинированные', '', 1, 'COMB_INVALID_DPUTYPE');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, 'Договори № %s і № %s не є комбінованими', '', 1, 'COMB_INVALID_DPUTYPE');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, 'Ошибка изъятия документа № %s из картотеки', '', 1, 'COMB_NLKREFUPD_FAILED');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, 'Помилка вилучення документу № %s з картотеки', '', 1, 'COMB_NLKREFUPD_FAILED');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, 'Ошибка зачисления (%s -> %s/%s, %s -> %s/%s): %s', '', 1, 'COMB_BREAKDOWN_FAILED');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, 'Помилка зарахування (%s -> %s/%s, %s -> %s/%s): %s', '', 1, 'COMB_BREAKDOWN_FAILED');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, 'Не описана операция для зачисления средств', '', 1, 'COMB_TT_NOT_FOUND');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, 'Не описана операція для зарахування коштів', '', 1, 'COMB_TT_NOT_FOUND');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, 'Не найден процентный счет по договору № %s', '', 1, 'UPDEAL_INTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, 'Не знайдений процентний рахунок по договору № %s', '', 1, 'UPDEAL_INTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, 'Не задан номер договора № %s', '', 1, 'UPDEAL_NUM_NULL');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, 'Не заданий номер договору № %s', '', 1, 'UPDEAL_NUM_NULL');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, 'Не задана дата оформления договора № %s', '', 1, 'UPDEAL_DATREG_NULL');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, 'Не задана дата оформлення договору № %s', '', 1, 'UPDEAL_DATREG_NULL');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, 'Не задана дата начала договора № %s', '', 1, 'UPDEAL_DATBEG_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, 'Не задана дата початку договору № %s', '', 1, 'UPDEAL_DATBEG_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, 'Не задана процентная ставка по договору № %s', '', 1, 'UPDEAL_RATE_NULL');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, 'Не задана відсоткова ставка по договору № %s', '', 1, 'UPDEAL_RATE_NULL');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, 'Не задана период-ть выплаты %% по договору № %s', '', 1, 'UPDEAL_FREQ_NULL');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Не задана період-ть сплати %% по договору № %s', '', 1, 'UPDEAL_FREQ_NULL');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, 'Не задан штраф за расторжение договора № %s', '', 1, 'UPDEAL_STOP_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, 'Не заданий штраф за розторгнення договору № %s', '', 1, 'UPDEAL_STOP_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, 'Не задано подразделение для договора № %s', '', 1, 'UPDEAL_BRANCH_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, 'Не заданий підрозділ для договору № %s', '', 1, 'UPDEAL_BRANCH_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, 'Ошибка изменения параметров договора № %s: %s', '', 1, 'UPDEAL_FAILED');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, 'Помилка зміни параметрів договору № %s: %s', '', 1, 'UPDEAL_FAILED');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, 'Ошибка пролонгации договора № %s: %s', '', 1, 'UPDEAL_PROLONG_FAILED');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, 'Помилка пролонгації договору № %s: %s', '', 1, 'UPDEAL_PROLONG_FAILED');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, 'Не найдена ставка по договору № %s на %s', '', 1, 'UPDEAL_RATE_NOT_FOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, 'Не знайдена ставка по договору № %s на %s', '', 1, 'UPDEAL_RATE_NOT_FOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, 'Ошибка изменения ставки по договору № %s: %s', '', 1, 'UPDEAL_RATE_FAILED');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, 'Помилка зміни ставки по договору № %s: %s', '', 1, 'UPDEAL_RATE_FAILED');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, 'Срочность депозита не соответствует бал.счету %s (%s != %s)', '', 1, 'S180_INVALID');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, 'Термін депозиту не відповідає бал.рахунку %s (%s != %s)', '', 1, 'S180_INVALID');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, 'Изменение вида договора № %s на комбинированный запрещено', '', 1, 'CRTSUBDEAL_NOTVALID');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, 'Зміна виду договору № %s на комбінований заборонена', '', 1, 'CRTSUBDEAL_NOTVALID');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, 'Не найден комб.вид для вида № %s', '', 1, 'CRTSUBDEAL_NOCOMBTYPE');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, 'Не знайдений комб.вид для виду № %s', '', 1, 'CRTSUBDEAL_NOCOMBTYPE');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, 'Не найдена ставка по договору № %s', '', 1, 'CRTSUBDEAL_NORATE');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, 'Не знайдена ставка по договору № %s', '', 1, 'CRTSUBDEAL_NORATE');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, 'Ошибка при открытии связанного договора для комб.договора № %s: %s', '', 1, 'CRTSUBDEAL_FAILED');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, 'Помилка при відкритті зв''язаного договору для комб.договору № %s: %s', '', 1, 'CRTSUBDEAL_FAILED');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, 'Указан недопустимое значение OB22 (%s) для бал.счета %s', '', 1, 'INVALID_OBB22');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, 'Вказане неприпустиме значення OB22 (%s) для бал.рах. %s', '', 1, 'INVALID_OBB22');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, 'Ошибка создания сценария для экспорта вида договора № %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, 'Помилка створення сценарію для експорта вида договора № %s: %s', '', 1, 'GEN_EXPDPTYPE_FAILED');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, 'Не найден вид договора № %s', '', 1, 'SETYPERATE_VIDD_NOT_FOUND');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, 'Не знайдений вид договору № %s', '', 1, 'SETYPERATE_VIDD_NOT_FOUND');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, 'Не найден тип продукта № %s', '', 1, 'SETYPERATE_TYPEID_NOT_FOUND');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, 'Не знайдений тип продукту № %s', '', 1, 'SETYPERATE_TYPEID_NOT_FOUND');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, 'Не найдена валюта № %s', '', 1, 'SETYPERATE_KV_NOT_FOUND');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, 'Не знайдена валюта № %s', '', 1, 'SETYPERATE_KV_NOT_FOUND');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, 'Указанный тип продукта (%s) не соответствует типу (%s) вида договора № %s', '', 1, 'SETYPERATE_TYPEID_MISMATCH');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, 'Вказаний тип продукту (%s) не відповідає типу (%s) виду договору № %s', '', 1, 'SETYPERATE_TYPEID_MISMATCH');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, 'Указанная валюта (%s) не соответствует валюте (%s) вида договора № %s', '', 1, 'SETYPERATE_KV_MISMATCH');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, 'Вказана валюта (%s) не відповідає валюті (%s) виду договору № %s', '', 1, 'SETYPERATE_KV_MISMATCH');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, 'Некорректно задан гран.срок (%s мес, %s дней, флаг вкл. %s)', '', 1, 'SETYPERATE_TERM_INVALID');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, 'Некоректно заданий гран.термін (%s міс, %s днів, флаг вкл. %s)', '', 1, 'SETYPERATE_TERM_INVALID');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, 'Некорректно задана гран.сумма (%s, флаг вкл. %s)', '', 1, 'SETYPERATE_AMNT_INVALID');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, 'Некоректно задана гран.сума (%s, флаг вкл. %s)', '', 1, 'SETYPERATE_AMNT_INVALID');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, 'Некорректно заданы ставки (факт. %s, макс. %s)', '', 1, 'SETYPERATE_RATE_INVALID');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, 'Некоректно задані ставки (факт. %s, макс. %s)', '', 1, 'SETYPERATE_RATE_INVALID');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, 'Ошибка при записи ставки для продукта %s/%s (вид %s), срока %s/%s и суммы %s: %s', '', 1, 'SETYPERATE_FAILED');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, 'Помилка при запису ставки для продукту %s/%s (вид %s), терміну %s/%s і суми %s: %s', '', 1, 'SETYPERATE_FAILED');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, 'Платеж по зачислению средств на ген.счет деп.линии (реф.%s) обрабатывается др.пользователем', '', 1, 'GENACC_RECEIPT_LOCKED');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, 'Платіж по зарахуванню коштів на ген.рахунок деп.лінії (реф.%s) оброблюється іншим користувачем', '', 1, 'GENACC_RECEIPT_LOCKED');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, 'Ошибка при обработке платежа по зачислению средств на ген.счет деп.линии (реф.%s): %s', '', 1, 'GENACC_RECEIPT_FAILED');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, 'Помилка при обробці платежу по зарахуванню коштів на ген.рахунок деп.лінії (реф.%s): %s', '', 1, 'GENACC_RECEIPT_FAILED');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, 'Депозитный договор № %s - найдены незавизир.документы по деп.счету', '', 1, 'DEPACC_SALDO_MISMATCH');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, 'Депозитний договір № %s - найдены незавизир.документы по деп.счету', '', 1, 'DEPACC_SALDO_MISMATCH');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, 'Депозитный договор № %s - найдены незавизир.документы по проц.счету', '', 1, 'INTACC_SALDO_MISMATCH');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, 'Депозитний договір № %s - найдены незавизир.документы по проц.счету', '', 1, 'INTACC_SALDO_MISMATCH');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, 'Закрытие %s заблокировано - уже закрыт', '', 1, 'CLOSDEAL_DENIED_ISCLOSED');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, 'Закриття %s заблоковано - вже закритий', '', 1, 'CLOSDEAL_DENIED_ISCLOSED');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, 'Закрытие %s заблокировано - ненулевые остатки на счете %s/%s', '', 1, 'CLOSDEAL_DENIED_SALDO');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, 'Закриття %s заблоковано - ненульові залишки на рахунку %s/%s', '', 1, 'CLOSDEAL_DENIED_SALDO');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, 'Закрытие %s заблокировано - в текущем дне найдены движения по счету %s/%s', '', 1, 'CLOSDEAL_DENIED_TURNS');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, 'Закриття %s заблоковано - в поточному дні знайдено обороти по рахунку %s/%s', '', 1, 'CLOSDEAL_DENIED_TURNS');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, 'Ошибка при закрытии %s', '', 1, 'CLOSDEAL_FAILED');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, 'Ошибка при закритті %s', '', 1, 'CLOSDEAL_FAILED');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, 'Закрытие %s заблокировано - найдены акт.доп.соглашения', '', 1, 'CLOSDEAL_DENIED_ACTAGR');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, 'Закрытие %s заблоковано - знайдені акт.дод.угоди', '', 1, 'CLOSDEAL_DENIED_ACTAGR');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, 'Запрещено добавление записей в справочник!', '', 1, 'MRATE_INSERT_DENIED');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, 'Заборонено додавання записів в довідник!', '', 1, 'MRATE_INSERT_DENIED');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, 'Запрещено удаление записей из справочника!', '', 1, 'MRATE_DELETE_DENIED');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, 'Заборонено видалення записів з довідника!', '', 1, 'MRATE_DELETE_DENIED');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, 'Значение ставки (%s) выходит за диапазон {0..100}', '', 1, 'MRATE_INVALID_VALUE');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, 'Значення ставки (%s) виходить за межі діапазону {0..100}', '', 1, 'MRATE_INVALID_VALUE');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, 'Мин.ставка (%s) не может быть больше максимальной (%s)', '', 1, 'MRATE_MISMATCH');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, 'Мін.ставка (%s) не може бути більшою за максимальну (%s)', '', 1, 'MRATE_MISMATCH');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, 'Указано некорректное значение (%s) поля "эфф.ставка не расчит."', '', 1, 'IRRDENIED_INVALID_VALUE');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, 'Вказано некоректне значення (%s) поля "ефф.ставка не розрах."', '', 1, 'IRRDENIED_INVALID_VALUE');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, 'Указан недопустимое значение K013 (%s)', '', 1, 'INVALID_K013');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, 'Вказане неприпустиме значення K013 (%s)', '', 1, 'INVALID_K013');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, 'Указан недопустимое значение S181 (%s)', '', 1, 'INVALID_S181');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, 'Вказане неприпустиме значення S181 (%s)', '', 1, 'INVALID_S181');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, 'Некорректно указана дата завершения договора (DAT_END[%s] <= ACR_DAT[%s])!', '', 1, 'UPDEAL_DATEND_INVALID');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, 'Некоректно вказана дата завершення договору (DAT_END[%s] <= ACR_DAT[%s])!', '', 1, 'UPDEAL_DATEND_INVALID');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, 'Указано недопустимое значение вида частичного возврата(%s)!', '', 1, 'INVALID_PARTIAL_PAYMENT_OPTION');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, 'Вказано недопустиме значення виду часткової вплати (%s)!', '', 1, 'INVALID_PARTIAL_PAYMENT_OPTION');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, 'Дата окончания транша s% превышает дату окончания линии s%!', '', 1, 'INVALID_DATEND_TRANCHE');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, 'Дата завершення транша %s перевищує дату завершення лінії %s!', '', 1, 'INVALID_DATEND_TRANCHE');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, 'Пользователям% s-го уровня запрещено изменять параметры договора!', '', 1, 'UPDEAL_MODIFY_DENIED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, 'Користувачам %s-го рівня заборонено змінювати параметри договору!', '', 1, 'UPDEAL_MODIFY_DENIED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, 'Ошибка выплаты процентов: %s', '', 1, 'PAYOUT_ERR');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'Помилка сплати відсотків: %s', '', 1, 'PAYOUT_ERR');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, 'Невозможно связать документ (реф %s) с депозитным договором № %s: %s', '', 1, 'LINK_DOCUMENT_FAILED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, 'Неможливо зв`язати документ (реф %s) з депозитним договором № %s: %s', '', 1, 'LINK_DOCUMENT_FAILED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, 'Запрещено досрочное изъятие средств для безотзывных депозитов!', '', 1, 'DPUID_IDSTOP_IRREVOCABLE');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, 'Заборонено дострокове вилучення коштів для безвідкличних депозитів!', '', 1, 'DPUID_IDSTOP_IRREVOCABLE');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, 'Не найден счет возврата удержанного налога на прибыль с ФЛ!', '', 1, 'RET_INCOME_TAX_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, 'Не знайдений рахунок повернення утриманого податку на прибуток з ФО!', '', 1, 'RET_INCOME_TAX_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, 'Задание уже запущено пользователем %s', '', 1, 'TASK_ALREADY_RUNNING');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, 'Завдання вже запущено користувачем %s', '', 1, 'TASK_ALREADY_RUNNING');

    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 999, l_exc, l_rus, 'Ошибка выполнения автомат. операции - %s', '', 1, 'AUTOJOB_ERROR');
    bars_error.add_message(l_mod, 999, l_exc, l_ukr, 'Помилка виконання автомат. завдання - %s', '', 1, 'AUTOJOB_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DPU.sql =========*** Run *** ==
PROMPT ===================================================================================== 
