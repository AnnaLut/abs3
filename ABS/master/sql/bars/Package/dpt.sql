
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPT is

g_header_version  constant varchar2(64)  := 'version 61.07 03.01.2017';
g_awk_header_defs constant varchar2(512) := ''
;

--
-- constants
--
r013_actdep   constant char(1) := '0'; -- спецпараметр R013 для активных вкладов -- c 27/12/2017 по требованию НБУ стал 0 (было 9)
r013_clsdep   constant char(1) := '1'; -- спецпараметр R013 для истекших вкладов
r013_tchacc   constant char(1) := '9'; -- спецпараметр R013 для техн.счетов

--
-- types
--
type acc_rec is record (acc_id    accounts.acc%type,
                        acc_num   accounts.nls%type,
                        acc_cur   accounts.kv%type,
                        acc_name  accounts.nms%type);

--
--  служебные функции
--
function header_version return varchar2;
function body_version   return varchar2;

--
-- заполнение доп.реквизита договора
--
procedure fill_dptparams
  (p_dptid in  dpt_depositw.dpt_id%type,
   p_tag   in  dpt_depositw.tag%type,
   p_val   in  dpt_depositw.value%type);
--
-- заполнение спецпараметров по счетам, обслуживающим договор
--
procedure fill_specparams
  (p_depaccid  in  accounts.acc%type,
   p_intaccid  in  accounts.acc%type,
   p_depnbs    in  accounts.nbs%type,
   p_intnbs    in  accounts.nbs%type,
   p_begdate   in  date,
   p_enddate   in  date,
   p_dpttype   in  dpt_vidd.vidd%type default null,
   p_idg       in  dpt_vidd.idg%type  default null,
   p_ids       in  dpt_vidd.ids%type  default null,
   p_amraccid  in  accounts.acc%type  default null,
   p_amrnbs    in  accounts.nbs%type  default null,
   p_migr      in  signtype           default null);
--
-- определение счета процентных расходов
--
function get_expenseacc
  (p_dptype   in  dpt_deposit.vidd%type, -- код вида вклада
   p_balacc   in  accounts.nbs%type,     -- бал.счет депозита
   p_curcode  in  accounts.kv%type,      -- код валюты депозита
   p_branch   in  varchar2,              -- код подразделения
   p_penalty  in  number default 0)      -- 0-счет для начисления, 1-счет для штрафования
   return accounts.acc%type;
--
-- Открытие депозитного договора ФЛ (расширенная процедура)
--
procedure p_open_vklad_ex
  (p_vidd         in     dpt_deposit.vidd%type,           -- код вида вклада
   p_rnk          in     dpt_deposit.rnk%type,            -- рег.№ вкладчика
   p_nd           in     dpt_deposit.nd%type,             -- номер договора (произвольный)
   p_sum          in     dpt_deposit.limit%type,          -- сумма договора
   p_nls_intpay   in     dpt_deposit.nls_p%type,          -- параметры выплаты %%
   p_mfo_intpay   in     dpt_deposit.mfo_p%type,          -- (счет, мфо, код окпо, получатель)
   p_okpo_intpay  in     dpt_deposit.okpo_p%type,
   p_name_intpay  in     dpt_deposit.name_p%type,
   p_fl_dptpay    in     number,                           -- признак открытия вклада до востребования
   p_nls_dptpay   in     dpt_deposit.nls_d%type,           -- параметры возврата депозита
   p_mfo_dptpay   in     dpt_deposit.mfo_p%type,           -- (счет, мфо, получатель)
   p_name_dptpay  in     dpt_deposit.nms_d%type,
   p_comments     in     dpt_deposit.comments%type,        -- комментарий
   p_datz         in     dpt_deposit.datz%type,            -- дата заключения договора
   p_datbegin     in     date     default null,            -- дата открытия счета
   p_dat_end_alt  in     date,                             -- дата досрочного расторжения
   p_term_m       in     number,                           -- срок вклада в месяцах (м.б. индивид.)
   p_term_d       in     number,                           -- срок вклада в днях    (м.б. индивид.)
   p_grp          in     number,                           -- группа доступа
   p_isp          in     number,                           -- ответ.исполнитель
   p_nocash       in     number default 0,                 -- признак безнал.взноса
   p_chgtype      in     number default 0,                 -- 0 - открытие вклада, 1 - изменение вида вклада
   p_depacctype   in     tips.tip%type  default 'ODB',     -- тип депозитного счета
   p_intacctype   in     tips.tip%type  default 'ODB',     -- тип счета начисленных процентов
   p_migr         in     number         default null,      -- ознака процесу міграції (1 - так )
   p_dptid        in out dpt_deposit.deposit_id%type,      -- системный № вклада
   p_nlsdep          out accounts.nls%type,                -- номер депозитного счета
   p_nlsint          out accounts.nls%type,                -- номер счета начисленных %%
   p_nlsamr          out accounts.nls%type,                -- номер счета амортизации
   p_errmsg          out varchar2,               -- сообщение об ошибке
   p_wb       in   dpt_deposit.wb%type default 'N'); -- признак открытия через веббанкинг
--
-- Открытие депозитного договора ФЛ
--
procedure p_open_vklad
  (p_vidd         in     dpt_deposit.vidd%type,         -- код вида вклада
   p_rnk          in     dpt_deposit.rnk%type,          -- рег.№ вкладчика
   p_nd           in     dpt_deposit.nd%type,           -- номер договора (произвольный)
   p_sum          in     dpt_deposit.limit%type,        -- сумма договора
   p_nls_intpay   in     dpt_deposit.nls_p%type,        -- параметры выплаты %%
   p_mfo_intpay   in     dpt_deposit.mfo_p%type,        -- (счет, мфо, код окпо, получатель)
   p_okpo_intpay  in     dpt_deposit.okpo_p%type,
   p_name_intpay  in     dpt_deposit.name_p%type,
   p_fl_dptpay    in     number,                        -- признак открытия вклада до востребования
   p_nls_dptpay   in     dpt_deposit.nls_d%type,        -- параметры возврата депозита
   p_mfo_dptpay   in     dpt_deposit.mfo_p%type,        -- (счет, мфо, получатель)
   p_name_dptpay  in     dpt_deposit.nms_d%type,
   p_comments     in     dpt_deposit.comments%type,     -- комментарий
   p_datz         in     dpt_deposit.datz%type,         -- дата заключения договора
   p_term_m       in     number,                        -- срок вклада в месяцах (м.б. индивид.)
   p_term_d       in     number,                        -- срок вклада в днях    (м.б. индивид.)
   p_dat_end_alt  in     date,                          -- дата досрочного расторжения
   p_grp          in     number,                        -- группа доступа
   p_isp          in     number,                        -- ответ.исполнитель
   p_dptid        in out dpt_deposit.deposit_id%type,   -- системный № вклада
   p_nlsdep          out accounts.nls%type,             -- номер депозитного счета
   p_nlsint          out accounts.nls%type,             -- номер счета начисленных %%
   p_nlsamr          out accounts.nls%type,             -- номер счета амортизации
   p_errmsg          out varchar2,            -- сообщение об ошибке
   p_wb       in   dpt_deposit.wb%type default 'N'); -- признак открытия через веббанкинг
--
-- Изменение вида вклада
--
procedure update_dpt_type
  (p_dptid         in  dpt_deposit.deposit_id%type,    -- идентификатор договора
   p_typeid        in  dpt_deposit.vidd%type,          -- новый вид договора
   p_dptamount     in  dpt_deposit.limit%type,         -- сумма договора
   p_nocash        in  number,                         -- признак безнал.взноса
   p_payoff        in  dpt_vidd.fl_2620%type,          -- флаг перечисления депозита
   p_intrcpmfo     in  dpt_deposit.mfo_p%type,         -- мфо банка-получателя %%
   p_intrcpacc     in  dpt_deposit.nls_p%type,         -- счет-получатель %%
   p_intrcpidcode  in  dpt_deposit.okpo_p%type,        -- идентиф.код получателя %%
   p_intrcpname    in  dpt_deposit.name_p%type,        -- получатель %%
   p_dptrcpmfo     in  dpt_deposit.mfo_d%type,         -- мфо банка-получателя депозита
   p_dptrcpacc     in  dpt_deposit.nls_d%type,         -- счет-получатель депозита
   p_dptrcpidcode  in  dpt_deposit.okpo_p%type,        -- идентиф.код получателя депозита
   p_dptrcpname    in  dpt_deposit.nms_d%type,         -- получатель депозита
   p_comment       in  dpt_deposit.comments%type);     -- комментарий
--
-- Процедура автопереоформления вклада
--
procedure p_dpt_extension
  (p_dptid   in  dpt_deposit.deposit_id%type,  -- идентификатор вклада
   p_datend  in  dpt_deposit.dat_end%type);    -- новая дата окончания вклада
--
-- Заполнение %-ной карточки для вкладов с прогрессивной %-ной ставкой
--
procedure p_rate_rise (dpt_id_ number);

--
-- Расчет штрафной ставки
--
function f_shtraf_rate
  ( p_dpt_id   number,
    p_dat      date,
    p_modcode  varchar2  default 'DPT'
  ) return number;

--
-- Процедура расчета штрафа
--
procedure  p_shtraf
  (p_dptid       in  number,  -- номер вклада
   p_finedate    in  date,    -- дата штрафа
   p_realproc    out number,  -- выплаченные %% по действующей %% ставке
   p_shtrafproc  out number,  -- %% по штрафной %% ставке
   p_comment     out varchar2);
--
-- Процедура перерасчета нач.%% при част.снятии вклада
--
procedure p_write_down (dpt_id_ number, fine_dat_ date);
--
-- Генерация номеров  и наименований депозитных счетов
--
function f_nls
 (p_type   in  char,                        -- NLS/NMS - номер/название счета
  p_rnk    in  accounts.rnk%type,           -- регистр.№ клиента
  p_nbs    in  accounts.nbs%type,           -- балансовый счет
  p_dptid  in  dpt_deposit.deposit_id%type, -- идентификатор вклада
  p_nd     in  dpt_deposit.nd%type,         -- номер договора
  p_curid  in  dpt_deposit.kv%type)         -- код валюты
  return varchar2;
--
-- Переброска капитала и нач.%% с просроченных депозитов на текущие счета
--
procedure  p_2620 (acc_ int, dat_ date);
--
-- Проверка допустимости выплаты процентов по вкладу (1-допустима, 0-недопустима)
--
function payoff_enable
 (p_intacc  in  accounts.acc%type,    -- внутр.№ счета начисл.процентов
  p_freq    in  freq.freq%type,       -- период-ть выплаты процентов
  p_avans   in  number,               -- признак авансовой выплаты процентов
  p_begdat  in  date,                 -- дата начала действия вклада
  p_enddat  in  date,                 -- дата окончания действия вклада
  p_curdat  in  date,                 -- банковская дата
  p_extend  in  number default 0)     -- признак переоформленного вклада
  return number;
--
-- Население временной таблицы перед безналичной выплатой процентов
--
procedure p_intpay
  (id_   smallint,
   dat_  date,
   tip_  char default 'S',
   filt_ varchar2);
--
-- Модификация ACRN.FPROC, которая учитывает плановый остаток на счете
--
function fproc (acc_ integer, datp_ date default null) return number;
--
-- Процедура заполнения %-ной карточки с ID=3 для вкладов с бонусной %-ной ставкой
--
procedure p_bonus_rate (dpt_id_ number);
--
-- Процедура перевода вкладов с баз.ступ.%-ных ставок в разряд инд.ставок для видов вкладов с "Фикс.%ной ставкой".
--
procedure p_chg_tier_rates (dat_ date);
--
-- Расчет курса при взыскании штрафа по валютному вкладу
--
function f_cur_dps(dpt_id_ number, s_ number, dat_ date) return number;
--
-- Расчет %-ной ставки при открытии вклада (по баз.ставке / по шкале)
--
function f_calc_rate
   (p_vidd    in dpt_vidd.vidd%type,                -- код вида вклада
    p_term_m  in dpt_vidd.duration%type,            -- срок вклада в мес.
    p_term_d  in dpt_vidd.duration_days%type,       -- срок вклада в днях
    p_sum     in dpt_vidd.min_summ%type,            -- сумма вклада в коп.
    p_dat     in date  default bankdate)            -- дата открытия вклада
    return number;
--
-- Вычисление значения доп.реквизита вклада
--
function f_dptw (p_dpt number,  p_tag char) return varchar2;
--
-- Поиск ответ.исполнителя по вкладу
--
function f_dptisp (p_isp staff.id%type) return number;
--
-- Процедура открытия технического счета
--
procedure p_open_tech_acc
  (p_dptid  in  dpt_deposit.deposit_id%type,
   p_nd     in  dpt_deposit.nd%type,
   p_rnk    in  dpt_deposit.rnk%type,
   p_kv     in  dpt_deposit.kv%type,
   p_acc    out accounts.acc%type,
   p_nls    out accounts.nls%type,
   p_nms    out accounts.nms%type);
--
-- Функция генерации напоминаний в карточке вклада
--
function f_dpt_reminder
  (p_dpt dpt_deposit.deposit_id%type, -- № вклада
   p_lng varchar2)                     -- код языка сообщения
   return varchar2;
--
-- Прогноз начисленнных процентов за весь срок договора
--
function get_forecast_int
  (p_dpttype      in  dpt_vidd.vidd%type,                 -- код вида вклада
   p_dptamount    in  dpt_vidd.min_summ%type,             -- сумма вклада в коп.
   p_opendate     in  date default bankdate,              -- дата открытия вклада
   p_term_months  in  dpt_vidd.duration%type default null,      -- длительность(мес.)
   p_term_days    in  dpt_vidd.duration_days%type default null)
   return number;
--
-- создание / редактирование доп.параметра вида вклада
--
procedure set_viddparam
  (p_tag          in  dpt_vidd_tags.tag%type,                         -- код параметра
   p_name         in  dpt_vidd_tags.name%type,                        -- наименование
   p_status       in  dpt_vidd_tags.status%type        default 'Y',   -- статус акт/неакт.
   p_checkquery   in  dpt_vidd_tags.check_query%type   default null,  -- SQL для допуст.знач.
   p_editable     in  dpt_vidd_tags.editable%type      default 'Y');  -- редактируемость
--
-- функция проверки типа данных указанного значения
--
function is_valid_datatype                   -- тип данных ('NUMB' / 'CHAR' / 'DATE')
  (p_datatype in  varchar2,                  -- значение
   p_data     in  varchar2)
   return number;
--
-- Заполнение значения дополнительного параметра для вида вклада
--
procedure set_viddparam_value
  (p_vidd    in  dpt_vidd_params.vidd%type,     -- код вида вклада
   p_tag     in  dpt_vidd_params.tag%type,      -- код доп.параметра
   p_val     in  dpt_vidd_params.val%type,      -- значение доп.параметра
   p_rwflag  in  number);                       -- флаг редактируемости
--
-- фиксация новых процентных ставок для договоров с пересмотром ставок
--
procedure fix_rate_review
  (p_dptid  in  dpt_deposit.deposit_id%type  default 0,       -- код вклада
   p_filter in  varchar2                     default null);   -- условие отбора

--
-- проверка допустимости выполнения операции по вкладу
--
function check_oper_permission
 (p_dptid  in  dpt_deposit.deposit_id%type,     -- идентификатор вклада
  p_dptop  in  dpt_op.id%type,                  -- идентификатор операции
  p_amount in  number default null)             -- сумма операции
  return number;

--
-- процедура переноса суммы депозита и процентов на техн.вклад до востребования
--           (вариант УПБ - без капитализации начисленных процентов)
--
procedure move2dmnd
  (p_dptid   in dpt_deposit.deposit_id%type,   -- № вклада
   p_tt      in tts.tt%type,                   -- код операции
   p_vobNC   in vob.vob%type,                  -- вид.док.в нац.вал.
   p_vobFC   in vob.vob%type);                 -- вид.док.в ин.вал.

--
-- функция расчета даты окончания срока действия вклада (старая)
--
function f_duration (dat_ date, term_m integer, term_d integer) return date;

--
-- функция расчета даты окончания срока действия вклада (универс.)
--
function get_datend_uni
  (p_datbeg   in  date,         -- дата начала срока действия вклада
   p_mnthcnt  in  number,       -- срок действия вклада в месяцах
   p_dayscnt  in  number,       -- срок действия вклада в днях
   p_dptype   in  number,        -- код вида вклада
   p_custid   in  number default null) --код клієнта, якщо строк дії депозиту залежить від віку клієнта (наприклад малолілтні)
   return date;                 -- дата окончания срока действия вклада

--
-- функция расчета даты окончания действия вклада с заданным днем окончания
--
function get_datend_fixday
  (p_datbeg   in  date,         -- дата начала срока действия вклада
   p_mnthcnt  in  number,       -- срок действия вклада в месяцах
   p_dayscnt  in  number,       -- срок действия вклада в днях
   p_endday   in  char)         -- день окончания срока действия вклада (1-31)
   return date;                 -- дата окончания срока действия вклада

--
-- определение ближайшей даты выплаты процентов, исходя из срока
-- действия вклада и условий выплаты процентов по договору
--
function get_intpaydate
 (p_date    in  date,             -- текущая банковская дата
  p_datbeg  in  date,             -- дата начала действия вклада
  p_datend  in  date,             -- дата окончания действия вклада
  p_freqid  in  freq.freq%type,   -- период-ть выплаты процентов
  p_advanc  in  number,           -- признак авансового вклада
  p_extend  in  number,           -- признак переоформленного вклада
  p_nocash  in  number default 0) -- расчет план.даты для нал/безнал.выплаты
  return   date;                  -- ближайшая дата выплаты процентов

--
-- коррекция срока вклада
--
procedure correct_deposit_term
 (p_dptid     in  dpt_deposit.deposit_id%type,  -- идентификатор вклада
  p_datbegold in  dpt_deposit.dat_begin%type,   -- старая дата начала
  p_datendold in  dpt_deposit.dat_end%type,     -- старая дата окончания (м.б.пусто)
  p_datbegnew in  dpt_deposit.dat_begin%type,   -- новая дата начала
  p_datendnew in  dpt_deposit.dat_end%type,     -- новая дата окончания  (м.б.пусто)
  p_cntdubl   in  dpt_deposit.cnt_dubl%type);   -- кол-во пролонгаций    (м.б.пусто)

--
-- восстановление фин.реквизитов деп.счетов по вкладам, срок действия которых истек
--
procedure restore_dptlimits
 (p_dptid  in  number,    -- идентификатор вклада или 0 (весь портфель вкладов)
  p_bdate  in  date);     -- текущая банковская дата

--
-- заполнение неснижаемого и макс.допустимого остатков на деп.счете
--
procedure set_dptlimits_ex
 (p_dptid  in  dpt_deposit.deposit_id%type);      -- идентификатор вклада

---
-- відкат наслідків штрафування депозиту при сторнуванні операції утримання штрафу
---
procedure REVOKE_PENALTY
( p_ref   in  oper.ref%type,
  p_tt    in  oper.tt%type
);

end dpt;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPT IS

g_body_version  CONSTANT VARCHAR2(64)  := 'version 71.7 10.01.2018';
g_awk_body_defs CONSTANT VARCHAR2(512) := ''
    ||'СБЕРБАНК' ||chr(10)
    ||'BRANCH - схема с иерарх.отделениями и мульти-МФО'||chr(10)
    ||'WEB - с работой в WEB-приложении'||chr(10)
    ||'HO - с обслуживанием вкладов в выходные и праздничные дни'||chr(10)
;

--
-- constants
--
g_modcode CONSTANT varchar2(3) := 'DPT';
g_errmsgD CONSTANT number(38)  := 4000;
g_errmsg  VARCHAR2(4000);

min_depamount constant dpt_vidd_tags.tag%type := 'MIN_DEPAMOUNT';
max_depamount constant dpt_vidd_tags.tag%type := 'MAX_DEPAMOUNT';
val_dptopen   constant dpt_vidd_tags.tag%type := 'VALIDATE_DPTOPEN';

--
-- возвращает версию заголовка пакета DPT
--
function header_version return varchar2 is
begin
  return 'Package DPT header '||g_header_version||'.'||chr(10)||
         'AWK definition: '   ||chr(10)||g_awk_header_defs;
end header_version;

--
-- возвращает версию тела пакета DPT
--
function body_version return varchar2 is
begin
  return 'Package DPT body '||g_body_version||'.'||chr(10)||
         'AWK definition: ' ||chr(10)||g_awk_body_defs;
end body_version;

--
-- получение идентификатора договора
--
function get_dpt_id return dpt_deposit.deposit_id%type
is
  l_title varchar2(60) := 'dptopen.getid:';
  l_dptid dpt_deposit.deposit_id%type;
begin

  bars_audit.trace('%s', l_title);

  begin
    select bars_sqnc.get_nextval('S_CC_DEAL') into l_dptid from dual;
  exception
    when no_data_found then
      -- невозможно получить идентификатор договора
      bars_error.raise_nerror(g_modcode, 'CANT_GET_DPTID');
  end;
  bars_audit.trace('%s s_cc_deal.nextval = %s', l_title, to_char(l_dptid));

  bars_audit.trace('%s идентификатор договора = %s', l_title, to_char(l_dptid));

  return l_dptid;

end get_dpt_id;

--
-- получение номера договора
--
function get_dpt_num
  (p_dptnum  in dpt_deposit.nd%type,
   p_dptid   in dpt_deposit.deposit_id%type,
   p_dptidp  in dpt_deposit.deposit_id%type)
return dpt_deposit.nd%type
is
  l_title  varchar2(60) := 'dptopen.getnum:';
  l_dptnum dpt_deposit.nd%type;
begin

  bars_audit.trace('%s договор № %s (%s), ид.родит.договора = %s', l_title,
                   p_dptnum, to_char(p_dptid), to_char(p_dptidP));

  -- номер договора - произвольный символьный номер
  l_dptnum := substr(nvl(p_dptnum, to_char(p_dptid)), 1, 35);

  bars_audit.trace('%s номер договора =  %s', l_title, l_dptnum);

  return l_dptnum;

end get_dpt_num;

--
-- внутр.процедура открытия одного счета
--
procedure open1acc
  (p1_dptid    in   dpt_deposit.deposit_id%type,
   p1_dptnum   in   dpt_deposit.nd%type,
   p1_custid   in   dpt_deposit.rnk%type,
   p1_typeid   in   dpt_deposit.vidd%type,
   p1_curcode  in   dpt_deposit.kv%type,
   p1_nbs      in   accounts.nbs%type,
   p1_type     in   accounts.tip%type,
   p1_isp      in   accounts.isp%type,
   p1_grp      in   accounts.grp%type,
   p1_acc      out  acc_rec,
   p1_ob22     in   accounts.ob22%type)
is
   l_title   varchar2(60) := 'dptopen.acc1:';
   l_tmp     number;
   l_tmpacc  acc_rec;
