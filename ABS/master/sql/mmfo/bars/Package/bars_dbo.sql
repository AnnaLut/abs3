
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dbo.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DBO 
is

  -- Author  : LVO
  -- Created : 05/08/2013 09:36:58

  g_header_version  constant varchar2(64) := 'version 5.20 18/03/2015';
  g_awk_header_defs constant varchar2(512) := '';

  type recCCLim is record(
    fdat cc_lim.fdat%type,
    rest cc_lim.lim2%type,
    sumg cc_lim.sumg%type,
    sumo cc_lim.sumo%type,
    sumk cc_lim.sumk%type);

  type tabCCLim is table of recCCLim;
  -------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;
  -------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;
  --------------------------------------------------------------------------------
  -- convertVal
  --
  function convertVal(p_Sin number,p_kvfrom decimal, p_kvto decimal, p_date date) return number;

  --------------------------------------------------------------------------------
  -- gen_statement - получения текущей выписки по счетам
  --
  procedure get_statement(p_date1   date default sysdate,
                          p_date2   date default sysdate,
                          p_nls     varchar2,
                          p_lcv     varchar2,
                          l_stm_res out clob);

  --------------------------------------------------------------------------------
  -- set_head_branch - представляемся головным бранчем
  --
  procedure set_head_branch;

  --------------------------------------------------------------------------------
  -- parse_str - процедура для разбора параметров
  --
  procedure parse_str(p_str varchar2, p_name out varchar2, p_val out varchar2);

  --------------------------------------------------------------------------------
  -- payord - платежный документ по перечислению средств между счетами
  --
  procedure payord(p_type       decimal,
                   p_nd         varchar2,
                   p_datd       date default sysdate,
                   p_kv         varchar2,
                   p_vdat       date default trunc(sysdate),
                   p_s          decimal,
                   p_nazn       varchar2,
                   p_rnka       decimal,
                   p_nlsa       varchar2,
                   p_mfob       decimal,
                   p_nmkb       varchar2,
                   p_nlsb       varchar2,
                   p_okpo       varchar2,
                   p_passport   varchar2,
                   p_param      varchar2 default null,
                   p_ref        out decimal,
                   p_errcod     out decimal,
                   p_errmessage out varchar2);

  procedure payordremove(p_ref        decimal,
                         p_errcode    out decimal,
                         p_errmessage out varchar2);
  --------------------------------------------------------------------------------
  -- используется для получения остатков по указанным в запросе счетам
  --
  function get_account_saldo_xml(p_rnk number,
                                 p_lcv varchar2,
                                 p_nls varchar2) return clob;

  --------------------------------------------------------------------------------
  -- возвращает набор счетов клиента, зарегистрированных в АБС банка
  --
  function get_account_list_xml(p_rnk number) return clob;

  --------------------------------------------------------------------------------
  -- Предназначен для получения информации о клиенте
  --
  function get_customer_xml(p_rnk number) return clob;

  --------------------------------------------------------------------------------
  -- Возвращает список курсов валют
  --
  function get_currency_rate_xml return clob;

  --------------------------------------------------------------------------------
  -- возвращает список банков участников СЭП  (Банки Украины)
  --
  function get_banks_list_xml return clob;

  --------------------------------------------------------------------------------
  -- Проверка состояния документа. Возможные состояние Исполнен,В процессе, Отказан
  --
  function get_kvit_xml(p_ref number) return clob;

  --------------------------------------------------------------------------------
  -- Создание депозита в АБС
  --

   procedure create_deposit_dbo(
                                p_rnk number,
                                p_kv varchar2,
                                p_doc_date Date,
                                p_doc_number varchar2,
                                p_term varchar2,
                                p_type decimal,
                                p_ammount decimal,
                                p_replanish_account varchar2,
                                p_percent_account varchar2,
                                p_percent_account_branch varchar2,
                                p_expire_account varchar2,
                                p_expire_account_branch varchar2,
                                p_cust_id out number,
                                p_ref out number,
                                p_nls out varchar2,
                                p_errcode out number,
                                p_errmessage out varchar2);

  --------------------------------------------------------------------------------
  -- Редактирование счетов депозита
  --
  procedure deposit_service(p_rnk in out number,
  p_reftdn in out varchar2,
  p_doc_date date,
  p_doc_number varchar2,
  /*p_percent_account varchar2,
  p_percent_account_branch varchar2,
  p_expire_account varchar2,
  p_expire_account_branch varchar2,*/
  p_prolongation varchar2,
  p_status out varchar2,
  p_errcode out number,
  p_errmessage out varchar2);

  procedure set_audit_xml(p_inner_xml clob , p_id out decimal);

  procedure upd_audit_xml(p_id        decimal,
                          p_outer_xml clob);

  ----------------------------Вспомогательные-------------------------------------
  --------------------------------------------------------------------------------
  --Предназначен для получения информации о плановых оплаты по договору
  --
  function get_plan(p_nd        number,
                    p_dateStart date,
                    p_dateEnd   date) return xmltype;
  --------------------------------------------------------------------------------
  --Предназначен для получения информации о фактических оплаты по договору
  --
  function get_fact(p_nd        number,
                    p_dateStart date,
                    p_dateEnd   date) return xmltype;
  --------------------------------------------------------------------------------
  --Предназначен для получения информации по плановым оплатам и по фактическим оплатам по договору
  --
  function get_pays(p_nd        number,
                    p_dateStart date,
                    p_dateEnd   date) return xmltype;
  --------------------------------------------------------------------------------
  --Предназначен для получения данных по фактическим оплатам договора
  --
  function fact_table(p_nd        cc_deal.nd%type,
                      p_dateStart date,
                      p_dateEnd   date) return tabCCLim
    pipelined;

  --------------------------------------------------------------------------------
  -- Предназначен для получения процентов по договору
  --
  function get_percent_rate(p_nd number) return number;

  --------------------------------------------------------------------------------
  -- Предназначен для получения сумми оплати по договору на дату
  --

  function plan_sum_pog( p_nd  in  number, p_kv in number,p_vid in number,p_ostx in number, p_cc_pay_s  in number ) return number
   ;
  --------------------------------------------------------------------------------
  -- Предназначен для получения списка кредитов
  --
  function get_loan_list_xml(p_rnk number) return clob;

  --------------------------------------------------------------------------------
  -- Предназначен для получения графика платежей по договору з даты p_dateStart по p_dateEnd по договору p_dateEnd клиента p_rnk
  --
  function get_loan_pay_list_xml(p_rnk       number,
                                 p_nd        number,
                                 p_dateStart date := null,
                                 p_dateEnd   date := null) return clob;
  --------------------------------------------------------------------------------
  --Предназначен для виполнения операции по депозиту/кредиту
  --
  procedure pay_operation(p_rnk           in number,
                          p_refTnd        in number,
                          p_actionCode    in varchar2,
                          p_dayDate       in date default sysdate,
                          p_amount        in decimal,
                          p_abrevKV       in varchar2,
                          p_ammountNumber in varchar2,
                          p_nazn          in varchar2,
                          p_ref           out number,
                          p_errcode       out number,
                          p_errmessage    out varchar2);
end bars_dbo;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DBO 
is

  -- Author  : LVO
  -- Created : 05/08/2013 09:36:58

g_body_version  constant varchar2(64)  := 'version 5.21 20/11/2017';
g_awk_body_defs constant varchar2(512) := '';

g_dbgcode constant varchar2(14) := 'bars_dbo.';

g_op_nls constant varchar2(3 Byte) := 'KL1';
g_op_sep constant varchar2(3 Byte) := 'KL2';
g_op_car constant varchar2(3 Byte) := 'FOK';

g_current_mfo banks.mfo%type;
g_modcode constant varchar2(3) := 'UPB';

g_FOA constant decimal := 6;
g_FOB constant decimal := 5;
g_FOC constant decimal := 8;
g_FOR constant decimal := 7;
--------------------------------------------------------------------------------
-- anks_list_cur - курсор: возвращает список банков участников СЭП  (Банки Украины)
--
cursor banks_list_cur
is with b_list as (select
  mfo,--МФО
  nb--Название банка
from banks$base
   where blk <> 1)
select
XmlAgg(
XmlElement("Bank",
  XmlElement("MFO", b_list.mfo),
  XmlElement("Name", b_list.nb))).getClobVal()
from b_list;

--------------------------------------------------------------------------------
-- customer_cur - курсор: Предназначен для получения информации о клиенте
--
cursor customer_cur(p_rnk number)
is with c as (select
  cus.rnk,--Идентификатор клиента в АБС
  decode(cus.codcagent, 2, 1, 4, 1, 6, 1, 0) as is_rez,--Тип клиента
  cus.nmkk,--Название в фин.документах
  cus.nmk,--Полное название
  cus.nmkv,--Международное название
  cus.okpo,--ИНН
  f_ourmfo as mfo,--МФО
  (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='EMAIL') as e_mail,--Эл.почта
  (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='ELT_N') as elt_n,--Номер договора на обслуживание
  to_char((select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='ELT_D'),'dd.mm.yyyy') as elt_d,--Дата договора на обслуживание
  decode((select count(*) from customer_address ca where ca.rnk=cus.rnk and ca.type_id=1), 0,
                 (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='ADRU'),
                 (select ca.country from customer_address ca where ca.rnk=cus.rnk and ca.type_id=1)) as adr_u,--Юр. адрес. Страна
  decode((select ca.zip from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2), null,
                 (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='FGIDX'),
                 (select ca.zip from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2)) as idx,--Индекс
  decode((select ca.domain from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2), null,
                 (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='FGOBL'),
                 (select ca.domain from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2)) as obl,--Область
  decode((select ca.locality from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2), null,
                 (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='FGTWN'),
                 (select ca.locality from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2)) as twn,--Населенный пункт
  decode((select ca.address from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2), null,
                 (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='FGADR'),
                 (select ca.address from customer_address ca where ca.rnk=cus.rnk and ca.type_id=2)) as adr,--Адрес
  pe.teld,--Основной (домашний) телефон
  pe.telw,--Рабочий телефон
  (select cusw.value from customerw cusw where cusw.rnk=cus.rnk and cusw.tag='MPNO') as mpno,--Мобильный телефон
  pa.name,--Тип документа, удостоверяющего личность (ДУЛ)
  pe.ser,--Серия паспорта (ДУЛ)
  pe.numdoc,--Номер паспорта (ДУЛ)
  to_char(pe.pdate,'dd.mm.yyyy') as pdate,--Дата выдачи паспорта (ДУЛ)
  pe.organ,--Где выдан паспорт (ДУЛ)
  to_char(pe.bday,'dd.mm.yyyy') as bday,--Дата рождения физ. лица
  pe.bplace,--Место рождения физ. лица
  decode(pe.sex, 1, 0, 2, 1, null) as sex,--Пол
  cus.branch--Номер филиала банка, где открыт счет клиента
from customer cus,
     person pe,
     passp pa
   where cus.rnk=p_rnk and cus.rnk=pe.rnk and pe.passp=pa.passp)