begin

  bars_audit.trace('%s бал.счет %s', l_title,  p1_nbs);

  l_tmpacc.acc_cur := p1_curcode;

  begin
    l_tmpacc.acc_num := substr(dpt.f_nls('NLS', p1_custid, p1_nbs, p1_dptid, p1_dptnum, p1_curcode), 1, 14);
  exception
    when others then
      -- ошибка при формировании номера счета (%s) по договору № %s/%s (вид вклада = %s, клиент № %s): %s
      bars_error.raise_nerror(g_modcode, 'NLS_MASK_FAILED',
                              p1_nbs, to_char(p1_dptid), p1_dptnum,
                              to_char(p1_typeid), to_char(p1_custid),
                              substr(sqlerrm, 1,g_errmsgD));
  end;
  bars_audit.trace('%s номер счета %s', l_title,  l_tmpacc.acc_num);

  begin
    l_tmpacc.acc_name := substr(dpt.f_nls('NMS', p1_custid, p1_nbs, p1_dptid, p1_dptnum, p1_curcode), 1, 70);
  exception
    when others then
      -- ошибка при формировании названия счета (%s) по договору № %s/%s (вид вклада = %s, клиент № %s): %s
      bars_error.raise_nerror(g_modcode, 'NMS_MASK_FAILED',
                              p1_nbs, to_char(p1_dptid), p1_dptnum,
                              to_char(p1_typeid), to_char(p1_custid),
                              substr(sqlerrm, 1,g_errmsgD));
  end;
  bars_audit.trace('%s наименование счета %s', l_title,  l_tmpacc.acc_name);

  begin

   /*accreg.SetAccountAttr(99, 0, 0, p1_grp, l_tmp, p1_custid, l_tmpacc.acc_num, l_tmpacc.acc_cur,l_tmpacc.acc_name, p1_type,p1_isp,l_tmpacc.acc_id,'1',p1_ob22);*/
   /* op_reg_exfl(99, 0, 0, p1_grp, l_tmp, p1_custid, l_tmpacc.acc_num, l_tmpacc.acc_cur, l_tmpacc.acc_name, p1_type, p1_isp, l_tmpacc.acc_id, 1, 2); */
  accreg.SetAccountAttr( 99, 0, 0, p1_grp, l_tmp, p1_custid, l_tmpacc.acc_num, l_tmpacc.acc_cur, l_tmpacc.acc_name, p1_type, p1_isp, l_tmpacc.acc_id, '1', p1_ob22, 2 );

  exception
    when others then
      bars_audit.info('OPENACC_FAILED' || dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
      -- ошибка при открытии счета № %s / %s : %s
      bars_error.raise_nerror(g_modcode, 'OPENACC_FAILED',
                              l_tmpacc.acc_num,to_char(l_tmpacc.acc_cur), substr(sqlerrm,1,g_errmsgD));

  end;
  bars_audit.trace('%s открыт счет (внутр.№ %s)', l_title, to_char(l_tmpacc.acc_id));

  p1_acc := l_tmpacc;

end open1acc;

--
-- открытие счетов по договору
--
procedure open_accounts
  (p_dptid    in  dpt_deposit.deposit_id%type,
   p_dptnum   in  dpt_deposit.nd%type,
   p_custid   in  dpt_deposit.rnk%type,
   p_typeid   in  dpt_deposit.vidd%type,
   p_curcode  in  dpt_deposit.kv%type,
   p_depnbs   in  accounts.nbs%type,
   p_intnbs   in  accounts.nbs%type,
   p_amrnbs   in  accounts.nbs%type,
   p_deptype  in  accounts.tip%type,
   p_inttype  in  accounts.tip%type,
   p_isp      in  accounts.isp%type,
   p_grp      in  accounts.grp%type,
   p_depacc  out  acc_rec,
   p_intacc  out  acc_rec,
   p_amracc  out  acc_rec)
is
   l_title   varchar2(60) := 'dptopen.accs:';
   l_isp     accounts.isp%type;
   l_tag     varchar2(16) := 'DPT_AVANSACC';
   l_nlsalt  accounts.nlsalt%type;
   l_depacc  acc_rec;
   l_intacc  acc_rec;
   l_amracc  acc_rec;
   l_dep_ob22 accounts.ob22%type;
   l_int_ob22 accounts.ob22%type;
   l_amr_ob22 accounts.ob22%type;
begin

  bars_audit.trace('%s договор № %s (%s), РНК %s, вид вклада %s, валюта %s',
                   l_title, p_dptnum, to_char(p_dptid), to_char(p_custid),
                   to_char(p_typeid), to_char(p_curcode));

  bars_audit.trace('%s бал.счета (%s, %s, %s)', l_title, p_depnbs, p_intnbs, p_amrnbs);

  l_isp := f_dptisp (p_isp);
  if l_isp is null then
     -- не найден ответственный исполнитель
     bars_error.raise_nerror(g_modcode, 'ISP_NOT_FOUND');
  end if;
  bars_audit.trace('%s ответ.исп. = %s', l_title, to_char(l_isp));

  begin
   select max(case when tag = 'DPT_OB22' then val else '0' end),
          max(case when tag = 'INT_OB22' then val else '0' end),
          max(case when tag = 'AMR_OB22' then val else '0' end)
   into l_dep_ob22, l_int_ob22, l_amr_ob22
   from dpt_vidd_params
   where vidd = p_typeid;
  exception when no_data_found then 
    l_dep_ob22:='00'; 
    l_int_ob22:='00'; 
    l_amr_ob22:='00';
  end;

  open1acc (p1_dptid    =>  p_dptid,
            p1_dptnum   =>  p_dptnum,
            p1_custid   =>  p_custid,
            p1_typeid   =>  p_typeid,
            p1_curcode  =>  p_curcode,
            p1_nbs      =>  p_depnbs,
            p1_type     =>  p_deptype,
            p1_isp      =>  l_isp,
            p1_grp      =>  p_grp,
            p1_acc      =>  l_depacc,
            p1_ob22     =>  l_dep_ob22);
  bars_audit.trace('%s открыт депозитный счет %s / %s', l_title, l_depacc.acc_num, to_char(l_depacc.acc_cur));

  open1acc (p1_dptid    =>  p_dptid,
            p1_dptnum   =>  p_dptnum,
            p1_custid   =>  p_custid,
            p1_typeid   =>  p_typeid,
            p1_curcode  =>  p_curcode,
            p1_nbs      =>  p_intnbs,
            p1_type     =>  p_inttype,
            p1_isp      =>  l_isp,
            p1_grp      =>  p_grp,
            p1_acc      =>  l_intacc,
            p1_ob22     =>  l_int_ob22);
  bars_audit.trace('%s открыт счет начисл.процентов %s / %s', l_title, l_intacc.acc_num, to_char(l_intacc.acc_cur));

  -- счет амортизации для авансовых вкладов
  if p_amrnbs is not null then
     open1acc (p1_dptid    =>  p_dptid,
               p1_dptnum   =>  p_dptnum,
               p1_custid   =>  p_custid,
               p1_typeid   =>  p_typeid,
               p1_curcode  =>  p_curcode,
               p1_nbs      =>  p_amrnbs,
               p1_type     =>  p_inttype,
               p1_isp      =>  l_isp,
               p1_grp      =>  p_grp,
               p1_acc      =>  l_amracc,
               p1_ob22     =>  l_amr_ob22);
     bars_audit.trace('%s открыт счет аморт.процентов %s / %s', l_title, l_amracc.acc_num, to_char(l_amracc.acc_cur));
  end if;

  p_depacc  := l_depacc;
  p_intacc  := l_intacc;
  p_amracc  := l_amracc;

end open_accounts;

--
-- поиск счетов по существующему договору
--
procedure find_accounts
  (p_dptid    in  dpt_deposit.deposit_id%type,
   p_dptnum   in  dpt_deposit.nd%type,
   p_custid   in  dpt_deposit.rnk%type,
   p_curcode  in  dpt_deposit.kv%type,
   p_amortbs  in  dpt_vidd.bsa%type,
   p_depacc  out  acc_rec,
   p_intacc  out  acc_rec,
   p_amracc  out  acc_rec)
is
   l_title   varchar2(60) := 'dptopen.findacc:';
   l_depacc  acc_rec;
   l_intacc  acc_rec;
   l_amracc  acc_rec;
begin

  bars_audit.trace('%s договор № %s (%s), РНК = %s, валюта = %s', l_title,
                   to_char(p_dptid), p_dptnum, to_char(p_custid), to_char(p_curcode));

  begin
    select ad.acc, ad.nls, ad.kv, ad.nms
      into l_depacc
      from dpt_deposit d, accounts ad
     where d.acc = ad.acc
       and d.deposit_id = p_dptid
       and d.nd = p_dptnum
       and ad.rnk = p_custid
       and ad.kv = p_curcode;
  exception
    when no_data_found then
      -- не найден депозитный счет по договору №
      bars_error.raise_nerror(g_modcode, 'DPTACC_NOT_FOUND', p_dptnum);
  end;
  bars_audit.trace('%s найден депозитный счет %s / %s', l_title,
                   l_depacc.acc_num, to_char(l_depacc.acc_cur));

  begin
    select ai.acc, ai.nls, ai.kv, ai.nms
      into l_intacc
      from int_accn i, accounts ai
     where i.acc = l_depacc.acc_id
       and i.id = 1
       and i.acra = ai.acc
       and ai.rnk = p_custid
       and ai.kv = p_curcode;
  exception
    when no_data_found then
      -- не найден счет начисленных процентов по договору №
      bars_error.raise_nerror(g_modcode, 'INTACC_NOT_FOUND', p_dptnum);
  end;
  bars_audit.trace('%s найден счет начисл.процентов %s / %s', l_title,
                   l_intacc.acc_num, to_char(l_intacc.acc_cur));

  if p_amortbs is not null then
     begin
       select am.acc, am.nls, am.kv, am.nms
         into l_amracc
         from int_accn i, accounts am
        where i.acc = l_depacc.acc_id
          and i.id = 1
          and i.acrb = am.acc
          and am.rnk = p_custid
          and am.kv = p_curcode
          and am.nbs = p_amortbs;
     exception
       when no_data_found then
         -- не найден cчет амортизациии процентов для договора №
         bars_error.raise_nerror(g_modcode, 'AMRACC_NOT_FOUND', p_dptnum);
     end;
     bars_audit.trace('%s найден счет аморт.процентов %s / %s', l_title,
                      l_amracc.acc_num, to_char(l_amracc.acc_cur));
  end if;

   p_depacc := l_depacc;
   p_intacc := l_intacc;
   p_amracc := l_amracc;

end find_accounts;

--
-- расчет значения спецпараметра R011
--
function get_r011
  (p_depnbs in ps.nbs%type,
   p_intnbs in ps.nbs%type,
   p_date   in date)
   return specparam.r011%type
is
   l_r011 specparam.r011%type;
begin

  if p_intnbs is not null then -- процентный счет
     begin
       select r011
         into l_r011
         from kl_r011
        where r020     = p_intnbs
          and r020r011 = p_depnbs
          and d_open  <= p_date
          and nvl(d_close, p_date) >= p_date;
     exception
       when no_data_found then
         begin
           select r011
             into l_r011
             from kl_r011
            where r020    = p_intnbs
              and r020r011 is null
              and d_open <= p_date
              and nvl(d_close, p_date) >= p_date;
         exception
           when no_data_found then
             l_r011 := null;
           when too_many_rows then
             l_r011 := case when (p_intnbs = '2903') then '2' else null end;
         end;
       when too_many_rows then
         l_r011 := case when (p_intnbs = '2628') then '1' else null end;
     end;
  else                         -- депозитный счет

    begin
      select r011
        into l_r011
        from kl_r011
       where r020 = p_depnbs
         and r020r011 is null
         and d_open  <= p_date
         and nvl(d_close, p_date) >= p_date;
    exception
      when no_data_found then
        l_r011 := null;
      when too_many_rows then
        l_r011 := case when (p_depnbs = '2620') then '1' else null end; -- bugfix for task 6172
    end;

  end if;

  return l_r011;
end get_r011;

--
-- заполнение спецпараметров по счетам, обслуживающим договор
--
procedure fill_specparams
 (p_depaccid  in  accounts.acc%type,
  p_intaccid  in  accounts.acc%type,
  p_depnbs    in  accounts.nbs%type,
  p_intnbs    in  accounts.nbs%type,
  p_begdate   in  date,
  p_enddate   in  date,
  p_dpttype   in  dpt_vidd.vidd%type default null,
  p_idg       in  dpt_vidd.idg%type  default null,
  p_ids       in  dpt_vidd.ids%type  default null,
  p_amraccid  in  accounts.acc%type  default null,
  p_amrnbs    in  accounts.nbs%type  default null,
  p_migr      in  signtype           default null -- ознака процесу міграції (1 - так )
 )
is
  l_title  varchar2(60) := 'dptopen.sparams:';
  l_bdate  date         := gl.bdate;
  l_s180   specparam.s180%type;
  l_s181   specparam.s181%type;
  l_r011   specparam.r011%type;
  l_r013   specparam.r013%type;
  l_d020   specparam.d020%type;
  l_sps    specparam.sps%type ;
  l_s181et specparam.s181%type;
begin

  bars_audit.trace('%s счета %s/%s, бал.счета %s/%s, срок %s-%s', l_title,
                   to_char(p_depaccid), to_char(p_intaccid), p_depnbs, p_intnbs,
                   to_char(p_begdate,'dd.mm.yyyy'), to_char(p_enddate,'dd.mm.yyyy'));

  if p_enddate is null then
     l_d020 := null;
  else
     l_d020 := '1';
  end if;

  begin
    select substr(val,1,1)
      into l_r013
      from dpt_vidd_params
     where tag  = 'R013'
       and vidd = p_dpttype;
  exception
    when no_data_found then
      l_r013 := null;
  end;

  -- неформализуемое изменение классификатора KL_R013 c 02/02/2010
  if l_r013 is null and ((newnbs.g_state = 1 and p_depnbs = '2630') or (newnbs.g_state = 0 and p_depnbs in ('2630', '2635'))) then
     l_r013 := r013_actdep;
  end if;
  -- заплатка для технических счетов
  if l_r013 is null and p_dpttype is null and p_enddate is null then
     l_r013 := r013_tchacc;
  end if;

  l_r011 := get_r011 (p_depnbs, null, p_begdate);

  l_s180 := substr(fs180(p_depaccid, null, null, p_begdate, p_migr), 1, 1); -- при міграції виправляєм на правильний s180 (p_migr=1)

  l_s181 := substr(fs181(p_depaccid, null, l_s180),          1, 1);
  bars_audit.trace('%s (s180, s181, r011, r013, d020) = (%s, %s, %s, %s)',
                   l_title, l_s180, l_s181, l_r011, l_r013, l_d020);
                   
/* -- commented by Livshyts 29/11/17 . Not Actual Check 
  -- контроль соответствия бал.счета срочности депозита только для 2630,2635
  begin
    select s181
      into l_s181et
      from kl_r020
     where r020    = p_depnbs
       and prem    = 'КБ'
       and d_open <= l_bdate
       and nvl(d_close, l_bdate) >= l_bdate
       and ((r020 = '2630' and newnbs.get_state = 1) or (newnbs.get_state = 0 and r020 in ('2630', '2635')));
  exception
    when no_data_found then
      l_s181et := null;
  end;
  if (l_s181et is not null and l_s181 is not null and l_s181 != l_s181et) then
     -- заданный срок депозита не соответствует бал.счету %s (%s != %s)
     bars_error.raise_nerror (g_modcode, 'NBS181_MISMATCH', p_depnbs, l_s181, l_s181et);
  end if;
*/
  -- заполнение спецпараметров для депозитного счета
  update specparam
     set s180 = l_s180,
         s181 = l_s181,
         d020 = l_d020,
         r013 = l_r013,
         r011 = l_r011
   where acc  = p_depaccid;
  if sql%rowcount = 0 then
     insert into specparam (acc, s180, s181, d020, r013, r011)
     values (p_depaccid, l_s180, l_s181, l_d020, l_r013, l_r011);
  end if;
  bars_audit.trace('%s заполнены спецпараметры депозитного счета', l_title);

  -- заполнение спецпараметров для процентного счета
  if p_intaccid is not null then

     l_r011 := get_r011 (p_depnbs, p_intnbs, p_begdate);
     l_r013 := case when p_intnbs = '2628' then l_r013 else null end;
     bars_audit.trace('%s спецпараметры r011 = %s, l_r013 = %s', l_title, l_r011, l_r013);

     l_sps := case
              when (p_idg is not null and p_ids is not null) then 1
              else null
              end;
     bars_audit.trace('%s спецпараметры IDG / IDS / SPS = %s / %s / %s', l_title,
                      to_char(p_idg), to_char(p_ids), to_char(l_sps));

     update specparam
        set s180 = l_s180,
            s181 = l_s181,
            r011 = l_r011,
            r013 = l_r013,
            idg  = p_idg,
            ids  = p_ids,
            sps  = l_sps
      where acc  = p_intaccid;

     if sql%rowcount = 0 then
        insert into specparam (acc, s180, s181, r011, r013, idg, ids, sps)
        values (p_intaccid, l_s180, l_s181, l_r011, l_r013, p_idg, p_ids, l_sps);
     end if;
     bars_audit.trace('%s заполнены спецпараметры счета начисл.процентов', l_title);

  end if;

  -- заполнение спецпараметра OB22 для деп.счета
  -- commented by Livshyts. Reason - данные параметры заполняются в процедуре open_accounts
    /*UPDATE accounts
       SET ob22 =
              (SELECT SUBSTR (val, 1, 2)
                 FROM dpt_vidd_params
                WHERE vidd = p_dpttype AND tag = 'DPT_OB22')
     WHERE acc = p_depaccid;


    UPDATE accounts
       SET ob22 =
              (SELECT SUBSTR (val, 1, 2)
                 FROM dpt_vidd_params
                WHERE vidd = p_dpttype AND tag = 'INT_OB22')
     WHERE acc = p_intaccid;

    UPDATE accounts
       SET ob22 =
              (SELECT SUBSTR (val, 1, 2)
                 FROM dpt_vidd_params
                WHERE vidd = p_dpttype AND tag = 'AMR_OB22')
     WHERE acc = p_amraccid;
     */
  begin
    insert into specparam_int (acc, ob22)
    select p_depaccid, substr(val, 1, 2)
      from dpt_vidd_params
     where vidd = p_dpttype
       and tag  = 'DPT_OB22';
  exception
    when dup_val_on_index then null;
  end;
  -- заполнение спецпараметра OB22 для проц.счета
  if p_intaccid is not null then
     begin
       insert into specparam_int (acc, ob22)
       select p_intaccid, substr(val, 1, 2)
         from dpt_vidd_params
        where vidd = p_dpttype
          and tag  = 'INT_OB22';
     exception
       when dup_val_on_index then null;
     end;
  end if;
  -- заполнение спецпараметра OB22 для счета амортизации
  if p_amraccid is not null then
     begin
       insert into specparam_int (acc, ob22)
       select p_amraccid, substr(val, 1, 2)
         from dpt_vidd_params
        where vidd = p_dpttype
          and tag  = 'AMR_OB22';
     exception
       when dup_val_on_index then null;
     end;
  end if;
  bars_audit.trace('%s заполнены спецпараметры OB22 для счетов', l_title);

end fill_specparams;

--
-- заполнение счетов консолидации
--
procedure fill_binded_accounts
  (p_depaccid    in  accounts.acc%type,
   p_intaccid    in  accounts.acc%type,
   p_curcode     in  accounts.kv%type,
   p_binddepacc  in  accounts.nls%type,
   p_bindintacc  in  accounts.nls%type)
is
   l_title    varchar2(60) := 'dptopen.bindacc:';
   l_acckd    accounts.acc%type;
   l_accki    accounts.acc%type;
begin

  bars_audit.trace('%s счета %s/%s, валюта %s, счета консолидации %s/%s', l_title,
                   to_char(p_depaccid), to_char(p_intaccid), to_char(p_curcode),
                   p_binddepacc, p_bindintacc);

  -- консолидированный счет для учета суммы депозита
  if p_binddepacc is not null then
     begin
       select acc into l_acckd from accounts
        where nls = p_binddepacc and kv = p_curcode and dazs is null;
     exception
       when no_data_found then
         -- не найден (или закрыт) счет консолидации
         bars_error.raise_nerror(g_modcode, 'CONSACC_NOT_FOUND', p_binddepacc);
     end;
  else
     l_acckd := null;
  end if;
  bars_audit.trace('%s счет консолидации для депозита = %s', l_title, to_char(l_accKD));

  update accounts
     set accc = l_acckd
   where acc = p_depaccid and nvl(accc, '-1') != nvl(l_acckd, '-1');
  bars_audit.trace('%s заполнен счет консолидации для деп.счета', l_title);


  -- консолидированный счет для учета суммы начисленных процентов
  if p_bindintacc is not null then
     begin
       select acc into l_accki from accounts
        where nls = p_bindintacc and kv =  p_curcode and dazs is null;
     exception
       when no_data_found then
         -- не найден (или закрыт) счет консолидации
         bars_error.raise_nerror(g_modcode, 'CONSACC_NOT_FOUND', p_bindintacc);
     end;
  else
     l_accki := null;
  end if;
  bars_audit.trace('%s счет консолидации для процентов = %s', l_title, to_char(l_accKI));

  update accounts
     set accc = l_accki
   where acc = p_intaccid and nvl(accc, '-1') != nvl(l_accki, '-1');
  bars_audit.trace('%s заполнен счет консолидации для счета нач.%%', l_title);

end fill_binded_accounts;

--
-- определение счета процентных расходов
--
function get_expenseacc
 (p_dptype   in  dpt_deposit.vidd%type,    -- код вида вклада
  p_balacc   in  accounts.nbs%type,        -- бал.счет депозита
  p_curcode  in  accounts.kv%type,         -- код валюты
  p_branch   in  varchar2,                 -- код подразделения
  p_penalty  in  number default 0)         -- 0 - счет для начисления, 1 - счет для штрафования
  return accounts.acc%type
is
  title    constant varchar2(60)      := 'dptopen.getexpacc:';
  basecur  constant tabval.kv%type    := gl.baseval;
  l_sour   constant proc_dr.sour%type := 4;
  l_accid  accounts.acc%type;
  l_accnum accounts.nls%type;
begin

  bars_audit.trace('%s entry, dptype=>%s, balacc=>%s, curcode=>%s, branch=>%s, p_penalty=>%s',
                   title, to_char(p_dptype), p_balacc, to_char(p_curcode),
                   p_branch, to_char(p_penalty));

  l_accid  := null;
  l_accnum := null;

  -- через повернення %% на рах.6399 забрав nvl(g67n, g67)
  begin

    select decode( p_curcode, basecur, decode(p_penalty, 0, g67, g67n), decode(p_penalty, 0, v67, v67n) )
      into l_accnum
      from PROC_DR$BASE -- proc_dr
     where sour   = l_sour
       and nbs    = p_balacc
       and rezid  = p_dptype
       and branch = p_branch;

    bars_audit.trace('%s found for (vidd, branch) = %s', title, l_accnum);

  exception
    when NO_DATA_FOUND then
      null;
/*
      begin
        select decode( p_curcode, basecur, decode(p_penalty, 0, g67, g67n), decode(p_penalty, 0, v67, v67n) )
          into l_accnum
          from proc_dr
         where sour   = l_sour
           and nbs    = p_balacc
           and rezid  = 0
           and branch = p_branch;
        bars_audit.trace('%s found for (branch) = %s', title, l_accnum);
      exception
        when no_data_found then
          bars_audit.trace('%s not found for (branch)', title);
      end;
*/
  end;

  bars_audit.trace('%s l_accnum = %s, l_accid = %s', title, l_accnum, to_char(l_accid));

  if l_accnum is not null then
     begin
       select acc
         into l_accid
         from accounts
        where nls    = l_accnum
          and kv     = basecur
          and dazs   is null;
     exception
       when no_data_found then
         l_accid := null;
     end;
  end if;

  if (l_accid is null)
  then
     bars_audit.trace( title || ' не знайдено рахунок витрат для (vidd='|| to_char(p_dptype) ||', nbs=' || p_balacc ||
                       ', curcode='|| to_char(p_curcode) ||', branch='|| p_branch ||', p_penalty='|| to_char(p_penalty) ||').' );
     -- не найден счет расходов для вида вклада №
     bars_error.raise_nerror(g_modcode, 'EXPACC_NOT_FOUND', to_char(p_dptype));
  end if;

  bars_audit.trace('%s exit with %s', title, to_char(l_accid));

  return l_accid;

exception
  when others then
     -- не найден счет расходов для вида вклада №
   bars_error.raise_nerror(g_modcode, 'EXPACC_NOT_FOUND', to_char(p_dptype));
end get_expenseacc;

--
-- определение операции для безнал.перечисления процентов
--
function get_acrpay_tt
  (p_bankcode banks.mfo%type,
   p_accnum   accounts.nls%type)
   return tts.tt%type
is
  l_mfo  banks.mfo%type := gl.amfo;
  l_tt   tts.tt%type;
begin
  l_tt := null;

  return l_tt;

end get_acrpay_tt;

--
-- заполнение процентной карточки
--
procedure fill_interst_card
  (p_chgtype      in  number,
   p_intid        in  int_accn.id%type,
   p_depaccid     in  accounts.acc%type,
   p_intaccid     in  accounts.acc%type,
   p_expaccid     in  accounts.acc%type,
   p_typecode     in  dpt_vidd.vidd%type,
   p_intmetr      in  int_accn.metr%type,
   p_intbasey     in  int_accn.basey%type,
   p_intfreq      in  int_accn.freq%type,
   p_intost       in  int_accn.io%type,
   p_intbeg       in  date,
   p_intstp       in  date,
   p_inttt        in  int_accn.tt%type,
   p_intpay_cur   in  int_accn.kvb%type,
   p_intpay_acc   in  int_accn.nlsb%type,
   p_intpay_mfo   in  int_accn.mfob%type,
   p_intpay_name  in  int_accn.namb%type)
is
   l_title  varchar2(60)     := 'dptopen.intcard:';
   l_mfo    banks.mfo%type   := gl.amfo;
   l_ttint  int_accn.tt%type;
   l_ttpay  int_accn.ttb%type;
begin

  bars_audit.trace('%s вид вклада %s, счета (%s, %s, %s)', l_title, to_char(p_typecode),
                   to_char(p_depaccid), to_char(p_intaccid), to_char(p_expaccid));

  l_ttint := nvl(p_inttt, '%%1');
  if p_intpay_acc is not null then
     l_ttpay := get_acrpay_tt (p_intpay_mfo, p_intpay_acc);
  end if;
  bars_audit.trace('%s код операции для начисления/выплаты %% = %s/%s', l_title, l_ttint, l_ttpay);

  bars_audit.trace('%s metr = %s, basey = %s, freq = %s, io = %s, stp_dat = %s',
                   l_title,
                   to_char(p_intmetr), to_char(p_intbasey), to_char(p_intfreq),
                   to_char(p_intost), to_char(p_intstp,'dd.mm.yyyy'));

  bars_audit.trace('%s  kvb = %s, nlsb = %s, mfob = %s, namb = %s', l_title,
                   to_char(p_intpay_cur), p_intpay_acc, p_intpay_mfo, p_intpay_name);

  -- основная процентная карточка
  if p_chgtype = 0 then

    begin
      insert into int_accn
        (acc, id, acra, acrb,
         metr, basem, basey, freq, io, acr_dat, stp_dat, tt,
         ttb, kvb, nlsb, mfob, namb)
      values
        (p_depaccid, p_intid, p_intaccid, p_expaccid,
         p_intmetr, 0,  p_intbasey, p_intfreq, p_intost, p_intbeg, p_intstp, l_ttint,
         l_ttpay, p_intpay_cur, p_intpay_acc, p_intpay_mfo, p_intpay_name);
    exception
      when others then
        -- ошибка при заполнении процентной карточки
        bars_error.raise_nerror(g_modcode, 'FILL_INTCARD_FAILED', substr(sqlerrm,1,g_errmsgD));
    end;
    bars_audit.trace('%s заполнена %-ная карточка счета', l_title);

  else

     update int_accn
        set acrb = p_expaccid,
            metr = p_intmetr,
           basem = 0,
           basey = p_intbasey,
            freq = p_intfreq,
              io = p_intost,
         stp_dat = p_intstp,
              tt = l_ttint,
             ttb = l_ttpay,
             kvb = p_intpay_cur,
            nlsb = p_intpay_acc,
            mfob = p_intpay_mfo,
            namb = p_intpay_name
      where  acc = p_depaccid
        and   id = p_intid
        and acra = p_intaccid;
    bars_audit.trace('%s изменена %-ная карточка счета', l_title);

  end if;

  -- наследование проц.ставок для доп.процентной карточки из ос.проц.карточки
  if p_intid = 3 then
     for i in (select acc, 3 id, bdat, ir, op, br
                 from int_ratn
                where acc = p_depaccid
                  and id = 1)
     loop
       begin
         insert into int_ratn (acc, id, bdat, ir, op, br)
         values (i.acc, i.id, i.bdat, i.ir, i.op, i.br);
       exception
         when dup_val_on_index then
           update int_ratn
              set ir   = i.ir,
                  op   = i.op,
                  br   = i.br
            where acc  = i.acc
              and id   = i.id
              and bdat = i.bdat;
       end;
     end loop;
  end if;

end fill_interst_card;

--
--  заполнение процентной ставки (основной и пролонгации)
--
procedure fill_interst_rate
  (p_chgtype   in  number,
   p_dptid     in dpt_deposit.deposit_id%type,
   p_accid     in accounts.acc%type,
   p_typecode  in dpt_vidd.vidd%type,
   p_fixrate   in dpt_vidd.basem%type,
   p_brateid   in dpt_vidd.br_id%type,
   p_brateid2  in dpt_vidd.br_id_l%type,
   p_termm     in number,
   p_termd     in number,
   p_begdate   in dpt_deposit.dat_begin%type,
   p_enddate   in dpt_deposit.dat_end%type,
   p_amount    in dpt_deposit.limit%type,
   p_currency  in dpt_deposit.kv%type)
is
   l_title  varchar2(60) := 'dptopen.intrate:';
   l_ir     int_ratn.ir%type;
   l_br     int_ratn.br%type;
begin

  bars_audit.trace('%s договор № %s, период действия %s - %s, сумма %s / %s', l_title,
                   to_char(p_dptid), to_char(p_begdate,'dd.mm.yyyy'), to_char(p_enddate,'dd.mm.yyyy'),
                   to_char(p_amount), to_char(p_currency));

  bars_audit.trace('%s вид вклада %s, срок %s мес. и %s дней', l_title,
                   to_char(p_typecode), to_char(p_termM), to_char(p_termD));

  bars_audit.trace('%s признак фикс.%-ной ставки  = %s', l_title, to_char(p_fixrate));
  bars_audit.trace('%s основная базовая ставка    = %s', l_title, to_char(p_brateid));
  bars_audit.trace('%s базовая ставка пролонгации = %s', l_title, to_char(p_brateid2));

  if p_chgtype != 0 then
     delete from int_ratn where acc = p_accid and id = 1;
  end if;

  -- основная процентная ставка
  if p_fixrate = 1 then
     l_br := null;
     l_ir := f_calc_rate (p_typecode, p_termm, p_termd, p_amount, p_begdate);
     if l_ir is null then
        l_ir := getbrat(p_begdate, p_brateid, p_currency, p_amount);
     end if;
  else
     l_br := p_brateid;
     l_ir := null;
  end if;
  bars_audit.trace('%s ставки (инд, баз) = (%s, %s)', l_title, to_char(l_ir), to_char(l_br));

  begin
    insert into int_ratn (acc, id, bdat, br, ir)
    values (p_accid, 1, p_begdate, l_br, l_ir);
  exception
    when others then
      -- ошибка при заполнении процентной ставки
      bars_error.raise_nerror(g_modcode, 'FILL_INTRATE_FAILED', substr(sqlerrm,1,g_errmsgD));
  end;
  bars_audit.trace('%s заполнена основная %-ная ставка', l_title);

  -- процентная ставка пролонгации
  if p_brateid2 > 0 and p_enddate is not null then

     update int_accn set stp_dat = null where acc = p_accid and id = 1;

     begin
       insert into int_ratn (acc, id, bdat, br) values (p_accid, 1, p_enddate, p_brateid2);
     exception
       when others then
        -- ошибка при заполнении процентной ставки
        bars_error.raise_nerror(g_modcode, 'FILL_INTRATE_FAILED', substr(sqlerrm,1,g_errmsgD));
      end;
      bars_audit.trace('%s заполнена ставка пролонгации № %s, действует с %s', l_title,
                      to_char(p_brateid2), TO_CHAR(p_enddate,'dd/mm/yyyy'));
  end if;

end fill_interst_rate;
--
-- проверка допустимости открытия вклада по описанным для вида вклада бизнес-правилам
--
procedure validate_dptopen
 (p_dptid  in dpt_deposit.deposit_id%type, -- идентификатор вклада
  p_typid  in dpt_deposit.vidd%type)       -- код вида вклада
is
  title     constant varchar2(60) := 'dpt.valdptopen:';
  l_query   dpt_vidd_params.val%type;
  l_cursor  integer;
  l_tmpnum  integer;
  l_result  varchar2(254);
begin

  bars_audit.trace('%s entry, dptid=>%s, typid=>%s', title, to_char(p_dptid), to_char(p_typid));

  begin
    select val
      into l_query
      from dpt_vidd_params
     where vidd = p_typid
       and tag  = val_dptopen;
  exception
    when no_data_found then
      l_query := null;
  end;

  if (l_query is not null) then

     begin
       l_cursor := dbms_sql.open_cursor;
       dbms_sql.parse (l_cursor, l_query, dbms_sql.native);
       dbms_sql.bind_variable (l_cursor, 'DPTID', p_dptid);
       dbms_sql.define_column (l_cursor, 1, l_result, 254);
       l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
       dbms_sql.column_value(l_cursor, 1, l_result);
       dbms_sql.close_cursor (l_cursor);
     exception
       when others then
         dbms_sql.close_cursor (l_cursor);
         bars_error.raise_nerror(g_modcode, 'VALIDATE_DPTOPEN_ERROR', sqlerrm);
     end;

     if l_result is not null then
        bars_error.raise_nerror(g_modcode, 'VALIDATE_DPTOPEN_FAILED', l_result);
     end if;

  end if;

  bars_audit.trace('%s exit', title);

end validate_dptopen;
--
-- создание договора
--
procedure create_deal
  (p_chgtype    in  number,
   p_dptid      in  dpt_deposit.deposit_id%type,
   p_dptnum     in  dpt_deposit.nd%type,
   p_custid     in  dpt_deposit.rnk%type,
   p_accid      in  dpt_deposit.acc%type,
   p_typeid     in  dpt_deposit.vidd%type,
   p_currid     in  dpt_deposit.kv%type,
   p_amount     in  dpt_deposit.limit%type,
   p_freq       in  dpt_deposit.freq%type,
   p_stopid     in  dpt_deposit.stop_id%type,
   p_datz       in  dpt_deposit.datz%type,
   p_datbeg     in  dpt_deposit.dat_begin%type,
   p_datend     in  dpt_deposit.dat_end%type,
   p_datend_alt in  dpt_deposit.dat_end_alt%type,
   p_comment    in  dpt_deposit.comments%type,
   p_intpayb    in  dpt_deposit.mfo_p%type,
   p_intpaya    in  dpt_deposit.nls_p%type,
   p_intpayn    in  dpt_deposit.name_p%type,
   p_intpayi    in  dpt_deposit.okpo_p%type,
   p_wb         in  dpt_deposit.wb%type default 'N')
is
  l_title  varchar2(60) := 'dptopen.createdeal:';
  l_dptnum dpt_deposit.nd%type;
  l_dptdat dpt_deposit.datz%type;
  l_userid dpt_deposit.userid%type;
begin

  bars_audit.trace('%s договор № %s (%s)', l_title, p_dptnum, to_char(p_dptid));

  l_dptnum := p_dptnum;
  l_dptdat := nvl(p_datz, trunc(sysdate));
  l_userid := gl.auid;

  if p_chgtype = 0 then

    -- открытие договора
    insert into dpt_deposit
       (deposit_id, nd, rnk, acc, vidd,
        kv, limit, freq, stop_id, userid,
        datz, dat_begin, dat_end, dat_end_alt,
        comments, mfo_p, nls_p, name_p, okpo_p, wb)
    values
       (p_dptid, l_dptnum, p_custid, p_accid, p_typeid,
        p_currid, p_amount, p_freq, p_stopid, l_userid,
        l_dptdat, p_datbeg, p_datend, p_datend_alt,
        p_comment, p_intpayb, p_intpaya, p_intpayn, p_intpayi, p_wb);

    bars_audit.trace('%s открыт договор № %s (%s)', l_title, p_dptnum, to_char(p_dptid));


  else

    update dpt_deposit
       set       vidd = p_typeid,
                limit = p_amount,
                 freq = p_freq,
              stop_id = p_stopid,
            dat_begin = p_datbeg,
              dat_end = p_datend,
          dat_end_alt = p_datend_alt,
             comments = p_comment,
                mfo_p = p_intpayb,
                nls_p = p_intpaya,
               name_p = p_intpayn,
               okpo_p = p_intpayi,
                   wb = p_wb
     where deposit_id = p_dptid;
    bars_audit.trace('%s изменены параметры договора № %s (%s)', l_title, l_dptnum, to_char(p_dptid));

    -- поменять dpt_deposit_clos!!!
  end if;

  -- пост-проверка допустимости открытия вклада по описанным для вида вклада бизнес-правилам
  validate_dptopen (p_dptid, p_typeid);

end create_deal;

--
-- заполнение доп.реквизита договора
--
procedure fill_dptparams
  (p_dptid in  dpt_depositw.dpt_id%type,
   p_tag   in  dpt_depositw.tag%type,
   p_val   in  dpt_depositw.value%type)
is
   l_title varchar2(60) := 'dptopen.dptparams:';
   l_val   dpt_depositw.value%type;
begin

  bars_audit.trace('%s договор %s, значение реквизита %s = %s',
                   l_title, to_char(p_dptid), p_tag, p_val);

  begin
    insert into dpt_depositw (dpt_id, tag, value)  values (p_dptid, p_tag, p_val);
    bars_audit.trace('%s заполнен доп.реквизит', l_title);
  exception
    when dup_val_on_index then
      if (p_tag = 'METAL') then

        select trim(value)||'#' into l_val
          from dpt_depositw where dpt_id = p_dptid and tag = p_tag;

        -- якщо вже є інформ. про злитки
        if length(l_val) > 1 then
          l_val := (l_val||p_val);
        else
          l_val := p_val;
        end if;

      else
        l_val := p_val;
      end if;

      update dpt_depositw
         set value = l_val
       where dpt_id = p_dptid and tag = p_tag;
  end;

end fill_dptparams;

--
-- заполнение псевдо-МФО для одного счета
--
procedure fill_bank_for_one_acc
  (p_acc in accounts.acc%type,
   p_mfo in banks.mfo%type)
is
   l_title varchar2(60) := 'dptopen.bankacc1:';
begin
  insert into bank_acc (acc, mfo) values (p_acc, p_mfo);
  bars_audit.trace('%s для счета %s заполнено псевдо-МФО %s', l_title, to_char(p_acc), p_mfo);
exception
  when dup_val_on_index then
    update bank_acc set mfo = p_mfo where acc = p_acc;
    bars_audit.trace('%s для счета %s изменено псевдо-МФО на %s', l_title, to_char(p_acc), p_mfo);
end fill_bank_for_one_acc;

--
-- заполнение псевдо-МФО для счетов, обслуживающих договор
--
procedure fill_bankacc
  (p_depaccid  in  accounts.acc%type,
   p_intaccid  in  accounts.acc%type,
   p_amraccid  in  accounts.acc%type)
is
   l_title varchar2(60) := 'dptopen.bankaccs:';
   l_mfo   banks.mfo%type;
begin

  select mfo into l_mfo from banks where mfo = substr(tobopack.gettobo, 1, 12);
  bars_audit.trace('%s псевдо-МФО %s', l_title, l_mfo);

  fill_bank_for_one_acc (p_depaccid, l_mfo);
  fill_bank_for_one_acc (p_intaccid, l_mfo);
  if p_amraccid is not null then
    fill_bank_for_one_acc (p_amraccid, l_mfo);
  end if;
  bars_audit.trace('%s заполнено псевдо-МВО для счетов по договору');

exception
  when no_data_found then
    bars_audit.trace('%s не найдено псевдо-МФО %s', l_title, substr(tobopack.gettobo, 1, 12));
end fill_bankacc;

--
-- расчет дат начала и окончания действия договора
--
procedure get_dealdates
  (p_dptype    in      dpt_vidd.vidd%type,          -- код вида вклада
   p_mnthcnt   in      dpt_vidd.duration%type,      -- срок договора в месяцах
   p_dayscnt   in      dpt_vidd.duration_days%type, -- срок договора в днях
   p_datdeal   in      date,                        -- календ.дата заключения договора
   p_datbegin  in out  date,                        -- дата начала действия договора
   p_datend    in out  date,                        -- дата окончания действия договора
   p_rnk       in      CUSTOMER.RNK%type default null )          -- rnk клієнта(для депозитів, строк яких залежить від віку клієнта)

is
  l_title     varchar2(60)   := 'dptopen.getdates:';
  l_basecur   tabval.kv%type := gl.baseval;
  l_bdate     date           := gl.bdate;
  l_weekend   number(3);
  l_backparam params.par%type := 'DPT_DTBK';
  l_frwdparam params.par%type := 'DPT_DTFW';
begin

  bars_audit.trace('%s вид вклада № %s, срок - %s мес и %s дней, даты %s - %s', l_title,
                   to_char(p_dptype), to_char(p_mnthcnt), to_char(p_dayscnt),
                   to_char(p_datbegin,'dd.mm.yy'), to_char(p_datend,  'dd.mm.yy'));

  -- дата начала действия договора
  p_datbegin := nvl(p_datdeal, trunc(sysdate));
  bars_audit.trace('%s дата начала - %s', l_title, to_char(p_datbegin,'dd.mm.yy'));

  -- дата окончания действия договора
  p_datend := get_datend_uni (p_datbegin, p_mnthcnt, p_dayscnt, p_dptype, p_rnk);

  if p_datend is null then
     bars_error.raise_nerror(g_modcode, 'INVALID_DPT_TERM');
  end if;
  -- вклад до востребования
  if p_datend = p_datbegin then
     p_datend := null;
  end if;
  bars_audit.trace('%s дата окончания - %s', l_title, to_char(p_datend,'dd.mm.yy'));

end get_dealdates;

--
-- заполнение неснижаемого и макс.допустимого остатков на деп.счете
--
procedure set_dptlimits
  (p_dptype in dpt_deposit.vidd%type,  -- код вида вклада
   p_dptacc in dpt_deposit.acc%type)   -- внутр.№ деп.счета
is
  title       constant varchar2(60) := 'dptopen.setlimits:';
  l_minamount number(38);
  l_maxamount number(38);
begin

  bars_audit.trace('%s запуск, dptype => %s, dptacc => %s',
                   title, to_char(p_dptype), to_char(p_dptacc));

  begin
    select to_number(minamount), to_number(maxamount)
      into l_minamount, l_maxamount
      from
           (select max(decode(tag, min_depamount, trim(val), null)) minamount,
                   max(decode(tag, max_depamount, trim(val), null)) maxamount
              from dpt_vidd_params
             where vidd = p_dptype and tag in (min_depamount, max_depamount))
     where minamount is not null
        or maxamount is not null;
    bars_audit.trace('%s несниж.остаток - %s, макс.допуст.остаток - %s',
                     title, to_char(l_minamount), to_char(l_maxamount));

    if l_minamount > 0 or l_maxamount > 0 then
       update accounts
          set lim  = - l_minamount,
              ostx = + l_maxamount
        where acc  = p_dptacc;
       bars_audit.trace('%s на счете %s установлен несниж.остаток %s и макс.остаток %s',
                        title, to_char(p_dptacc), to_char(l_minamount), to_char(l_maxamount));
    end if;

  exception
    when no_data_found then
      bars_audit.trace('%s отсутствуют ограничения на суммы для вида вклада %s',
                       title, to_char(p_dptype));
    when others then
      bars_error.raise_nerror (g_modcode, 'SET_DPTLIMITS_FAILED', to_char(p_dptype), sqlerrm);
  end;

  bars_audit.trace('%s выход', title);

end set_dptlimits;

--
-- заполнение хранилища счетов по вкладу
--
procedure ins_dptacc
 (p_dptid  in dpt_accounts.dptid%type, -- идентификатор вклада
  p_accid  in dpt_accounts.accid%type) -- идентификатор счета
is
begin
  insert into dpt_accounts (dptid, accid) values (p_dptid, p_accid);
exception
  when dup_val_on_index then null;
end ins_dptacc;

--
-- открытие депозитного договора (полная версия)
--
procedure p_open_vklad_ex
  (p_vidd         in      dpt_deposit.vidd%type,
   p_rnk          in      dpt_deposit.rnk%type,
   p_nd           in      dpt_deposit.nd%type,
   p_sum          in      dpt_deposit.limit%type,
   p_nls_intpay   in      dpt_deposit.nls_p%type,
   p_mfo_intpay   in      dpt_deposit.mfo_p%type,
   p_okpo_intpay  in      dpt_deposit.okpo_p%type,
   p_name_intpay  in      dpt_deposit.name_p%type,
   p_fl_dptpay    in      number,
   p_nls_dptpay   in      dpt_deposit.nls_d%type,
   p_mfo_dptpay   in      dpt_deposit.mfo_p%type,
   p_name_dptpay  in      dpt_deposit.nms_d%type,
   p_comments     in      dpt_deposit.comments%type,
   p_datz         in      dpt_deposit.datz%type,
   p_datbegin     in      date           default null,
   p_dat_end_alt  in      date,
   p_term_m       in      number,
   p_term_d       in      number,
   p_grp          in      number,
   p_isp          in      number,
   p_nocash       in      number         default 0,
   p_chgtype      in      number         default 0,
   p_depacctype   in      tips.tip%type  default 'ODB',
   p_intacctype   in      tips.tip%type  default 'ODB',
   p_migr         in      number         default null,
   p_dptid        in out  dpt_deposit.deposit_id%type,
   p_nlsdep          out  accounts.nls%type,
   p_nlsint          out  accounts.nls%type,
   p_nlsamr          out  accounts.nls%type,
   p_errmsg          out  varchar2,              -- сообщение об ошибке
   p_wb       in    dpt_deposit.wb%type)         -- признак открытия через веббанкинг
is
  l_title       varchar2(60)       := 'dptopenex:';
  l_mfo         banks.mfo%type     := gl.amfo;
  l_custcode    customer.okpo%type;
  l_viddrow     dpt_vidd%rowtype;
  l_dat_begin   dpt_deposit.dat_begin%type;
  l_dat_end     dpt_deposit.dat_end%type;
  l_dptparent   dpt_deposit.deposit_id%type;
  l_dptnum      dpt_deposit.nd%type;
  l_depacc      acc_rec;
  l_intacc      acc_rec;
  l_amracc      acc_rec;
  l_expaccid    accounts.acc%type;
  -- параметры безналичной выплаты процентов
  l_nls_intpay  dpt_deposit.nls_p%type;
  l_mfo_intpay  dpt_deposit.mfo_p%type;
  l_name_intpay dpt_deposit.name_p%type;
  l_okpo_intpay dpt_deposit.okpo_p%type;
  -- параметры безналичного перечисления депозита
  l_fl_dmnd     number(1);
  l_vidd_dmnd   dpt_deposit.vidd%type;
  l_dpt_dmnd    dpt_deposit.dpt_d%type;
  l_acc_dmnd    dpt_deposit.acc_d%type;
  l_mfo_dmnd    dpt_deposit.mfo_d%type;
  l_nms_dmnd    dpt_deposit.nms_d%type;
  l_nlsd_dmnd   accounts.nls%type;
  l_nlsn_dmnd   accounts.nls%type;
  l_nlsa_dmnd   accounts.nls%type;
  l_erm_dmnd    varchar2(100);
  l_accparent   accounts.acc%type;
  -----------------------------------
  l_branch      accounts.tobo%type;
  l_acc_details_a   acc_rec;
  l_acc_details_b   acc_rec;
  l_ref         oper.ref%type;
  l_tt          oper.tt%type;
  l_dk          oper.dk%type;
begin

  bars_audit.trace('%s запуск, вид вклада -%s, № %s от %s на сумму %s, тип откр. - %s',
                   l_title, to_char(p_vidd), p_nd, to_char(p_datz,'dd.mm.yy'),
                            to_char(p_sum), to_char(p_chgtype));
  -- код відділення демозиту
  l_branch := nvl(sys_context ('bars_context', 'user_branch'), nvl(tobopack.gettobo, 0));

  -- идентификационный код клиента
  begin
    select okpo into l_custcode from customer where rnk = p_rnk;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'CUST_NOT_FOUND', to_char(p_rnk));
  end;
  bars_audit.trace('%s клиент № %s, идентиф.код %s', l_title, to_char(p_rnk), l_custcode);

  -- параметры вида вклада
  begin
    select *
      into l_viddrow
      from dpt_vidd
     where vidd = p_vidd and (flag = 1 or p_vidd < 0);
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'VIDD_NOT_FOUND_OR_CLOSED', to_char(p_vidd));
  end;
  bars_audit.trace('%s вид вклада %s', l_title, l_viddrow.type_name);

  -- даты договора
  bars_audit.trace('%s срок %s мес/%s дней', l_title, to_char(p_term_m), to_char(p_term_d));

  if p_datbegin is null then
    l_dat_begin := gl.bdate;
  else
    l_dat_begin := p_datbegin;
  end if;

  l_dat_end   := null;

  get_dealdates (p_dptype   => p_vidd,        -- код вида вклада
                 p_mnthcnt  => p_term_m,      -- срок договора в месяцах
                 p_dayscnt  => p_term_d,      -- срок договора в днях
                 p_datdeal  => p_datz,        -- календ.дата заключения договора
                 p_datbegin => l_dat_begin,   -- дата начала действия договора
                 p_datend   => l_dat_end,      -- дата окончания действия договора
                 p_rnk      => p_rnk);         -- rnk клієнта

  bars_audit.trace('%s период действия: %s - %s', l_title,
                   to_char(l_dat_begin, 'dd.mm.yyyy'),
                   to_char(l_dat_end,   'dd.mm.yyyy'));

  if p_chgtype = 0 then

    -- идентификатор родительского договора
    l_dptparent := case when p_dptid > 0 then p_dptid else null end;

    -- идентификатор договора
    p_dptid  := get_dpt_id;

    -- номер договора
    If ( p_migr = 1 )
    Then -- міграція депозитів
      l_dptnum := get_dpt_num( p_dptnum => p_nd,
                               p_dptid  => p_dptid,
                               p_dptidP => l_dptparent );
    Else
      l_dptnum := SubStr(to_char(p_dptid), 1, 35);
    End If;

    bars_audit.trace('%s договор № %s (%s)', l_title, l_dptnum, to_char(p_dptid));

    -- открытие счетов
    open_accounts (p_dptid   => nvl(l_dptparent, p_dptid),
                   p_dptnum  => l_dptnum,
                   p_custid  => p_rnk,
                   p_typeid  => p_vidd,
                   p_curcode => l_viddrow.kv,
                   p_depnbs  => l_viddrow.bsd,
                   p_intnbs  => l_viddrow.bsn,
                   p_amrnbs  => l_viddrow.bsa,
                   p_deptype => p_depacctype,
                   p_inttype => p_intacctype,
                   p_isp     => p_isp,
                   p_grp     => p_grp,
                   p_depacc  => l_depacc,
                   p_intacc  => l_intacc,
                   p_amracc  => l_amracc);

    p_nlsdep := l_depacc.acc_num;
    p_nlsint := l_intacc.acc_num;
    p_nlsamr := l_amracc.acc_num;

    bars_audit.trace('%s открыты счета (%s, %s, %s)', l_title, p_nlsdep, p_nlsint, p_nlsamr);

  else

    l_dptparent := null;
    l_dptnum    := p_nd;

    bars_audit.trace('%s договор № %s (%s), ид.родит.договора %s', l_title,
                     l_dptnum, to_char(p_dptid), to_char(l_dptparent));


    find_accounts (p_dptid    =>  p_dptid,
                   p_dptnum   =>  l_dptnum,
                   p_custid   =>  p_rnk,
                   p_curcode  =>  l_viddrow.kv,
                   p_amortbs  =>  l_viddrow.bsa,
                   p_depacc   =>  l_depacc,
                   p_intacc   =>  l_intacc,
                   p_amracc   =>  l_amracc);

    p_nlsdep := l_depacc.acc_num;
    p_nlsint := l_intacc.acc_num;
    p_nlsamr := l_amracc.acc_num;

    bars_audit.trace('%s найдены счета (%s, %s, %s)', l_title, p_nlsdep, p_nlsint, p_nlsamr);

  end if;

  -- заполнение даты погашения
  update accounts
     set mdate = l_dat_end,
         vid = 4
   where acc = l_depacc.acc_id;

  update accounts
     set mdate = l_dat_end
   where acc = l_intacc.acc_id;

  update accounts
     set mdate = l_dat_end
   where acc = l_amracc.acc_id;

  bars_audit.trace('%s заполнена дата погашения', l_title);

  -- заполнение неснижаемого и макс.допустимого остатков на деп.счете
  set_dptlimits (p_dptype => l_viddrow.vidd, p_dptacc => l_depacc.acc_id);

  -- заполнение спецпараметров
  fill_specparams (p_depaccid  =>  l_depacc.acc_id,
                   p_intaccid  =>  l_intacc.acc_id,
                   p_depnbs    =>  l_viddrow.bsd,
                   p_intnbs    =>  l_viddrow.bsn,
                   p_begdate   =>  l_dat_begin,
                   p_enddate   =>  l_dat_end,
                   p_dpttype   =>  l_viddrow.vidd,
                   p_idg       =>  l_viddrow.idg,
                   p_ids       =>  l_viddrow.ids,
                   p_amraccid  =>  l_amracc.acc_id,
                   p_amrnbs    =>  l_viddrow.bsa,
                   p_migr      =>  p_migr
          );
  bars_audit.trace('%s заполнены спецпараметры', l_title);

  -- заполнение счетов консолидации
  fill_binded_accounts (p_depaccid    =>  l_depacc.acc_id,
                        p_intaccid    =>  l_intacc.acc_id,
                        p_curcode     =>  l_viddrow.kv,
                        p_binddepacc  =>  l_viddrow.nls_k,
                        p_bindintacc  =>  l_viddrow.nlsn_k);
  bars_audit.trace('%s заполнены счета консолидации', l_title);

  -- счет процентных расходов
  l_expaccid := get_expenseacc (p_dptype  => p_vidd,
                                p_balacc  => l_viddrow.bsd,
                                p_curcode => l_viddrow.kv,
                                p_branch  => l_branch);
  bars_audit.trace('%s счет расходов %s', l_title, to_char(l_expaccid));

  -- параметры безналичной выплаты %% (в том числе капитализация)
  if l_viddrow.comproc = 1 then
     l_mfo_intpay  := substr(l_mfo,             1, 12);
     l_nls_intpay  := substr(l_depacc.acc_num,  1, 14);
     l_okpo_intpay := substr(l_custcode,        1, 14);
     l_name_intpay := substr(l_depacc.acc_name, 1, 38);
  else
     l_mfo_intpay  := substr(p_mfo_intpay,      1, 12);
     l_nls_intpay  := substr(p_nls_intpay,      1, 14);
     l_okpo_intpay := substr(p_okpo_intpay,     1, 14);
     l_name_intpay := substr(p_name_intpay,     1, 38);
  end if;
  bars_audit.trace('%s выплата процентов: МФО = %s, счет = %s, ид.код = %s, получатель = %s',
                   l_title, l_mfo_intpay, l_nls_intpay, l_okpo_intpay, l_name_intpay);

  -- основная процентная карточка
  fill_interst_card (p_chgtype      =>  p_chgtype,
                     p_intid        =>  1,
                     p_depaccid     =>  l_depacc.acc_id,
                     p_intaccid     =>  l_intacc.acc_id,
                     p_expaccid     =>  nvl(l_amracc.acc_id, l_expaccid), -- 7041/3500
                     p_typecode     =>  p_vidd,
                     p_intmetr      =>  l_viddrow.metr,
                     p_intbasey     =>  l_viddrow.basey,
                     p_intfreq      =>  l_viddrow.freq_n,
                     p_intost       =>  l_viddrow.tip_ost,
                     p_intbeg       =>  (l_dat_begin - 1),
                     p_intstp       =>  (l_dat_end   - 1),
                     p_inttt        =>  l_viddrow.tt,
                     p_intpay_cur   =>  l_viddrow.kv,
                     p_intpay_acc   =>  l_nls_intpay,
                     p_intpay_mfo   =>  l_mfo_intpay,
                     p_intpay_name  =>  l_name_intpay);
  bars_audit.trace('%s заполнена основная процентная карточка', l_title);

  -- основная процентная ставка и процентная ставка пролонгации
  fill_interst_rate (p_chgtype   => p_chgtype,
                     p_dptid     => p_dptid,
                     p_accid     => l_depacc.acc_id,
                     p_typecode  => p_vidd,
                     p_fixrate   => l_viddrow.basem,
                     p_brateid   => l_viddrow.br_id,
                     p_brateid2  => nvl(l_viddrow.br_id_l, 0),
                     p_termM     => p_term_m,
                     p_termD     => p_term_d,
                     p_begdate   => l_dat_begin,
                     p_enddate   => l_dat_end,
                     p_amount    => p_sum,
                     p_currency  => l_viddrow.kv);
  bars_audit.trace('%s заполнена процентная ставка и ставка пролонгации', l_title);

  -- процентная карточка для авансовых вкладов
  if l_amracc.acc_id is not null then
     -- заполнение основной проц.карточки (id = 0) для амортиз.счета
     fill_interst_card (p_chgtype      => p_chgtype,
                        p_intid        => 0,
                        p_depaccid     => l_amracc.acc_id,
                        p_intaccid     => l_amracc.acc_id,
                        p_expaccid     => l_expaccid,
                        p_typecode     => p_vidd,
                        p_intmetr      => l_viddrow.amr_metr,
                        p_intbasey     => l_viddrow.basey,
                        p_intfreq      => l_viddrow.freq_n,
                        p_intost       => l_viddrow.tip_ost,
                        p_intbeg       => l_dat_begin,
                        p_intstp       => (l_dat_end - 1),
                        p_inttt        => l_viddrow.tt,
                        p_intpay_cur   =>  null,
                        p_intpay_acc   =>  null,
                        p_intpay_mfo   =>  null,
                        p_intpay_name  =>  null );
     bars_audit.trace('%s заполнена процентная карточка для авансовых вкладов', l_title);
  end if;


  -- открытие договора
  create_deal (p_chgtype     =>  p_chgtype,
               p_dptid       =>  p_dptid,
               p_dptnum      =>  l_dptnum,
               p_custid      =>  p_rnk,
               p_accid       =>  l_depacc.acc_id,
               p_typeid      =>  p_vidd,
               p_currid      =>  l_viddrow.kv,
               p_amount      =>  p_sum,
               p_freq        =>  l_viddrow.freq_k,
               p_stopid      =>  l_viddrow.id_stop,
               p_datz        =>  p_datz,
               p_datbeg      =>  l_dat_begin,
               p_datend      =>  l_dat_end,
               p_datend_alt  =>  p_dat_end_alt,
               p_comment     =>  substr(p_comments,1,128),
               p_intpayB     =>  l_mfo_intpay,
               p_intpayA     =>  l_nls_intpay,
               p_intpayN     =>  l_name_intpay,
               p_intpayI     =>  l_okpo_intpay,
               p_wb          =>  p_wb);
  bars_audit.trace('%s сохранена информация по договору', l_title);

  -- прогрессивная %-ная ставка
  p_rate_rise (p_dptid);
  bars_audit.trace('%s выполнен расчет прогрессивной ставки', l_title);

  -- бонуcная %-ная карточка
  p_bonus_rate (p_dptid);
  bars_audit.trace('%s выполнена расчет бонусной ставки', l_title);

  -- перечисление суммы депозита после окончания срока действия договора

  bars_audit.trace('%s признак перечисления депозита = %s', l_title, to_char(p_fl_dptpay));
  bars_audit.trace('%s возврат депозита: МФО = %s, счет = %s, получатель = %s',
                   l_title, p_mfo_dptpay, p_nls_dptpay, p_name_dptpay);

  if p_fl_dptpay = 1 then
     l_fl_dmnd  := 3;  -- открытие вклада до востребования
  elsif (p_nls_dptpay is not null and nvl(p_mfo_dptpay, l_mfo) is not null) then
     l_fl_dmnd  := 1;
  else
     l_fl_dmnd  := 0;
  end if;

  -- l_fl_dmnd = 3  -- депозит перечисляется на вклад до востребования
  -- l_fl_dmnd = 2  -- депозит перечисляется на технический счет
  -- l_fl_dmnd = 1  -- депозит перечисляется на указанный счет в указанном банке
  -- l_fl_dmnd = 0  -- депозит не перечисляется

  if l_fl_dmnd = 3    then

     bars_audit.trace('%s депозит перечисляется на вклад до востребования', l_title);

     begin
       select vidd into l_vidd_dmnd
         from dpt_vidd
        where vidd < 0 and kv = l_viddrow.kv;
     exception
       when no_data_found then
         -- не найден вид вклада до востребования для валюты
         bars_error.raise_nerror(g_modcode, 'DMNDVIDD_NOT_FOUND', to_char(l_viddrow.kv));
       when too_many_rows then
         -- невозможно однозначно найти вид вклада до востребования для валюты
         bars_error.raise_nerror(g_modcode, 'DMNDVIDD_TOO_MANY_ROWS', to_char(l_viddrow.kv));
     end;

     -- в процедуру открытия подчиненного вклада передаем номер родительского вклада
     l_dpt_dmnd  := p_dptid;
     l_accparent := l_depacc.acc_id;

     p_open_vklad_ex (p_vidd         => l_vidd_dmnd,
                      p_rnk          => p_rnk,
                      p_nd           => l_dptnum,
                      p_sum          => p_sum,
                      p_nls_intpay   => null,
                      p_mfo_intpay   => null,
                      p_okpo_intpay  => null,
                      p_name_intpay  => null,
                      p_fl_dptpay    => 0,
                      p_nls_dptpay   => null,
                      p_mfo_dptpay   => null,
                      p_name_dptpay  => null,
                      p_comments     => SUBSTR(p_comments, 1, 128),
                      p_datz         => p_datz,
                      p_datbegin     => p_datbegin,
                      p_dat_end_alt  => null,
                      p_term_m       => 0,
                      p_term_d       => 0,
                      p_grp          => p_grp,
                      p_isp          => p_isp,
                      p_nocash       => 0,
                      p_chgtype      => 0,
                      p_depacctype   => p_depacctype,
                      p_intacctype   => p_intacctype,
                      p_dptid        => l_dpt_dmnd,
                      p_nlsdep       => l_nlsd_dmnd,
                      p_nlsint       => l_nlsn_dmnd,
                      p_nlsamr       => l_nlsa_dmnd,
                      p_errmsg       => l_erm_dmnd,
              p_wb       => p_wb);

     l_mfo_dmnd := l_mfo;

     -- параметры вклада до востребования
     select d.acc, substr(a.nms, 1, 38)
       into l_acc_dmnd, l_nms_dmnd
       from dpt_deposit d, accounts a
      where d.acc = a.acc and d.deposit_id = l_dpt_dmnd;

  elsif l_fl_dmnd = 2 then

     bars_audit.trace('%s депозит перечисляется на технический счет', l_title);

     l_dpt_dmnd := null;
     l_mfo_dmnd := l_mfo;

     p_open_tech_acc( p_dptid => p_dptid,
                      p_nd    => l_dptnum,
                      p_rnk   => p_rnk,
                      p_kv    => l_viddrow.kv,
                      p_acc   => l_acc_dmnd,
                      p_nls   => l_nlsd_dmnd,
                      p_nms   => l_nms_dmnd);

  elsif l_fl_dmnd = 1 then

     bars_audit.trace('%s депозит перечисляется на указанный счет в указанном банке', l_title);

     l_dpt_dmnd  := null;
     l_acc_dmnd  := null;
     l_mfo_dmnd  := substr(nvl(p_mfo_dptpay, l_mfo), 1, 12);
     l_nlsd_dmnd := substr(p_nls_dptpay,             1, 14);
     l_nms_dmnd  := substr(p_name_dptpay,            1, 38);

     if l_mfo_dmnd = l_mfo then
        begin
          select acc, substr(nms,1,38)
            into l_acc_dmnd, l_nms_dmnd
            from accounts
           where nls = p_nls_dptpay and kv = l_viddrow.kv;
        exception
          when no_data_found then
            -- неверно указан счет для возврата депозита
            bars_error.raise_error(g_modcode, 17);
        end;
     end if;

  else

     bars_audit.trace('%s депозит не перечисляется', l_title);

  end if;


  if l_fl_dmnd in (1, 3) then

     update dpt_deposit
        set dpt_d = l_dpt_dmnd,
            acc_d = l_acc_dmnd,
            nls_d = l_nlsd_dmnd,
            nms_d = l_nms_dmnd,
           okpo_d = l_custcode,
            mfo_d = l_mfo_dmnd
      where deposit_id = p_dptid;
     bars_audit.trace('%s заполены параметры возврата депозита', l_title);

  end if;


  bars_audit.trace('%s признак безнал.первичного взноса = %s', l_title, to_char(p_nocash));

  if p_nocash <> 0 then
     fill_dptparams (p_dptid => p_dptid,
                     p_tag   => 'NCASH',
                     p_val   => p_nocash);
     bars_audit.trace('%s заполнен параметр NCASH', l_title);
  end if;

  -- заполнение хранилища счетов по вкладу
  if l_depacc.acc_id is not null then ins_dptacc (p_dptid, l_depacc.acc_id); end if;
  if l_intacc.acc_id is not null then ins_dptacc (p_dptid, l_intacc.acc_id); end if;
  if l_amracc.acc_id is not null then ins_dptacc (p_dptid, l_amracc.acc_id); end if;
  bars_audit.trace('%s заполнено хранилище счетов по вкладу', l_title);

    If ( p_migr is Null )
    Then
    ---------------------------------------------------
    --  породження операції на видачу ощадної книжки --
    -- ( використовуєм змінні параметрів безготівкового перерахування депозиту )
      begin
        select 1
          into l_fl_dmnd
          from DPT_VIDD_FIELD
         where TAG  = 'BOOKS'
           and VIDD = p_vidd;
      exception
        when NO_DATA_FOUND then
          l_fl_dmnd := 0;
      end;

      bars_audit.trace('%s для виду депозиту %s передбачено обов`язкову видачу ощадкнижки (%s)', l_title, to_char(p_vidd), to_char(l_fl_dmnd));

      -- якщо видом вкладу передбачено видачу ощадкнижки
      if l_fl_dmnd = 1 then

        l_title := 'dptopenex.PAYDOC_ISSUANCE_BOOK:';

        -- пошук рахунку обліку ощадкнижки
        begin
          select acc, nls, kv, nms
            into l_acc_details_b
            from accounts a
           where a.kv   = 980
             and a.nbs  = '9821'
             and a.ob22 = ( select VAL from DPT_VIDD_PARAMS
                             where VIDD = p_vidd and TAG  = 'BOOK_OB22' )
             and a.dazs is null
             and branch = l_branch
             and rownum = 1;
        exception
          when NO_DATA_FOUND then
            p_errmsg := 'Помилка створення операції видачі ощадкнижки (не знайдено рахунок обліку ощадкнижки для підрозділу '||l_branch||')';
            l_acc_details_b := null;
        end;

        bars_audit.trace('%s рахунок обліку ощадкнижки для підрозділу %s = %s/%s',
                         l_title, l_branch, l_acc_details_a.acc_num, to_char(l_acc_details_a.acc_cur));

        -- пошук контрахунку для видачі ощадкнижки
        begin
          select acc, nls, kv, nms
            into l_acc_details_a
            from accounts a
           where a.kf  = l_mfo
             and a.nls = BRANCH_USR.GET_BRANCH_PARAM2('NLS_9910',1)
             and a.kv  = 980
             and a.dazs is null;
        exception
          when NO_DATA_FOUND then
            p_errmsg := 'Помилка створення операції видачі ощадкнижки (не знайдено контррахунок [TAG=''NLS_9910''] для підрозділу '||l_branch||')';
            l_acc_details_a := null;
        end;

        bars_audit.trace('%s контррахунок для видачі ощадкнижки = %s/%s',
                         l_title, l_acc_details_b.acc_num, to_char(l_acc_details_b.acc_cur));
        -- створюєм документ по видачі книжки
        if (l_acc_details_a.acc_id is not null and l_acc_details_b.acc_id is not null) then
          begin
            gl.ref (l_ref);
            l_tt := 'UKV';
            l_dk := 1;
            gl.in_doc3 (ref_    => l_ref,
                        tt_     => l_tt,
                        vob_    => 207,
                        nd_     => SubStr(to_char(l_ref),1,10),
                        pdat_   => sysdate,
                        vdat_   => l_dat_begin,
                        dk_     => l_dk,
                        kv_     => l_acc_details_a.acc_cur,
                        s_      => 100,
                        kv2_    => l_acc_details_b.acc_cur,
                        s2_     => 100,
                        sk_     => null,
                        data_   => l_dat_begin,
                        datp_   => sysdate,
                        nam_a_  => SubStr(l_acc_details_a.acc_name, 1, 38),
                        nlsa_   => l_acc_details_a.acc_num,
                        mfoa_   => l_mfo,
                        nam_b_  => SubStr(l_acc_details_b.acc_name, 1, 38),
                        nlsb_   => l_acc_details_b.acc_num,
                        mfob_   => l_mfo,
                        nazn_   => 'Видано ощадну книжку до депозитного договору № '||to_char(p_dptid),
                        d_rec_  => null,
                        id_a_   => gl.aokpo,
                        id_b_   => gl.aokpo,
                        id_o_   => null,
                        sign_   => null,
                        sos_    => null,
                        prty_   => 0,
                        uid_    => p_isp);
          end;

          paytt (null, l_ref, l_dat_begin, l_tt, l_dk,
                       l_acc_details_a.acc_cur, l_acc_details_a.acc_num, 100,
                       l_acc_details_b.acc_cur, l_acc_details_b.acc_num, 100);

          bars_audit.trace('%s створено документ на видачу ощадкнижки (референс = %s', l_title, to_char(l_ref)||')');
          p_errmsg := 'Cтворено документ на видачу ощадкнижки (референс #'||l_ref||')';

          -- зберігаєм референс документу в параметрах вкладу
          fill_dptparams (p_dptid => p_dptid,
                          p_tag   => 'BOOKS',
                          p_val   => to_char(l_ref) );
          update dpt_deposit
             set comments = substr(p_errmsg, 1, 128)
           where deposit_id = p_dptid;

        else
          bars_audit.trace('%s Err: %s', l_title, p_errmsg);
        end if;
        l_title := 'dptopenex:';
      end if;

    end if;  -- p_migr is null

  bars_audit.trace('%s процедура выполнена', l_title);

end p_open_vklad_ex;

--
-- открытие депозитного договора (сокращенная версия)
--
procedure p_open_vklad
  (p_vidd         in      dpt_deposit.vidd%type,
   p_rnk          in      dpt_deposit.rnk%type,
   p_nd           in      dpt_deposit.nd%type,
   p_sum          in      dpt_deposit.limit%type,
   p_nls_intpay   in      dpt_deposit.nls_p%type,
   p_mfo_intpay   in      dpt_deposit.mfo_p%type,
   p_okpo_intpay  in      dpt_deposit.okpo_p%type,
   p_name_intpay  in      dpt_deposit.name_p%type,
   p_fl_dptpay    in      number,
   p_nls_dptpay   in      dpt_deposit.nls_d%type,
   p_mfo_dptpay   in      dpt_deposit.mfo_p%type,
   p_name_dptpay  in      dpt_deposit.nms_d%type,
   p_comments     in      dpt_deposit.comments%type,
   p_datz         in      dpt_deposit.datz%type,
   p_term_m       in      number,
   p_term_d       in      number,
   p_dat_end_alt  in      date,
   p_grp          in      number,
   p_isp          in      number,
   p_dptid        in out  dpt_deposit.deposit_id%type,
   p_nlsdep          out  accounts.nls%type,
   p_nlsint          out  accounts.nls%type,
   p_nlsamr          out  accounts.nls%type,
   p_errmsg          out  varchar2,
   p_wb       in    dpt_deposit.wb%type default 'N')
is
begin

  p_open_vklad_ex (p_vidd         => p_vidd,
                   p_rnk          => p_rnk,
                   p_nd           => p_nd,
                   p_sum          => p_sum,
                   p_nls_intpay   => p_nls_intpay,
                   p_mfo_intpay   => p_mfo_intpay,
                   p_okpo_intpay  => p_okpo_intpay,
                   p_name_intpay  => p_name_intpay,
                   p_fl_dptpay    => p_fl_dptpay,
                   p_nls_dptpay   => p_nls_dptpay,
                   p_mfo_dptpay   => p_mfo_dptpay,
                   p_name_dptpay  => p_name_dptpay,
                   p_comments     => substr(p_comments, 1, 128),
                   p_datz         => p_datz,
                   p_dat_end_alt  => p_dat_end_alt,
                   p_term_m       => p_term_m,
                   p_term_d       => p_term_d,
                   p_grp          => p_grp,
                   p_isp          => p_isp,
                   p_dptid        => p_dptid,
                   p_nlsdep       => p_nlsdep,
                   p_nlsint       => p_nlsint,
                   p_nlsamr       => p_nlsamr,
                   p_errmsg       => p_errmsg,
           p_wb       => p_wb);

end p_open_vklad;

--
--
--
PROCEDURE update_dpt_type
  (p_dptid         IN  dpt_deposit.deposit_id%type,
   p_typeid        IN  dpt_deposit.vidd%type,
   p_dptamount     IN  dpt_deposit.limit%type,
   p_nocash        IN  number,
   p_payoff        IN  dpt_vidd.fl_2620%type,
   p_IntRcpMFO     IN  dpt_deposit.mfo_p%type,
   p_IntRcpAcc     IN  dpt_deposit.nls_p%type,
   p_IntRcpIDCode  IN  dpt_deposit.okpo_p%type,
   p_IntRcpName    IN  dpt_deposit.name_p%type,
   p_DptRcpMFO     IN  dpt_deposit.mfo_d%type,
   p_DptRcpAcc     IN  dpt_deposit.nls_d%type,
   p_DptRcpIDCode  IN  dpt_deposit.okpo_p%type,
   p_DptRcpName    IN  dpt_deposit.nms_d%type,
   p_comment       IN  dpt_deposit.comments%type)
IS
  l_title      varchar2(60)         := 'dpt.update_dpt_type: ';
  l_dptrow     dpt_deposit%rowtype;
  l_oldtyperow dpt_vidd%rowtype;
  l_newtyperow dpt_vidd%rowtype;
  l_payoff     dpt_vidd.fl_2620%type;
  l_termm      dpt_vidd.duration%type;
  l_termd      dpt_vidd.duration_days%type;
  l_dptaccnum  accounts.nls%type;
  l_intaccnum  accounts.nls%type;
  l_amraccnum  accounts.nls%type;
  l_errmsg     varchar2(4000);