select
XmlConcat(
  XmlElement("CustomerID", c.rnk),
  XmlElement("CustomerType", c.is_rez),
  XmlElement("NameShort", c.nmk),
  XmlElement("NameFull", c.nmkk),
  XmlElement("NameLatin", c.nmkv),
  XmlElement("OKPO", c.okpo),
  XmlElement("MFO", c.mfo),
  decode(c.e_mail, null, null ,XmlElement("Email", c.e_mail)),
  decode(c.elt_n, null, null ,XmlElement("ContractNumber", c.elt_n)),
  decode(c.elt_d, null, null ,XmlElement("ContractDate", c.elt_d)),
  decode(c.adr_u, null, null ,XmlElement("LawCountry", c.adr_u)),
  decode(c.idx, null, null ,XmlElement("LawZip", c.idx)),
  decode(c.obl, null, null ,XmlElement("LawState", c.obl)),
  decode(c.twn, null, null ,XmlElement("LawPlace", c.twn)),
  decode(c.adr, null, null ,XmlElement("LawAddress", c.adr)),
  decode(c.teld, null, null ,XmlElement("Phone", c.teld)),
  decode(c.telw, null, null ,XmlElement("WorkPhone", c.telw)),
  decode(c.mpno, null, null ,XmlElement("MobilePhone", c.mpno)),
  XmlElement("PersonalIDDocType", c.name),
  XmlElement("PassportSeries", c.ser),
  XmlElement("PassportNumber", c.numdoc),
  decode(c.pdate, null, null ,XmlElement("PassportData", c.pdate)),
  XmlElement("PassportPlace", c.organ),
  decode(c.bday, null, null ,XmlElement("BirthDate", c.bday)),
  decode(c.bplace, null, null ,XmlElement("BirthPlace", c.bplace)),
  decode(c.sex, null, null ,XmlElement("Gender", c.sex)),
  decode(c.branch, null, null ,XmlElement("Branch", c.branch))).getClobVal()
from c;

--------------------------------------------------------------------------------
-- currency_rate_cur - курсор: Возвращает список курсов валют
--
cursor currency_rate_cur
is with cur_rate as (select
  tb.lcv,--Буквенный ISO-код валюты счета
  cur.kv,--Цифровой ISO-код валюты счета
  '980' as basey,--Цифровой код базовой валюты
  tb.nominal,--Масштаб валюты
  cur.val,--Курс
  cur.col--Тип курса
from (select * from cur_rates cr
      unpivot (val for col in (rate_o as '2', rate_b as '0', rate_s as '1'))) cur,
      tabval tb,
      params$base pb
    where cur.kv=tb.kv and cur.vdate=to_date(pb.val, 'mm.dd.yyyy') and pb.par='BANKDATE' /*and cur.kv > 100*/ order by cur.kv)
select
XmlAgg(
XmlElement("CurrencyRateList",
  decode(cur_rate.lcv, null, null, XmlElement("CurrencyISOA3Code", cur_rate.lcv)),
  XmlElement("CurrencyISONCode", lpad(cur_rate.kv,3,'0')),
  XmlElement("CRB", cur_rate.basey),
  XmlElement("SCALE", cur_rate.nominal),
  XmlElement("Rate", cur_rate.val),
  XmlElement("TYPE", cur_rate.col))).getClobVal()
from cur_rate;