BEGIN

  bars_audit.trace('%s договор № %s, вид вклада № %s, сумма = %s',
                   l_title, to_char(p_dptid), to_char(p_typeid), to_char(p_dptamount));

  BEGIN
    SELECT * INTO l_dptrow FROM dpt_deposit WHERE deposit_id = p_dptid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
  END;

  BEGIN
    SELECT * INTO l_oldtyperow FROM dpt_vidd WHERE vidd = l_dptrow.vidd;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'VIDD_NOT_FOUND', to_char(l_dptrow.vidd));
  END;
  bars_audit.trace('%s "старый" вид договора № %s - %s, вал %s, бал.счета (%s,%s,%s)',
                   l_title, to_char(l_oldtyperow.vidd), l_oldtyperow.type_name, to_char(l_oldtyperow.kv),
                   to_char(l_oldtyperow.bsd), to_char(l_oldtyperow.bsn), to_char(l_oldtyperow.bsa));

  BEGIN
    SELECT * INTO l_newtyperow FROM dpt_vidd WHERE vidd = p_typeid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'VIDD_NOT_FOUND', to_char(p_typeid));
  END;
  bars_audit.trace('%s "старый" вид договора № %s - %s, вал %s, бал.счета (%s,%s,%s)',
                   l_title, to_char(l_newtyperow.vidd), l_newtyperow.type_name, to_char(l_newtyperow.kv),
                   to_char(l_newtyperow.bsd), to_char(l_newtyperow.bsn), to_char(l_newtyperow.bsa));

  IF (l_newtyperow.kv   != l_oldtyperow.kv  OR
      l_newtyperow.bsd  != l_oldtyperow.bsd OR
      l_newtyperow.bsn  != l_oldtyperow.bsn OR
      l_newtyperow.flag != 1                   )   THEN
     -- изменение випа вклада для договора № запрещено:
     -- несовпадают осн.характеристики видов вкладов №... и №...
     bars_error.raise_nerror(g_modcode, 'CHG_DPTYPE_INVALID', to_char(p_dptid),
                             to_char(l_oldtyperow.vidd), l_oldtyperow.type_name,
                             to_char(l_newtyperow.vidd), l_newtyperow.type_name);
  END IF;

  l_termm  := NVL(l_newtyperow.duration,      0);
  l_termd  := NVL(l_newtyperow.duration_days, 0);
  bars_audit.trace('%s срок = %s мес. и %s дн.', l_title, to_char(l_termm), to_char(l_termd));

  l_payoff := CASE
              WHEN (l_newtyperow.type_cod = 'COMB') THEN 1
              ELSE                                       p_payoff
              END;
  bars_audit.trace('%s признак перекрытия = %s', l_title, to_char(l_payoff));

  BEGIN
    p_open_vklad_ex (p_vidd         => p_typeid,
                     p_rnk          => l_dptrow.rnk,
                     p_nd           => l_dptrow.nd,
                     p_sum          => p_dptamount,
                     p_nls_intpay   => p_IntRcpAcc,
                     p_mfo_intpay   => p_IntRcpMFO,
                     p_okpo_intpay  => p_IntRcpIDCode,
                     p_name_intpay  => p_IntRcpName,
                     p_fl_dptpay    => l_payoff,
                     p_nls_dptpay   => p_DptRcpAcc,
                     p_mfo_dptpay   => p_DptRcpMFO,
                     p_name_dptpay  => p_IntRcpName,
                     p_comments     => p_comment,
                     p_datz         => l_dptrow.datz,
                     p_dat_end_alt  => null,
                     p_term_m       => l_termm,
                     p_term_d       => l_termd,
                     p_grp          => null,
                     p_isp          => null,
                     p_nocash       => p_nocash,
                     p_chgtype      => 1,
                     p_dptid        => l_dptrow.deposit_id,
                     p_nlsdep       => l_dptaccnum,
                     p_nlsint       => l_intaccnum,
                     p_nlsamr       => l_amraccnum,
                     p_errmsg       => l_errmsg);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- ошибка при изменении вида договора для договора № : ...
      bars_error.raise_nerror(g_modcode, 'CHG_DPTYPE_ERROR', to_char(p_dptid), sqlerrm);
  END;
  bars_audit.trace('%s изменен вид договора № %s', l_title, to_char(p_dptid));

END update_dpt_type;

--
-- внутр.процедура получения и валидации конфиг.параметров переоформления вкладов
--
procedure igetextparams
  (p_extt  out  char,  -- значение конфиг.параметра DPT_EXTT
   p_extd  out  char,  -- значение конфиг.параметра DPT_EXTD
   p_extr  out  char)  -- значение конфиг.параметра DPT_EXTR
is
  title     varchar2(60) := 'dpt.ext.params:';
  l_ttcode  char(3);
  l_dayscnt char(1);
  l_method  char(2);
begin

  bars_audit.trace('%s entry', title);

  select nvl(max(decode(par, 'DPT_EXTT', substr(val, 1, 3), null)),   ''),
         nvl(max(decode(par, 'DPT_EXTD', substr(val, 1, 1), null)),  '0'),
         nvl(max(decode(par, 'DPT_EXTR', substr(val, 1, 2), null)), 'YY')
    into l_ttcode, l_dayscnt, l_method
    from params
   where par in ('DPT_EXTT', 'DPT_EXTD', 'DPT_EXTR');

  -- существует ли описанная операция
  if l_ttcode is not null then
     begin
       select tt into l_ttcode from tts where tt = l_ttcode;
     exception
       when no_data_found then
         -- не найдена операция для учета средств при переоформлении договора
         bars_error.raise_nerror(g_modcode, 'CANT_GET_EXTEND_TT', l_ttcode);
     end;
  end if;

  -- включен ли режим накручивания оборотов
  bars_audit.trace('%s parameter <DPT_EXTT> = %s', title,  l_ttcode);

  -- метод расчета даты начала переоформленного договора ('DPT_EXTD')
  bars_audit.trace('%s parameter <DPT_EXTD> = %s', title, l_dayscnt);

  -- метод начисления процентов в граничные дни ('DPT_EXTR')
  bars_audit.trace('%s parameter <DPT_EXTR> = %s', title, l_method);

  -- проверка параметров
  if (l_dayscnt = '0' and l_ttcode is     null and l_method = 'YY' or
      l_dayscnt = '0' and l_ttcode is     null and l_method = 'NN' or
      l_dayscnt = '0' and l_ttcode is not null and l_method = 'NN' or
      l_dayscnt = '1' and l_ttcode is     null and l_method = 'YY' or
      l_dayscnt = '1' and l_ttcode is     null and l_method = 'YN' or
      l_dayscnt = '1' and l_ttcode is     null and l_method = 'NY' or
      l_dayscnt = '1' and l_ttcode is     null and l_method = 'NN' or
      l_dayscnt = '1' and l_ttcode is not null and l_method = 'YN' or
      l_dayscnt = '1' and l_ttcode is not null and l_method = 'NN') then
    p_extt := l_ttcode;
    p_extd := l_dayscnt;
    p_extr := l_method;
    bars_audit.trace('%s exit with (%s, %s, %s)', title, p_extt, p_extd, p_extr);
  else
    bars_error.raise_nerror(g_modcode, 'INVALID_EXTPARAMS', l_dayscnt, l_ttcode, l_method);
  end if;

end igetextparams;
--
-- внутр.процедура изменения процентной ставки при переоформлении вклада
--
procedure iextratereview
 (p_dptid   in  dpt_deposit.deposit_id%type,
  p_accid   in  dpt_deposit.acc%type,
  p_curid   in  dpt_deposit.kv%type,
  p_saldo   in  accounts.ostc%type,
  p_typeid  in  dpt_vidd.vidd%type,
  p_extid   in  dpt_vidd.extension_id%type,
  p_inidat  in  date,
  p_datend  in  date,
  p_cntint  in  number,
  p_datint  in  date,
  p_mnthcnt in  number,
  p_dayscnt in  number)
is
  title   varchar2(60) := 'dpt.ext.ratereview:';
  l_intid int_ratn.id%type := 1;
  l_ir    int_ratn.ir%type;
  l_op    int_ratn.op%type;
  l_br    int_ratn.br%type;
  l_date  date;
begin
  bars_audit.trace('%s entry, dptid=>%s, accid=>%s, saldo=>%s/%s, vidd=>%s, extid=>%s',
                   title, to_char(p_dptid), to_char(p_accid), to_char(p_saldo),
                          to_char(p_curid), to_char(p_typeid), to_char(p_extid));

  bars_audit.trace('%s entry,inidat=>%s, datend=>%s, cntint=>%s, datint=>%s',
                   title, to_char(p_inidat,'dd.mm.yyyy'), to_char(p_datend,'dd.mm.yyyy'),
                          to_char(p_cntint), to_char(p_datint,'dd.mm.yyyy'));

  for e in
   (SELECT DECODE (term_type, 1, term_mnth, p_mnthcnt) term_mnth,
           DECODE (term_type, 1, term_days, p_dayscnt) term_days,
           DECODE (method_id, 0, p_inidat, p_datint) bdat,
           indv_rate,
           oper_id,
           base_rate,
           method_id
      FROM (SELECT v.term_type,
                   e.term_mnth,
                   e.term_days,
                   e.indv_rate,
                   e.oper_id,
                   e.base_rate,
                   e.method_id,
                   ext_num,
                   LEAD (ext_num) OVER (PARTITION BY p_typeid ORDER BY ext_num) - 1 next_num
              FROM dpt_vidd_extdesc e, dpt_vidd v
             WHERE v.vidd = p_typeid AND e.type_id = p_extid)
     WHERE (p_cntint BETWEEN ext_num AND next_num)
           OR (next_num IS NULL AND p_cntint >= ext_num)
     order by 1, 2)
  loop

    bars_audit.trace('%s term=(%s, %s), rate=(%s, %s, %s), method=%s, bdat=%s',
                     title, to_char(e.term_mnth), to_char(e.term_days),
                     to_char(e.indv_rate), to_char(e.oper_id), to_char(e.base_rate),
                     to_char(e.method_id), to_char(e.bdat, 'dd.mm.yyyy'));

    if (e.base_rate is not null and e.method_id in (0, 1)) then

        l_ir := getbrat(e.bdat, e.base_rate, p_curid, p_saldo);

        if e.indv_rate > 0 then
           l_ir := case when e.oper_id = 1 then l_ir + e.indv_rate
                        when e.oper_id = 2 then l_ir - e.indv_rate
                        when e.oper_id = 3 then l_ir * e.indv_rate
                        when e.oper_id = 4 then l_ir / e.indv_rate
                    end;
        end if;

        l_op := null;
        l_br := null;

    else

        l_ir := e.indv_rate;
        l_op := e.oper_id;
        l_br := e.base_rate;

    end if;
    bars_audit.trace('%s %s: ir=%s, op=%s, br=%s', title, to_char(e.bdat, 'dd.mm.yyyy'),
                     to_char(l_ir), to_char(l_op), to_char(l_br));

    insert into int_ratn (acc, id, bdat, ir, op, br)
    values (p_accid, l_intid, p_datint, l_ir, l_op, l_br);

    l_date := get_datend_uni (p_datint, e.term_mnth, e.term_days, p_typeid);
    bars_audit.trace('%s dat_ext_int = %s', title, to_char(l_date, 'dd.mm.yyyy'));

    update dpt_deposit set
           cnt_ext_int = p_cntint,
           dat_ext_int = l_date
     where deposit_id  = p_dptid;

  end loop;

  insert into dpt_extension_log
   (id, dat, deposit_id, kod, n_dubl, dat_begin, dat_end, rate)
  values
   (user_id, sysdate, p_dptid, 1, p_cntint, p_datint, l_date, l_ir);

  if l_date < p_datend then
     iextratereview (p_dptid   => p_dptid,
                     p_accid   => p_accid,
                     p_curid   => p_curid,
                     p_saldo   => p_saldo,
                     p_typeid  => p_typeid,
                     p_extid   => p_extid,
                     p_inidat  => p_inidat,
                     p_datend  => p_datend,
                     p_cntint  => p_cntint + 1,
                     p_datint  => l_date,
                     p_mnthcnt => p_mnthcnt,
                     p_dayscnt => p_dayscnt);
  end if;

  bars_audit.trace('%s exit', title);

end iextratereview;
--
--  внутр.процедура исключения даты для начисления при переоформления вкладов
--
procedure iexcludeintday
 (p_accid in int_ratn.acc%type,
  p_date  in int_ratn.bdat%type)
is
  title     varchar2(60)   := 'dpt.ext.exclintday:';
  l_maxrow  int_ratn%rowtype;
begin

  bars_audit.trace('%s entry, accid=>%s, date=>%s', title,
                   to_char(p_accid), to_char(p_date,'dd.mm.yyyy'));

  -- ставка, которая действовала НА указанную дату (м.б. равна дате)
  -- обязательно существует
  select *
    into l_maxrow
    from int_ratn
   where acc = p_accid
     and id = 1
     and bdat = (select max(bdat)
                        from int_ratn
                       where acc = p_accid
                         and id = 1
                         and bdat <= p_date);

  begin
    insert into int_ratn (acc, id, bdat, ir, op, br)
    values (l_maxrow.acc, l_maxrow.id, p_date + 1, l_maxrow.ir, l_maxrow.op, l_maxrow.br);
  exception
    when dup_val_on_index then null;
  end;

  begin
     insert into int_ratn (acc, id, bdat, ir, op, br)
     values (p_accid, 1, p_date, 0, null, null);
  exception
    when dup_val_on_index then
      update int_ratn
         set ir = 0,
             op = null,
             br = null
       where acc = p_accid and id = 1 and bdat = p_date;
  end;

  bars_audit.trace('%s exit', title);

end iexcludeintday;
--
-- внутр.процедура оплаты платежа (накрутка оборотов) при переоформления вкладов
--
procedure ipayextdoc
  (p_dptid     in  dpt_deposit.deposit_id%type,
   p_accnum    in  accounts.nls%type,
   p_acccur    in  accounts.kv%type,
   p_accname   in  accounts.nms%type,
   p_amount    in  accounts.ostc%type,
   p_custcode  in  customer.okpo%type,
   p_tt        in  tts.tt%type,
   p_bankcode  in  banks.mfo%type,
   p_userid    in  staff.id%type,
   p_bdate     in  date,
   p_ref       out oper.ref%type)
is
  title   varchar2(60)   := 'dpt.ext.pay:';
  l_vob     oper.vob%type  := 6;
  l_nazn    oper.nazn%type;
  l_ref     oper.ref%type;
  l_instr   number;
begin

  bars_audit.trace('%s entry, dptid=>%s, amount=>%s', title, to_char(p_dptid), to_char(p_amount));

  -- вид документа
  begin
    select vob
      into l_vob
      from tts_vob
     where tt = p_tt and ord = decode(p_acccur, gl.baseval, 1, 2);
  exception
    when no_data_found or too_many_rows then
      l_vob := 6;
  end;

  -- назначение платежа
  select nazn into l_nazn from tts where tt = p_tt;

  l_instr := instr(l_nazn, '№');
  if l_instr > 0 then
     l_nazn := substr(substr(l_nazn, 1, l_instr)
                    ||to_char(p_dptid)
                    ||substr(l_nazn, l_instr + 1), 1, 160);
  end if;

  gl.ref (l_ref);
  gl.in_doc3 (ref_    => l_ref,
              tt_     => p_tt,
              vob_    => l_vob,
              nd_     => SubStr(to_char(l_ref),1,10),
              pdat_   => sysdate,
              vdat_   => p_bdate,
              dk_     => 1,
              kv_     => p_acccur,
              s_      => p_amount,
              kv2_    => p_acccur,
              s2_     => p_amount,
              sk_     => null,
              data_   => p_bdate,
              datp_   => sysdate,
              nam_a_  => p_accname,
              nlsa_   => p_accnum,
              mfoa_   => p_bankcode,
              nam_b_  => p_accname,
              nlsb_   => p_accnum,
              mfob_   => p_bankcode,
              nazn_   => l_nazn,
              d_rec_  => null,
              id_a_   => p_custcode,
              id_b_   => p_custcode,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => p_userid);

  paytt (null, l_ref, p_bdate, p_tt, 1,
               p_acccur, p_accnum, p_amount,
               p_acccur, p_accnum, p_amount);

  p_ref := l_ref;
  bars_audit.trace('%s exit with ref = %s', title, to_char(p_ref));

end ipayextdoc;
--
-- переоформление депозитных договоров
--
procedure p_dpt_extension
 (p_dptid   in  dpt_deposit.deposit_id%type,  -- идентификатор вклада
  p_datend  in  dpt_deposit.dat_end%type)     -- новая дата окончания вклада
is
  title     varchar2(60)    := 'dpt.ext:';
  l_extt    char(3);
  l_extd    char(1);
  l_extr    char(2);
  l_dubl    number(38);
  l_stpdat  date;
  l_bdate   date            := gl.bdate;
  l_userid  staff.id%type   := gl.auid;
  l_mfo     banks.mfo%type  := gl.amfo;
  l_ref     oper.ref%type;
begin

  bars_audit.trace('%s entry, dptid => %s, datend => %s', title,
                   to_char(p_dptid), to_char(p_datend, 'dd.mm.yyyy'));

  -- получение и валидация конфиг.параметров переоформления вкладов
  igetextparams (l_extt,  -- режим накручивания оборотов
                 l_extd,  -- метод расчета даты начала переоформленного договора
                 l_extr); -- метод начисления процентов в граничные дни
  bars_audit.trace('%s extt=%s, extd=%s, extr=%s', title, l_extt, l_extd, l_extr);

  for dpt_cur in
     (select dpt_id, vidd, acc, kv, nls, nms, okpo, ost, accn,
             dat_start, dat_begin_old datbeg0, dat_end_old datend0,
             dat_begin_new datbeg1, nvl(p_datend, dat_end_new) datend1,
       extension_id, cnt_dubl, cnt_ext_int, dat_ext_int,
             term_m, term_d
        from dpt_auto_extend
       where dpt_id = decode(p_dptid, 0, dpt_id, p_dptid)
       order by 1)
  loop

    bars_audit.trace('%s deposit № %s, (%s, %s) -> (%s, %s)', title,
                     to_char(dpt_cur.dpt_id),
                     to_char(dpt_cur.datbeg0,'dd.mm.yyyy'),
                     to_char(dpt_cur.datend0,'dd.mm.yyyy'),
                     to_char(dpt_cur.datbeg1,'dd.mm.yyyy'),
                     to_char(dpt_cur.datend1,'dd.mm.yyyy'));

    savepoint sp_extension;

    begin
      l_dubl := dpt_cur.cnt_dubl + 1;

      l_stpdat := dpt_cur.datend1 - 1;

      -- изменение дат договора
      update dpt_deposit
         set cnt_dubl   = l_dubl,
             dat_begin  = dpt_cur.datbeg1,
             dat_end    = dpt_cur.datend1
       where deposit_id = dpt_cur.dpt_id;

      update accounts set mdate   = dpt_cur.datend1 where acc = dpt_cur.acc;
      update accounts set mdate   = dpt_cur.datend1 where acc = dpt_cur.accn;
      update int_accn set stp_dat = l_stpdat        where acc = dpt_cur.acc and id = 1;

      -- заполнение неснижаемого и макс.допустимого остатков на деп.счете
      set_dptlimits (p_dptype => dpt_cur.vidd, p_dptacc => dpt_cur.acc);

      -- протокол переоформления
      insert into dpt_extension_log
        (id, dat, deposit_id, kod, n_dubl, dat_begin, dat_end)
      values
        (l_userid, sysdate, dpt_cur.dpt_id, 0, l_dubl, dpt_cur.datbeg1, dpt_cur.datend1);

      -- пролонгация ставки
      if (dpt_cur.extension_id is not null and dpt_cur.dat_ext_int <= l_bdate) then
        bars_audit.trace('%s rate review for deal № %s...', title, to_char(dpt_cur.dpt_id));
        iextratereview (p_dptid   => dpt_cur.dpt_id,
                        p_accid   => dpt_cur.acc,
                        p_curid   => dpt_cur.kv,
                        p_saldo   => dpt_cur.ost,
                        p_typeid  => dpt_cur.vidd,
                        p_extid   => dpt_cur.extension_id,
                        p_inidat  => dpt_cur.dat_start,
                        p_datend  => dpt_cur.datend1,
                        p_cntint  => dpt_cur.cnt_ext_int + 1,
                        p_datint  => dpt_cur.dat_ext_int,
                        p_mnthcnt => dpt_cur.term_m,
                        p_dayscnt => dpt_cur.term_d);
      end if;

      -- обработка граничных дней
      bars_audit.trace('%s managing boundary days for deal № %s...', title, to_char(dpt_cur.dpt_id));

      if (l_extd = 0 and l_extt is null     and l_extr like 'NN')
      or (l_extd = 1 and l_extt is null     and l_extr like 'N_')
      or (l_extd = 1 and l_extt is not null and l_extr like 'NN') then
          bars_audit.trace('%s excluding %s', title, to_char(dpt_cur.datend0, 'dd.mm.yyyy'));
          iexcludeintday (dpt_cur.acc, dpt_cur.datend0);
      elsif (l_extd = 1 and l_extt is null and l_extr like '_N') then
          bars_audit.trace('%s excluding %s', title, to_char(dpt_cur.datbeg1, 'dd.mm.yyyy'));
          iexcludeintday (dpt_cur.acc, dpt_cur.datbeg1);
      else
          bars_audit.trace('%s no exclude', title);
      end if;

      -- учет средств путем накручивания оборотов на депозитном счете
      if l_extt is not null then
         ipayextdoc (p_dptid     => dpt_cur.dpt_id,
                     p_accnum    => dpt_cur.nls,
                     p_acccur    => dpt_cur.kv,
                     p_accname   => dpt_cur.nms,
                     p_amount    => dpt_cur.ost,
                     p_custcode  => dpt_cur.okpo,
                     p_tt        => l_extt,
                     p_bankcode  => l_mfo,
                     p_userid    => l_userid,
                     p_bdate     => l_bdate,
                     p_ref       => l_ref);
         bars_audit.trace('%s doc ref № %s', title, to_char(l_ref));
      end if;

    exception
      when others then
        bars_audit.error('Ошибка при переоформлении вклада № '||to_char(dpt_cur.dpt_id)||': '||sqlerrm);
        rollback to sp_extension;
    end;

  end loop;
  bars_audit.trace('%s exit', title);

end p_dpt_extension;

--
--  Автозаполнение %-ной карточки по вкладам с прогрессивной %ной ставкой
--
procedure p_rate_rise (dpt_id_ number)
is
  int_idn   constant int_ratn.id%type := 1;
  l_accid   dpt_deposit.acc%type;
  l_datbeg  dpt_deposit.dat_begin%type;
  l_datend  dpt_deposit.dat_end%type;
  l_amount  dpt_deposit.limit%type;
  l_vidd    dpt_vidd.vidd%type;
  l_kv      dpt_vidd.kv%type;
  l_fixrate dpt_vidd.basem%type;
  l_raterow int_ratn%rowtype;
begin

  select d.acc, d.dat_begin, d.dat_end, d.limit, v.vidd, v.kv, nvl (v.basem, 0)
    into l_accid, l_datbeg, l_datend, l_amount, l_vidd, l_kv, l_fixrate
    from dpt_deposit d, dpt_vidd v
   where d.vidd = v.vidd and d.deposit_id = dpt_id_;

  for r in
     (select dpt.get_datend_uni (l_datbeg, duration_m, duration_d, l_vidd) bdat,
             br, ir, op
        from dpt_rate_rise
       where vidd = l_vidd
         and id = 1
         and dpt.get_datend_uni (l_datbeg, duration_m, duration_d, l_vidd) <= l_datend
       order by 1)
  loop
      l_raterow.acc := l_accid;
      l_raterow.id := int_idn;
      l_raterow.bdat := r.bdat;

      if l_fixrate = 1 then
         -- фиксированная ставка
         l_raterow.op := null;
         l_raterow.br := null;
         if nvl (r.op, 0) = 0 then
            if r.br >= 0 then
               l_raterow.ir := getbrat (r.bdat, r.br, l_kv, l_amount);
            else
               l_raterow.ir := nvl (r.ir, 0);
            end if;
         else
            if r.op = 1 then
               l_raterow.ir := nvl (r.ir, 0) + getbrat (r.bdat, r.br, l_kv, l_amount);
            elsif r.op = 2 then
               l_raterow.ir := nvl (r.ir, 0) - getbrat (r.bdat, r.br, l_kv, l_amount);
            elsif r.op = 3 then
               l_raterow.ir := nvl (r.ir, 0) * getbrat (r.bdat, r.br, l_kv, l_amount);
            elsif r.op = 4 then
               l_raterow.ir := nvl (r.ir, 0) / getbrat (r.bdat, r.br, l_kv, l_amount);
            end if;
         end if;
      else
         -- плавающая ставка
         l_raterow.ir := r.ir;
         l_raterow.op := r.op;
         l_raterow.br := r.br;
      end if;

      begin
        insert into int_ratn (acc, id, bdat, ir, br, op)
        values (l_raterow.acc, l_raterow.id, l_raterow.bdat,
                l_raterow.ir,  l_raterow.br, l_raterow.op);
      exception
        when dup_val_on_index then
          update int_ratn
             set ir   = l_raterow.ir,
                 op   = l_raterow.op,
                 br   = l_raterow.br
           where acc  = l_raterow.acc
             and id   = l_raterow.id
             and bdat = l_raterow.bdat;
      end;

  end loop;

end p_rate_rise;

--
-- расчет процентной ставки при досрочном расторжении срочного вклада
--
function f_shtraf_rate ( p_dpt_id   number,
                         p_dat      date,
                         p_modcode  varchar2  default 'DPT'
                        )
return number
is
  title         varchar2(60) := 'dpt.shtrafrate:';
  l_accid       dpt_deposit.acc%type;
  l_currency    dpt_deposit.kv%type;
  l_dat1        dpt_deposit.dat_begin%type;
  l_dat2        dpt_deposit.dat_end%type;
  l_stopid      dpt_deposit.stop_id%type;
  l_stoprow     dpt_stop%rowtype;
  l_months      number;
  l_term        number;
  l_dptrate     number;
  l_penaltyrate number;
  l_type        dpt_stop_a.sh_proc%type;
  l_value       dpt_stop_a.k_proc%type;
begin

  bars_audit.trace('%s вклад № %s (%)', title, to_char(p_dpt_id), p_modcode);

  -- параметры вклада
  begin
    If    p_modcode = 'DPT' then  -- депозити ФО
      select acc, kv, dat_begin, dat_end, stop_id
        into l_accid, l_currency, l_dat1, l_dat2, l_stopid
        from dpt_deposit
       where deposit_id  = p_dpt_id;

    ElsIf p_modcode = 'DPU' then  -- депозити ЮО
      select a.acc, a.kv, dat_begin, dat_end, id_stop
        into l_accid, l_currency, l_dat1, l_dat2, l_stopid
        from dpu_deal d,
             accounts a
       where d.dpu_id  = p_dpt_id
         and d.acc     = a.acc;

    Else
      bars_error.raise_nerror( g_modcode, 'INVALID_PENALTY_MODCODE', nvl(p_modcode, 'null') );
    End If;

  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dpt_id));
  end;

  bars_audit.trace('%s штраф № %s, даты %s - %s', title, to_char(l_stopid),
                   to_char(l_dat1, 'dd.mm.yy'), to_char(l_dat2, 'dd.mm.yy'));

  if not (l_dat1 <= p_dat and l_dat2  > p_dat and l_stopid != 0) then
     bars_audit.trace('%s штраф не предусмотрен', title);
     return null;
  end if;

  -- параметры штрафа
  begin
    select * into l_stoprow from dpt_stop where id = l_stopid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'FINEPARAMS_NOT_FOUND', to_char(l_stopid));
  end;

  l_months := months_between(p_dat, l_dat1);

  if (l_stoprow.sh_proc = 1 and trunc(l_months) < 1) then
     bars_audit.trace('%s факт.срок вклад < 1 мес -> полный штраф', title);
     return 0;
  end if;

  l_term := case
            when l_stoprow.fl = 0 then trunc(((p_dat -l_dat1+1)/(l_dat2-l_dat1+1)) * 100)
            when l_stoprow.fl = 1 then round(l_months, 2)
            else                       p_dat - l_dat1 + 1
            end;
  bars_audit.trace('%s относит.срок вклада - %s', title, to_char(l_term)||' '||
                   case when l_stoprow.fl = 0 then '%%'
                        when l_stoprow.fl = 1 then 'мес.'
                        else                       'дн.'
                        end);

  -- расчет типа и значения штрафа для данного периода
  begin
    select s.sh_proc, s.k_proc
      into l_type, l_value
      from dpt_stop_a s
     where s.id = l_stopid
       and s.k_srok = (select max(t.k_srok)
                         from dpt_stop_a t
                        where t.id = s.id
                          and t.k_srok <= l_term
                          and t.k_srok <= (select min(k_srok)
                                             from dpt_stop_a
                                            where k_srok > l_term
                                              and id = s.id));
  exception
    when no_data_found then
    bars_audit.trace('%s вышли за диапазон штрафования', title);
    return null;
  end;

  bars_audit.trace('%s тип - %s, значение %s', title,
                   case
                       when l_type = 1 then 'жесткий штраф'
                       when l_type = 2 then 'мягкий штраф'
                       when l_type = 3 then 'фикс.процент штрафа'
                       when l_type = 5 then 'штраф по баз.ставке'
                       else                 'пустой штраф'
                       end,
                   to_char(l_value));

  if l_type in (1, 2) then
     if l_value = 0 then
        bars_audit.trace('%s штраф не предусмотрен', title);
        return null;
     else
        l_dptrate := acrn.fproc (l_accid, p_dat);
        if l_dptrate is null then
           bars_error.raise_nerror(g_modcode, 'DPTRATE_CALC_ERROR');
        else
           l_penaltyrate := (100 - l_value) * l_dptrate /100;
        end if;
     end if;
  elsif l_type = 3 then
     l_penaltyrate := l_value;
  elsif l_type = 5 then
     begin
       l_penaltyrate := getbrat(p_dat, l_value, l_currency, fost(l_accid, p_dat));
     exception
       when others then
         bars_error.raise_nerror(g_modcode, 'DPTRATE_CALC_ERROR', to_char(l_value));
     end;
  else
     bars_audit.trace('%s невозможно вычислить значение штрафной ставки', title);
     l_penaltyrate := null;
  end if;

  bars_audit.trace('%s штрафная ставка = %s', title, to_char(l_penaltyrate));
  return l_penaltyrate;

end f_shtraf_rate;

--
-- Процедура расчета процентов при досрочном расторжении договора
--
PROCEDURE p_shtraf
  (p_DptId       in  number,   -- номер вклада
   p_FineDate    in  date,     -- дата штрафа
   p_RealProc    out number,   -- начислено по основной ставке
   p_ShtrafProc  out number,   -- начислено по штрафной ставке
   p_Comment     out varchar2) -- подробное описание
IS
   title       varchar2(60) := 'DPT.P_SHTRAF: ';
   l_acc       dpt_deposit.acc%type;
   l_dat_begin dpt_deposit.dat_begin%type;
   l_dat_end   dpt_deposit.dat_end%type;
   l_freq      dpt_deposit.freq%type;
   l_nmk       customer.nmk%type;
   l_acra      int_accn.acra%type;
   l_acr_dat   int_accn.acr_dat%type;
   l_kv        tabval.kv%type;
   l_iso       tabval.lcv%type;
   l_dig       tabval.dig%type;
   l_daos      accounts.daos%type;
   l_stopid    dpt_stop.id%type;
   l_stopname  dpt_stop.name%type;
   l_sh_ost    dpt_stop.sh_ost%type;
   l_sh_full   dpt_stop.sh_proc%type;
   l_sh_srok   dpt_stop.fl%type;
   l_io        NUMBER(1);
   l_period_ideal    NUMBER;
   l_period_real     NUMBER;
   l_period_koef     NUMBER;
   l_FullMonth       NUMBER;
   l_sh_out          NUMBER;
   l_sh_rate         NUMBER;
   l_sh_type         dpt_stop_a.sh_proc%type;
   l_sh_term         dpt_stop_a.k_term%type;
   l_termtype        dpt_stop_a.sh_term%type;
   l_rate            NUMBER;
   l_sum0            NUMBER;
   l_dat0            DATE;
   l_sh_percent      NUMBER;
   l_sh_acr_dat      DATE;
   l_apl_dat         DATE;
BEGIN

  p_Comment := '';
  bars_audit.trace('%s дата расторжения договора № %s - %s',
                   title, to_char(p_DptId), to_char(p_FineDate, 'dd/mm/yyyy'));

  -- 1. Параметры  вклада
  BEGIN
    SELECT d.acc, d.dat_begin, d.dat_end, d.freq, c.nmk, i.acra, i.acr_dat,
           v.kv, decode(v.kv, gl.baseval, 'грн', t.lcv), t.dig,
           NVL(d.stop_id, v.id_stop), a.daos
      INTO l_acc, l_dat_begin, l_dat_end, l_freq, l_nmk, l_acra, l_acr_dat,
           l_kv, l_iso, l_dig, l_stopid, l_daos
      FROM dpt_deposit d, dpt_vidd v, dpt_stop s,
           int_accn i, customer c, tabval t, accounts a
     WHERE d.deposit_id = p_DptId
       AND d.vidd = v.vidd
       AND d.rnk = c.rnk
       AND v.kv = t.kv
       AND v.id_stop = s.id
       AND d.acc = a.acc
       AND a.acc = i.acc
       AND i.id = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_DptId));
  END;
  bars_audit.trace('%s счета (%s, %s), штраф № %s, код период-ти - %s, '||
                   'даты %s - %s, дата посл.начисления = %s',
                   title, to_char(l_acc),      to_char(l_acra),
                          to_char(l_stopid),   to_char(l_freq),
                          to_char(l_dat_begin, 'dd/mm/yyyy'),
                          to_char(l_dat_end,   'dd/mm/yyyy'),
                          to_char(l_acr_dat,   'dd/mm/yyyy'));
  p_Comment := p_Comment||'№ вклада: '||to_char(p_DptId)
                        ||'     ФИО: '||l_nmk
                        ||CHR(13)||CHR(10);


  -- 2. Общая сумма начисленных процентов по основной ставке
  p_Comment := p_Comment||'1. РАСЧЕТ НАЧИСЛЕННЫХ ПРОЦЕНТОВ'||CHR(13)||CHR(10);

  IF (l_dat_begin = l_daos AND l_acc <> l_acra) THEN
     SELECT NVL(SUM(kos),0)/power(10,l_dig)
       INTO p_RealProc
       FROM saldoa
      WHERE acc = l_acra;
  ELSE
     p_Comment := p_Comment||'     переоформленный вклад'||CHR(13)||CHR(10);
     acrn.p_int (l_acc, 1, l_dat_begin, l_acr_dat, p_RealProc, null, 0);
     p_RealProc := nvl(round(p_RealProc), 0)/power(10, l_dig);
  END IF;

  bars_audit.trace( '%s всего начислено = %s.', title, to_char(p_RealProc) );

  p_Comment := p_Comment||'     по вкладу № '||to_char(p_DptId)
                        ||' за период с '||to_char(l_dat_begin,'DD.MM.YYYY')
                        ||' по '||to_char(l_acr_dat,'DD.MM.YYYY')
                        ||CHR(13)||CHR(10)
                        ||'     было начислено '||to_char(round(p_RealProc,l_dig))
                        ||' '||l_iso
                        ||CHR(13)||CHR(10);

  -- уместно ли штрафование
  IF (l_dat_begin >= p_FineDate OR
      l_dat_end <= p_FineDate   OR
      l_dat_end IS NULL)
  THEN
     bars_audit.trace('DPT.P_SHTRAF: штрафование не уместно');
     p_Comment := p_Comment||'Штрафование не уместно по причине:'||CHR(13)||CHR(10)
                           ||' - истек срок действия вклада'     ||CHR(13)||CHR(10)
                           ||' - вклад еще не вступил в действие'||CHR(13)||CHR(10)
                           ||' - вклад бессрочный'               ||CHR(13)||CHR(10)
                           ||CHR(13)||CHR(10);
     p_ShtrafProc := p_RealProc;
     RETURN;
  END IF;

  IF l_acr_dat IS NULL THEN
     l_acr_dat := l_dat_begin - 1;
  END IF;

  -- остаток на счете
  SELECT nvl(fost(l_acc, gl.bdate), 0)
    INTO l_sum0 FROM dual;

  bars_audit.trace( '%s остаток на осн.счете = %s.', title, to_char(l_sum0) );

  -- 3. Карточка штрафа
  BEGIN
    SELECT name, fl, sh_ost, sh_proc
      INTO l_stopname, l_sh_srok, l_sh_ost, l_sh_full
      FROM dpt_stop
     WHERE id = l_stopid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- не найден штраф №
      bars_error.raise_nerror(g_modcode, 'FINE_NOT_FOUND', to_char(l_stopid));
  END;

  bars_audit.trace( '%s вычитали карточку штрафа: %s (l_sh_ost = %s).',
                    title, l_stopname, to_char(l_sh_ost) );

  p_Comment := p_Comment||'2. ТИП ШТРАФА '
                        ||CHR(13)||CHR(10)
                        ||'     '||to_char(l_stopid)||' - '||l_stopname
                        ||CHR(13)||CHR(10);

  -- Заводим штрафную %%-ную карточку
  IF l_dat_begin >= to_date('01/01/2004','dd/MM/yyyy') THEN
     l_io := 1;
  ELSE
     l_io := 0;
  END IF;

  DELETE FROM int_accn WHERE acc = l_acc AND id = 3;

  INSERT INTO int_accn
        (acc, id, basem, basey, metr, io,   freq, tt, acra)
  SELECT acc, 3,  basem, basey, metr, l_io, freq, tt, acra
    FROM int_accn
   WHERE acc = l_acc AND id = 1;

  bars_audit.trace('DPT.P_SHTRAF: завели штрафную %%-ную карточку');

  -- 4. Вычисление сроков вклада
  p_Comment := p_Comment||'3. ВЫЧИСЛЕНИЕ ОТНОСИТЕЛЬНОГО ПЕРИОДА ВКЛАДА (ОПВ)'
                        ||CHR(13)||CHR(10);

  l_period_real := p_FineDate - l_dat_begin + 1;
  l_period_ideal:= l_dat_end  - l_dat_begin + 1;

  bars_audit.trace('DPT.P_SHTRAF: плановый срок вклада = '
                  ||to_char(l_period_real)
                  ||', фактический срок вклада = '
                  ||to_char(l_period_ideal));
  p_Comment := p_Comment
            ||'     Дата начала: '||to_char(l_dat_begin,'DD.MM.YYYY')
            ||', дата окончания: '||to_char(l_dat_end,  'DD.MM.YYYY')
            ||CHR(13)||CHR(10)
            ||'     => Плановый срок = '||to_char(l_period_ideal)||'дн.'
            || CHR(13)||CHR(10)
            ||'     => Фактический срок = '||to_char(l_period_real)||'дн.'
            ||CHR(13)||CHR(10);

  -- Если вклад пролежал меньше 1 мес, то %% не начисляются
  IF l_sh_full = 1 THEN

    SELECT trunc(months_between(p_FineDate,l_dat_begin))
      INTO l_FullMonth
      FROM dual;

    IF l_FullMonth < 1 THEN

      p_ShtrafProc := 0;

      bars_audit.trace('DPT.P_SHTRAF: вклад пролежал меньше 1 мес');
      p_Comment := p_Comment||'   Штраф <До мес - 100%>'
                            ||'. Вклад вылежал '||to_char(l_FullMonth)||' мес.'
                            ||CHR(13)||CHR(10)
                            ||'     => по штрафной ставке выплатим '
                            ||to_char(p_ShtrafProc)||' '||l_iso
                            ||CHR(13)||CHR(10);

      RETURN;

    END IF;

  END IF;

  -- Относительный период вклада
  IF l_sh_srok = 0 THEN
  -- в % від строку
     l_period_koef := trunc((l_period_real / l_period_ideal) * 100);

     bars_audit.trace('DPT.P_SHTRAF: ОПВ = '||to_char(l_period_koef)||' %%');
     p_Comment := p_Comment||'     ОПВ = '||l_period_koef||' %%';

  ELSIF l_sh_srok = 1 THEN
  -- в місяцях
     l_period_koef := round(months_between(p_FineDate,l_dat_begin),2);

     bars_audit.trace('DPT.P_SHTRAF: ОПВ = '||to_char(l_period_koef)||' мес.');
     p_Comment := p_Comment||'     ОПВ = '||l_period_koef||' мес.';

  ELSE -- l_sh_srok = 2
  -- в днях
     l_period_koef := p_FineDate-l_dat_begin + 1;

     bars_audit.trace('DPT.P_SHTRAF: ОПВ = '||to_char(l_period_koef)||' дней');
     p_Comment := p_Comment||'     ОПВ = '||l_period_koef||' дней';

  END IF;

  p_Comment := p_Comment||CHR(13)||CHR(10);

  -- 5. Расчет типа и значения штрафа для данного периода
  p_Comment := p_Comment||'4. РАСЧЕТ ТИПА ШТРАФА ДЛЯ ДАННОГО ПЕРИОДА'||CHR(13)||CHR(10);

  BEGIN
    SELECT sh_proc, k_proc, k_term, sh_term
      INTO l_sh_type,
           l_sh_rate,
           l_sh_term,
           l_termtype
      FROM DPT_STOP_A
     WHERE id = l_stopid
       AND k_srok =
          (SELECT max(k_srok) FROM dpt_stop_a
            WHERE id = l_stopid
              AND k_srok <= l_period_koef
              AND k_srok <=
                 (SELECT min(k_srok) FROM dpt_stop_a
                   WHERE k_srok > l_period_koef AND id = l_stopid));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_sh_out  := 1;
      l_sh_rate := 0;
      l_sh_type := 0;

      bars_audit.trace('DPT.P_SHTRAF: вышли за диапазон штрафования');
      p_Comment := p_Comment||'   вышли за диапазон штрафования'||CHR(13)||CHR(10);
  END;

  bars_audit.trace('DPT.P_SHTRAF: рассчитали тип штрафа для данного периода: '
                 ||' l_sh_type = %s, l_sh_rate = %s, '
                 ||' l_sh_term = %s, l_termtype = %s ',
                 to_char(l_sh_type), to_char(l_sh_rate),
                 to_char(l_sh_term), to_char(l_termtype));

  -- 5.1.  Мягкий штраф (по последней ставке)
  IF l_sh_type = 2 THEN

    SELECT dpt.fproc(l_acc, gl.bdate) INTO l_rate FROM dual;
    l_sh_percent := ((100 - l_sh_rate) * l_rate)/100;

    bars_audit.trace('DPT.P_SHTRAF: мягкий штраф, '
                   ||'текущая ставка = '||to_char(l_rate)||'%, '
                   ||'коэффициент штрафа = '||to_char(l_sh_rate)
                   ||' => штрафная ставка = '||l_sh_percent||'%');
    p_Comment:=p_Comment||'   МЯГКИЙ ШТРАФ (по последней ставке)'
                        ||CHR(13)||CHR(10)
                        ||'     текущая ставка = '||l_rate||'%'
                        ||', коэффициент штрафа = '||l_sh_rate
                        ||CHR(13)||CHR(10)
                        ||'     => штрафная ставка = '||l_sh_percent
                        ||CHR(13)||CHR(10);

    INSERT INTO int_ratn (acc, id, bdat, ir)
    VALUES (l_acc, 3, l_dat_begin, l_sh_percent);

  END IF;

  -- 5.2. Жесткий штраф (по ист.ставки)
  IF l_sh_type = 1 THEN

    bars_audit.trace('DPT.P_SHTRAF: жесткий штраф, '
                   ||'коэффициент штрафа = '||to_char(l_sh_rate));
    p_Comment := p_Comment||'   ЖЕСТКИЙ  ШТРАФ (по истории ставок)'
                          ||CHR(13)||CHR(10)
                          ||'     коэффициент штрафа = '||l_sh_rate
                          ||CHR(13)||CHR(10);
    FOR c IN
       (SELECT bdat, dpt.fproc(l_acc,bdat) RATE
          FROM int_ratn
         WHERE acc = l_acc AND bdat <= p_FineDate
         ORDER BY bdat)
    LOOP
      l_sh_percent := ((100 - l_sh_rate) * c.rate)/100;

      bars_audit.trace('DPT.P_SHTRAF: жесткий штраф, '
                     ||'на '||to_char(c.bdat,'dd/mm/yyyy')
                     ||' текущая ставка = '||to_char(c.rate)
                     ||' => штрафная ставка = '||to_char(l_sh_percent)||'%');
      p_Comment := p_Comment
                ||'     на '||c.bdat ||' текущая ставка = '||c.rate
                ||CHR(13)||CHR(10)
                ||'     => штрафная ставка = '||l_sh_percent
                ||CHR(13)||CHR(10);

      INSERT INTO int_ratn (acc, id, bdat, ir)
      VALUES (l_acc, 3, c.bdat, l_sh_percent);

   END LOOP;

  END IF;

  -- 5.3. Фиксированный процент штрафа
--IF l_sh_type = 3 THEN
  IF ( l_sh_type = 3 AND l_termtype != 2 ) THEN

    l_sh_percent := l_sh_rate;

    bars_audit.trace('DPT.P_SHTRAF: фиксированный процент штрафа, '
                   ||' => штрафная ставка = '||to_char(l_sh_percent)||'%');
    p_Comment := p_Comment||'   ФИКСИРОВАННЫЙ ПРОЦЕНТ ШТРАФА'
                          ||CHR(13)||CHR(10)
                          ||'     => штрафная ставка = '||l_sh_percent
                          ||CHR(13)||CHR(10);

    INSERT INTO int_ratn (acc, id, bdat, ir)
    VALUES (l_acc, 3, l_dat_begin, l_sh_percent);

  END IF;

  -- 5.4. Штраф по указанной базовой %-ой ставке
  IF l_sh_type = 5 THEN

    SELECT getbrat (p_FineDate, l_sh_rate, l_kv ,l_sum0)
      INTO l_sh_percent
      FROM dual;

    bars_audit.trace('DPT.P_SHTRAF: штраф по базовой %-ой ставки, '
                   ||'код баз.ставки = '||to_char(l_sh_rate)
                   ||' => штрафная ставка = '||to_char(l_sh_percent, 'FM90D00')||'%');
    p_Comment := p_Comment||'   ШТРАФ ПО ЗНАЧЕНИЮ БАЗОВОЙ СТАВКИ (БС)'
                          ||CHR(13)||CHR(10)
                          ||'     код БС = '||l_sh_rate
                          ||', значение = '||l_sh_percent
                          ||CHR(13)||CHR(10)
                          ||'     => штрафная ставка = '||l_sh_percent
                          ||CHR(13)||CHR(10);

   INSERT INTO int_ratn (acc, id, bdat, ir)
   VALUES (l_acc, 3, l_dat_begin, l_sh_percent);

  END IF;

  -- 6. Расчет штрафного периода
  p_Comment := p_Comment||'5. РАСЧЕТ ШТРАФНОГО ПЕРИОДА'||CHR(13)||CHR(10);

  CASE
    WHEN l_termtype = 2
    THEN -- Строк штрафу (Штраф стягується виходячи з параметру "строк штрафа")

      bars_audit.trace('DPT.P_SHTRAF: cрок штрафа = '||to_char(l_sh_term));
      p_Comment := p_Comment||'     cрок штрафа = '||l_sh_term||CHR(13)||CHR(10);

      IF l_sh_srok = 1 THEN
      -- термін вказаний у місяцях

        CASE
          WHEN l_sh_term < 0 THEN
          -- якщо термін штрафу відємний то нараховуєм %% по штрафній ставці за вилежаний період мінус термін штрафу
            l_apl_dat := add_months(l_dat_begin, nvl(ABS(l_sh_term),0));
          WHEN l_sh_term > 0 THEN
            l_apl_dat := add_months(l_acr_dat, -nvl(l_sh_term,0));
          ELSE -- l_sh_term = 0
            l_apl_dat := l_dat_begin;
        END CASE;

        l_sh_acr_dat := l_acr_dat;

        bars_audit.trace( 'DPT.P_SHTRAF: (М) штрафний період з '||to_char(l_apl_dat,'dd/mm/yyyy')||' по '||to_char(l_sh_acr_dat,'dd/mm/yyyy') );

        p_Comment := p_Comment ||'      (М) штрафний період з '||to_char(l_apl_dat,'dd/mm/yyyy')
                               ||' по '||to_char(l_sh_acr_dat,'dd/mm/yyyy')
                               ||CHR(13)||CHR(10);

      ELSIF l_sh_srok = 2 THEN
      -- срок задан в днях

        CASE
          WHEN l_sh_term < 0 THEN
          -- якщо термін штрафу відємний то нараховуєм %% по штрафній ставці за вилежаний період мінус термін штрафу
            l_apl_dat := l_dat_begin + nvl(ABS(l_sh_term),0);
          WHEN l_sh_term > 0 THEN
            l_apl_dat := l_acr_dat - nvl(l_sh_term,0);
          ELSE
            l_apl_dat := l_dat_begin;
        END CASE;

        l_sh_acr_dat := l_acr_dat;

        bars_audit.trace( 'DPT.P_SHTRAF: (Д) штрафний період з '||to_char(l_apl_dat,'dd/mm/yyyy')||' по '||to_char(l_sh_acr_dat,'dd/mm/yyyy') );

        p_Comment := p_Comment ||'      (Д) штрафний період з '||to_char(l_apl_dat,'dd/mm/yyyy')
                               ||' по '||to_char(l_sh_acr_dat,'dd/mm/yyyy')
                               ||CHR(13)||CHR(10);

      ELSE
        -- некорректно описан штраф
        bars_error.raise_nerror(g_modcode, 'INVALID_FINE');
      END IF;

      --
      INSERT INTO int_ratn
           ( acc, id, bdat, ir, br, op )
      SELECT acc,  3, bdat, ir, br, op
        FROM int_ratn
       WHERE acc = l_acc
         AND id  = 1
         AND bdat < l_apl_dat;

      INSERT INTO int_ratn
        ( acc, id, bdat, ir )
      VALUES
        ( l_acc, 3, l_apl_dat, l_sh_rate );

    WHEN l_termtype = 1
    THEN -- Розрахуноквий період  (Штраф розраховується за останній розрахунковий період)

      bars_audit.trace('DPT.P_SHTRAF: расчетный период '||to_char(l_sh_term));
      p_Comment := p_Comment||'     расчетный период '||l_sh_term||CHR(13)||CHR(10);

      l_apl_dat :=
      CASE
        WHEN (l_freq = 3  ) THEN l_dat_begin +           7*trunc((gl.bdate-l_dat_begin)/7,0)
        WHEN (l_freq = 5  ) THEN add_months(l_dat_begin, 1*trunc(months_between(gl.bdate,l_dat_begin),0))
        WHEN (l_freq = 7  ) THEN add_months(l_dat_begin, 3*trunc(months_between(gl.bdate,l_dat_begin)/3,0))
        WHEN (l_freq = 180) THEN add_months(l_dat_begin, 6*trunc(months_between(gl.bdate,l_dat_begin)/6,0))
        WHEN (l_freq = 360) THEN add_months(l_dat_begin,12*trunc(months_between(gl.bdate,l_dat_begin)/12,0))
        WHEN (l_freq = 400) THEN l_dat_end
        ELSE l_dat_begin
      END;
      l_sh_acr_dat := l_apl_dat;

      bars_audit.trace('DPT.P_SHTRAF: выплатим по '||to_char(l_apl_dat,'dd/mm/yyyy'));
      p_Comment := p_Comment||'     выплатим %% по '||l_apl_dat||CHR(13)||CHR(10);

    WHEN l_termtype = 3
    THEN -- Неповний рік (Виплата відсотків відбувається за повний рік)

      bars_audit.trace('DPT.P_SHTRAF: штраф неповний рік '||to_char(l_sh_term));
      p_Comment := p_Comment||'     штраф за незакрытый год '||l_sh_term||CHR(13)||CHR(10);

      l_apl_dat := add_months( l_dat_begin,
                               12 * trunc(months_between(gl.bdate,l_dat_begin)/12,0) -- к-ть повних років
                             );

      bars_audit.trace('DPT.P_SHTRAF: выплатим по '||to_char(l_apl_dat,'dd/mm/yyyy'));
      p_Comment := p_Comment||'     выплатим %% по '||l_apl_dat||CHR(13)||CHR(10);

      l_sh_acr_dat := l_apl_dat;

    WHEN l_termtype = 0
    THEN -- Фактичний період (Штраф розраховується за час фактичного строку вкладу)

      IF l_acr_dat > (p_FineDate - 1) THEN
         l_sh_acr_dat := p_FineDate - 1;
      ELSE
         l_sh_acr_dat := l_acr_dat;
      END IF;

      bars_audit.trace('DPT.P_SHTRAF: фактический срок, начислим %% по '
                     ||to_char(l_sh_acr_dat,'dd/mm/yyyy'));
      p_Comment := p_Comment||'     фактический срок'||CHR(13)||CHR(10)
                            ||'начислим %% по '
                            ||to_char(l_sh_acr_dat,'dd/mm/yyyy')||CHR(13)||CHR(10);
    ELSE -- некорректно описан штраф
      bars_error.raise_nerror(g_modcode, 'INVALID_FINE');

  END CASE;

  -- 7. Расчет штрафных процентов в зависимости от типа остатка
  p_Comment := p_Comment||'6. ТИП ОСТАТКА ДЛЯ РАСЧЕТА ШТРАФА'||CHR(13)||CHR(10);

  IF l_sh_ost = 1 THEN

    BEGIN
      SELECT fdat, kos INTO l_dat0, l_sum0 FROM saldoa
       WHERE acc = l_acc AND kos > 0 AND
             fdat = (SELECT min(fdat) FROM saldoa
                      WHERE acc = l_acc AND kos > 0);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- не найдена сумма первичного взноса
        bars_error.raise_nerror(g_modcode, 'FIRST_PAYMENT_NOT_FOUND');
    END;

    acrn.p_int (l_acc, 3, l_dat0 + 1, l_sh_acr_dat, l_sh_rate, l_sum0, 0);

    bars_audit.trace('DPT.P_SHTRAF: штраф по сумме перв.взноса = '||to_char(l_sum0));
    p_Comment := p_Comment
              ||'     штраф по сумме первичного взноса = '
              ||to_char(round(l_sum0/power(10,l_dig),l_dig))||' '||l_iso;

  ELSIF l_sh_ost = 2 THEN

    acrn.p_int (l_acc, 3, l_dat_begin, l_sh_acr_dat, l_sh_rate, NULL, 0);

    bars_audit.trace('DPT.P_SHTRAF: штраф по истории остатка');

    p_Comment := p_Comment || '     штраф по истории остатка';

  ELSE
  -- l_sh_ost = 3

    acrn.p_int( l_acc, 3, l_dat_begin, l_sh_acr_dat, l_sh_rate, l_sum0, 0 );

    bars_audit.trace('DPT.P_SHTRAF: штраф по текущему остатку = '||to_char(l_sum0) );

    p_Comment := p_Comment
              ||'     штраф по текущему остатку '
              ||CHR(13)||CHR(10)
              ||'       текущий остаток = '
              ||to_char(round(l_sum0/power(10,l_dig),l_dig))||' '||l_iso;

  END IF;

  bars_audit.trace('DPT.P_SHTRAF: по штрафной ставке выплатим '||to_char(round(l_sh_rate)));
  p_Comment := p_Comment
            ||CHR(13)||CHR(10)
            ||'     => по штрафній ставці за период з '||to_char(l_dat_begin,'DD/MM/YYYY')
            ||' по '||to_char(l_sh_acr_dat,'DD/MM/YYYY')
            ||' виплатим '||to_char(round(l_sh_rate/power(10,l_dig),l_dig))||' '||l_iso
            ||CHR(13)||CHR(10);

  -- Финита-ля-комедия
  IF l_sh_out = 1 THEN
     p_ShtrafProc := p_RealProc;
  ELSE
     p_ShtrafProc := round(l_sh_rate/power(10,l_dig),l_dig);
  END IF;

  bars_audit.trace('DPT.P_SHTRAF: ИТОГО: выплатим сумму = '||to_char(p_ShtrafProc));

  p_Comment := p_Comment||'ИТОГО: выплатим сумму = '||to_char(p_ShtrafProc)||' '||l_iso||CHR(13)||CHR(10);


  rollback;

END p_shtraf;

--
-- Процедура перерасчета начисленных %% при частичном снятии со вклада
--
PROCEDURE p_write_down (dpt_id_ NUMBER, fine_dat_ DATE)
IS
 kv980_ NUMBER(3);
 okpob_ VARCHAR2(14);
 ost_   NUMBER;        delta_  NUMBER;  real_proc_    NUMBER;  ostPlD_  NUMBER;
 ostn_  NUMBER;        rest_   NUMBER;  shtraf_proc_  NUMBER;  ostPlN_  NUMBER;
 nlsa_  VARCHAR2(15);  kva_    NUMBER;  nmsa_   VARCHAR2(38);
 nlsb_  VARCHAR2(15);  kvb_    NUMBER;  nmsb_   VARCHAR2(38);
 nlsc_  VARCHAR2(15);  deltaQ_ NUMBER;  nmsc_   VARCHAR2(38);
 nazn_  VARCHAR2(160); ratO_   NUMBER;
 ref_   NUMBER;        ratB_   NUMBER;
 tt_    CHAR(3);       ratS_   NUMBER;
 mfo_   VARCHAR(12);
 vob_   NUMBER;
 bdat_  DATE;
 ir_    NUMBER;
 pay_demand_ NUMBER;
 dpt_demand_ NUMBER;  nls_demand_ VARCHAR2(15);  nms_demand_ VARCHAR2(38);
BEGIN

 SELECT substr(val,1,15) INTO okpob_ FROM params WHERE par='OKPO';
 SELECT to_number(val)   INTO kv980_ FROM params WHERE par='BASEVAL';

 FOR k IN
    (SELECT d.acc, d.dat_begin, d.dat_end, v.vidd, v.br_wd, v.kv,
            i.acra, i.acrb, i.acr_dat, c.nmk, c.okpo
       FROM dpt_deposit d, dpt_vidd v, int_accn i, customer c
      WHERE d.deposit_id=dpt_id_
        AND v.vidd=d.vidd
        AND d.rnk=c.rnk
        AND i.acc=d.acc
        AND i.id=1)
 LOOP
    IF k.dat_end <= fine_dat_ OR k.br_wd IS NULL THEN
       RETURN;
    END IF;

    -- Текущий остаток вклада
    SELECT nvl(fost(k.acc,fine_dat_),0) INTO ost_ FROM dual;

    -- Текущий остаток счета начисленных %%
    IF k.acc<>k.acra THEN
       SELECT sum(kos) INTO real_proc_ FROM saldoa WHERE acc=k.acra;
    ELSE
       SELECT sum(s) INTO real_proc_ FROM opldok
       WHERE substr(tt,1,1)='%' AND dk=1 AND acc=k.acc;
    END IF;

    -- %-ная ставка частичного снятия
    SELECT getbrat (fine_dat_, k.br_wd, k.kv ,ost_) INTO ir_ FROM dual;

    -- Расчет %% по ставке частичного снятия
    DELETE FROM int_accn WHERE acc=k.acc AND id=3;

    INSERT INTO int_accn
          (acc,  id, metr, basey, freq, io, tt, acra)
    SELECT k.acc, 3, metr, basey, 1,    io, tt, acra
      FROM int_accn
     WHERE acc = k.acc AND id = 1;

    INSERT INTO int_ratn (acc, id, bdat, ir)
    VALUES (k.acc, 3, k.dat_begin, ir_);

    acrn.p_int (k.acc, 3, k.dat_begin, k.acr_dat, shtraf_proc_, NULL, 0);

    delta_:=real_proc_ - shtraf_proc_;
    ROLLBACK;

    IF delta_ > 0 THEN
       nazn_ :='Списання відсотків при частковій виплаті вкладу згідно умов договору №' ||dpt_id_;
       tt_:='DPY';
       mfo_:=gl.aMFO;
       gl.ref (ref_);
       IF k.kv=kv980_ THEN
          vob_:=6;
       ELSE
          vob_:=16;
       END IF;

       SELECT a.nls, a.kv, substr(a.nms,1,38), a.ostb,
              b.nls, b.kv, substr(b.nms,1,38),
              c.nls,       substr(c.nms,1,38)
         INTO nlsa_, kva_, nmsa_, ostn_, nlsb_, kvb_, nmsb_, nlsc_, nmsc_
         FROM accounts a, accounts b, accounts c
  WHERE a.acc=k.acra AND b.acc=k.acrb AND c.acc=k.acc;

       gl.x_rat(ratO_, ratB_, ratS_, kva_, kvb_, gl.bdate);
       deltaQ_ := delta_ * ratO_;

       INSERT INTO oper
           (ref, tt, vob, nd, dk, pdat, vdat, datd,
      nam_a, nlsa, mfoa, id_a, nam_b, nlsb, mfob, id_b,
      kv, s, kv2, s2, nazn, userid, sos)
       VALUES
           (ref_, tt_, vob_, ref_, 1, sysdate, gl.bdate, gl.bdate,
      nmsa_, nlsa_, mfo_, k.okpo, nmsb_, nlsb_, mfo_, okpob_,
      kva_, delta_, kvb_, deltaQ_, nazn_, user_id, 1);

       rest_ := greatest(delta_ - ostn_ ,0);

       IF rest_ > 0 THEN
       paytt(NULL, ref_, gl.bdate, tt_, 1, kva_, nlsc_, rest_, kva_, nlsa_, NULL);
       END IF;

       paytt(NULL, ref_, gl.bdate, tt_, 1, kva_, nlsa_, delta_, kvb_, nlsb_, NULL);

       --gl.pay(0, ref_, gl.bdate);
    END IF;

    -- Переброска на вклад "На вимогу"
    BEGIN
      SELECT dpt_d, nls_d, nms_d, 1
        INTO dpt_demand_, nls_demand_, nms_demand_, pay_demand_
        FROM dpt_deposit
       WHERE deposit_id = dpt_id_ AND (dpt_d IS NOT NULL OR nls_d IS NOT NULL);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN pay_demand_:=0;
    END;

    IF pay_demand_ = 1  THEN

       ostPlD_  := ost_ - rest_;
       ostPlN_ := ostn_ - delta_;

       IF ostPlD_ > 0 THEN
          gl.ref (ref_);
          nazn_ :='Перенесення коштів з депозиту №' ||dpt_id_||' на поточний рахунок';
          INSERT INTO oper
           (ref, tt, vob, nd, dk, pdat, vdat, datd, nazn, userid,
            kv,   s, nam_a, nlsa, mfoa, id_a,
            kv2, s2, nam_b, nlsb, mfob, id_b)
          VALUES
           (ref_, 'DPX', 6, ref_, 1, sysdate, gl.bdate, gl.bdate, nazn_, USER_ID,
            k.kv, ostPlD_, nmsc_, nlsc_, gl.amfo, k.okpo,
            k.kv, ostPlD_, nms_demand_,  nls_demand_,  gl.amfo, k.okpo);
          paytt(null,ref_,gl.bdate,'DPX',1,k.kv,nlsc_,ostPlD_,k.kv,nls_demand_,ostPlD_);

          IF ostPlN_ > 0 THEN
            paytt(null,ref_,gl.bdate,'DPX',1,k.kv,nlsa_,ostPlN_,k.kv,nls_demand_,ostPlN_);
          END IF;
       END IF;
 END IF;

  -- Изменение %-ной карточки
  bdat_:= NVL(k.acr_dat+1,k.dat_begin);

  BEGIN
    INSERT INTO int_ratn (acc,id, bdat,ir ) VALUES (k.acc, 1, bdat_, ir_);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      UPDATE int_ratn SET br=NULL, op=NULL, ir=ir_ WHERE acc=k.acc AND id=1 AND bdat=bdat_;
  END;

 END LOOP;
END p_write_down;
--
-- Генерация номеров  и наименований депозитных счетов
--
function f_nls
 (p_type   in  char,                        -- NLS/NMS - номер/название счета
  p_rnk    in  accounts.rnk%type,           -- регистр.№ клиента
  p_nbs    in  accounts.nbs%type,           -- балансовый счет
  p_dptid  in  dpt_deposit.deposit_id%type, -- идентификатор вклада
  p_nd     in  dpt_deposit.nd%type,         -- номер договора
  p_curid  in  dpt_deposit.kv%type)         -- код валюты
  return varchar2
is
  title constant varchar2(60) := 'dpt.nls:';
  l_mfo constant banks.mfo%type := gl.amfo;
  l_nls accounts.nls%type;
  l_nms accounts.nms%type;
begin

  bars_audit.trace('%s entry, type=>%s,rnk=>%s,nbs=>%s,dptid=>%s,nd=>%s,curid=>%s',
                   title,p_type,to_char(p_rnk),p_nbs,to_char(p_dptid),p_nd,to_char(p_curid));

  if p_type = 'NLS' then
     -- передаем идентификатор договора
     l_nls := substr(f_newnls2 (0, 'DPT', p_nbs, p_rnk, p_dptid, p_curid), 1, 14);
     l_nls := vkrzn (substr(l_mfo, 1, 5), l_nls);
     bars_audit.trace('%s exit with %s', title, l_nls);
     return (l_nls);
  else
    l_nms := substr(f_newnms (0, 'DPT', p_nbs, p_rnk, p_nd), 1, 70);
    bars_audit.trace('%s exit with %s', title, l_nms);
    return (l_nms);
  end if;