--------------------------------------------------------------------------------
-- account_list_cur - курсор: возвращает набор счетов клиента, зарегистрированных в АБС банка
--
cursor account_list_cur(p_rnk number)
is with acc_list as (select
  a.nls,--Номер счета
  tv.lcv,--Буквенный ISO-код валюты счета
  a.kv,--Цифровой код валюты счета
  a.kf,--MFO код
  a.nms,--Название счета
  a.tip,--Тип счёта
  trim(to_char(/*a.ostc*/fost(a.acc,bankdate_g)/100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as ostc,--Остаток по счёту
  trim(to_char(a.ostf/100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as ostf,--Остаток по счёту с учетом будущих платежей
  to_char(a.daos, 'dd.mm.yyyy') as daos,--Дата открытия
  a.lim,--Неснижаемый остаток по счету
  a.tobo--Номер филиала банка, где открыт счет клиента
from accounts a,
     tabval tv
  where a.kv=tv.kv and a.rnk=p_rnk and a.nbs in (2620) and a.dazs is null)
select
XmlAgg(
XmlElement("Account",
  XmlElement("Number", acc_list.nls),
  decode(acc_list.lcv, null, null, XmlElement("CurrencyISOA3Code", acc_list.lcv)),
  decode(acc_list.kv, null, null, XmlElement("CurrencyISONCode", acc_list.kv)),
  decode(acc_list.kf, null, null, XmlElement("MFO", acc_list.kf)),
  XmlElement("Name", acc_list.nms),
  XmlElement("Type", acc_list.tip),
  XmlElement("Saldo", acc_list.ostc),
  XmlElement("SaldoPlan", acc_list.ostf),
  decode(acc_list.daos, null, null, XmlElement("DateBegin", acc_list.daos)),
  decode(acc_list.lim, null, null, XmlElement("Limit", acc_list.lim)),
  decode(acc_list.tobo, null, null, XmlElement("Branch", acc_list.tobo)))).getClobVal()
from acc_list;

--------------------------------------------------------------------------------
-- account_saldo_cur - курсор: используется для получения остатков по указанным в запросе счетам
--
cursor account_saldo_cur(p_rnk number, p_lcv varchar2, p_nls varchar2)
is with acc_sal as (select
  tv.lcv,--Буквенный ISO код валюты
  a.nls,--Номер счета
  trim(to_char(fost(
     a.acc,bankdate_g)/100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as ostc--Сальдо
from accounts a,
     tabval tv
  where a.rnk=p_rnk and tv.lcv=p_lcv and a.nls=p_nls and a.kv=tv.kv)
select
XmlElement("Account",
  XmlElement("CurrencyISOA3Code", acc_sal.lcv),
  XmlElement("Number", acc_sal.nls),
  XmlElement("Saldo", acc_sal.ostc)).getClobVal()
from acc_sal;

cursor account_stm_cur(p_nls varchar2, p_kv decimal, p_date1 date, p_date2 date)
is with acc_stm as (select
  a.kf,
  a.branch,
  a.nls,
  tv.lcv,
  a.nms,
  a.tip,
  trim(to_char(fost(a.acc,(select max(fdat) from fdat where fdat < p_date1))/100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as ostf,
  trim(to_char(fost(a.acc,p_date2)/100,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as osst
from accounts a, tabval tv
  where a.nls = p_nls and a.kv = p_kv and a.kv = tv.kv)
select
XmlConcat(
  decode(acc_stm.kf, null, null, XmlElement("MFO", acc_stm.kf)),
  decode(acc_stm.branch, null, null, XmlElement("Branch", acc_stm.branch)),
  XmlElement("Number", acc_stm.nls),
  XmlElement("CurrencyISOA3Code", acc_stm.lcv),
  XmlElement("Name", acc_stm.nms),
  XmlElement("Type", acc_stm.tip),
  XmlElement("InBalance", acc_stm.ostf),
  XmlElement("OutBalance", acc_stm.osst)).getClobVal()
from acc_stm;

--------------------------------------------------------------------------------
-- stm_cur - курсор: предназначен для получения текущей выписки по счетам
--
cursor stm_cur(p_nls varchar2, p_kv decimal, p_date_b date, p_date_e date)
is with stm as (select
  to_char(vrp.datd, 'dd.mm.yyyy') as datd,--Дата документа
  trim(to_char(vrp.s,'999999999999999990D99','NLS_NUMERIC_CHARACTERS=''. ''')) as s,--Сумма движения вал
  --vrp.sq,--Сумма движения екв
  vrp.nd,--Номер документа
  vrp.nls2,--Расчетный счет контрагента
  vrp.mfo2,--МФО банка счет контрагента
  vrp.tt,--Описание операции
  vrp.nazn--Назначение платежа
from --accounts a,
     v_rptlic vrp
  where /*a.nls=vrp.nls*/vrp.nls = p_nls and vrp.kv = p_kv
        and vrp.datd >= p_date_b
        and vrp.datd <= (case when p_date_e > bankdate_g then
                                   bankdate_g
                              else p_date_e
                         end))
select
XmlAgg(
  XmlElement("STM",
    XmlElement("Date", stm.datd),
    XmlElement("Amount", stm.s),
    --XmlElement("AmountEkv", stm.sq),
    decode(stm.nd, null, null, XmlElement("DocNumber", stm.nd)),
    decode(stm.nls2, null, null, XmlElement("AccountNumber", stm.nls2)),
    decode(stm.mfo2, null, null, XmlElement("MFO", stm.mfo2)),
    decode(stm.tt, null, null, XmlElement("Description", stm.tt)),
    decode(stm.nazn, null, null, XmlElement("PaymentDetails", stm.nazn)))).getClobVal()
from stm;

--------------------------------------------------------------------------------
-- kvit_cur - курсор: Проверка состояния документа. Возможные состояние Исполнен,В процессе, Отказан
--
cursor kvit_cur(p_ref number)
is with kvit as (select
  op.ref,--Референс документа
  (case
    when op.sos in (-1, -2, 99) then 3
    when op.sos in (0, 3) then 2
    when op.sos in (1, 5) then 1
   end) as status,--Состояние
  decode(op.sos, -1,
        (select value from operw where ref=op.ref and tag='BACKR'),
        null) as des--Детальное описание состояния
from oper op where op.ref=p_ref)
select
XmlAgg(
XmlElement("Document",
  XmlElement("REF", kvit.ref),
  XmlElement("Status", kvit.status),
  XmlElement("Description", kvit.des))).getClobVal()
from kvit;

--------------------------------------------------------------------------------
-- deposit_list_cur - курсор: Возвращает набор депозитов клиента
--
cursor deposit_list_cur(p_cust_id number)
is select dpa.dpt_accnum,
       dpa.dpt_curcode,
       dpa.cust_name,
       dpa.vidd_code,
       dpa.int_kos,
       dpa.dpt_saldo_pl,
       dpa.dat_begin,
       dpa.dat_end,
       v.term_add,
       v.min_summ as lim,
       v.min_summ as minrep,
       dpa.dpt_id,
       decode(v.extension_id,2,1,0) as isprologable
  from v_dpt_portfolio_active dpa,
       dpt_vidd v
 where dpa.vidd_code = v.vidd
   and dpa.cust_id = p_cust_id;

--------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
  begin
    return 'Package header bars_nokk_mgr '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

--------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
  begin
    return 'Package body bars_nokk_mgr '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;
--------------------------------------------------------------------------------
-- convertVal
--
function convertVal(p_Sin number,p_kvfrom decimal, p_kvto decimal, p_date date) return number is
  begin
    tuda;
    if p_sin is null then
      return null;
    end if;
    return gl.p_ncurval(p_kvto,gl.p_icurval(p_kvfrom,p_Sin*1000000000,p_date),p_date)/1000000000;
  end;

--------------------------------------------------------------------------------
-- get_statement - получения текущей выписки по счетам
--
procedure get_statement(p_date1 date default sysdate, p_date2 date default sysdate, p_nls varchar2, p_lcv varchar2, l_stm_res out clob)
  is
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_statement';
  l_kv decimal;
  l_acc_stm clob;
  l_stm clob;
  begin
    bars_audit.trace('%s: entry point', l_th);
    bars_audit.info(l_th||' start. Вхідні параметри: date_start - '||p_date1||', date_end - '||p_date2||', nls - '||p_nls);

    begin
      select a.kv into l_kv from accounts a, tabval t where a.nls = p_nls and t.lcv=p_lcv and a.kv=t.kv;
    exception
      when no_data_found then
        --l_stm := null;
        bars_error.raise_nerror(g_modcode, 'ACC_NOTFOUND', p_nls, to_char(l_kv));
    end;

    bars_audit.trace('%s: p_date1=%s, p_date2=%s, p_nls=%s, p_kv=%s',
      l_th, to_char(p_date1), to_char(p_date2), p_nls, to_char(l_kv));

    if l_kv = 980 then
      bars_rptlic.lic_grnb (p_date1, p_date2, p_nls, 0, '%', 0);
    else
      bars_rptlic.lic_valb (p_date1, p_date2, p_nls, l_kv, 0, '%', 0);
    end if;

    open account_stm_cur(p_nls, l_kv, p_date1, p_date2);
    fetch account_stm_cur into l_acc_stm;
    close account_stm_cur;

    open stm_cur(p_nls, l_kv, p_date1, p_date2);
    fetch stm_cur into l_stm;
    close stm_cur;

    l_stm_res := null;

    if l_stm is not null then
      l_stm_res := '<Account>'||l_acc_stm||l_stm||'</Account>';
    else
      l_stm_res := '<Account>'||l_acc_stm||'</Account>';
    end if;
    bars_audit.info(l_th||' exit.');
    bars_audit.trace('%s: done', l_th);
end get_statement;

--------------------------------------------------------------------------------
-- ref - генерация референса
--
function get_ref  return number is
  ern constant positive := 201;
  l_ref number;
begin
  select s_oper.nextval into l_ref from dual;
  return l_ref;
exception
  when others then
    raise_application_error(-(20000+ern),'\'||'9345 - Cannot obtain ref value :'||
    sqlerrm, true);
end get_ref;

function get_current_mfo return varchar2 is
begin
  if g_current_mfo is null then
    g_current_mfo := f_ourmfo_g;
  end if;
  return g_current_mfo;
end;

function get_head_branch return varchar2 is
begin
  return bc.make_branch(get_current_mfo);
end;

--------------------------------------------------------------------------------
-- set_head_branch - представляемся головным бранчем
--
procedure set_head_branch is
  l_th constant varchar2(100) := g_dbgcode || 'subst_mfo';
  l_user_branch branch.branch%type;
begin
  bars_audit.trace('%s: entry point', l_th);
  l_user_branch := sys_context('bars_context','user_branch');
  if l_user_branch is null or l_user_branch = '/' then
    bc.subst_branch(get_head_branch);
  end if;
  bars_audit.trace('%s: branch is %s', l_th, to_char(get_head_branch));
  bars_audit.trace('%s: done', l_th);
end;

--------------------------------------------------------------------------------
-- parse_str - процедура для разбора параметров
--
procedure parse_str(p_str varchar2, p_name out varchar2, p_val out varchar2)
is
begin
  p_name := substr(p_str,0,instr(p_str,'-')-1);
  p_val := substr(p_str,instr(p_str,'-')+1);
end;

--------------------------------------------------------------------------------
-- payord - платежный документ по перечислению средств между счетами
--
procedure payord(
  p_type decimal,
  p_nd varchar2,
  p_datd date default sysdate,
  p_kv varchar2,
  p_vdat date default trunc(sysdate),
  p_s decimal,
  p_nazn varchar2,
  p_rnka decimal,
  p_nlsa varchar2,
  p_mfob decimal,
  p_nmkb varchar2,
  p_nlsb varchar2,
  p_okpo varchar2,
  p_passport varchar2,
  p_param varchar2 default null,
  p_ref out decimal,
  p_errcod out decimal,
  p_errmessage out varchar2
  )
is
  l_tt varchar2(3 Byte);
  l_ref decimal;
  l_impdoc xml_impdocs%rowtype;
  acca accounts%rowtype;
  cusa customer%rowtype;
  l_dk decimal;
  l_doc bars_xmlklb_imp.t_doc;
  l_dreclist  bars_xmlklb.array_drec;
  l_errcode decimal;
  l_errmsg varchar2(4000);
  l_branch branch.branch%type;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'payord';
  l_vob decimal := 6;
  l_kv decimal;
  l_nbs decimal;
  l_rnka decimal;
  l_str varchar2(4000);
  l_tmp varchar2(4000);
  l_length decimal;
  l_name varchar2(100);
  l_val varchar2(100);
  l_key decimal := 0;
  l_recid number;
  l_param varchar2(4000) := null;
  pay_extern_doc_ex exception;
begin
  bars_audit.trace('%s: start, acc %s, kv %s', l_th, p_nlsa, to_char(l_kv));
  bars_audit.info(l_th||' start. Вхідні параметри: nls - '||p_nlsa||' kv - '||l_kv);
  /*for c in (select * from holiday)
    loop
      if trunc(sysdate) = c.holiday then
        l_key := 1;
      end if;
    end loop;
  if trunc(sysdate) != bankdate and l_key != 1 then
    bars_error.raise_nerror(g_modcode, 'NCOR_BANKDATE', 'Банківська дата суттєво відрізняється від поточної');
  end if;*/

  savepoint sp_paystart;

  begin
    begin
       select kv into l_kv from tabval$global where lcv=p_kv;
    exception when no_data_found then
      bars_error.raise_nerror(g_modcode, 'KV_NOTFOUND', p_kv);
    end;

    begin
       select nbs into l_nbs from accounts where nls = p_nlsa and kv = l_kv and dazs is null;
    exception when no_data_found then
      bars_error.raise_nerror(g_modcode, 'ACC_NOTFOUND', p_nlsa, to_char(p_kv));
    end;
    if l_nbs = '2924' then
      if p_type = 3 then
        select tt into l_tt from dbo_tt_operationkind where operation_kind = p_type;
      elsif p_type = 4 then
        select tt into l_tt from dbo_tt_operationkind where operation_kind = p_type;
        l_rnka := p_rnka;
      else
        select tt into l_tt from dbo_tt_operationkind where operation_kind = 20;
        select rnk into l_rnka from accounts where nls=p_nlsa and kv = l_kv and dazs is null;
      end if;
    else
      begin
        select tt into l_tt from dbo_tt_operationkind where operation_kind = p_type;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode, 'PAYMENT_ERR', 'Не вказано тип операції');
      end;
      l_rnka := p_rnka;
    end if;

    begin
      select vob into l_vob from tts_vob where tt = l_tt and rownum = 1;
    exception
      when no_data_found then null;
    end;

    -- ищем бранч счета
    begin
      select * into acca
        from accounts a
       where nls = p_nlsa
         and kv = l_kv
         and dazs is null;
    exception when no_data_found then
      bars_audit.trace('%s: error detected, acc %s not found', l_th, acca.kf);
      bars_error.raise_nerror(g_modcode, 'ACC_NOTFOUND', p_nlsa, to_char(p_kv));
    end;

    l_branch := acca.branch;

    --bars_audit.info('DBO_TST l_rnka = '||l_rnka);
    begin
      if l_rnka = -1 or l_rnka is null then
        select * into cusa from customer c where c.rnk = (select rnk from accounts where nls = p_nlsa and kv = l_kv and dazs is null);
        l_rnka := cusa.rnk;
      else
        select * into cusa from customer c where c.rnk = l_rnka;
      end if;
    exception when no_data_found then
      bars_audit.trace('%s: error detected, rnk %s not found', l_th, cusa.rnk);
      bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(l_rnka));
    end;

    --алгоритм разбора клиентов которые не имеют ИНН
    if cusa.okpo = '000000000' then
      begin
        select 'Ф-'||ser||numdoc||';' into l_param from person where rnk = cusa.rnk;
      exception
        when no_data_found then
          bars_error.raise_nerror(g_modcode, 'PER_NOTFOUND', to_char(cusa.rnk));
      end;
    end if;

    if p_okpo = '000000000' and p_passport is not null then
      l_param := 'ф-'||p_passport||';';
    end if;

    set_head_branch();

    -- представляемся отделением
    bc.subst_branch(l_branch);

    l_ref := get_ref();

    l_errcode:=null;
    l_errmsg:=null;

    l_dk:=1;

    l_impdoc.ref_a  := null ;
    l_impdoc.impref := null ;
    l_impdoc.nd     := p_nd;
    l_impdoc.datd   := p_datd;
    l_impdoc.vdat   := p_vdat    ;
    l_impdoc.nam_a  := cusa.nmkk   ;
    l_impdoc.mfoa   := acca.kf    ;
    l_impdoc.nlsa   := p_nlsa    ;
    l_impdoc.id_a   := cusa.okpo   ;
    l_impdoc.nam_b  := p_nmkb    ;
    l_impdoc.mfob   := p_mfob    ;
    l_impdoc.nlsb   := p_nlsb    ;
    l_impdoc.id_b   := p_okpo   ;
    l_impdoc.s      := p_s * 100       ;
    l_impdoc.kv     := l_kv      ;
    l_impdoc.s2     := p_s * 100       ;
    l_impdoc.kv2    := l_kv      ;
    l_impdoc.sk     := null      ;
    l_impdoc.dk     := l_dk      ;
    l_impdoc.tt     := l_tt      ;
    l_impdoc.vob    := l_vob     ;
    l_impdoc.nazn   := p_nazn    ;
    l_impdoc.datp   := p_datd     ;

--    l_impdoc.drec

    l_impdoc.userid := null     ;

    l_impdoc.d_rec  := null;

    l_doc.doc  := l_impdoc;
    if p_param is not null or cusa.okpo = '000000000' or (p_okpo = '000000000' and p_passport is not null) then
      if p_param is not null then
        l_param := l_param||p_param;
      end if;
      l_length := length(l_param) - length(replace(l_param,';'));
      l_str :=l_param;
      for i in 0..l_length - 1 loop
        l_tmp := substr(l_str, 0, instr(l_str,';')-1);
        l_str := substr(l_str, instr(l_str,';')+1);
        parse_str(l_tmp,l_name,l_val);
        l_doc.drec(i).tag := l_name;
        l_doc.drec(i).val := l_val;
      end loop;
    end if;

    bars_xmlklb_imp.pay_extern_doc( p_doc  => l_doc,
                        p_errcode => l_errcode,
                        p_errmsg  => l_errmsg );

   if l_errcode = 0 then
      bars_audit.trace('%s: entry ref block Ref:%s', l_th, to_char(l_doc.doc.ref));
      -- проверка красного сальдо
      begin
        select * into acca
          from accounts a
         where nls = p_nlsa
           and kv = l_kv
           and dazs is null;
      exception when no_data_found then
        bars_audit.trace('%s: error detected, acc %s not found', l_th, acca.kf);
        bars_error.raise_nerror(g_modcode, 'ACC_NOTFOUND', p_nlsa, to_char(p_kv));
      end;

      --bars_audit.info('Начало проверки остатка счета '||acca.nls||', ostb = '||to_char(acca.ostb));
      if acca.ostb < 0 and acca.pap = 2 then
         --bars_audit.info('Проверка остатка счета '||acca.nls||', ostb = '||acca.ostb);
         rollback to savepoint sp_paystart;
         bars_error.raise_nerror(g_modcode, 'ACC_LIMIT', acca.nls);
      end if;

      if acca.ostb > 0 and acca.pap = 1 then
         --bars_audit.info('Проверка остатка счета '||acca.nls||', ostb = '||acca.ostb);
         rollback to savepoint sp_paystart;
         bars_error.raise_nerror(g_modcode, 'ACC_LIMIT', acca.nls);
      end if;
      --bars_audit.info('Конец проверки остатка счета '||acca.nls||', ostb = '||to_char(acca.ostb));

      p_ref := l_doc.doc.ref;
      p_errcod := 0;
      p_errmessage := null;
      bars_audit.trace('%s: out ref block', l_th);
    else
      bars_audit.trace('%s: entry error block Code:%s Msg:%s', l_th, to_char(l_errcode), l_errmsg);
      p_errcod := l_errcode;
      p_errmessage := l_errmsg;
      p_ref := null;
      rollback to savepoint sp_paystart;
      bars_audit.trace('%s: out error block', l_th);
    end if;

    bc.set_context;

  exception
    when others then

      rollback to savepoint sp_paystart;

      p_errcod := sqlcode;
      p_errmessage := sqlerrm;
      p_ref := null;

      -- возврат контекста
      bc.set_context;

       -- запись полного сообщения об ошибке в журнал
       bars_audit.error(sqlerrm);
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
          dbms_utility.format_error_backtrace(), '', null, l_recid);


      bars_audit.trace('%s: exception block entry point', l_th);
      bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_th, to_char(p_errcod), p_errmessage);
  end;
  bars_audit.info(l_th||' exit. Вихідні параметри: ref - '||p_ref);
  bars_audit.trace('%s: stop ', l_th);

end payord;

procedure payordremove(p_ref decimal, p_errcode out decimal, p_errmessage out varchar2)
is
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'payordremove';
  l_errcode decimal;
  l_errmsg varchar2(4000);
  l_ref decimal;
begin
  bars_audit.info(l_th||' start. Вхідні параметри: ref - '||p_ref);
  begin
    select o.ref into l_ref from oper o where o.ref = p_ref;
  exception when no_data_found then
    l_ref := p_ref;
  end;
  p_back_dok(l_ref, 5, null, l_errcode, l_errmsg);

  if l_errcode is null then
     bars_audit.trace('%s: entry ref block Ref:%s', l_th, to_char(p_ref));
     p_errcode := 0;
     p_errmessage := null;
     bars_audit.trace('%s: out ref block', l_th);
  else
     bars_audit.trace('%s: entry error block Code:%s Msg:%s', l_th, to_char(l_errcode), l_errmsg);
     p_errcode := l_errcode;
     p_errmessage := l_errmsg;
     bars_audit.trace('%s: out error block', l_th);
  end if;
  bars_audit.info(l_th||' exit.');
exception when others then
  p_errcode := sqlcode;
  p_errmessage := sqlerrm;
end;

--------------------------------------------------------------------------------
-- используется для получения остатков по указанным в запросе счетам
--
function get_account_saldo_xml(p_rnk number, p_lcv varchar2, p_nls varchar2) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_account_saldo';
  l_cusnum number;
  l_accnum number;
  l_kv number;
begin
  bars_audit.trace('%s: entry function, rnk=%s, lcv=%s, nls=%s', l_th, to_char(p_rnk), p_lcv, p_nls);
  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||to_char(p_rnk)||', lcv - '||p_lcv||', nls - '||p_nls);
  --проверка на наличие РНК
  select count(*) into l_cusnum from customer where rnk=p_rnk;
  if l_cusnum = 0 then
    bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
  end if;
  --выборка кода валюты
  select kv into l_kv from tabval where lcv=p_lcv;

  begin
    open account_saldo_cur(p_rnk, p_lcv, p_nls);
    fetch account_saldo_cur into l_clob;

    if account_saldo_cur%notfound then
      close account_saldo_cur;
      bars_error.raise_nerror(g_modcode, 'ACC_NOTFOUND', p_nls, to_char(l_kv));
    end if;

    close account_saldo_cur;
  exception
    when others then
      if account_saldo_cur%isopen then
        close account_saldo_cur;
      end if;
      raise;
  end;
  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_account_saldo_xml;

--------------------------------------------------------------------------------
-- возвращает набор счетов клиента, зарегистрированных в АБС банка
--
function get_account_list_xml(p_rnk number) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_account_list';
  l_cusnum number;
begin
  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||p_rnk);
  --проверка на наличие РНК
  select count(*) into l_cusnum from customer where rnk=p_rnk;
  if l_cusnum = 0 then
    bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
  end if;

  begin
    open account_list_cur(p_rnk);
    fetch account_list_cur into l_clob;

    if l_clob is null then
      close account_list_cur;
      l_clob := ' ';
      --bars_error.raise_nerror(g_modcode, 'CUS_ACC_NOTFOUND', to_char(p_rnk));
    end if;

    --close account_list_cur;
  exception
    when others then
      if account_list_cur%isopen then
        close account_list_cur;
      end if;
      raise;
  end;
  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_account_list_xml;

--------------------------------------------------------------------------------
-- Предназначен для получения информации о клиенте
--
function get_customer_xml(p_rnk number) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_customer';
  l_cusnum number;
begin
  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||p_rnk);
  --проверка на наличие РНК
/*  select count(*) into l_cusnum from customer where rnk=p_rnk;
  if l_cusnum = 0 then

  end if;
  */
  begin
    open customer_cur(p_rnk);
    fetch customer_cur into l_clob;

    if customer_cur%notfound then
      close customer_cur;
      bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
    end if;

    close customer_cur;

  exception when others then
    if customer_cur%isopen then
      close customer_cur;
    end if;
    raise;
  end;

  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_customer_xml;

--------------------------------------------------------------------------------
-- Возвращает список курсов валют
--
function get_currency_rate_xml return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_currency_rate';
  l_bdate varchar2(100);
begin
  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start.');
  select to_char(pb.val) into l_bdate from params$base pb where pb.par='BANKDATE';
  begin
    open currency_rate_cur;
    fetch currency_rate_cur into l_clob;

    if currency_rate_cur%notfound then
      close currency_rate_cur;
      bars_error.raise_nerror(g_modcode, 'CURRANCY_NOTFOUND', to_char(to_date(l_bdate, 'mm.dd.yyyy')));
    end if;

    close currency_rate_cur;
  exception
    when others then
      if currency_rate_cur%isopen then
        close currency_rate_cur;
      end if;
      raise;
  end;
  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_currency_rate_xml;

--------------------------------------------------------------------------------
-- возвращает список банков участников СЭП  (Банки Украины)
--
function get_banks_list_xml return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_banks_list';
begin
  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start.');
  open banks_list_cur;
  fetch banks_list_cur into l_clob;
  close banks_list_cur;
    bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_banks_list_xml;

--------------------------------------------------------------------------------
-- Проверка состояния документа. Возможные состояние Исполнен,В процессе, Отказан
--
function get_kvit_xml(p_ref number) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_kvit';
  l_docnum number;
begin
  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start. Вхідні параметри: ref - '||p_ref);
  --проверка на наличие документа
  /*select count(*) into l_docnum from oper where ref=p_ref;
  if l_docnum = 0 then
    bars_error.raise_error(g_modcode, 2, to_char(p_ref));
  end if;*/

  open kvit_cur(p_ref);
  fetch kvit_cur into l_clob;
  close kvit_cur;
  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_kvit_xml;

--------------------------------------------------------------------------------
-- Создание депозита в АБС
--
procedure create_deposit_dbo(p_rnk number,
  p_kv varchar2,
  p_doc_date Date,
  p_doc_number varchar2,
  p_term varchar2,
  p_type decimal,
  p_ammount decimal,
  p_replanish_account varchar2,
  p_percent_account varchar2,
  p_percent_account_branch varchar2,
  p_expire_account varchar2,
  p_expire_account_branch varchar2,
  p_cust_id out number,
  p_ref out number,
  p_nls out varchar2,
  p_errcode out number,
  p_errmessage out varchar2)
is
  --l_rnk number;
  l_dpt_id number;
  l_kv decimal;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'create_deposit_dbo';
  l_vidd dpt_vidd%rowtype;
  l_nms_p accounts.nms%type;
  l_okpo_p customer.okpo%type;
  l_nls_p accounts.nls%type;
  l_kf_p accounts.kf%type;
  l_nms_d accounts.nms%type;
  l_okpo_d customer.okpo%type;
  l_nls_d accounts.nls%type;
  l_kf_d accounts.kf%type;
  l_expire_account accounts%rowtype;
  l_customer customer%rowtype;
  l_dpt_dep dpt_deposit%rowtype;
  l_doc_ref decimal;
  l_doc_err_code decimal;
  l_doc_err_msg varchar(4000);
  l_rep_acc accounts%rowtype;
  l_mfob decimal;
  l_nmkb varchar2(1000);
  l_nlsb varchar2(15);
  l_okpob customer.okpo%type;
  l_nlst varchar2(15);
begin

  bars_audit.trace('%s: entry function', l_th);

  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||p_rnk);

  bars_audit.info(l_th||' exit.');

  bars_audit.trace('%s: done. Out params: p_ref=%s', l_th, p_ref);

end create_deposit_dbo;

--------------------------------------------------------------------------------
-- Редактирование счетов депозита
--
procedure deposit_service(p_rnk in out number,
  p_reftdn in out varchar2,
  p_doc_date date,
  p_doc_number varchar2,
  /*p_percent_account varchar2,
  p_percent_account_branch varchar2,
  p_expire_account varchar2,
  p_expire_account_branch varchar2,*/
  p_prolongation varchar2,
  p_status out varchar2,
  p_errcode out number,
  p_errmessage out varchar2)
is
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'deposit_service';
  l_dpt_list v_dpt_portfolio_active%rowtype;
  /*l_nms_p dpt_deposit.name_p%type;
  l_okpo_p dpt_deposit.okpo_p%type;
  l_nls_p dpt_deposit.nls_p%type;
  l_mfo_p dpt_deposit.mfo_p%type;
  l_nms_d dpt_deposit.nms_d%type;
  l_okpo_d dpt_deposit.okpo_d%type;
  l_nls_d dpt_deposit.nls_d%type;
  l_mfo_d dpt_deposit.mfo_d%type;
  l_nlst accounts.nls%type;*/
  l_vidd dpt_vidd%rowtype;
  l_recid number;
begin
  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||p_rnk||' договір №'||p_reftdn);

  begin
    select * into l_dpt_list from v_dpt_portfolio_active dpa where dpa.dpt_id = p_reftdn and dpa.cust_id = p_rnk;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'DPT_NOTFOUND', p_reftdn);
  end;

  begin
    select * into l_vidd from dpt_vidd v where v.vidd = l_dpt_list.vidd_code and v.vidd > 0 and v.flag = 1 and v.datk is null;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'DPT_VIDD_NOTFOUND', to_char(l_dpt_list.vidd_code));
  end;

  begin
    if p_prolongation = 'N' then
      dpt_web.fix_extcancel(l_dpt_list.dpt_id, 1);
    end if;

    p_reftdn := p_reftdn;
    p_rnk := l_dpt_list.cust_id;
    p_status := 'Accepted';
    p_errcode := 0;
    p_errmessage := null;
  exception
    when others then
      p_reftdn := p_reftdn;
      p_rnk := l_dpt_list.cust_id;
      p_status := 'NotAccepted';
      p_errcode := sqlcode;
      p_errmessage := sqlerrm;
      -- запись полного сообщения об ошибке в журнал
      bars_audit.error(sqlerrm);
      bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
      dbms_utility.format_error_backtrace(), '', null, l_recid);
  end;

  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done. Out params: p_reftdn=%s', l_th, p_reftdn);
end deposit_service;

--------------------------------------------------------------------------------
-- Запись запросов в журнал
--
procedure set_audit_xml(p_inner_xml clob, p_id out decimal)
is
--p_id number;
begin
  p_id:=s_aud.nextval;
  --insert into bars_dbo_audit(id,time,inner_xml)
  --values(p_id,sysdate, p_inner_xml);
end set_audit_xml;

--------------------------------------------------------------------------------
-- Запись ответов журнал
--
procedure upd_audit_xml(p_id decimal, p_outer_xml clob)
is
begin null;
  --update bars_dbo_audit b
  --set b.outxml=p_outer_xml where b.id=p_id;
end upd_audit_xml;



-------------------------------------------
--Danysh S.T
--


--------------------------------------------------------------------------------
--Предназначен для получения информации о плановых оплаты по договору
--
function get_plan(p_nd number,p_dateStart date,p_dateEnd date) return xmltype is
  ll_xml xmltype;
begin
with c as (
select
lag(null, 1,b.TotalAmount) over (order by b.ddate) TotalAmount,
lag(null, 1,b.TotalBody) over (order by b.ddate) TotalBody,
lag(null, 1,b.TotalPercent) over (order by b.ddate) TotalPercent,
lag(null, 1,b.TotalCommission) over (order by b.ddate) TotalCommission,
lag(null, 1,b.TotalRest) over (order by b.ddate) TotalRest,
       b.ddate,
       b.Amount,
       b.Body,
       b.Percent,
       b.Commission,
       b.Rest
from (
select sum(a.Amount) over() TotalAmount,
       sum(a.Body) over() TotalBody,
       sum(a.Percent) over() TotalPercent,
       sum(a.Commission) over() TotalCommission ,
       min(rest) over () TotalRest,
       a.dDate,
       a.Amount,
       a.Body,
       a.Percent,
       a.Commission,
       a.Rest
  from (
select cc.fdat ddate,
       round(cc.sumo/100,2) Amount,
       round(cc.sumg/100,2) Body,
       round((cc.sumo-cc.sumg-nvl(sumk,0))/100,2) Percent,
       round(nvl(cc.sumk,0),2) Commission,
       round(cc.lim2/100,2) Rest
from cc_lim cc where cc.nd=p_nd and cc.fdat<=p_dateEnd and cc.fdat>=p_dateStart order by fdat desc
) a ) b)
select
Xmlagg(xmlconcat(
decode(c.TotalAmount,null,null, Xmlelement("TotalAmount",c.TotalAmount )) ,
decode(c.TotalBody,null,null, Xmlelement("TotalBody",c.TotalBody )) ,
decode(c.TotalPercent,null,null, Xmlelement("TotalPercent",c.TotalPercent )) ,
decode(c.TotalCommission,null,null, Xmlelement("TotalCommission",c.TotalCommission )) ,
decode(c.TotalRest,null,null, Xmlelement("Rest",c.TotalRest )) ,
Xmlelement("Pay",
       Xmlelement("Date",c.dDate),
       Xmlelement("Amount",c.Amount),
       Xmlelement("Body",c.Body),
       Xmlelement("Percent",c.Percent),
       Xmlelement("Commission",c.Commission),
       Xmlelement("Rest",c.Rest)
       ))) into ll_xml
 from c;