end f_nls;

--
-- Переброска капитала и нач.%% с просроченных депозитов на текущие счета
--                      ВЫПОЛНЯЕТСЯ НА СТАРТЕ ДНЯ
procedure p_2620
 (acc_ int,
  dat_ date)
is
  title      varchar2(60)     := 'dpt.p2620:';
  l_mfo      oper.mfoa%type   := gl.amfo;
  l_userid   oper.userid%type := gl.auid;
  l_bdate    oper.vdat%type   := gl.bdate;
  l_tt       oper.tt%type     := 'DPX';
  l_ref      oper.ref%type;
  l_nazn     oper.nazn%type;
  l_dmndnum  oper.nlsb%type;
  l_dmndnam  oper.nam_b%type;
  l_amount1m oper.s%type;
  l_amount1d oper.s%type;
  l_amount2m oper.s%type;
  l_allowed  boolean;
  type  t_dptrec  is record (dptid     dpt_deposit.deposit_id%type,
                             custid    customer.okpo%type,
                             dmnddpt   dpt_deposit.dpt_d%type,
                             dmndacc   dpt_deposit.nls_d%type,
                             depnum    accounts.nls%type,
                             depcur    accounts.kv%type,
                             depnam    accounts.nms%type,
                             depsal    accounts.ostb%type,
                             depdaos   accounts.daos%type,
                             intnum    accounts.nls%type,
                             intcur    accounts.kv%type,
                             intnam    accounts.nms%type,
                             intsal    accounts.ostb%type,
                             typeid    dpt_vidd.vidd%type,
                             extflg    dpt_vidd.fl_dubl%type,
                             extcnt    dpt_vidd.term_dubl%type,
                             termonth  number,
                             termdays  number);
  type  t_dpttbl is table of t_dptrec;
  l_dpt t_dpttbl;
  --
  -- оплата документа DPX
  --
  procedure ipaydpx
   (p_nlsa   in  oper.nlsa%type,
    p_nama   in  oper.nam_a%type,
    p_nlsb   in  oper.nlsb%type,
    p_namb   in  oper.nam_b%type,
    p_okpo   in  oper.id_a%type,
    p_cur    in  oper.kv%type,
    p_sum    in  oper.s%type,
    p_nazn   in  oper.nazn%type,
    p_ref    out oper.ref%type)
  is
    l_ref oper.ref%type;
  begin
    gl.ref (l_ref);
    insert into oper
      (ref, tt, vob, nd, dk,
       pdat, vdat, datd, nazn, userid,
       kv,   s, nam_a, nlsa, mfoa, id_a,
       kv2, s2, nam_b, nlsb, mfob, id_b)
    values
      (l_ref, l_tt, 6, to_char(l_ref), 1,
       sysdate, l_bdate, l_bdate, p_nazn, l_userid,
       p_cur, p_sum, p_nama, p_nlsa, l_mfo, p_okpo,
       p_cur, p_sum, p_namb, p_nlsb, l_mfo, p_okpo);
    paytt(null, l_ref, l_bdate, l_tt, 1,
                p_cur, p_nlsa, p_sum,
                p_cur, p_nlsb, p_sum);
    p_ref := l_ref;
  end ipaydpx;
  ---
begin

  bars_audit.trace('%s entry, acc=>%s, dat=>%s', title, to_char(acc_), to_char(dat_,'dd.mm.yyyy'));

  select d.deposit_id, c.okpo, d.dpt_d, d.nls_d,
         da.nls, da.kv, substr(da.nms, 1, 38), da.ostb, da.daos,
         pa.nls, pa.kv, substr(pa.nms, 1, 38), pa.ostb,
         v.vidd, v.fl_dubl, nvl(term_dubl, 0),
         decode(v.term_type, 1, nvl(v.duration, 0), 0),
         decode(v.term_type, 1, nvl(v.duration_days, 0), (d.dat_end - d.dat_begin))
    bulk collect
    into l_dpt
    from dpt_deposit d,
         customer    c,
         dpt_vidd    v,
         saldo       da,
         int_accn    i,
         accounts    pa
   where d.rnk   = c.rnk
     and d.vidd  = v.vidd
     and d.acc   = da.acc
     and da.acc  = i.acc
     and i.id    = 1
     and i.acra  = pa.acc
     and da.dazs is null
     and pa.dazs is null
     and da.ostc = da.ostb
     and pa.ostc = pa.ostb
     and (da.ostc > 0 or pa.ostc > 0)
     and ((d.nls_d is not null and d.mfo_d = l_mfo) or (d.dpt_d is not null))
     and d.dat_end <= dat_
     and d.acc = decode(acc_, 0, d.acc, acc_);

  for i in 1..l_dpt.count loop

      bars_audit.trace('%s deposit № %s...', title, to_char(l_dpt(i).dptid));

      if l_dpt(i).extflg = 0 then
         -- вклад без переоформления
         l_allowed := true;
      else
         if l_dpt(i).extcnt = 0 then
            -- вклад c беcконечным кол-вом переоформлений
            l_allowed := false;
         else
            -- вклад достиг макс.кол-во переоформлений
            if dpt.get_datend_uni( l_dpt(i).depdaos,
                                  (1 + l_dpt(i).extcnt) * l_dpt(i).termonth,
                                  (1 + l_dpt(i).extcnt) * l_dpt(i).termdays,
                                   l_dpt(i).typeid) <= dat_ then
               l_allowed := true;
            else
               l_allowed := false;
            end if;
         end if;
      end if;

      if l_allowed then

         bars_audit.trace('%s moving to 2620 is allowed for dep № %s', title, to_char(l_dpt(i).dptid));

         if l_dpt(i).dmnddpt is not null then
            l_nazn := 'Перенесення коштів з депозиту №'||to_char(l_dpt(i).dptid)
                    ||' на вклад "На вимогу" №'        ||to_char(l_dpt(i).dmnddpt);
            begin
              select a.nls, substr(a.nms, 1, 38)
                into l_dmndnum, l_dmndnam
                from dpt_deposit d, accounts a
               where d.acc        = a.acc
                 and d.deposit_id = l_dpt(i).dmnddpt
                 and a.dazs is null;
            exception
              when no_data_found then
                bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(l_dpt(i).dmnddpt));
            end;
         else
           l_nazn := 'Перенесення коштів з депозиту №' ||to_char(l_dpt(i).dptid)||' на поточний рахунок';
           begin
             select a.nls, substr(a.nms, 1, 38)
               into l_dmndnum, l_dmndnam
               from accounts a
              where a.nls = l_dpt(i).dmndacc
                and a.kv  = l_dpt(i).depcur
                and a.dazs is null;
           exception
              when no_data_found then
               bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND_2', l_dpt(i).dmndacc, to_char(l_dpt(i).depcur));
           end;
         end if;

         l_amount1m := l_dpt(i).depsal;
         l_amount1d := case when l_dpt(i).depsal = 0 then 0 else l_dpt(i).intsal end;
         l_amount2m := case when l_dpt(i).depsal = 0 then l_dpt(i).intsal else 0 end;
         l_ref := null;
         if l_amount1m > 0 then
            ipaydpx (p_nlsa   =>  l_dpt(i).depnum,
                     p_nama   =>  l_dpt(i).depnam,
                     p_nlsb   =>  l_dmndnum,
                     p_namb   =>  l_dmndnam,
                     p_okpo   =>  l_dpt(i).custid,
                     p_cur    =>  l_dpt(i).depcur,
                     p_sum    =>  l_amount1m,
                     p_nazn   =>  l_nazn,
                     p_ref    =>  l_ref);
            if l_amount1d > 0 then
               paytt(null, l_ref, l_bdate, l_tt, 1,
                     l_dpt(i).intcur, l_dpt(i).intnum, l_amount1d,
                     l_dpt(i).intcur, l_dmndnum,       l_amount1d);
            end if;
            bars_audit.trace('%s ref(dep) = %s', title, to_char(l_ref));
         end if;
         l_ref := null;
         if l_amount2m > 0 then
            ipaydpx (p_nlsa   =>  l_dpt(i).intnum,
                     p_nama   =>  l_dpt(i).intnam,
                     p_nlsb   =>  l_dmndnum,
                     p_namb   =>  l_dmndnam,
                     p_okpo   =>  l_dpt(i).custid,
                     p_cur    =>  l_dpt(i).intcur,
                     p_sum    =>  l_amount2m,
                     p_nazn   =>  l_nazn,
                     p_ref    =>  l_ref);
            bars_audit.trace('%s ref(int) = %s', title, to_char(l_ref));
         end if;
      end if; -- allowed
  end loop;

end p_2620;

--
-- проверка допустимости выплаты процентов по вкладу (1-допустима, 0-недопустима)
--
function payoff_enable
 (p_intacc  in  accounts.acc%type,    -- внутр.№ счета начисл.процентов
  p_freq    in  freq.freq%type,       -- период-ть выплаты процентов
  p_avans   in  number,               -- признак авансовой выплаты процентов
  p_begdat  in  date,                 -- дата начала действия вклада
  p_enddat  in  date,                 -- дата окончания действия вклада
  p_curdat  in  date,                 -- банковская дата
  p_extend  in  number default 0)     -- признак переоформленного вклада
  return number
is
  title           varchar2(60) := 'dpt.payoffenable:';
  l_enable        number(1);
  l_freqcnt       number(2);
  l_mnthcnt       number(38);
  l_dayscnt       number(38);
  l_payscnt       number(38);
  l_lastpay       date;
  l_plansal       number(38);
  l_factsal       number(38);
  l_islastyearday boolean;
  l_intpaydat     date;
begin

  bars_audit.trace('%s entry, intacc=>%s,freq=>%s,avans=>%s,term=>%s-%s,curdate=>%s',
                   title, to_char(p_intacc), to_char(p_freq), to_char(p_avans),
                          to_char(p_begdat, 'dd.mm.yy'),
                          to_char(p_enddat, 'dd.mm.yy'),
                          to_char(p_curdat, 'dd.mm.yy'));

  -- ближайшая дата выплаты процентов
  l_intpaydat := get_intpaydate( p_date    => p_curdat,
                                 p_datbeg  => p_begdat,
                                 p_datend  => p_enddat,
                                 p_freqid  => p_freq,
                                 p_advanc  => p_avans,
                                 p_extend  => p_extend,
                                 p_nocash  => 0);
  bars_audit.trace('%s intpaydat = %s', title, to_char(l_intpaydat,'dd.mm.yyyy'));

  if p_curdat >= l_intpaydat then
     l_enable := 1;
  else
     l_enable := 0;
  end if;


  bars_audit.trace('%s exit with %s', title, to_char(l_enable));
  return l_enable;

end payoff_enable;
--
-- формирование назначения платежа для операции безнал.выплаты процентов
--
function get_payoff_details
 (p_dealnum     in  dpt_deposit.nd%type,
  p_dealdat     in  dpt_deposit.datz%type,
  p_defdetails  in  oper.nazn%type)
  return oper.nazn%type
is
  l_details  oper.nazn%type := p_defdetails;
begin

  if l_details is null then
     l_details := substr('Виплата відсотків згідно деп.договору '||p_dealnum||
                         'від '||to_char(p_dealdat, 'dd/mm/yyyy'), 1, 160);
  end if;

  return l_details;

end get_payoff_details;
--
--
--
PROCEDURE p_intpay
   (id_   SMALLINT,
    dat_  DATE,
    tip_  CHAR DEFAULT 'S',
    filt_ VARCHAR2)
IS
  c_title     constant varchar2(60)    := 'dpt(intpay): ';
  c_parname   constant params.par%type := 'MBK_VZAL';
  l_table     varchar2(30);
  l_baseval   tabval.kv%type := gl.baseval;
  l_mfo       banks.mfo%type := gl.amfo;
  l_vobFC     oper.vob%type;
  l_vob       oper.vob%type;
  --------------------------
  l_statement varchar2(2000);
  type       CurDpt is ref cursor;
  l_cursor   CurDpt;
  --------------------------
  l_ready    number(1);
  l_nazn     oper.nazn%type;
  ---------------------------
  k_dptid    dpt_deposit.deposit_id%type;
  k_dptnum   dpt_deposit.nd%type;
  k_dptdat   dpt_deposit.datz%type;
  k_accd     accounts.acc%type;
  k_accp     accounts.acc%type;
  k_vidd     dpt_deposit.vidd%type;
  k_freq     dpt_deposit.freq%type;
  k_datn     dpt_deposit.dat_begin%type;
  k_datk     dpt_deposit.dat_end%type;
  k_nmk      customer.nmk%type;
  k_apldat   date;
  k_tt       oper.tt%type;
  k_nlsa     oper.nlsa%type;   k_nlsb  oper.nlsa%type;
  k_kva      oper.kv%type;     k_kvb   oper.kv2%type;
  k_nmsa     oper.nam_a%type;  k_nmsb  oper.nam_b%type;
  k_okpoa    oper.id_a%type;   k_okpob oper.id_b%type;
  k_mfob     oper.mfob%type;
  k_nazn     oper.nazn%type;
  k_amount   oper.s%type;
  k_dig      tabval.dig%type;

BEGIN
  bars_audit.trace('%s запуск с параметрами (%s, %s, %s, %s)', c_title,
                   to_char(id_), to_char(dat_, 'dd/mm/yyyy'), tip_, filt_);

  DELETE FROM tmp_intpay WHERE id = id_;

  -- вид тикета для вал.документов
  BEGIN
    SELECT val INTO l_vobFC FROM params WHERE par = c_parname;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN l_vobFC := 6;
  END;
  bars_audit.trace('%s тикета для вал.документов - %s', c_title, to_char(l_vobFC));

  IF tip_ = 'A' THEN
     l_table := 'ACCOUNTS';
  ELSE
     l_table := 'SALDO';
  END IF;

  l_statement := 'SELECT d.id, d.nd, d.datz, d.acc, d.accn, d.vidd,            '||
                 '       d.freq, d.datn, d.datk, substr(d.nmk, 1, 38),         '||
                 '       a.nls, a.kv, substr(a.nms,1,38), d.okpo,              '||
                 '       d.mfop, d.nlsp, a.kv, substr(d.nmsp, 1, 38), d.okpop, '||
                 '       d.naznp, a.ostc, d.ttp, nvl(d.apl_dat, d.datn), d.dig '||
                 '  FROM dpt_1 d, '||l_table ||' a '||
                 ' WHERE d.accn = a.acc     '||
                 '   AND a.ostb = a.ostc    '||
                 '   AND a.ostc > 0         '||
                 '   AND d.nlsp IS NOT NULL '|| filt_;

  OPEN l_cursor FOR l_statement;
  LOOP

    FETCH l_cursor
     INTO k_dptid, k_dptnum,  k_dptdat, k_accd,   k_accp, k_vidd,
          k_freq,  k_datn,    k_datk,   k_nmk,
                   k_nlsa,    k_kva,    k_nmsa,   k_okpoa,
          k_mfob,  k_nlsb,    k_kvb,    k_nmsb,   k_okpob,
          k_nazn,  k_amount,  k_tt,     k_apldat, k_dig;

    EXIT WHEN l_cursor%NOTFOUND;

    bars_audit.trace('%s вклад № %s', c_title, to_char(k_dptid));

    -- проверка допустимости выплаты процентов по вкладу
    l_ready := payoff_enable (p_intacc  => k_accp,
                              p_freq    => k_freq,
                              p_avans   => 0,
                              p_begdat  => k_datn,
                              p_enddat  => k_datk,
                              p_curdat  => dat_ );

    IF l_ready = 1 THEN
       bars_audit.trace('%s допустима выплата процентов по вкладу № %s', c_title, to_char(k_dptid));

       l_nazn := get_payoff_details (p_dealnum    => k_dptnum,
                                     p_dealdat    => k_dptdat,
                                     p_defdetails => k_nazn);
       bars_audit.trace('%s назначение платежа - %s', c_title, l_nazn);

       k_nmsa  := case when k_mfob = l_mfo then k_nmsa else k_nmk end;
       k_mfob  := nvl(k_mfob,  l_mfo);
       k_okpob := nvl(k_okpob, k_okpoa);

  -- вид тікета для документів в нац.вал.
  -- внутрішні
       IF k_mfob = l_mfo THEN
          l_vob := CASE WHEN k_kva = l_baseval THEN 6 ELSE l_vobFC END;
  -- зовнішні (VOB береться з картки операції DP6)
       ELSE
         BEGIN
           SELECT vob INTO l_vob
             FROM tts_vob WHERE tt = 'DP6' and ord=1;
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
             l_vob := 6;
         END;
       END IF;
       bars_audit.trace('%s вид обработки - %s', c_title, to_char(l_vob));

       k_tt := nvl(k_tt, get_acrpay_tt (k_mfob, k_nlsb)) ;
       bars_audit.trace('%s код операции - %s', c_title, k_tt);

       INSERT INTO tmp_intpay
          (id, dpt_id, nd, vidd, acc, acca, apl_dat, dat_end,
           tt, dk, vob, nazn, dig,
           mfoa, nlsa, nmsa, okpoa, kva, s,
           mfob, nlsb, nmsb, okpob, kvb, s2)
        VALUES
          (id_, k_dptid, k_dptnum, k_vidd, k_accd, k_accp, null, k_datk,
           k_tt, 1, l_vob, l_nazn, k_dig,
           l_mfo,  k_nlsa, k_nmsa, k_okpoa, k_kva, k_amount,
           k_mfob, k_nlsb, k_nmsb, k_okpob, k_kvb, k_amount);
    END IF;

  END LOOP;
  bars_audit.trace('%s выход', c_title);

END p_intpay;

FUNCTION fproc (acc_ INTEGER, datp_ DATE DEFAULT NULL) RETURN NUMBER
IS
  --***************************************************************************
  -- Функция расчета процентной ставки по счету на указанную банк.дату,
  -- которая учитывает плановый остаток на счете. Полезна для печати договоров.
  -- Version 1.00 (07/05/2003)  INNA
  -- Version 2.00 (10/05/2007)  INNA - ликвидировано обращение к opldok
  -- Version 3.00 (30/07/2007)  INNA - исправлена ошибка округления ставки
  --***************************************************************************
 l_bd    DATE := gl.bdate;
 l_dat   DATE;
 l_kv    accounts.kv%type;
 l_ostc  accounts.ostc%type;
 l_ostb  accounts.ostb%type;
 l_daos  accounts.daos%type;
 l_apap  accounts.pap%type;
 l_ppap  ps.pap%type;
 l_id    SMALLINT;
 l_ir    int_ratn.ir%type;
 l_br    int_ratn.br%type;
 l_op    int_ratn.op%type;
 l_type  brates.br_type%type;
 l_rate  int_ratn.ir%type;
BEGIN

  l_dat := NVL(datp_, l_bd);

  BEGIN
    SELECT a.kv, s.ostf - s.dos + s.kos, p.pap, a.pap, a.daos, a.ostb
      INTO l_kv, l_ostc, l_ppap, l_apap, l_daos, l_ostb
      FROM accounts a,saldoa s,ps p
     WHERE a.acc = s.acc
       AND a.nbs = p.nbs
       AND a.acc = s.acc
       AND a.acc = acc_
       AND s.fdat = (SELECT MAX(fdat) FROM saldoa
                      WHERE acc = acc_ AND fdat <= l_dat);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
  END;

  -- учитываем плановый остаток
  --IF l_dat = l_bd THEN
  --   l_ostc := l_ostb;
  --END IF;
  l_ostc := case when l_ostc = 0 then l_ostb else l_ostc end;

  IF    l_ostc < 0
    OR  l_ostc = 0 AND l_ppap = 1
    OR  l_ostc = 0 AND l_ppap = 3 AND l_apap = 1  THEN l_id := 0;
  ELSIF l_ostc > 0
    OR  l_ostc = 0 AND l_ppap = 2
    OR  l_ostc = 0 AND l_ppap = 3 AND l_apap = 2  THEN l_id := 1;
  ELSE
     RETURN 0;
  END IF;



  IF    l_ostc < 0
    OR  l_ostc = 0 AND l_ppap = 1
    OR  l_ostc = 0 AND l_ppap = 3 AND l_apap = 1  THEN l_id := 0;
  ELSIF l_ostc > 0
    OR  l_ostc = 0 AND l_ppap = 2
    OR  l_ostc = 0 AND l_ppap = 3 AND l_apap = 2  THEN l_id := 1;
  ELSE
     RETURN 0;
  END IF;

  BEGIN
    SELECT ir, br, op
      INTO l_ir, l_br, l_op
      FROM int_ratn
     WHERE acc = acc_
       AND id = l_id
       AND bdat = (SELECT MAX(bdat) FROM int_ratn
                    WHERE acc = acc_ AND id = l_id AND bdat <= l_dat);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
  END;

  IF l_br > 0 THEN

     BEGIN

       BEGIN
         SELECT br_type INTO l_type FROM brates WHERE br_id = l_br;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN l_type := 1;
       END;

       IF l_type = 1 THEN
          SELECT rate INTO l_rate
            FROM br_normal
           WHERE br_id = l_br AND kv = l_kv AND
                 bdate = (SELECT MAX(bdate)
                            FROM br_normal
                           WHERE br_id = l_br
                             AND kv = l_kv
                             AND bdate <= l_dat);
       ELSE
          SELECT rate INTO l_rate
            FROM br_tier
           WHERE br_id = l_br AND kv = l_kv AND
                (bdate, s) = (SELECT max(bdate), min(s)
                                FROM br_tier
                               WHERE br_id = l_br
                                 AND kv = l_kv
                                 AND bdate <= l_dat
                                 AND s >= l_ostc);
       END IF;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN l_rate := 0;
     END;

   END IF;

   IF    l_ir > 0        AND NVL(l_rate, 0) = 0 THEN  RETURN l_ir;
   ELSIF NVL(l_ir,0) = 0 AND l_rate > 0         THEN  RETURN l_rate;
   ELSIF l_ir > 0        AND l_rate > 0         THEN
                                  IF l_op = 1 THEN  RETURN l_ir + l_rate;
                               ELSIF l_op = 2 THEN  RETURN l_ir - l_rate;
                               ELSIF l_op = 3 THEN  RETURN l_ir * l_rate;
                               ELSIF l_op = 4 THEN  RETURN l_ir / l_rate;
                              END IF;
   END IF;

   RETURN 0;

END FPROC;

PROCEDURE p_bonus_rate (dpt_id_ NUMBER) IS
  rate0_   NUMBER;
  rate_    NUMBER;
--************************************************************************
--       Автозаполнение дополнительной %-ной карточки (id=3)
--           по вкладам с повышенной процентной ставкой
--                Version 1.00 (15/03/2005)   INNA
--************************************************************************
BEGIN

  FOR d IN
     (SELECT deposit_id, acc, kv, fix_rate, br, ir, op, dat, dat_begin DAT0, dat_end, rate
        FROM
            (SELECT d.deposit_id, d.acc, d.kv, d.dat_begin, d.dat_end,
                    nvl(v.basem,0) FIX_RATE, r.br, r.ir, r.op,
                    dpt.get_datend_uni(d.dat_begin, r.duration_m, r.duration_d, d.vidd) DAT,
                    dpt.fproc(d.acc,d.dat_begin) RATE
               FROM dpt_deposit d, dpt_vidd v, dpt_rate_rise r
              WHERE d.vidd = v.vidd
                AND v.vidd = r.vidd
                AND d.deposit_id = dpt_id_
                AND r.id   = 3)
              WHERE dat <= dat_end
              ORDER BY 1, 9)
  LOOP

    -- значение первоначальной баз.ставки на момент открытия вклада
    BEGIN
      SELECT rate INTO rate0_
        FROM br_normal
       WHERE br_id=d.br AND kv=d.kv AND
             bdate=
                   (SELECT MAX(bdate) FROM br_normal
                     WHERE bdate<=d.dat0 AND br_id=d.br AND kv=d.kv);
    EXCEPTION WHEN NO_DATA_FOUND THEN
      bars_error.raise_error(g_modcode, 26, to_char(d.br), to_char(d.kv), to_char(d.dat0,'dd/MM/yyyy'));
    END;

    -- Заведение бонусной процентной карточки как "слепок" с основной
    BEGIN
      INSERT INTO int_accn
        (acc, id, metr, basey, basem, freq, stp_dat, acr_dat, tt, acra, acrb, io)
      SELECT
         acc, 3, metr, basey, 0, 1, stp_dat, acr_dat, tt, acra, acrb, io
        FROM int_accn
       WHERE id=1 AND acc=d.acc;
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
      NULL;
    END;

    -- Расчет текущей %-ной ставки осносительно расчетной таблицы и
    -- значения первоначальной ставки
    IF d.fix_rate=1 THEN
        IF    d.ir>0        AND nvl(d.br,0)=0 THEN rate_:=d.ir;
        ELSIF nvl(d.ir,0)=0 AND d.br>0        THEN rate_:=rate0_;
        ELSIF d.ir>0        AND d.br>0        THEN
             IF d.op = 1 THEN rate_:=d.ir + rate0_;
          ELSIF d.op = 2 THEN rate_:=d.ir - rate0_;
          ELSIF d.op = 3 THEN rate_:=d.ir * rate0_;
          ELSIF d.op = 4 THEN rate_:=d.ir / rate0_;
         END IF;
     END IF;

     -- Запись текущей ставки(индивид.) в процентную бонусную карточку по вкладу
     BEGIN
       INSERT INTO int_ratn (acc, id, bdat, ir)
       VALUES (d.acc, 3, d.dat, rate_);
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
       bars_error.raise_error(g_modcode, 27, to_char(rate_), to_char(d.dat,'dd/MM/yyyy'));
     END;

     -- Запись текущей ставки (базов.) в процентную бонусную карточку по вкладу
    ELSE
       BEGIN
         INSERT INTO int_ratn (acc, id, bdat, ir, br, op)
         VALUES (d.acc, 3, d.dat, d.ir, d.br, d.op);
       EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
         bars_error.raise_error(g_modcode, 28, to_char(d.br), to_char(d.dat,'dd/MM/yyyy'));
       END;
    END IF;

  END LOOP;

END p_bonus_rate;

PROCEDURE p_chg_tier_rates (dat_ DATE) IS
  ir_ NUMBER;
--*************************************************************************
-- Перевод вкладов, открытых в дату dat_, с базовой ступенчатой
-- процентной ставки на индивидуальную.
-- Работает только для вкладов с признаком "Фикс.%-ная ставка"
--                Version 1.00 (04/04/2005)   INNA
--************************************************************************
BEGIN
 FOR v IN
    (SELECT v.vidd, v.br_id, b.br_type
       FROM dpt_vidd v, brates b
      WHERE v.br_id=b.br_id AND b.br_type<>1 AND basem=1
      ORDER BY v.vidd)
 LOOP

    FOR d IN
       (SELECT deposit_id DPT_ID, acc ACC, acrn.fproc(acc,bankdate) RATE
          FROM dpt_deposit
         WHERE vidd=v.vidd AND dat_begin = dat_
         ORDER BY deposit_id)
    LOOP

       BEGIN
         SELECT nvl(ir,0) INTO ir_
     FROM int_ratn WHERE acc=d.acc AND id=1 AND bdat=dat_ AND br=v.br_id;
       EXCEPTION WHEN NO_DATA_FOUND THEN
         ir_:=1;
       END;

       IF ir_ = 0 THEN
          UPDATE int_ratn SET
               br = to_number(NULL),
                 ir = d.rate
           WHERE acc=d.acc AND id=1 AND bdat=dat_;
       END IF;

    END LOOP;  -- d

 END LOOP;  -- v

END p_chg_tier_rates;

FUNCTION f_cur_dps (dpt_id_ NUMBER, s_ NUMBER, dat_ DATE)
RETURN NUMBER
IS
 kv_  NUMBER;
 cur_ NUMBER;
--*******************************************************************--
--  Расчет ГРН - эквивалента при взыскании штрафа по валютному вкладу
--
--             Version 1.00 (30/05/2005)  INNA
--*******************************************************************--
BEGIN
  BEGIN
    SELECT kv INTO kv_ FROM dpt_deposit WHERE deposit_id = dpt_id_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
  END;

  IF kv_ = gl.baseval THEN RETURN s_;
  ELSE
    SELECT gl.p_icurval(kv_, s_, dat_) INTO cur_ FROM dual;
    RETURN cur_;
    -- RETURN NULL;
  END IF;
END f_cur_dps;

--
-- расчет %-ной ставки при открытии вклада (по базовой ставке или по шкале)
--
function f_calc_rate
   (p_vidd    in dpt_vidd.vidd%type,
    p_term_m  in dpt_vidd.duration%type,
    p_term_d  in dpt_vidd.duration_days%type,
    p_sum     in dpt_vidd.min_summ%type,
    p_dat     in date  default bankdate)
    return number
is
  l_title     varchar2(60)  := 'dpt(calc_rate): ';
  l_dat       date;
  l_brid      dpt_vidd.br_id%type;
  l_kv        dpt_vidd.kv%type;
  l_termtype  dpt_vidd.term_type%type;
  l_rate      dpt_vidd_rate.rate%type;
begin

  bars_audit.trace('%s старт с параметрами (%s, %s, %s, %s, %s)', l_title,
                   to_char(p_vidd), to_char(p_term_m), to_char(p_term_d),
                   to_char(p_sum), to_char(p_dat, 'dd.mm.yyyy'));
  select max(dat)
    into l_dat
    from dpt_vidd_rate
   where vidd = p_vidd
     and dat <= p_dat;

  select br_id, kv, term_type
    into l_brid, l_kv, l_termtype
    from dpt_vidd
   where vidd = p_vidd;

  bars_audit.trace('%s баз.ставка № %s, вал = %s, тип срока = %s, шкала действует с %s',
                   l_title, to_char(l_brid), to_char(l_kv),
                   to_char(l_termtype), to_char(l_dat, 'dd.mm.yyyy'));

  if (l_termtype = 1 or l_dat is null) then

     l_rate := getbrat (p_dat, l_brid, l_kv, nvl(p_sum, 0));
     bars_audit.trace('%s значение баз.ставки = %s', l_title, to_char(l_rate));

  elsif l_termtype = 0 then

     select d.rate into l_rate
       from dpt_vidd_rate d
      where d.vidd = p_vidd
        and d.term_m = p_term_m
        and d.term_d = p_term_d
        and (d.dat, d.limit) =  (select max(dat), min(limit)
                                   from dpt_vidd_rate
                                  where vidd   = d.vidd
                                    and term_m = d.term_m
                                    and term_d = d.term_d
                                    and limit >= p_sum
                                    and dat    = l_dat);
     bars_audit.trace('%s значение ставки по шкале ("=")= %s', l_title, to_char(l_rate));

  else

     select d.rate into l_rate
       from dpt_vidd_rate d
      where d.vidd = p_vidd
        and ((add_months (d.dat, d.term_m) + d.term_d), d.dat,    d.limit) =
           (select min(add_months (dat, term_m) + term_d),   min(dat), min(limit)
              from dpt_vidd_rate
             where vidd   = d.vidd
               and limit >= p_sum
               and dat    = l_dat
               and (add_months (dat, p_term_m) + p_term_d)
                <  (add_months (dat,   term_m) +   term_d) );
     bars_audit.trace('%s значение ставки по шкале ("<>")= %s', l_title, to_char(l_rate));

  end if;

  bars_audit.trace('%s выход с параметром %s', l_title, to_char(l_rate));
  return l_rate;

exception
  when no_data_found then
    bars_audit.trace('%s данные не найдены, выход с параметром %s', l_title, to_char(l_rate));
    return 0;
end f_calc_rate;

FUNCTION f_dptw (p_dpt NUMBER,  p_tag CHAR) RETURN VARCHAR2
-- *******************************************************************--
-- Вычисление значения доп.реквизита с кодом p_tag для вклада с № p_dpt.
--             Version 1.00 (27/09/2005)  INNA
-- *******************************************************************--
IS
  l_value   VARCHAR2(500);
BEGIN
  BEGIN
    SELECT trim(value) INTO l_value
      FROM dpt_depositw
     WHERE dpt_id = p_dpt AND tag = trim(p_tag);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN l_value := '';
  END;

  RETURN l_value;

END f_dptw;

FUNCTION f_dptisp (p_isp staff.id%type) RETURN NUMBER
-- ********************************* --
-- Поиск ответ.исполнителя по вкладу --
-- ********************************* --
IS
  l_I_am staff.id%type;
  l_isp  staff.id%type;