if ll_xml is not null then
  select XmlElement("Plan",ll_xml) into ll_xml from dual;
end if;
return ll_xml;
end get_plan;

--------------------------------------------------------------------------------
--Предназначен для получения информации о фактических оплаты по договору
--
function get_fact(p_nd number,p_dateStart date,p_dateEnd date) return xmltype is
  ll_xml xmltype;
begin
with c as (
select
lag(null, 1,b.TotalAmount) over (order by b.ddate) TotalAmount,
lag(null, 1,b.TotalBody) over (order by b.ddate) TotalBody,
lag(null, 1,b.TotalPercent) over (order by b.ddate) TotalPercent,
lag(null, 1,b.TotalCommission) over (order by b.ddate) TotalCommission,
lag(null, 1,b.TotalRest) over (order by b.ddate) TotalRest,
       b.ddate,
       b.Amount,
       b.Body,
       b.Percent,
       b.Commission,
       b.Rest
from (
select sum(a.Amount) over() TotalAmount,
       sum(a.Body) over() TotalBody,
       sum(a.Percent) over() TotalPercent,
       sum(a.Commission) over() TotalCommission ,
       min(rest) over () TotalRest,
       a.dDate,
       a.Amount,
       a.Body,
       a.Percent,
       a.Commission,
       a.Rest
  from (
select cc.fdat ddate,
       round(cc.sumo/100,2) Amount,
       round(cc.sumg/100,2) Body,
       round((cc.sumo-cc.sumg-nvl(sumk,0))/100,2) Percent,
       round(nvl(cc.sumk,0)/100,2) Commission,
       round(cc.rest/100,2) Rest
from table(bars_dbo.fact_table(p_nd,p_dateStart,p_dateEnd)) cc order by cc.fdat desc
) a ) b order by b.ddate desc)
select
Xmlagg(xmlconcat(
decode(c.TotalAmount,null,null, Xmlelement("TotalAmount",c.TotalAmount )) ,
decode(c.TotalBody,null,null, Xmlelement("TotalBody",c.TotalBody )) ,
decode(c.TotalPercent,null,null, Xmlelement("TotalPercent",c.TotalPercent )) ,
decode(c.TotalCommission,null,null, Xmlelement("TotalCommission",c.TotalCommission )) ,
decode(c.TotalRest,null,null, Xmlelement("Rest",c.TotalRest )) ,
Xmlelement("Pay",
       Xmlelement("Date",c.dDate),
       Xmlelement("Amount",c.Amount),
       Xmlelement("Body",c.Body),
       Xmlelement("Percent",c.Percent),
       Xmlelement("Commission",c.Commission),
       Xmlelement("Rest",c.Rest)
       ))) into ll_xml
 from c;

if ll_xml is not null then
  select XmlElement("Fact",ll_xml) into ll_xml from dual;
end if;
return ll_xml;
end get_fact;


--------------------------------------------------------------------------------
--Предназначен для получения информации по плановым оплатам и по фактическим оплатам по договору
--
function get_pays(p_nd number,p_dateStart date,p_dateEnd date) return xmltype is
  ll_xml xmltype;
begin
   with c as (
select
round(sum(cc.sumo)/100,2) TotalAmount,
round(sum(cc.sumo-nvl(sumk,0))/100,2) TotalBodyPercent,
round(sum(cc.sumg)/100,2) TotalBody,
round(sum(cc.sumo-cc.sumg-nvl(sumk,0))/100,2) TotalPercent,
round(sum(nvl(cc.sumk,0)),2) TotalCommission,
(select round(l.lim2/100,2) from cc_lim l where l.nd=p_nd and l.fdat=p_dateEnd) Rest,
cc.nd
  from cc_lim cc
 where cc.nd=p_nd
 group by cc.nd
 )
select

Xmlconcat(
    decode(c.TotalAmount, null, null ,XmlElement("TotalAmount", c.TotalAmount)),
    decode(c.TotalBodyPercent, null, null ,XmlElement("TotalBodyPercent", c.TotalBodyPercent)),
    decode(c.TotalBody, null, null ,XmlElement("TotalBody", c.TotalBody)),
    decode(c.TotalPercent, null, null ,XmlElement("TotalPercent", c.TotalPercent)),
    decode(c.TotalCommission, null, null ,XmlElement("TotalCommission", c.TotalCommission)),
    decode(c.Rest, null, null ,XmlElement("Rest", c.Rest))
    ,get_fact(p_nd,p_dateStart,p_dateEnd)
    ,get_plan(p_nd,p_dateStart,p_dateEnd)
    ) into ll_xml
from c;
if ll_xml is not null then
  select XmlElement("Pays",ll_xml) into ll_xml from dual;
end if;
return ll_xml;
end get_pays;

--------------------------------------------------------------------------------
--Предназначен для получения данных по фактическим оплатам договора
--
function fact_table(p_nd cc_deal.nd%type,p_dateStart date,p_dateEnd date) return tabCCLim pipelined
  as
begin
  for cur in (
      select tt.fdat,
             (select abs(nvl(fost(aa.acc,tt.fdat),0))
                from accounts aa,nd_acc na
               where aa.acc=na.acc
                 and na.nd=p_nd
                 and aa.tip in ('LIM'/*'SS','SP','SL','SN','SPN','SLN','SK0','SK9','SN8'*/)
                ) rest,
             sum(pogt)               pogg,
             sum(pogt+pogp+pogk+pen) pogo,
             sum(pogk)               pogk
        from
        (select d.fdat, k.s pogt, to_number(0) pogp, to_number(0) pogk, to_number(0) pen
          from (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s
                  from opldok   o,
                        accounts a,
                       saldoa   s
                 where o.dk = 0
                   and a.acc = o.acc
                /*   and a.acc in (select ac.acc
                                   from nd_acc n,accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc)*/
                   and a.nbs in (select nbs
                                   from nbs_deb_pog)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.dos > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) d,
               (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s,
                       a.nbs
                  from accounts a,
                       opldok   o,
                       saldoa   s
                 where o.dk = 1
                   and a.acc = o.acc
                   and a.acc in (select ac.acc
                                   from nd_acc n,
                                   accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc
                                  and ac.tip in ('SS','SP'))
                   and a.nbs in (select nbs
                                   from nbs_krd_pogt)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.kos  > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) k
         where k.ref  = d.ref
           and k.stmt = d.stmt
           and d.fdat = k.fdat
               union all
        select d.fdat, to_number(0) pogt, to_number(0) pogp, k.s pogk, to_number(0) pen
          from (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s
                  from opldok   o,
                       accounts a,
                       saldoa   s
                 where o.dk = 0
                   and a.acc = o.acc
                  /* and a.acc in (select ac.acc
                                   from nd_acc n,accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc)*/
                   and a.nbs in (select nbs
                                 from nbs_deb_pog
                               union all
                               select '3800'
                                 from dual)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.dos > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) d,
               (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s
                  from accounts a,
                       opldok   o,
                       saldoa   s
                 where o.dk = 1
                   and a.acc = o.acc
                   and a.acc in (select ac.acc
                                   from nd_acc n,
                                   accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc
                                  and ac.tip in ('SK0','SK9'))
                   and a.nbs in (select nbs
                                   from nbs_krd_pogk)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.kos  > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) k
         where k.ref  = d.ref
           and k.stmt = d.stmt
           and d.fdat = k.fdat
               union all
         select d.fdat, to_number(0) pogt, k.s pogp, to_number(0) pogk, to_number(0) pen
          from (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s
                  from opldok   o,
                        accounts a,
                       saldoa   s
                 where o.dk = 0
                   and a.acc = o.acc
                   /*and a.acc in (select ac.acc
                                   from nd_acc n,accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc)*/
                   and a.nbs in (select nbs
                                   from nbs_deb_pog)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.dos > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) d,
               (select o.fdat,
                       o.ref,
                       o.stmt,
                       o.s,
                       a.nbs,
                       a.tip
                  from accounts a,
                       opldok   o,
                       saldoa   s
                 where o.dk = 1
                   and a.acc = o.acc
                   and a.acc in (select ac.acc
                                   from nd_acc n,
                                   accounts ac
                                where nd = p_nd
                                  and ac.acc=n.acc
                                  and ac.tip in ('SN','SPN') )
                   and a.nbs in (select nbs
                                   from nbs_krd_pogp)
                   and s.acc = a.acc
                   and o.fdat = s.fdat
                   and s.kos  > 0
                   and s.fdat >= p_dateStart
                   and s.fdat <= p_dateEnd
                   ) k
         where k.ref  = d.ref
           and k.stmt = d.stmt
           and d.fdat = k.fdat
        union all
        select o.fdat, to_number(0) pogt, to_number(0) pogp, to_number(0) pogk, o.s pen
                  from accounts a,
                       opldok   o,
                       saldoa   s
                 where o.dk = 1 and
                    a.acc = o.acc
                   and a.acc in (select ac.acc
                                   from nd_acc n,
                                   accounts ac
                                where nd = p_nd
                          and ac.acc=n.acc
                          and ac.tip in ('SN8'))
           and s.acc = a.acc
           and o.fdat = s.fdat
           and s.kos  > 0
           and s.fdat >= p_dateStart
           and s.fdat <= p_dateEnd
        ) tt
         group by fdat
         order by 2,1
)
loop
  pipe row (cur);
end loop;
end;


--------------------------------------------------------------------------------
-- Предназначен для получения процентов по договору
--
function get_percent_rate(p_nd number) return number is
  l_rate number;
  begin
    select RATE into l_rate
    from (SELECT ACRN.FPROCN(ACC,0, gl.bd) RATE
                        FROM (SELECT A.ACC FROM ACCOUNTS A,INT_ACCN I,nd_acc n
                        WHERE n.acc=a.acc
                        and a.tip in ('SS','LIM')
                        and (select count(1) from saldoa sa where sa.acc=a.acc)!=0
                        AND I.ID=0 AND I.ACC=A.ACC and n.nd=p_nd
                              ORDER BY decode(ACRN.FPROCN(a.ACC,0, gl.bd),0,0,1), A.daos desc  )
                        WHERE ROWNUM =1
                   );
  return l_rate;
  end;

--------------------------------------------------------------------------------
-- Предназначен для получения планового платежа по телу с учетом просрочки
--
function plan_sum_pog ( p_nd  in  number, p_kv in number,p_vid in number,p_ostx in number, p_cc_pay_s  in number ) return number
  is
  -- CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0');
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'plan_sum_pog';
  del_SK4       number:=0   ; -- дельта досрочного погашения (для относительного метода CCK_PAY_S=1)

 type t_lim  is record
  (
  nd        number(10),
  fdat      date,
  lim2      number(38,2),
  acc       integer,
  not_9129  integer,
  sumg      number(38,2),
  sumo      number(38,2),
  otm       integer,
  kf        varchar2(6 byte),
  sumk      number (38,2),
  not_sn    integer
  );

  rLim t_lim; -- данные ГПК за текщий платежный период
  nSS_ number;

begin

     bars_audit.trace(l_th||': Start ND='||to_char(P_ND)||' KV='||to_char(P_KV)||' VID='||to_char(P_VID)||' X_OST='||to_char(P_OSTX)||' CC_PAY_S='||to_char(P_CC_PAY_S));
       dbms_output.put_line ('Start');

  -- Остаток по договору
 begin
  SELECT Nvl(-SUM(a.ostb+a.ostf),0)/100
    INTO  nSS_
    FROM accounts a, nd_acc n
   WHERE n.nd=P_ND and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
         and a.kv=P_KV;
 exception when no_data_found then
  dbms_output.put_line ('SS='||nSS_);
  return 0;
  nSS_:=0;
 end;

 logger.trace('CCK_PLAN_SUM_POG: Плановый остаток по КД nSS='||TO_CHAR(nSS_));

 begin
  -- 3)ближайший платеж
   select      fdat, lim2/100, sumg/100, nvl(sumk/100,0), sumo/100
     into rLim.fdat,rLim.lim2,rLim.SUMg,rLim.SUMk       ,rLim.SUMo
     from cc_lim l
    where l.nd=P_ND and (l.nd,l.fdat)=
          (select nd,min(fdat) from cc_lim
           where nd=P_ND and fdat >= gl.BDATE and sumg>0
           group by nd
          );

   bars_audit.trace(l_th||': платеж следующий к оплате fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);

  --  считаем такой вид кредита "кредитной линией" которая
  --  не предпологает погашения тела кредита

  -- Для всех банков следующий платеж еще не наступил -  кроме UPB
  if rLim.fdat>add_months(cck_app.CorrectDate2(980,gl.bd,0),1)   -- or   ( rLim.fdat>last_day(gl.bd))
                            then
     bars_audit.trace(l_th||': следующий платеж еще не наступил');
     rLim.LIM2:=abs(P_OSTX/100);
     rLim.SUMo:=0;
     rLim.sumg:=0;
     rLim.SUMk:=0;
  end if;


 EXCEPTION  WHEN NO_DATA_FOUND THEN
     rLim.Lim2:=abs(P_OSTX/100);
     rLim.SUMo:=0; rLim.SUMg:=0; rLim.SUMk:=0;
 end;

  -- Узнаем дельту переплаты для относительного метода
  if P_CC_PAY_S in (1,-1) or P_VID=4 then
   begin

     -- погашение по КД за тек месяц
     SELECT greatest(Nvl(SUM(s.KOS),0)-Nvl(SUM(decode(a.tip,upper('SP '),s.DOS,0)),0)- Nvl(SUM(decode(a.tip,upper('SP '),s.KOS,0)),0) ,0)/100
       INTO  Del_SK4
       FROM accounts a, nd_acc n,saldoa s
      WHERE n.nd=P_ND and n.acc=a.acc and a.tip in (upper('SS '),upper('SP'))
            and a.kv=P_KV and s.acc=a.acc
            and s.fdat>(select max(fdat) from cc_lim
                         where nd=P_ND and fdat < gl.BDATE and sumg>0
                       );


  --   Del_SK4:=greatest(l_limit-nSS1_- Del_SK4,0);
  --   Del_SK4:=greatest(nvl(Del_SK4,0),0);  -- дельта платежа с учетом погашения
  --   факт досрочки         досрочка - тек платеж
   /*
   if rLim.LIM2+rLim.Sumg-nSS_>0 then
      -- if rLim.LIM2+rLim.Sumg-nSS_<=DEL_SK4 then
       if rLim.LIM2-nSS_>=DEL_SK4-rLim.Sumg then
          DEL_SK4:=rLim.Sumg;
       else
          DEL_SK4:=rLim.Sumg-least(rLim.LIM2-nSS_,DEL_SK4);
       end if;
   else
      DEL_SK4:=0;
   end if;
   */
      --оплаченная уже сумма за тек месяц равна = сумма тек платежа - неоплаченная дельта по ГПК
      -- обороты позволяют контрол что это оплата тек месяца
     DEL_SK4:=greatest(least(rLim.Sumg,DEL_SK4)-greatest(nSS_-rLim.LIM2,0),0);


     bars_audit.trace(l_th||': Дельта переплаты Del_SK4='||to_char(Del_SK4));
   exception when no_data_found then
     Del_SK4:=0;
     bars_audit.trace(l_th||': Дельта переплаты exception Del_SK4='||to_char(Del_SK4));
   end;
  end if;




  -- платеж по телу кредита

  --If rLim.fdat is not null then
    If p_vid=4 or p_cc_pay_s=1 then   -- при отметке о погашении не предлагать тек платеж
          nSS_:= greatest(nSS_-rLim.LIM2,least( rLim.SUMg-Del_SK4,nSS_),0) ; --без каникул
    else
          nSS_:= greatest(nSS_-rLim.LIM2,0); --с каникулами
    end if;
return nSS_*100;
END;

--------------------------------------------------------------------------------
-- Предназначен для получения списка кредитов
--
function get_loan_list_xml(p_rnk number) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_loan';
begin
  begin
 with c as (
select (select t.name from cc_potra t where t.id=cc.prod) CredType,
        cc.Sdate ContractDate,
        cc.cc_id ContractNumber,
        cc.Wdate DateEnd,
        bars_dbo.get_percent_rate(cc.nd) Percents,
        (select name from freq f where f.freq=aa.freq) PayPeriod,
        null PayStartDate,
        (select lcv from TABVAL t where t.kv=aa.kv) CurrencyISOA3Code,
        round(cc.sdog,2) Amount,
        (select round(abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100,2) from accounts a, nd_acc n where n.acc=a.acc and a.tip='SS' and n.nd=cc.nd) Rest,
        (select a.nls from accounts a, nd_acc n where n.acc=a.acc and a.tip in ('SG') and n.nd=cc.nd and a.dazs is null and a.kv=aa.kv) AccountNumber,
        (select round(abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100,2) from accounts a, nd_acc n where n.acc=a.acc and a.tip='SN' and n.nd=cc.nd) PercentAmount,
        (case when
              (select nvl(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)),0)
                 from accounts a, nd_acc n
                 where n.acc=a.acc and a.tip in ('SN','SPN','SLN') and n.nd=cc.nd )<0 then
              trunc(sysdate)
              else
              (select min(fdat) from cc_lim l where l.fdat>=trunc(sysdate) and l.nd=cc.nd and nvl(l.sumo-l.sumg-nvl(l.sumk,0),0) !=0 ) end
        ) PercentPayTerm,
        (select round(abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100,2) from accounts a, nd_acc n where n.acc=a.acc and a.tip in('SP','SL') and n.nd=cc.nd) OutstandingDebt,
        (select round(abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100,2) from accounts a, nd_acc n where n.acc=a.acc and a.tip in('SPN','SLN') and n.nd=cc.nd) OutstandingPrc,
        (select round(acrn.FPROCN(a.acc,0,trunc(sysdate))+
                      acrn.FPROCN(a.acc,2,trunc(sysdate))
                   ,2)
           from accounts a, nd_acc n
          where nd=cc.nd and
                a.acc = n.acc and
                a.tip = 'SP' and
                a.dazs is null
                and a.kv=aa.kv) OutstandingPercent,
        (select decode(t.sos,10,0,15,1,13,2) from CC_SOS t where t.sos=cc.sos) Status,
        aa.wdate DateBegin,
        /*(select
                (select round(sumo/100,2)
                   from cc_lim
                  where nd = cc.nd
                    and fdat = (select min(fdat)
                                  from cc_lim l
                                 where nd = cc.nd
                                 and sumo>0
                                   and fdat > trunc(sysdate))
            )
         from dual)*/
          round(

               ((select bars_dbo.plan_sum_pog(c.nd,a.kv,a.vid,a.ostx,0)
                  from cc_deal c,accounts a,nd_acc n
                 where a.acc=n.acc and
                       n.nd=c.nd and
                       a.tip='LIM' and
                       c.nd=cc.nd and a.kv=aa.kv)
         +
                (select abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))
           from accounts a, nd_acc n
          where n.acc=a.acc
            and a.tip in ('SN','SPN','SLN','SN8','SK0','SK9')
            and n.nd=cc.nd))
         /100,2) MinRepay,
        (select
                (select round(nvl(sumo-sumg-nvl(sumk,0),0)/100,2)
                   from cc_lim
                  where nd = cc.nd
                    and fdat = (select min(fdat)
                                  from cc_lim l
                                 where nd = cc.nd
                                 and nvl(sumo,0) !=0
                                   and fdat > trunc(sysdate))
            )
         from dual) PercentPay,
        (select round(abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100,2) from accounts a, nd_acc n where n.acc=a.acc and a.tip='SN8' and n.nd=cc.nd ) OutFine,
        null Fine,
        round(

               ((select bars_dbo.plan_sum_pog(c.nd,a.kv,a.vid,a.ostx,0)
                  from cc_deal c,accounts a,nd_acc n
                 where a.acc=n.acc and
                       n.nd=c.nd and
                       a.tip='LIM' and
                       c.nd=cc.nd and a.kv=aa.kv)
         +
                (select abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))
           from accounts a, nd_acc n
          where n.acc=a.acc
            and a.tip in ('SN','SPN','SLN','SN8','SK0','SK9')
            and n.nd=cc.nd))
         /100,2) TotalSum,

         --round(bars_dbo.get_sum_pay(cc.nd,cc.cc_id,trunc(sysdate),aa.kv)/100,2) TotalSum,
         --Дата след погашения
        (select min(fdat)
           from cc_lim l
          where l.nd=cc.nd
            and lim2<(select abs(fost(a.acc,gl.bd))
                        from nd_acc n, accounts a
                       where a.acc=n.acc
                         and n.nd=cc.nd
                         and a.tip='LIM')
            and l.fdat>trunc(sysdate)
            and nvl(l.sumo,0) !=0) PayTerm,
        to_char(cc.nd) RefTdn,
        --Сумма досрочного погашения
        (select abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))/100
           from accounts a, nd_acc n
          where n.nd = cc.nd
            and n.acc = a.acc
            and a.tip in ('SS ', -- SS  Основний борг
                          'SN ', -- SN  Процентний борг
                          'SP ', -- SP  Просрочений осн.борг
                          'SPN', -- SPN Просрочений проц.борг
                          'SL ', -- SL  Сумнівний осн.борг
                          'SLN', -- SLN Сомнительный процентный долг
                          'SK0', -- SK0 Нарах. комісія за кредит
                          'SK9', -- SK9 Просроч. комісія за кредит
                          'SN8'  -- SN8 Нарах.пеня
                          )) AmountEarlyPay,
        -- Остання оплата по кредиту
        (select max(s.fdat)
           from nd_acc n,
                accounts a,
                saldoa s
          where a.acc=s.acc
            and n.acc=a.acc
            and nd=cc.nd
            and tip='SG'
            and s.kos!=0) DateLastPay,
        --сума останнього погашення
        (select sa.kos/100
           from nd_acc   nn,
                accounts aa,
                saldoa   sa
          where aa.acc = sa.acc
            and nn.acc = aa.acc
            and aa.tip = 'SG'
            and nn.nd = cc.nd
            and sa.fdat = (select max(s.fdat)
                             from nd_acc   n,
                                  accounts a,
                                  saldoa   s
                            where a.acc = s.acc
                              and n.acc = a.acc
                              and n.nd = cc.nd
                              and a.tip = 'SG'
                              and s.kos != 0)
) AmountLastPay,
        null InqLoanPenalty,
        null InqIntPenalty,
        (select cck_plan_sum_pog(c.nd,a.kv,a.vid,a.ostx,0)
                  from cc_deal c,accounts a,nd_acc n
                 where a.acc=n.acc and
                       n.nd=c.nd and
                       a.tip='LIM' and
                       c.nd=cc.nd and a.kv=aa.kv) dod1
  from cc_deal cc,
       cc_add aa
 where aa.nd=cc.nd
 and   aa.kf=cc.kf
 and   cc.rnk=p_rnk
 and   cc.sos not in (14,15)
 )