BEGIN
  l_I_am := gl.aUID;

  -- Ответ.исп.передается на входе
  IF p_isp IS NOT NULL THEN
     l_isp := p_isp;
  ELSE
    -- Поиск по TOBO_PARAMS/BRANCH_PARAMS
    l_isp := branch_usr.get_branch_param('DPT_ISP');
  END IF;

  IF l_isp IS NULL THEN
    -- Поиск по DPT_STAFF
    BEGIN
      SELECT isp INTO l_isp
        FROM dpt_staff
       WHERE userid = l_I_am
         AND branch = sys_context('bars_context','user_branch')
         AND isp IS NOT NULL;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_isp := l_I_am;
    END;
  END IF;

  -- проверка на корректность
  BEGIN
    SELECT id INTO l_isp
      FROM staff$base
     WHERE id = l_isp;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_isp := null;
  END;

  RETURN l_isp;

END f_dptisp;
--
-- процедура открытия технического счета
--
procedure p_open_tech_acc
  (p_dptid  in  dpt_deposit.deposit_id%type,
   p_nd     in  dpt_deposit.nd%type,
   p_rnk    in  dpt_deposit.rnk%type,
   p_kv     in  dpt_deposit.kv%type,
   p_acc    out accounts.acc%type,
   p_nls    out accounts.nls%type,
   p_nms    out accounts.nms%type)
is
  title      constant varchar2(60)      := 'dpt.opentechacc:';
begin

  bars_audit.trace('%s старт, вклад № %s (# %s), РНК = %s, валюта = %s',
                   title, p_nd, to_char(p_dptid), to_char(p_rnk), to_char(p_kv));

  null;

  bars_audit.trace('%s выход', title);

end p_open_tech_acc;

FUNCTION f_dpt_reminder
  (p_dpt dpt_deposit.deposit_id%type, p_lng varchar2)
  RETURN varchar2
IS
  -- функция генерации напоминаний в карточке вклада
  l_bd     date := bankdate;
  l_intost accounts.ostb%type;
  l_datend dpt_deposit.dat_end%type;
  l_acrdat int_accn.acr_dat%type;
  l_zalcnt number(38);
  l_zalval params.val%type;
  l_zalpar params.par%type := 'ZAL_DPT';
  l_zalcnm varchar2(30);
  l_zalmsg varchar2(3000);
  l_dptmsg varchar2(3000);
  l_msgdim number(38) := 3000;
BEGIN
  -- поиск вклада
  BEGIN
    SELECT a.ostb, d.dat_end, nvl(i.acr_dat + 1, d.dat_begin)
      INTO l_intost, l_datend, l_acrdat
      FROM dpt_deposit d, int_accn i, accounts a
     WHERE d.acc = i.acc
       AND i.id = 1
       AND i.acra = a.acc
       AND d.deposit_id = p_dpt;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- вклад в архиве -> выходим
      RETURN NULL;
  END;

  -- срок вклада истек
  IF l_datend <= l_bd THEN
     l_dptmsg := SUBSTR(CASE
                          WHEN (p_lng = 'UKR') THEN 'Термін договору закінчився!'
                          ELSE 'Срок договора истек!'
                        END
                      ||chr(13)||chr(10), 1, l_msgdim);
     IF l_acrdat < (l_datend - 1) THEN
        l_dptmsg := SUBSTR(l_dptmsg
                         ||CASE
                             WHEN (p_lng = 'UKR') THEN 'Не забудьте донарахувати відсотки!'
                             ELSE 'Не забудьте доначислить проценты!'
                           END
                         ||chr(13)||chr(10), 1, l_msgdim);
     END IF;
     IF l_intost > 0 THEN
        l_dptmsg := SUBSTR(l_dptmsg
                         ||CASE
                             WHEN (p_lng = 'UKR') THEN 'Не забудьте сплатити відсотки!'
                             ELSE 'Не забудьте выплатить проценты!'
                           END
                         ||chr(13)||chr(10), 1, l_msgdim);
     END IF;
  END IF;
  RETURN l_dptmsg;

END f_dpt_reminder;

--
-- Прозноз начисленнных процентов за весь срок договора
--
function get_forecast_int
  (p_dpttype      in  dpt_vidd.vidd%type,
   p_dptamount    in  dpt_vidd.min_summ%type,
   p_opendate     in  date default bankdate,
   p_term_months  in  dpt_vidd.duration%type default null,
   p_term_days    in  dpt_vidd.duration_days%type default null)
   return number
is
   title        varchar2(60) := 'dpt.getforecastint: ';
   l_dptyperow  dpt_vidd%rowtype;
   l_dealterm   number;
   l_baseterm   number;
   l_rate       number;
   l_intamount  number;
begin

  bars_audit.trace('%s старт с параметрами (%s, %s, %s)', title,
                   to_char(p_dpttype), to_char(p_dptamount), to_char(p_opendate, 'dd.mm.yy'));

  select * into l_dptyperow from dpt_vidd where vidd = p_dpttype;

  if l_dptyperow.term_type != 1 and p_term_months is not null and p_term_days is not null
  then
      l_dptyperow.duration := p_term_months;
      l_dptyperow.duration_days := p_term_days;
  end if;

  l_dealterm := get_datend_uni (p_opendate, l_dptyperow.duration, l_dptyperow.duration_days, p_dpttype)
             - p_opendate
             - 1;

  l_baseterm := case
                when l_dptyperow.basey = 1 then 365
                when l_dptyperow.basey = 2 then 360
                when l_dptyperow.basey = 3 then 360
                else
                     to_date('3112'||to_char(p_opendate,'YYYY'),'DDMMYYYY')
                     - trunc(p_opendate,'YEAR') + 1
                end;

  l_rate := f_calc_rate (p_vidd   => l_dptyperow.vidd,
                         p_term_m => l_dptyperow.duration,
                         p_term_d => l_dptyperow.duration_days,
                         p_sum    => p_dptamount,
                         p_dat    => p_opendate);

  bars_audit.trace('%s кол-во дней - %s, баз.год - %s, ставка - %s', title,
                   to_char(l_dealterm), to_char(l_baseterm), to_char(l_rate));

  l_intamount := round(l_rate * p_dptamount * l_dealterm / l_baseterm / 100);

  l_intamount := greatest (nvl(l_intamount, 0), 0);

  bars_audit.trace('%s выход с параметром %s', title, to_char(l_intamount));

  return l_intamount;

end get_forecast_int;
--
-- создание / редактирование доп.параметра вида вклада
--
procedure set_viddparam
  (p_tag          in  dpt_vidd_tags.tag%type,
   p_name         in  dpt_vidd_tags.name%type,
   p_status       in  dpt_vidd_tags.status%type        default 'Y',
   p_checkquery   in  dpt_vidd_tags.check_query%type   default null,
   p_editable     in  dpt_vidd_tags.editable%type      default 'Y')
is
  title    varchar2(60) := 'dpt.setviddparam:';
begin
  bars_audit.trace('%s entry, {%s, %s, %s, %s, %s}', title,
                   p_tag, p_name, p_status, p_checkquery, p_editable);

  insert into dpt_vidd_tags (tag, name, status, check_query, editable)
  values (substr(p_tag,        1, 16),
          substr(p_name,       1, 100),
          substr(p_status,     1, 1),
          substr(p_checkquery, 1, 3000),
          substr(p_editable,   1, 1));
  bars_audit.trace('%s tag %s created', title, p_tag);
exception
  when dup_val_on_index then
    update dpt_vidd_tags
       set name        = substr(p_name,       1, 100),
           status      = substr(p_status,     1, 1),
           check_query = substr(p_checkquery, 1, 3000),
           editable    = substr(p_editable,   1, 1)
     where tag = p_tag;
    bars_audit.trace('%s tag %s modified', title, p_tag);
end set_viddparam;
--
-- функция проверки типа данных указанного значения
--
function is_valid_datatype
  (p_datatype in  varchar2,
   p_data     in  varchar2)
   return number
is
  l_result  number(1) := 0;
  l_numdata number;
  l_datdata date;
begin
  if    p_datatype = 'NUMB' then
    begin
      l_numdata := to_number(p_data);
      l_result  := 1;
    exception
      when value_error then
       l_result  := 0;
    end;
  elsif p_datatype = 'DATE' then
    begin
      l_datdata := to_date(p_data, 'dd.mm.yyyy');
      l_result  := 1;
    exception
      when others then
       l_result  := 0;
    end;
  elsif p_datatype = 'CHAR' then
    l_result  := 1;
  else
    l_result  := 1;
  end if;
  return l_result;
end is_valid_datatype;
--
-- Проверка корректности значения ополнительного параметра для вида вклада
--
procedure viddparam_validation
  (p_vidd    in  dpt_vidd_params.vidd%type,
   p_tag     in  dpt_vidd_params.tag%type,
   p_val     in  dpt_vidd_params.val%type)
is
  title    varchar2(60) := 'dpt.viddparamvalid:';
  l_query  dpt_vidd_tags.check_query%type;
  l_result char(1);
  l_errmsg varchar2(3000);
  l_cursor integer;
  l_tmpnum integer;
begin

  bars_audit.trace('%s entry, {%s, %s, %s}', title, to_char(p_vidd), p_tag, p_val);

  select check_query into l_query from dpt_vidd_tags where tag = p_tag;
  bars_audit.trace('%s l_query = %s', title, l_query);

--begin
--  execute immediate l_query into l_result using p_val, p_vidd;
--exception
--  when others then
--    l_result := 0; l_errmsg := substr(sqlerrm, 1, 3000);
--end;

  if l_query is null then
     l_result := 1;
  else
     begin
       l_cursor := dbms_sql.open_cursor;
       dbms_sql.parse(l_cursor, l_query, dbms_sql.native);
       dbms_sql.bind_variable(l_cursor, 'p_vidd', p_vidd);
       dbms_sql.bind_variable(l_cursor, 'p_val',  p_val );
       dbms_sql.define_column(l_cursor, 1, l_result, 1);
       l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
       dbms_sql.column_value(l_cursor,  1, l_result);
       dbms_Sql.close_cursor(l_cursor);
     exception
       when others then
         l_result := 0; l_errmsg := substr(sqlerrm, 1, 3000);
     end;
  end if;

  if nvl(l_result, 0) != 1 then
     -- Указанное значение доп.параметра %s (%s) не соответствует формату параметра %s
     bars_error.raise_nerror(g_modcode, 'VIDDPARAM_CHECK_FAILED', p_tag, p_val, l_errmsg);
  end if;
  bars_audit.trace('%s exit', title);

end viddparam_validation;
--
-- Заполнение значения дополнительного параметра для вида вклада
--
procedure set_viddparam_value
  (p_vidd    in  dpt_vidd_params.vidd%type,
   p_tag     in  dpt_vidd_params.tag%type,
   p_val     in  dpt_vidd_params.val%type,
   p_rwflag  in  number)
is
  title      varchar2(60) := 'dpt.setviddparam:';
  l_editable dpt_vidd_tags.editable%type;
begin

  bars_audit.trace('%s entry, {%s, %s, %s, %s}', title, to_char(p_vidd), p_tag, p_val, to_char(p_rwflag));

  -- p_rwflag = 2 полный доступ
  -- p_rwflag = 1 вид вклада активнный или есть вклады
  -- p_rwflag = 0 запрет на редактирование

  select editable into l_editable from dpt_vidd_tags where tag = p_tag;

  if (p_rwflag = 0) or (p_rwflag = 1 and l_editable = 'N') then
     -- запрещено редактирование доп.параметра %s для вида вклада %s (статус %s)
     bars_error.raise_nerror (g_modcode, 'VIDDPARAM_SET_DENIED', p_tag, to_char(p_vidd), to_char(p_rwflag));
  end if;

  -- проверка корректности заданного значнеия
  viddparam_validation (p_vidd, p_tag, p_val);

  if p_val is null then
     delete from dpt_vidd_params where vidd = p_vidd and tag = p_tag;
     -- DPT: выполнена очистка значения параметра < %s > для вида вклада № %s
     bars_audit.info(bars_msg.get_msg(g_modcode, 'VIDDPARAM_DELETED', p_tag, to_char(p_vidd)));
  else
     begin
       insert into dpt_vidd_params (vidd, tag, val) values (p_vidd, p_tag, p_val);
     exception
       when dup_val_on_index then
         update dpt_vidd_params set val = p_val where vidd = p_vidd and tag = p_tag;
     end;
     -- DPT: выполнена установка значения параметра < %s > = %s для вида вклада № %s
     bars_audit.info(bars_msg.get_msg(g_modcode, 'VIDDPARAM_UPDATED', p_tag, p_val, to_char(p_vidd)));
  end if;

  bars_audit.trace('%s exit', title);

end set_viddparam_value;
--
-- фиксация новых процентных ставок для договоров с пересмотром ставок
--
procedure fix_rate_review
  (p_dptid  in  dpt_deposit.deposit_id%type default 0,
   p_filter in  varchar2                    default null )
is
   title      varchar2(60)                := 'dpt.fixratereview:';
   l_bd       date                        := gl.bdate;
   l_userid   staff.id%type               := gl.auid;
   l_id       int_ratn.id%type            := 1;
   l_jobcode  dpt_jobs_list.job_code%type := 'RATE_RVW';
   l_runid    dpt_jobs_jrnl.run_id%type;
   l_brdat    int_ratn.bdat%type;
   type       t_dptlist is table of v_dptreviewratedeals%rowtype;
   l_dptlist  t_dptlist;
   l_query    varchar2(3000);
   l_errflg   boolean;
   l_errmsg   varchar2(3000);
   l_branch   varchar2(30);
   l_cnt      number;
begin

  bars_audit.trace('%s entry with params (%s, %s)', title, to_char(p_dptid), p_filter);

  l_branch := sys_context('bars_context','user_branch');

  -- фиксация начала сеанса протоколирования
  dpt_jobs_audit.p_start_job (p_jobid  => dpt_jobs_audit.get_jobid (l_jobcode),
                              p_branch => l_branch,
                              p_bdate  => l_bd,
                              p_user   => l_userid,
                              p_run_id => l_runid);

  l_query := 'select * from v_dptreviewratedeals';
  if p_dptid = 0 then
     if p_filter is not null then
        l_query := l_query || ' where '||p_filter;
     end if;
  else
     l_query := l_query || ' where dpt_id = '||to_char(p_dptid);
  end if;
  bars_audit.trace('%s l_query = %s', title, l_query);

  execute immediate l_query bulk collect into l_dptlist;

  bars_audit.trace('%s deals for rate_review = %s', title, to_char(l_dptlist.count));

  for i in 1..l_dptlist.count loop

    bars_audit.trace('%s deal № %s ...', title, to_char(l_dptlist(i).dpt_id));

    l_errflg  := false;
    l_errmsg  := null;
    l_brdat   := null;

    begin

      savepoint sp_rate;

      -- история изменения ставки "наперед"
      select min(r.bdat), count(*)
        into l_brdat, l_cnt
        from int_ratn r
       where r.acc   = l_dptlist(i).acc_id
         and r.id    = l_id
         and r.bdat >= l_dptlist(i).review_date
         and r.bdat <  l_dptlist(i).dat_end;
      bars_audit.trace('%s nearest change rate date = %s', title, to_char(l_brdat, 'dd.mm.yy'));

      if l_brdat is null then
         insert into int_ratn (id, acc, bdat, ir)
         values (l_id,
                 l_dptlist(i).acc_id,
                 l_dptlist(i).review_date,
                 l_dptlist(i).review_rate);
      elsif (l_brdat = l_dptlist(i).review_date and l_cnt = 1) then
          update int_ratn
             set ir  = l_dptlist(i).review_rate,
                 br  = null,
                 op  = null
          where id   = l_id
            and acc  = l_dptlist(i).acc_id
            and bdat = l_dptlist(i).review_date;
      else
        -- возможно нарушение истории ставок
        l_errflg := true;
        l_errmsg := bars_msg.get_msg(g_modcode, 'RATE_REVIEW_INCONSISTENT');
      end if;
    exception
      when others then
        l_errflg := true;
        l_errmsg := sqlerrm;
    end;

    if l_errflg then
       rollback to sp_rate;
    end if;

    -- запись в протокол
    dpt_jobs_audit.p_save2log (p_runid    => l_runid,
                               p_dptid    => l_dptlist(i).dpt_id,
                               p_dealnum  => l_dptlist(i).dpt_num,
                               p_branch   => l_branch,
                               p_ref      => null,
                               p_rnk      => l_dptlist(i).cust_id,
                               p_nls      => l_dptlist(i).acc_num,
                               p_kv       => l_dptlist(i).acc_cur,
                               p_dptsum   => l_dptlist(i).acc_saldo,
                               p_intsum   => null,
                               p_status   => (case when l_errflg then -1 else 1 end),
                               p_errmsg   => l_errmsg,
                               p_rateval  => l_dptlist(i).review_rate,
                               p_ratedat  => l_dptlist(i).review_date);

    -- запись в журнал событий АБС или возврат ошибки (для одиночного выполнения)
    if    (l_errflg and p_dptid = 0) then
           bars_audit.error(bars_error.get_nerror_text (g_modcode, 'RATE_REVIEW_FAILED',
                                               to_char(l_dptlist(i).dpt_id), l_errmsg));
    elsif (l_errflg and p_dptid != 0) then
           -- фиксируем окончание протолола, т.к. вылетаем с ошибкой
           dpt_jobs_audit.p_finish_job (l_runid);
           bars_error.raise_nerror(g_modcode, 'RATE_REVIEW_FAILED',
                                   to_char(l_dptlist(i).dpt_id), l_errmsg);
    else
           -- выполнен пересмотр процентной ставки по деп.договору № %s (ставка %s действует с %s)
           bars_audit.info(bars_msg.get_msg(g_modcode, 'RATE_REVIEW_DONE',
                                            to_char(l_dptlist(i).dpt_id),
                                            to_char(l_dptlist(i).review_rate, '99D9999'),
                                            to_char(l_dptlist(i).review_date, 'dd.mm.yyyy')));
    end if;

    bars_audit.trace('%s deal № %s processed', title, to_char(l_dptlist(i).dpt_id));

  end loop;

  -- фиксация окончания сеанса протоколирования
  dpt_jobs_audit.p_finish_job (l_runid);

  bars_audit.trace('%s exit', title);

end fix_rate_review;

--
--
--
function check_oper_permission
 (p_dptid  in  dpt_deposit.deposit_id%type,  -- идентификатор вклада
  p_dptop  in  dpt_op.id%type,               -- идентификатор операции
  p_amount in  number default null)          -- сумма операции
  return number
is
  title      varchar2(30)      := 'dpt.chechoperpermission:';
  tagname    op_field.tag%type := 'DPTOP';
  l_bdate    date              := gl.bdate;
  l_dptnum   dpt_deposit.nd%type;
  l_datbeg   dpt_deposit.dat_begin%type;
  l_datend   dpt_deposit.dat_end%type;
  l_freqid   dpt_deposit.freq%type;
  l_stopid   dpt_deposit.stop_id%type;
  l_accid    accounts.acc%type;
  l_accnum   accounts.nls%type;
  l_curcode  accounts.kv%type;
  l_typeid   dpt_vidd.vidd%type;
  l_typename dpt_vidd.type_name%type;
  l_avans    number(1);
  l_extend   number(1);
  l_intaccid int_accn.acra%type;
  l_opername dpt_op.name%type;
  l_ttcnt    number(38)        := 0;
  l_status   number(1)         := 0;
  l_errmsg   varchar(3000)     := null;