select
XmlElement("Loans",
XmlAgg(
XmlElement("Loan",
  XmlElement("CredType", c.CredType),
  XmlElement("ContractDate", c.ContractDate),
  XmlElement("ContractNumber", c.ContractNumber),
  decode(c.DateEnd, null, null ,XmlElement("DateEnd", c.DateEnd)),
  XmlElement("Percents", c.Percents),
  decode(c.PayPeriod, null, null ,XmlElement("PayPeriod", c.PayPeriod)),
  decode(c.PayStartDate, null, null ,XmlElement("PayStartDate", c.PayStartDate)),
  XmlElement("CurrencyISOA3Code", c.CurrencyISOA3Code),
  XmlElement("Amount", c.Amount),
  XmlElement("Rest", c.Rest),
  XmlElement("AccountNumber", c.AccountNumber),
  XmlElement("PercentAmount", c.PercentAmount),
  decode(c.PercentPayTerm, null, null ,XmlElement("PercentPayTerm", c.PercentPayTerm)),
  XmlElement("OutstandingDebt", c.OutstandingDebt),
  XmlElement("OutstandingPrc", c.OutstandingPrc),
  XmlElement("OutstandingPercent", c.OutstandingPercent),
  XmlElement("Status", c.Status),
  decode(c.DateBegin, null, null ,XmlElement("DateBegin", c.DateBegin)),
  decode(c.MinRepay, null, null ,XmlElement("MinRepay", c.MinRepay)),
  decode(c.PercentPay, null, null ,XmlElement("PercentPay", c.PercentPay)),
  decode(c.OutFine, null, null ,XmlElement("OutFine", c.OutFine)),
  decode(c.Fine, null, null ,XmlElement("Fine", c.Fine)),
  decode(c.TotalSum, null, null ,XmlElement("TotalSum", c.TotalSum)),
  decode(c.PayTerm, null, null ,XmlElement("PayTerm", c.PayTerm)),
  decode(c.RefTdn, null, null ,XmlElement("RefTdn", c.RefTdn)),
  decode(c.InqLoanPenalty, null, null ,XmlElement("InqLoanPenalty", c.InqLoanPenalty)),
  decode(c.InqIntPenalty, null, null ,XmlElement("InqIntPenalty", c.InqIntPenalty)),
  decode(c.AmountEarlyPay, null, null ,XmlElement("AmountEarlyPay", c.AmountEarlyPay)),
  decode(c.DateLastPay, null, null ,XmlElement("DateLastPay", c.DateLastPay)),
  decode(c.AmountLastPay, null, null ,XmlElement("AmountLastPay", c.AmountLastPay))))).getClobVal() into l_clob
from c;
  exception
  when NO_DATA_FOUND then
    bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
  when others then
    raise;
  end;

  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;

end get_loan_list_xml;

--------------------------------------------------------------------------------
-- Предназначен для получения графика платежей по договору з даты p_dateStart по p_dateEnd по договору p_nd клиента p_rnk
--
function get_loan_pay_list_xml(p_rnk number,p_nd number,p_dateStart date:=null,p_dateEnd date:=null) return clob
is
  l_clob clob;
  l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'get_loan';
  l_dateStart date;
  l_dateEnd date;
  l_count number;