begin

  bars_audit.trace ('%s entry with {%s, %s, %s}', title,
                    to_char(p_dptid), to_char(p_dptop), to_char(p_amount));

  --  параметры вклада
  begin
    select d.nd, d.dat_begin, d.dat_end, d.freq, d.stop_id,
           a.acc, a.nls, a.kv,
           v.vidd, v.type_name, decode(v.amr_metr, 0, 0, 1), i.acra,
           decode(nvl(d.cnt_dubl, 0), 0, 0, 1)
      into l_dptnum, l_datbeg, l_datend, l_freqid, l_stopid,
           l_accid, l_accnum, l_curcode,
           l_typeid, l_typename, l_avans, l_intaccid, l_extend
      from dpt_deposit  d,
           dpt_vidd     v,
           accounts     a,
           int_accn     i
     where d.vidd       = v.vidd
       and d.acc        = a.acc
       and a.acc        = i.acc
       and i.id         = 1
       and d.deposit_id = p_dptid;
  exception
    when no_data_found then
      bars_error.raise_nerror (g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
  end;
  bars_audit.trace ('%s № %s, account %s/%s, typeid № %s %s, term %s-%s', title,
                    l_dptnum, l_accnum, to_char(l_curcode),
                    to_char(l_typeid), l_typename,
                    to_char(l_datbeg), to_char(l_datend));

  -- проверка существования заданного типа операции
  begin
    select name into l_opername from dpt_op where id = p_dptop;
  exception
    when no_data_found then
      bars_error.raise_nerror (g_modcode, 'OPERATION_NOT_FOUND', to_char(p_dptop));
  end;

  -- наличие привязанных операций заданного типа к виду вклада
  select count(*)
    into l_ttcnt
    from dpt_tts_vidd v, op_rules o
   where v.tt   = o.tt
     and v.vidd = l_typeid
     and o.tag  = tagname
     and o.val  = to_char(p_dptop);

  if l_ttcnt = 0 then
     -- операция <%s> не разрешена для вида вклада <%s>
     bars_error.raise_nerror (g_modcode, 'OPERATION_NOT_ALLOWED', l_opername, l_typename);
  end if;
  bars_audit.trace ('%s tt_count for operation %s = %s', title, l_opername, to_char(l_ttcnt));

  --
  -- первичный взнос
  --
  if p_dptop = 0 then
     if l_datbeg < dat_next_u(l_bdate, (-1)*nvl(getglobaloption('DPT_DTBK'),0))
        or
        l_datbeg > dat_next_u(l_bdate, (+1)*nvl(getglobaloption('DPT_DTFW'),0)) then
        -- нарушен срок первичного взноса средств на вклад № %s
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_TERM_VIOLATION', l_dptnum);
     elsif (l_datend <= l_bdate) then
        -- истек срок действия вклада № %s
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_TERM_EXPIRED', l_dptnum);
     else
        if (p_amount > 0) then
           -- проверка "минимальная сумма первичного взноса"
           l_status := f_dpt_stop (0, l_curcode, l_accnum, p_amount, l_bdate);
        end if;
        begin
          select 1
            into l_status
            from accounts a
           where a.acc   = l_accid
             and a.ostc  = 0
             and (a.ostb  = 0 or a.ostb = p_amount)
             and a.ostf  = 0
             and a.daos >= l_bdate
             and a.dazs is null
             and (select sum(dos) + sum(kos) from saldoa where acc = a.acc) = 0;
        exception
          when no_data_found then
            -- первичный взнос средств на вклад № %s уже выполнен
            l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_CREDIT_SALDO', l_dptnum);
        end;
     end if;
  --
  -- пополнение вклада
  --
  elsif p_dptop = 1 then
     if (l_datbeg > l_bdate) then
        -- вклад № %s еще не вступил в силу
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_FORWARDEAL', l_dptnum);
     elsif (l_datend <= l_bdate) then
        -- истек срок действия вклада № %s
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_TERM_EXPIRED', l_dptnum);
     else
        if (p_amount > 0) then
           -- проверка "минимальная сумма пополнения"
           l_status := f_dpt_stop (2, l_curcode, l_accnum, p_amount, l_bdate);
           -- проверка "максимальная сумма пополнения" (инд.график)
           l_status := f_dpt_stop (22, l_curcode, l_accnum, p_amount, l_bdate);
           -- !!!  подумать
           -- 22 - стоп-правило на МАКСИМАЛЬНУЮ сумму пополнения (инд.график)
           -- 23 - стоп-правило на МАКСИМАЛЬНУЮ сумму пополнения (календ.график)
           -- 24 - стоп-правило на МАКСИМАЛЬНУЮ сумму пополнения (за весь срок)
        end if;
        -- проверка "срок пополнения"
        l_status := 1 + f_dpt_stop (1, l_curcode, l_accnum, p_amount, l_bdate);
       -- проверка возможности пополнения вклада за период указанный в настройках вида вклада
        l_status := 1 + f_dpt_stop (17, l_curcode, l_accnum, p_amount, l_bdate);
     end if;
  --
  -- возврат суммы депозита
  --
  elsif p_dptop in (2, 6, 21, 23, 25, 26) then
     if (l_datend <= l_bdate or l_datend is null or l_stopid = 0) then
         l_status := 1;
     elsif (dpt.f_shtraf_rate(p_dptid, l_bdate) is null) then
         l_status := 1;
     else
         select count(*)
           into l_status
           from dpt_deposit_clos
          where action_id  = 5
            and deposit_id = p_dptid;
         bars_audit.trace ('%s флаг штрафования = %s', title, to_char(l_status));
         if l_status > 0 then
            l_status := 1;
            bars_audit.trace ('%s было штрафование, => свободная выплата', title);
         else
            -- срок действия вклада № %s не истек
            l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_TERM_NOTEXPIRED', l_dptnum);
         end if;
     end if;
  --
  -- выплата процентов
  --
  elsif p_dptop in (3, 4, 33, 43, 44, 45, 46) then

     select count(*)
       into l_status
       from dpt_deposit_clos
      where action_id  = 5
        and deposit_id = p_dptid;
     bars_audit.trace ('%s флаг штрафования = %s', title, to_char(l_status));
     if l_status > 0 then
        l_status := 1;
        bars_audit.trace ('%s было штрафование, => свободная выплата', title);
     else
        bars_audit.trace ('%s freqid = %s', title, to_char(l_freqid));
        l_status := payoff_enable (p_intacc  => l_intaccid,
                                   p_freq    => l_freqid,
                                   p_avans   => l_avans,
                                   p_begdat  => l_datbeg,
                                   p_enddat  => l_datend,
                                   p_curdat  => l_bdate,
                                   p_extend  => l_extend);
        if l_status = 0 then
           -- не наступил срок выплаты процентов по вкладу № %s
           l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_FREQ_VIOLATED', l_dptnum);
        end if;
     end if;

  --
  -- частичное снятие вклада
  --
  elsif p_dptop in (8, 22) then
     if (l_datend <= l_bdate or l_datend is null or l_stopid = 0) then
        l_status := 1;
     else
        -- "сумма депозита после выплаты >= миним.суммы"
        if p_amount > 0 then
           l_status := 1 + f_dpt_stop (3, l_curcode, l_accnum, p_amount, l_bdate);
        else
           -- частичное снятие вклада № %s не допустимо
           l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_WRITEDOWN_NOTPERMITTED', l_dptnum);
        end if;
     end if;
  --
  -- досрочное расторжение договора
  --
  elsif p_dptop = 5 then
     if (l_datend <= l_bdate or l_datend is null) then
        -- срок действия вклада № %s истек
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_TERM_EXPIRED', l_dptnum);
     elsif (l_stopid = 0) then
        -- досрочное расторжение вклада № %s не допустимо
        l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_PENALTY_NOTPERMITTED', l_dptnum);
     else
        l_status := 1;
     end if;
  else
     -- тип операции не классифицирован
     l_errmsg := bars_msg.get_msg (g_modcode, 'CHECKOPERPERM_DPTOP_UNKNOWN', to_char(p_dptop));
  end if;

  --
  -- ф И Н И Ш
  --
  if l_status = 0 then
     -- запрещено выполнение операции <%s> по вкладу № %s (%s) : %s
     bars_error.raise_nerror (g_modcode, 'CHECKOPERPERM_ACCESS_DENIED',
                              l_opername, l_dptnum, to_char(p_dptid), l_errmsg);
  else
     return l_status;
  end if;

end check_oper_permission;

--
-- процедура переноса суммы депозита и процентов на техн.вклад до востребования
-- без капитализации процентов с открытием техн.вклада (при необходимости)
--
procedure move2dmnd
( p_dptid  in  dpt_deposit.deposit_id%type,      -- № вклада
  p_tt     in  tts.tt%type,                      -- код операции
  p_vobNC  in  vob.vob%type,                     -- вид.док.в нац.вал.
  p_vobFC  in  vob.vob%type )                    -- вид.док.в ин.вал.
is
  title        varchar2(60)     := 'dpt.move2dmnd:';
  l_bdate      date             := gl.bdate;
  l_mfo        oper.mfoa%type   := gl.amfo;
  l_bcur       oper.kv%type     := gl.baseval;
--  l_userid   oper.userid%type := gl.auid;
  l_dpt        v_dpt_move2dmnd%rowtype;
  l_vidd       dpt_vidd.vidd%type;
  l_bsd        dpt_vidd.bsd%type;
  l_intacc     accounts.acc%type;
  l_intnum     accounts.nls%type;
  l_intname    accounts.nms%type;
  l_amrnum     accounts.nls%type;
  l_expaccid   int_accn.acrb%type;
  l_errmsg     varchar2(3000);
  l_sum        oper.s%type;
  l_ref        oper.ref%type;
  l_dk         oper.dk%type;
  l_vob        oper.vob%type;
  l_nazn       oper.nazn%type;
  l_inherited  char(1);
  l_mindate    date;
begin

  bars_audit.trace('%s entry, dptid=>%s, tt=>%s, vob=>%s/%s', title,
                   to_char(p_dptid), p_tt, to_char(p_vobNC), to_char(p_vobFC));

  begin
    select * into l_dpt from v_dpt_move2dmnd where dptid = p_dptid;
  exception
    when no_data_found then
      -- не найден вклад № %s для переноса на вклад до востребования
      bars_error.raise_nerror (g_modcode, 'MOVE2DMND_DPT_NOT_FOUND', to_char(p_dptid));
  end;

  if l_dpt.depsal_fact != l_dpt.depsal_plan then
     -- найдены незавизир.док-ты по деп.счету вклада № %s
     bars_error.raise_nerror (g_modcode, 'MOVE2DMND_INVALID_DPTSALDO', to_char(p_dptid));
  end if;
  if l_dpt.intsal_fact != l_dpt.intsal_plan then
     -- найдены незавизир.док-ты по проц.счету вклада № %s
     bars_error.raise_nerror (g_modcode, 'MOVE2DMND_INVALID_INTSALDO', to_char(p_dptid));
  end if;

  -- поиск / открытие вклада до востребования
  if l_dpt.dmndaccnum is not null then

     l_dpt.dmndaccname := nvl(l_dpt.dmndaccname, substr(l_dpt.custname, 1, 38));

     begin
       select p.nls, substr(p.nms, 1, 38)
         into l_intnum, l_intname
         from accounts d, int_accn i, accounts p
        where d.nls  = l_dpt.dmndaccnum
          and d.kv   = l_dpt.curid
          and d.acc  = i.acc
          and i.id   = 1
          and i.acra = p.acc;
     exception
       when no_data_found then
         -- не найден процентный счет для текущего счета %s / %s и вклада %s
         bars_error.raise_nerror (g_modcode, 'MOVE2DMND_INTACC_NOT_FOUND',
                                  l_dpt.dmndaccnum, to_char(l_dpt.curid), to_char(p_dptid));
     end;
     bars_audit.trace('%s demand accounts found, № %s/%s', title, l_dpt.dmndaccnum, l_intnum);

  else

     bars_audit.trace('%s demand accounts not found => opening...', title);

    -- поиск техн.вида вклада до востребования
    begin
      select vidd, bsd
        into l_vidd, l_bsd
        from dpt_vidd
       where vidd < 0 and kv = l_dpt.curid;
    exception
      when no_data_found then
        -- не найден вид вклада до востребования для валюты %s
        bars_error.raise_nerror(g_modcode, 'DMNDVIDD_NOT_FOUND', to_char(l_dpt.curid));
      when too_many_rows then
        -- невозможно однозначно найти вид вклада до востребования для валюты %s
        bars_error.raise_nerror(g_modcode, 'DMNDVIDD_TOO_MANY_ROWS', to_char(l_dpt.curid));
    end;

    bars_audit.trace('%s demand type = %s', title, to_char(l_vidd));

    -- открытие вклада до востребования
    begin
       l_dpt.dmnddptid := p_dptid;
       p_open_vklad_ex (p_vidd         => l_vidd,
                        p_rnk          => l_dpt.custid,
                        p_nd           => l_dpt.dptnum,
                        p_sum          => l_dpt.depsal_fact,
                        p_nls_intpay   => null,
                        p_mfo_intpay   => null,
                        p_okpo_intpay  => null,
                        p_name_intpay  => null,
                        p_fl_dptpay    => 0,
                        p_nls_dptpay   => null,
                        p_mfo_dptpay   => null,
                        p_name_dptpay  => null,
                        p_comments     => substr(l_dpt.comments, 1, 128),
                        p_datz         => nvl(l_dpt.dptdat, trunc(sysdate)),
                        p_datbegin     => l_bdate,
                        p_dat_end_alt  => null,
                        p_term_m       => 0,
                        p_term_d       => 0,
                        p_grp          => l_dpt.depgrp,
                        p_isp          => l_dpt.depisp,
                        p_nocash       => 0,
                        p_chgtype      => 0,
                        p_depacctype   => l_dpt.deptype,
                        p_intacctype   => l_dpt.inttype,
                        p_dptid        => l_dpt.dmnddptid,
                        p_nlsdep       => l_dpt.dmndaccnum,
                        p_nlsint       => l_intnum,
                        p_nlsamr       => l_amrnum,
                        p_errmsg       => l_errmsg);

       select d.acc, substr(d.nms, 1, 38),
              p.acc, substr(p.nms, 1, 38)
         into l_dpt.dmndaccid, l_dpt.dmndaccname, l_intacc, l_intname
         from accounts d, accounts p
        where d.nls = l_dpt.dmndaccnum
          and d.kv  = l_dpt.curid
          and p.nls = l_intnum
          and p.kv  = l_dpt.curid;

       -- изменение ТОБО
       update accounts set tobo = l_dpt.branch where acc = l_dpt.dmndaccid;
       update accounts set tobo = l_dpt.branch where acc = l_intacc;

       -- изменение счета проц.расходов
       l_expaccid := get_expenseacc (l_vidd, l_bsd, l_dpt.curid, l_dpt.branch);
       update int_accn set acrb = l_expaccid where acc = l_dpt.dmndaccid;

       update dpt_deposit
          set dpt_d      = l_dpt.dmnddptid,
              acc_d      = l_dpt.dmndaccid,
              nls_d      = l_dpt.dmndaccnum,
              nms_d      = l_dpt.dmndaccname,
              okpo_d     = l_dpt.custcode,
              mfo_d      = l_mfo
        where deposit_id = p_dptid;

     exception
       when others then
         -- Ошибка открытия вклада до востребования для вклада № %s: %s
         bars_error.raise_nerror (g_modcode, 'MOVE2DMND_DMNDOPEN_FAILED', to_char(p_dptid), sqlerrm);
     end;

     bars_audit.trace('%s demand accounts opened, № %s/%s', title, l_dpt.dmndaccnum, l_intnum);

  end if;

  begin
    select ostb into l_sum from accounts where acc = l_dpt.depaccid for update of ostb nowait;
  exception
    when others then
      -- Ошибка блокировки депозитного счета вклада № %s: %s
      bars_error.raise_nerror (g_modcode, 'MOVE2DMND_ACCBLK_FAILED', to_char(p_dptid), sqlerrm);
  end;

  l_dk   := 1;
  l_vob  := case when l_dpt.curid = l_bcur then p_vobNC else p_vobFC end;

  l_nazn := substr(bars_msg.get_msg(g_modcode, 'MOVE2DMND_DETAILS',
                                    l_dpt.dptnum, to_char(l_dpt.dptdat, 'dd/mm/yyyy')), 1, 160);
  begin
    gl.ref (l_ref);
    gl.in_doc3 (ref_    => l_ref,
                tt_     => p_tt,
                vob_    => l_vob,
                nd_     => SubStr(to_char(l_ref),1,10),
                pdat_   => sysdate,
                vdat_   => l_bdate,
                dk_     => l_dk,
                kv_     => l_dpt.curid,
                s_      => l_dpt.depsal_fact,
                kv2_    => l_dpt.curid,
                s2_     => l_dpt.depsal_fact,
                sk_     => null,
                data_   => l_bdate,
                datp_   => sysdate,
                nam_a_  => l_dpt.depaccname,
                nlsa_   => l_dpt.depaccnum,
                mfoa_   => l_mfo,
                nam_b_  => l_dpt.dmndaccname,
                nlsb_   => l_dpt.dmndaccnum,
                mfob_   => l_mfo,
                nazn_   => l_nazn,
                d_rec_  => null,
                id_a_   => l_dpt.custcode,
                id_b_   => l_dpt.custcode,
                id_o_   => null,
                sign_   => null,
                sos_    => null,
                prty_   => 0,
                uid_    => null );

    paytt (null, l_ref, l_bdate, p_tt, l_dk,
                 l_dpt.curid, l_dpt.depaccnum,  l_dpt.depsal_fact,
                 l_dpt.curid, l_dpt.dmndaccnum, l_dpt.depsal_fact);

    bars_audit.trace('%s dep %s = %s -> %s (%s)', title, to_char(l_ref),
                     l_dpt.depaccnum, l_dpt.dmndaccnum, to_char(l_dpt.depsal_fact));

  exception
    when others then
       -- ошибка переноса суммы депозита для вклада № %s: %s
       bars_error.raise_nerror(g_modcode, 'MOVE2DMND_PAYDOCDEP_FAILED', to_char(p_dptid), sqlerrm);
  end;

  if l_dpt.intsal_fact > 0 and l_dpt.intaccnum != l_dpt.depaccnum then

     l_nazn := substr(bars_msg.get_msg(g_modcode, 'MOVE2DMND_DETAILS%2',
                                       l_dpt.dptnum, to_char(l_dpt.dptdat, 'dd/mm/yyyy')), 1, 160);

     begin
       gl.ref (l_ref);
       gl.in_doc3 (ref_    => l_ref,
                   tt_     => p_tt,
                   vob_    => l_vob,
                   nd_     => SubStr(to_char(l_ref),1,10),
                   pdat_   => sysdate,
                   vdat_   => l_bdate,
                   dk_     => l_dk,
                   kv_     => l_dpt.curid,
                   s_      => l_dpt.intsal_fact,
                   kv2_    => l_dpt.curid,
                   s2_     => l_dpt.intsal_fact,
                   sk_     => null,
                   data_   => l_bdate,
                   datp_   => sysdate,
                   nam_a_  => l_dpt.intaccname,
                   nlsa_   => l_dpt.intaccnum,
                   mfoa_   => l_mfo,
                   nam_b_  => l_dpt.dmndaccname,
                   nlsb_   => l_dpt.dmndaccnum,
                   mfob_   => l_mfo,
                   nazn_   => l_nazn,
                   d_rec_  => null,
                   id_a_   => l_dpt.custcode,
                   id_b_   => l_dpt.custcode,
                   id_o_   => null,
                   sign_   => null,
                   sos_    => null,
                   prty_   => 0,
                   uid_    => null );

       paytt (null, l_ref, l_bdate, p_tt, l_dk,
                    l_dpt.curid, l_dpt.intaccnum,  l_dpt.intsal_fact,
                    l_dpt.curid, l_dpt.dmndaccnum, l_dpt.intsal_fact);
       bars_audit.trace('%s int %s = %s -> %s (%s)', title, to_char(l_ref),
                        l_dpt.intaccnum, l_dpt.dmndaccnum, to_char(l_dpt.intsal_fact));

     exception
       when others then
          -- ошибка переноса суммы процентов для вклада № %s: %s
          bars_error.raise_nerror(g_modcode, 'MOVE2DMND_PAYDOCINT_FAILED', to_char(p_dptid), sqlerrm);
     end;

  end if;

  bars_audit.trace('%s exit, deposit № %s succ.processed', title, to_char(p_dptid));

end move2dmnd;

--
-- функция расчета даты окончания срока действия вклада (старая)
--
function f_duration (dat_ date, term_m integer, term_d integer) return date
is
begin
  return get_datend_uni ( p_datbeg  => dat_,
                          p_mnthcnt => term_m,
                          p_dayscnt => term_d,
                          p_dptype  => null);
end f_duration;

--
-- внутр.функция определения дня месяца для заданной даты
--
function get_day (p_date in date) return number
is
begin
  return to_number(to_char(p_date, 'DD'));
end get_day;

--
-- функция расчета даты окончания срока действия вклада (универс.)
--
function get_datend_uni
  (p_datbeg   in  date,                -- дата начала срока действия вклада
   p_mnthcnt  in  number,              -- срок действия вклада в месяцах
   p_dayscnt  in  number,              -- срок действия вклада в днях
   p_dptype   in  number,              -- код вида вклада
   p_custid   in  number default null) -- код клієнта, якщо строк дії депозиту залежить від віку клієнта (наприклад малолілтні)
   return date                         -- дата окончания срока действия вклада
is
  title    varchar2(60)             := 'dpt.getdatenduni:';
  l_tag    dpt_vidd_params.tag%type := 'DURATION_FUNC';
  l_func   dpt_vidd_params.val%type;
  l_cursor integer;
  l_tmpnum integer;
  l_day    number(2);
  l_datend date;
  l_datend_t date;
  l_nbs    varchar2(4);
  l_TYPE_ID number;
  l_TYPE_CODE VARCHAR2(4);

begin
  -- нельзя просто использовать функцию add_months из-за посл.дней месяцев
  -- add_months (30.04.2009, 1) = 31.05.2009, а должно быть 30.04.2009
  -- add_months (31.05.2009, 1) = 30.06.2009, а должно быть 01.07.2009
  -- НО!  28.02.2011 + 12 мес = должно быть 29.02.2012
  bars_audit.trace('%s entry, datbeg=>%s, mnthcnt=>%s, dayscnt=>%s, dptype=>%s',
                   title, to_char(p_datbeg, 'dd.mm.yyyy'), to_char(p_mnthcnt),
                   to_char(p_dayscnt), to_char(p_dptype));
   BEGIN
       SELECT bsd, TYPE_ID
         INTO l_nbs, l_TYPE_ID
         FROM dpt_vidd
        WHERE vidd = p_dptype;
    EXCEPTION
       WHEN no_data_found
       THEN
          l_nbs := '---';
    END;

    BEGIN
       SELECT TYPE_CODE
         INTO l_TYPE_CODE
         FROM dpt_types
        WHERE type_id = l_TYPE_ID;
    EXCEPTION
       WHEN no_data_found
       THEN
          l_TYPE_CODE:= '----';
    END;

  begin
    select trim(val)
      into l_func
      from dpt_vidd_params
     where tag  = l_tag
       and vidd = p_dptype
       and p_dptype is not null;
  exception
    when no_data_found then
      l_func := null;
  end;

  if l_func is not null then

     begin
       bars_audit.trace('%s function = %s', title, l_func);
       l_cursor := dbms_sql.open_cursor;
       dbms_sql.parse(l_cursor, l_func, dbms_sql.native);

        --намагаємось збіндити змінні, оскільки в залежності від налаштувань доппараметрів змінної може просто не бути в запиті ( SQLCODE in( -01006, -01008))
           begin
           dbms_sql.bind_variable(l_cursor, 'cust_id', p_custid);
           exception
            when others then
               if SQLCODE in( -01006, -01008)
               then null;
               else
               dbms_sql.close_cursor(l_cursor);
                raise;
                end if;
           end;

           begin
            dbms_sql.bind_variable(l_cursor, 'dat',  p_datbeg);
           exception
            when others then
               if SQLCODE in( -01006, -01008)
               then null;
               else
                dbms_sql.close_cursor(l_cursor);
                raise;
                end if;
           end;
           begin
            dbms_sql.bind_variable(l_cursor, 'vidd', p_dptype);
           exception
            when others then
               if SQLCODE in( -01006, -01008)
               then null;
               else
                dbms_sql.close_cursor(l_cursor);
                raise;
                end if;
           end;

      dbms_sql.define_column(l_cursor, 1, l_datend);
       l_tmpnum := dbms_sql.execute_and_fetch(l_cursor);
       dbms_sql.column_value(l_cursor,  1, l_datend);
       dbms_sql.close_cursor(l_cursor);
     exception
       when others then
         bars_error.raise_nerror (g_modcode, 'GET_DATEND_FAILED', to_char(p_dptype), sqlerrm);
         dbms_sql.close_cursor(l_cursor);
     end;

  else

    if p_mnthcnt > 0 then
       l_day    := get_day(p_datbeg);
       l_datend := add_months(trunc(p_datbeg, 'MM'), p_mnthcnt);
       if get_day (last_day(l_datend)) < l_day then
          -- в месяце окончания нет такого числа => первое число след.месяца
          l_datend := add_months(l_datend, 1);
       else
          l_datend := l_datend + l_day - 1;
       end if;
       -- спецобработка для дата окончания = 28.02 высокосного года
       if to_char(p_datbeg, 'ddmm')          = '2802' and
          to_char(l_datend, 'ddmm')          = '2802' and
          mod(to_char(p_datbeg, 'yyyy'), 4) != '0'    and
          mod(to_char(l_datend, 'yyyy'), 4)  = '0'    then
          l_datend := add_months(p_datbeg, p_mnthcnt);
       end if;

       -- спецобработка для дата окончания = 29.02 высокосного года (2016-02-29 Pavlenko)
       if to_char(p_datbeg, 'ddmm')          = '2902' and
          to_char(l_datend, 'ddmm')          = '0103' and
          mod(to_char(p_datbeg, 'yyyy'), 4)  = '0'    and
          mod(to_char(l_datend, 'yyyy'), 4) != '0'    then
          l_datend := add_months(p_datbeg, p_mnthcnt); -- иначе строковисть не соблюдается, переносим на 2802
       end if;
    else
       l_datend := p_datbeg;
    end if;
   --dpt.getdatenduni:p_mnthcnt=12,to_char(p_datbeg, 'ddmm')=2902,to_char(l_datend, 'ddmm')=0103,mod(to_char(p_datbeg, 'yyyy'), 4)=0,mod(to_char(l_datend, 'yyyy'), 4)=1,p_datbeg =29/02/2016
    bars_audit.trace(title|| 'p_mnthcnt='||  to_char(p_mnthcnt)
                          || ',to_char(p_datbeg, ''ddmm'')=' || to_char(p_datbeg, 'ddmm')
                          || ',to_char(l_datend, ''ddmm'')=' || to_char(l_datend, 'ddmm')
                          || ',mod(to_char(p_datbeg, ''yyyy''), 4)='|| to_char(mod(to_char(p_datbeg, 'yyyy'), 4))
                          || ',mod(to_char(l_datend, ''yyyy''), 4)='|| to_char(mod(to_char(l_datend, 'yyyy'), 4))
                          || ',p_datbeg =' || to_char(p_datbeg,'dd/mm/yyyy'));


    l_datend := l_datend + nvl(p_dayscnt, 0);

   if l_TYPE_CODE not in ('POTD','PENS') -- inga 10/04/2015 если счет текущий, то манипуляции с переносом даты с выходного дня не производим
   then

    bars_audit.trace('l_datend = '||to_char(l_datend, 'dd/mm/yyyy'));
    bars_audit.trace('l_nbs = '||to_char(l_nbs));
    begin
      select dat_next_u(holiday, 1)
        into l_datend_t
        from holiday
       where holiday = trunc(l_datend)
         and kv      = gl.baseval;
    exception
      when no_data_found then null;
    end;
    bars_audit.trace('l_datend_t = '||to_char(l_datend_t, 'dd/mm/yyyy'));
    bars_audit.trace('l_datend_t - p_datbeg = '||to_char(l_datend_t - p_datbeg));


    if ((l_datend_t - p_datbeg)> 365) and (l_nbs = '2630')
    then
      begin
      select dat_next_u(holiday, -1)
        into l_datend
        from holiday
       where holiday = trunc(l_datend)
         and kv      = gl.baseval;
    exception
      when no_data_found then null;
    end;
    else l_datend := nvl(l_datend_t,l_datend);
    end if;
   end if;
  end if;

  bars_audit.trace('%s exit with %s', title, to_char(l_datend, 'dd.mm.yyyy'));

  return l_datend;

end get_datend_uni;

--
-- функция расчета даты окончания действия вклада с заданным днем окончания
--
function get_datend_fixday
 (p_datbeg   in  date,    -- дата начала срока действия вклада
  p_mnthcnt  in  number,  -- срок действия вклада в месяцах
  p_dayscnt  in  number,  -- срок действия вклада в днях
  p_endday   in  char)    -- день окончания срока действия вклада (1-31)
  return date             -- дата окончания срока действия вклада
is
  title    varchar2(60)   := 'dpt.getdatendfixday:';
  l_dptdat date;
  l_tmpdat date;
  l_limdat date;
begin

  bars_audit.trace('%s entry, datbeg=>%s, mnthcnt=>%s, dayscnt=>%s, endday=>%s',
                   title, to_char(p_datbeg, 'dd.mm.yyyy'), to_char(p_mnthcnt),
                   to_char(p_dayscnt), p_endday);

  -- дата окончания действия договора (станд.формула)
  l_dptdat := get_datend_uni (p_datbeg, p_mnthcnt, p_dayscnt, null);
  -- граничная дата для поиска даты окончания действия договора
  l_limdat := get_datend_uni (p_datbeg, p_mnthcnt + 1, p_dayscnt, null);

  if to_char(l_dptdat, 'dd') = p_endday then
     bars_audit.trace('%s exit with %s', title, to_char(l_dptdat, 'dd.mm.yyyy'));
     return l_dptdat;
  else
     l_tmpdat := l_dptdat;
     for i in 1..31
     loop
         l_tmpdat := l_tmpdat + 1;
         if to_char(l_tmpdat, 'dd') = p_endday and l_tmpdat <= l_limdat then
            bars_audit.trace('%s exit with %s', title, to_char(l_tmpdat, 'dd.mm.yyyy'));
            return l_tmpdat;
         end if;
     end loop;
     bars_audit.trace('%s exit with %s', title, to_char(l_dptdat, 'dd.mm.yyyy'));
     return l_dptdat;
  end if;

end get_datend_fixday;

--
-- функция прибавления к дате кол-ва месяцев по банковским правилам
--
function add_month (p_datbeg in date, p_mnthcnt in number) return date
is
  l_datend date;
begin

  l_datend := add_months (p_datbeg, p_mnthcnt);

  if to_char(l_datend, 'dd') > to_char(p_datbeg, 'dd') then
     l_datend := to_date(  to_char(p_datbeg, 'dd')
                           ||
                           to_char(l_datend, 'mmyyyy'),
                           'ddmmyyyy');
  end if;

  return l_datend;

end add_month;

--
-- определение ближайшей плановой даты выплаты процентов, исходя из срока
-- действия вклада и условий выплаты процентов по договору
--
function get_intpaydate
 (p_date    in  date,                 -- текущая банковская дата
  p_datbeg  in  date,                 -- дата начала действия вклада
  p_datend  in  date,                 -- дата окончания действия вклада
  p_freqid  in  freq.freq%type,       -- период-ть выплаты процентов
  p_advanc  in  number,               -- признак авансового вклада
  p_extend  in  number,               -- признак переоформленного вклада
  p_nocash  in  number default 0)     -- расчет план.даты для нал/безнал.выплаты
  return   date                       -- ближайшая дата выплаты процентов
is
  title        constant varchar2(60) := 'dpt.getintpaydate:';
  l_freqindex  number(38);
  l_intpaydate date;
  l_tempdat    date;
  l_uppbound   number(38);
begin

  -- проверка корректности заданных параметров
  if p_date   is null
  or p_datbeg is null
  or p_datbeg > p_datend
  or p_datbeg > p_date
  -- or p_freqid not in (1, 2, 3, 5, 7, 30, 180, 360, 400)
  or p_freqid not in (1, 2, 3, 5, 7, 12, 30, 180, 360, 400)
  or p_advanc not in (0, 1)
  or p_extend not in (0, 1) then
     return null;
  end if;

  l_freqindex := case when p_freqid = 3   then  7  --  7 дней
                      when p_freqid = 5   then  1  --  1 мес
                      when p_freqid = 7   then  3  --  3 мес
                      when p_freqid = 30  then 30  -- 30 дней
                      when p_freqid = 180 then  6  --  6 мес
                      when p_freqid = 360 then 12  -- 12 мес
                 end;

  if p_datend <= p_date then
     -- срок действия вклада истек
     l_intpaydate := p_datend;
  elsif p_freqid in (1, 2) then
     -- ежедневная/свободная выплата %%
     l_intpaydate := p_date;
  elsif p_freqid in (3, 30) then
     -- выплата %% каждые 7 / 30 дней
     l_uppbound := round((p_date - p_datbeg + 1)/l_freqindex);
     for i in 1..l_uppbound loop
         l_tempdat := p_datbeg + i * l_freqindex;
         exit when l_tempdat > p_date;
         l_intpaydate := l_tempdat;
     end loop;
  elsif p_freqid in (5, 7, 180, 360) then
  -- выплата %% раз в месяц/квартал/полгода/рік
  -- elsif p_freqid in (5, 7, 180) then
  --   l_uppbound := ceil(months_between (p_date, p_datbeg)/l_freqindex);
    l_uppbound := round(months_between (p_date, p_datbeg)/l_freqindex);

    for i in 1..l_uppbound loop
      l_tempdat := add_month(p_datbeg, i * l_freqindex);
      exit when l_tempdat > (case
                               when p_nocash = 0 then p_date
                               else last_day(p_date)
                             end);
      l_intpaydate := l_tempdat;

    end loop;

  --elsif p_freqid = 360 then
  elsif p_freqid = 12 then
     -- виплата %% 1 раз в рік (дозволена тільки в останній робочий день року)
     l_intpaydate := dat_next_u(add_months(trunc(p_date, 'YEAR'), 12), -1);
     l_intpaydate := least (l_intpaydate, p_datend);
  elsif p_freqid = 400 then
     -- выплата %% в конце срока
     if (p_extend = 1 or p_advanc = 1) then
        -- выплата %% авансом или выплата процентов за прошлый срок
        l_intpaydate := p_datbeg;
     else
        -- выплата %% в конце срока
        l_intpaydate := p_datend;
     end if;
  else
     l_intpaydate := null;
  end if;

  if (l_intpaydate is null) and (p_extend = 1 or p_advanc = 1) then
      l_intpaydate := p_datbeg;
  end if;

  return l_intpaydate;

end get_intpaydate;

--
-- коррекция срока вклада
--
procedure correct_deposit_term
 (p_dptid     in  dpt_deposit.deposit_id%type,  -- идентификатор вклада
  p_datbegold in  dpt_deposit.dat_begin%type,   -- старая дата начала
  p_datendold in  dpt_deposit.dat_end%type,     -- старая дата окончания (м.б.пусто)
  p_datbegnew in  dpt_deposit.dat_begin%type,   -- новая дата начала
  p_datendnew in  dpt_deposit.dat_end%type,     -- новая дата окончания  (м.б.пусто)
  p_cntdubl   in  dpt_deposit.cnt_dubl%type)    -- кол-во пролонгаций    (м.б.пусто)
is
  title     constant varchar2(60) := 'dpt.correctdepterm: ';
  l_nulldat constant date         := to_date('10.11.1900', 'dd.mm.yyyy');
  l_depacc  accounts.acc%type;
  l_intacc  accounts.acc%type;
  l_amracc  accounts.acc%type;
  l_cntdubl dpt_deposit.cnt_dubl%type;
  l_errflg  boolean := false;
begin

  bars_audit.trace('%s entry, dptid=>%s,  cntdubl=>%s, oldterm=>%s-%s, newterm=>%s-%s',
                   title, to_char(p_dptid), to_char(p_cntdubl),
                   to_char(p_datbegold,'dd.mm.yyyy'),  to_char(p_datendold,'dd.mm.yyyy'),
                   to_char(p_datbegnew,'dd.mm.yyyy'),  to_char(p_datendnew,'dd.mm.yyyy'));

  begin
    select d.acc, i.acra, decode(v.amr_metr, 0, null, i.acrb), d.cnt_dubl
      into l_depacc, l_intacc, l_amracc, l_cntdubl
      from dpt_deposit  d,
           dpt_vidd     v,
           int_accn     i
     where d.vidd       = v.vidd
       and d.acc        = i.acc
       and i.id         = 1
       and d.deposit_id = p_dptid
       and d.dat_begin  = p_datbegold
       and nvl(d.dat_end, l_nulldat) = nvl(p_datendold, l_nulldat);
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'CORRTERM_DEPNOTFOUND');
  end;
  bars_audit.trace('%s depacc, intacc, amracc = (%s, %s, %s)', title,
                   to_char(l_depacc), to_char(l_intacc), to_char(l_amracc));

  if (p_datbegnew is null)
  or (p_datbegnew > p_datendnew)
  or (p_cntdubl <= 0)
  or (p_cntdubl != trunc(p_cntdubl)) then
      bars_error.raise_nerror(g_modcode, 'CORRTERM_INVALIDATES');
  end if;

  if  (p_datbegold = p_datbegnew)
  and (nvl(p_datendold, l_nulldat) = nvl(p_datendnew, l_nulldat))
  and (nvl(l_cntdubl, 0) = nvl(p_cntdubl, 0)) then
       bars_error.raise_nerror(g_modcode, 'CORRTERM_NOTHING2CHANGE');
  end if;

  update dpt_deposit
     set dat_begin  = p_datbegnew,
         dat_end    = p_datendnew,
         cnt_dubl   = p_cntdubl
   where deposit_id = p_dptid;

  if p_datbegnew < p_datbegold then

     begin
       insert into int_ratn (acc, id, bdat, ir, op, br)
       select acc, id, p_datbegnew, ir, op, br
         from int_ratn
        where acc  = l_depacc
          and id   = 1
          and bdat = p_datbegold;
     exception
       when dup_val_on_index then null;
     end;

     delete from int_ratn
      where acc  = l_depacc
        and id   = 1
        and bdat = p_datbegold;

     bars_audit.trace('%s rate history updated for %s', title, to_char(p_datbegnew,'dd.mm.yyyy'));

  end if;

  if nvl(p_datendold, l_nulldat) != nvl(p_datendnew, l_nulldat) then

     update accounts set mdate = p_datendnew where acc = l_depacc;
     update accounts set mdate = p_datendnew where acc = l_intacc;
     update int_accn set stp_dat = (p_datendnew - 1) where acc = l_depacc and id = 1;

     bars_audit.trace('%s maturity date updated for %s', title, to_char(p_datendnew,'dd.mm.yyyy'));

     if l_amracc is not null then
        update accounts set mdate = p_datendnew         where acc = l_amracc;
        update int_accn set stp_dat = (p_datendnew - 1) where acc = l_amracc and id = 0;
        update int_accn set stp_dat = (p_datendnew - 1) where acc = l_depacc and id = 3;
     end if;

     if (p_datendnew is not null and p_datendold is not null and p_datendold != p_datbegnew) then

        begin
          insert into int_ratn (acc, id, bdat, ir, op, br)
          select acc, id, p_datendnew, ir, op, br
            from int_ratn
           where acc  = l_depacc
             and id   = 1
             and bdat = p_datendold;
        exception
          when dup_val_on_index then null;
        end;
        delete from int_ratn
         where acc  = l_depacc
           and id   = 1
           and bdat = p_datendold;
        bars_audit.trace('%s rate history updated for %s', title, to_char(p_datendnew,'dd.mm.yyyy'));

     end if;

  end if;

  -- Изменен срок действия вклада № .. с .. на .. . Кол-во пролонгаций изменено с .. на .. .
  bars_audit.info(bars_msg.get_msg (g_modcode, 'CORRECT_DEPTERM_DONE', to_char(p_dptid),
                                    to_char(p_datbegold,'dd.mm.yyyy'), to_char(p_datendold,'dd.mm.yyyy'),
                                    to_char(p_datbegnew,'dd.mm.yyyy'), to_char(p_datendnew,'dd.mm.yyyy'))
                ||case
                  when nvl(l_cntdubl, 0) != nvl(p_cntdubl, 0)
                  then bars_msg.get_msg (g_modcode, 'CORRECT_CNTDUBL_DONE',
                                                    nvl(to_char(l_cntdubl), '< >'),
                                                    nvl(to_char(p_cntdubl), '< >') )
                  end );

exception
  when others then
    bars_error.raise_nerror(g_modcode, 'CORRTERM_FAILED', to_char(p_dptid), sqlerrm);
end correct_deposit_term;

--
-- восстановление фин.реквизитов деп.счетов по вкладам, срок действия которых истек
--
procedure restore_dptlimits
 (p_dptid  in  number, -- идентификатор вклада или 0 (весь портфель вкладов)
  p_bdate  in  date)   -- текущая банковская дата
is
  title  constant varchar2(60)        := 'dpt.restoredptlimits:';
  type  t_dptrec is record  (dptid  number(38),
                             accid  number(38),
                             minsum number(38),
                             maxsum number(38));
  type  t_dpttbl is table of t_dptrec;
  l_dpt t_dpttbl;
  l_cnt number(38) := 0;
begin

  bars_audit.trace('%s entry, dptid=>%s, bdate=>%s', title,
                   to_char(p_dptid), to_char(p_bdate,'dd.mm.yyyy'));

  select d.deposit_id, a.acc, a.lim, a.ostx
    bulk collect
    into l_dpt
    from dpt_deposit d,
         accounts    a,
         (select distinct vidd
            from dpt_vidd_params
           where tag in (min_depamount, max_depamount)) v
   where d.vidd       = v.vidd
     and d.acc        = a.acc
     and not (a.lim   = 0 and a.ostx is null)
     and d.dat_end   <= decode(p_dptid, 0, p_bdate,      d.dat_end)
     and d.deposit_id = decode(p_dptid, 0, d.deposit_id, p_dptid);

  for i in 1..l_dpt.count loop

     begin
       update accounts set lim = 0, ostx = null where acc = l_dpt(i).accid;
       l_cnt := l_cnt + 1;
       bars_audit.trace('%s deposit %s, lim = %s->0, ostx = %s->null', title,
                        to_char(l_dpt(i).dptid), to_char(l_dpt(i).minsum), to_char(l_dpt(i).maxsum));
     exception
       when others then
         bars_error.raise_nerror(g_modcode, 'RESTORE_DPTLIMITS_FAILED', to_char(l_dpt(i).dptid), sqlerrm);
     end;

  end loop;

  if p_dptid = 0 and l_cnt > 0 then
     bars_audit.info(bars_msg.get_msg(g_modcode, 'RESTORE_DPTLIMITS_DONE', to_char(l_cnt)));
  end if;

  bars_audit.trace('%s exit', title);

end restore_dptlimits;

--
-- заполнение неснижаемого и макс.допустимого остатков на деп.счете
--
procedure set_dptlimits_ex
 (p_dptid in dpt_deposit.deposit_id%type) -- идентификатор вклада
is
  title       constant varchar2(60) := 'dptopen.setlimitsex:';
  l_dptype    dpt_deposit.vidd%type;
  l_dptacc    dpt_deposit.acc%type;
begin

  bars_audit.trace('%s запуск, dptid => %s', title, to_char(p_dptid));

  select vidd, acc
    into l_dptype, l_dptacc
    from dpt_deposit
   where deposit_id = p_dptid;

  set_dptlimits (l_dptype, l_dptacc);

  bars_audit.trace('%s выход', title);

exception
  when no_data_found then
    bars_error.raise_nerror(g_modcode, 'DPT_NOT_FOUND', to_char(p_dptid));
end set_dptlimits_ex;

---
-- відкат наслідків штрафування депозиту при сторнуванні операції утримання штрафу
---
procedure REVOKE_PENALTY
( p_ref   in  oper.ref%type,
  p_tt    in  oper.tt%type
) is
  c_title     constant varchar2(60) := 'dpt.revoke_penalty:';
  l_dptid     dpt_deposit.deposit_id%type;
  l_acc       dpt_deposit.acc%type;
  l_DatEnd    dpt_deposit.dat_end%type;
begin

  bars_audit.trace( '%s start with ref = %s.', c_title, to_char(p_ref), p_tt );

  delete from DPT_DEPOSIT_CLOS
        where action_id = 5
          and ref_dps = p_ref
    returning deposit_id, acc, dat_end
         into l_dptid, l_acc, l_DatEnd;

  If (l_dptid is Not Null)
  Then

    -- восстановление фин.реквизитов деп.счета
    dpt.set_dptlimits_ex (l_dptid);

    update INT_ACCN
       set STP_DAT = (l_DatEnd - 1)
     where ACC = l_acc
       and ID  = 1
       and STP_DAT < (l_DatEnd - 1);

  Else

    If ( p_tt in ('DPS','DPT') )
    Then

      begin

        --
        select d.deposit_id, d.acc, d.dat_end
          into l_dptid, l_acc, l_DatEnd
          from DPT_PAYMENTS dp
         inner join DPT_DEPOSIT d on ( d.deposit_id = dp.dpt_id )
         where dp.ref = p_ref;

        -- видалення помітки на закриття депозиту
        delete from DPT_DEPOSITW
         where DPT_ID = l_dptid
           and TAG = '2CLOS';

        -- відновлення СТОП-дати нарахування відсотків
        update INT_ACCN
           set STP_DAT = (l_DatEnd - 1)
         where ACC = l_acc
           and ID  = 1
           and STP_DAT < (l_DatEnd - 1);

      exception
        when NO_DATA_FOUND then
          null;
      end;

    End If;

  End If;

  bars_audit.trace( '%s exit with dpt_id = %s.', c_title, to_char(l_dptid) );

end REVOKE_PENALTY;


END DPT;
/
 show err;
 
PROMPT *** Create  grants  DPT ***
grant EXECUTE                                                                on DPT             to ABS_ADMIN;
grant EXECUTE                                                                on DPT             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT             to CC_DOC;
grant EXECUTE                                                                on DPT             to DPT;
grant EXECUTE                                                                on DPT             to DPT_ADMIN;
grant EXECUTE                                                                on DPT             to DPT_ROLE;
grant EXECUTE                                                                on DPT             to START1;
grant EXECUTE                                                                on DPT             to TECH005;
grant EXECUTE                                                                on DPT             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 