begin

  if p_dateStart is null then
   select min(fdat) into l_dateStart from cc_lim l where l.nd=p_nd;
  else l_dateStart:=p_dateStart;
  end if;

  if p_dateEnd is null then
   select max(fdat) into l_dateEnd from cc_lim l where l.nd=p_nd;
  else l_dateEnd:=p_dateEnd;
  end if;

  begin
  select count(1) into l_count from customer c where c.rnk=p_rnk;
  if l_count=0 then
    bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
    end if;
  end;

  begin
  select count(1) into l_count from cc_deal c where c.rnk=p_rnk and c.nd=p_nd;
  if l_count=0 then
    bars_error.raise_nerror(g_modcode, 'ND_NOTFOUND', to_char(p_nd));
  end if;
  end;

  with c as (
    select
    cc.sdate DateBegin,
    cc.wdate DateEnd,
    cc.cc_id DocNumber,
    (select lcv from TABVAL t,nd_acc a, accounts ac where ac.acc=a.acc and a.nd=cc.nd and t.kv=ac.kv and ac.tip='LIM' and ac.dazs is null) CurrencyISONCode,
    (select nls from accounts a,nd_acc n where a.acc=n.acc and n.nd=cc.nd and a.tip='SG' and a.kv=aa.kv) AccountNumber,
    cc.sdog Amount,
    (select round(acrn.FPROCN(a.acc,0,sysdate),2) from nd_acc a, accounts ac,tips t where ac.acc=a.acc and a.nd=cc.nd and ac.tip=t.tip and ac.tip='SS' and ac.dazs is null) Percent,
    (select round(acrn.FPROCN(a.acc,-2,sysdate),2) from nd_acc a, accounts ac,tips t where ac.acc=a.acc and a.nd=cc.nd and ac.tip=t.tip and ac.tip='LIM' and ac.dazs is null) Commission,
    (select abs(sum(bars_dbo.convertVal(fost(a.acc,trunc(sysdate)),a.kv,aa.kv,gl.bd)))
           from accounts a, nd_acc n
          where n.nd = cc.nd
            and n.acc = a.acc
            and a.tip in ('SS ', -- SS  Основний борг
                          'SN ', -- SN  Процентний борг
                          'SP ', -- SP  Просрочений осн.борг
                          'SPN', -- SPN Просрочений проц.борг
                          'SL ', -- SL  Сумнівний осн.борг
                          'SLN', -- SLN Сомнительный процентный долг
                          'SK0', -- SK0 Нарах. комісія за кредит
                          'SK9', -- SK9 Просроч. комісія за кредит
                          'SN8'  -- SN8 Нарах.пеня
                          )) dod1,
        -- Остання оплата по кредиту
        (select max(s.fdat)
           from nd_acc n,
                accounts a,
                saldoa s
          where a.acc=s.acc
            and n.acc=a.acc
            and nd=cc.nd
            and tip='SG'
            and s.kos!=0) dod2,
        --сума останнього погашення
        (select sa.kos
           from nd_acc   nn,
                accounts aa,
                saldoa   sa
          where aa.acc = sa.acc
            and nn.acc = aa.acc
            and aa.tip = 'SG'
            and nn.nd = cc.nd
            and sa.fdat = (select max(s.fdat)
                             from nd_acc   n,
                                  accounts a,
                                  saldoa   s
                            where a.acc = s.acc
                              and n.acc = a.acc
                              and n.nd = cc.nd
                              and a.tip = 'SG'
                              and s.kos != 0)
    ) dod3,
    cc.nd
    from cc_deal cc, cc_add aa
    where cc.nd=aa.nd
      and aa.kf=cc.kf
      and cc.nd=p_nd
      and cc.rnk=p_rnk
  )
    select
    XmlElement("LoanPayList",
    XmlConcat(
      decode(c.DateBegin, null, null ,XmlElement("DateBegin", c.DateBegin)),
      decode(c.DateEnd, null, null ,XmlElement("DateEnd", c.DateEnd)),
      decode(c.DocNumber, null, null ,XmlElement("DocNumber", c.DocNumber)),
      decode(c.CurrencyISONCode, null, null ,XmlElement("CurrencyISONCode", c.CurrencyISONCode)),
      decode(c.AccountNumber, null, null ,XmlElement("AccountNumber", c.AccountNumber)),
      decode(c.Amount, null, null ,XmlElement("Amount", c.Amount)),
      decode(c.Percent, null, null ,XmlElement("Percent", c.Percent)),
      decode(c.Commission, null, null ,XmlElement("Commission", c.Commission))
      ,bars_dbo.get_pays(c.nd,l_dateStart,l_dateEnd)
      )).getClobVal() into l_clob
  from c;

  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
  return l_clob;
end get_loan_pay_list_xml;



procedure pay_operation(p_rnk           in     number,
                        p_refTnd        in     number,
                        p_actionCode    in     varchar2,
                        p_dayDate       in     date default sysdate,
                        p_amount        in     decimal,
                        p_abrevKV       in     varchar2,
                        p_ammountNumber in     varchar2,
                        p_nazn          in     varchar2,
                        p_ref              out number,
                        p_errcode          out number,
                        p_errmessage       out varchar2)
  is
   l_th constant varchar2(100) := 'Запит від ДБО процедура ' || g_dbgcode || 'pay_operation';
   l_count number:=0;
   l_actionCode decimal:=0;
   l_rnka number;
   l_nlsa accounts.nls%type;
   l_mfob varchar2(100);
   l_nmkb customer.nmk%type;
   l_nlsb accounts.nls%type;
   l_okpo customer.okpo%type;
   l_nbsa accounts.nbs%type;
   l_cntdep number;
   l_key decimal := 0;
   l_dpt_saldo v_dbo_deposit_list.dpt_saldo%type;
   l_lim v_dbo_deposit_list.lim%type;
   l_nbs accounts.nbs%type;
   l_limit dpt_vidd.limit%type;
   l_recid number;
   l_rnk number;
   l_nazn varchar2(1000);
  begin

  bars_audit.trace('%s: entry function', l_th);
  bars_audit.info(l_th||' start. Вхідні параметри: rnk - '||p_rnk);
  /*for c in (select * from holiday)
    loop
      if trunc(sysdate) = c.holiday then
        l_key := 1;
      end if;
    end loop;
  if trunc(sysdate) != bankdate and l_key != 1 then
    bars_error.raise_nerror(g_modcode, 'PAYMENT_ERR', 'Банківська дата суттєво відрізняється від поточної');
  end if;*/

  /*  select count(1) into l_count from customer c where c.rnk=p_rnk;
    if l_count=0 then
     bars_error.raise_nerror(g_modcode, 'RNK_NOTFOUND', to_char(p_rnk));
    end if;
  */
  if substr(p_ammountNumber,1,4) = '2924' then
    l_rnk := -1;
  else
    l_rnk := p_rnk;
  end if;

  if p_actionCode in ('DEPADD')  then
     select a.rnk,
            a.nls,
            a.nbs
       into l_rnka,
            l_nlsa,
            l_nbsa
       from accounts a
      where a.nls=p_ammountNumber
        and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk)
        and a.kv=(select kv from tabval$global where lcv=p_abrevKV)
        and a.dazs is null;

     select a.nbs,
            dv.limit
       into l_nbs,
            l_limit
       from dpt_deposit dd,
            dpt_vidd dv,
            accounts a
      where dd.vidd = dv.vidd
        and dd.acc = a.acc
        and dd.rnk = decode(l_rnk, -1, dd.rnk, null, dd.rnk, p_rnk)
        and dd.deposit_id = p_refTnd;
     l_nazn := 'Поповнення вкладу згідно договору №'||to_char(p_refTnd)||' від '||to_char(trunc(sysdate),'dd.mm.yyyy');
     /*Пополнение депозита*/
     if (l_nbs = '2630' and (l_limit is null or l_limit = 0))
     then
       bars_error.raise_nerror(g_modcode, 'DPT_MAKEDEP', p_refTnd);
     end if;
     /*Минимальная сумма пополнения*/
     if l_limit > p_amount then
       bars_error.raise_nerror(g_modcode, 'DPT_MINSUM_AMMOUNT', p_refTnd);
     end if;

     l_mfob:=get_current_mfo;

     select count(*)
       into l_cntdep
       from saldoa s,
            accounts a,
            dpt_deposit d
      where d.acc=a.acc
        and a.kv=d.kv
        and s.kos>0
        and a.acc=s.acc
        and d.deposit_id=p_refTnd
        and a.dazs is null;

        if (l_cntdep>0) then
          l_actionCode:=g_FOB;--'FOB';
        else
          l_actionCode:=g_FOA;--'FOA';
        end if;
     select c.nmk,
            a.nls,
            c.okpo
       into l_nmkb,
            l_nlsb,
            l_okpo
       from accounts a, dpt_deposit d,customer c
      where c.rnk=a.rnk
        and d.acc=a.acc
        and d.deposit_id=p_refTnd
        and a.dazs is null
        and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk);

     elsif p_actionCode in ('DEPTRANS') then
     select a.rnk,
            a.nls,
            a.nbs
       into l_rnka,
            l_nlsa,
            l_nbsa
       from accounts a,
            dpt_deposit d
      where d.acc=a.acc
        and d.deposit_id=p_refTnd
        and a.kv=(select kv from tabval$global where lcv=p_abrevKV)
        and a.dazs is null
        and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk);
     l_nazn := 'Повернення вкладу, виплата вкладу згідно договору №'||to_char(p_refTnd)||' від '||to_char(trunc(sysdate),'dd.mm.yyyy');
     /*Частичное снятие*/
     if (l_nbsa = '2630')
     then
       bars_error.raise_nerror(g_modcode, 'DPT_PARTIAL_WITHDRAWAL', p_refTnd);
     end if;
     /*Минимальная сумма депозита*/
     select ddl.dpt_saldo,
            ddl.lim
       into l_dpt_saldo,
            l_lim
       from v_dbo_deposit_list ddl
      where ddl.cust_id = decode(l_rnk, -1, ddl.cust_id, null, ddl.cust_id, p_rnk)
        and ddl.dpt_id = p_refTnd;
     if l_dpt_saldo - p_amount < l_lim then
       bars_error.raise_nerror(g_modcode, 'DPT_MINSUM', p_refTnd);
     end if;

     l_mfob:=get_current_mfo;

     begin
     select c.nmk,
            a.nls,
            c.okpo
       into l_nmkb,
            l_nlsb,
            l_okpo
       from accounts a,customer c
      where c.rnk=a.rnk
        and a.nls=p_ammountNumber
        and a.dazs is null
        and a.kv=(select kv from tabval$global where lcv=p_abrevKV)
        and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk);
        l_actionCode:=g_FOC;--'FOC';
     exception
       when NO_DATA_FOUND then
     bars_error.raise_nerror(g_modcode, 'NLS_NOTFOUND', to_char(p_ammountNumber), p_abrevKV);
     end;
     elsif p_actionCode in ('CRDREPAY') then
      select a.rnk,
            a.nls,
            a.nbs
       into l_rnka,
            l_nlsa,
            l_nbsa
       from accounts a
      where a.nls=p_ammountNumber
        and a.kv=(select kv from tabval$global where lcv=p_abrevKV)
        and a.dazs is null
        and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk);
       l_mfob:=get_current_mfo;
     select c.nmk,
            a.nls,
            c.okpo
       into l_nmkb,
            l_nlsb,
            l_okpo
     from accounts a, nd_acc n,customer c
    where c.rnk=a.rnk
      and n.acc=a.acc
      and a.dazs is null
      and a.tip='SG'
      and n.nd=p_refTnd
      and rownum<=1
      and a.rnk=decode(l_rnk, -1, a.rnk, null, a.rnk, p_rnk);
    l_nazn := 'Часткове погашення кредиту згідно договору №'||to_char(p_refTnd)||' від '||to_char(trunc(sysdate),'dd.mm.yyyy');
    l_actionCode:=g_FOR;--'FOR';

     end if;
  payord( l_actionCode
        , to_char(p_refTnd)
        , p_dayDate
        , p_abrevKV
        , trunc(p_dayDate)
        , p_amount
        , p_nazn
        , l_rnka
        , l_nlsa
        , l_mfob
        , l_nmkb
        , l_nlsb
        , l_okpo
        , null
        , l_nazn
        , p_ref
        , p_errcode
        , p_errmessage);

  bars_audit.info(l_th||' exit.');
  bars_audit.trace('%s: done', l_th);
   exception
    when others then
      p_errcode := sqlcode;
      p_errmessage := sqlerrm;
      p_ref := null;

      -- запись полного сообщения об ошибке в журнал
       bars_audit.error(sqlerrm);
       bars_audit.error(dbms_utility.format_error_stack()||chr(10)||
          dbms_utility.format_error_backtrace(), '', null, l_recid);

      bars_audit.trace('%s: exception block entry point', l_th);
      bars_audit.trace('%s: error detected sqlerrcode=%s, sqlerrm=%s', l_th, to_char(p_errcode), p_errmessage);

  end pay_operation;

end bars_dbo;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dbo.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 