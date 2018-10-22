
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt_social.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPT_SOCIAL 
is
  -- ---------------------------------------------------- --
  --  Пакет работы с депозитами пенсионеров и безработных --
  -- ---------------------------------------------------- --

  -- поддержка версионности пакета
  g_header_version  constant varchar2(64)  := 'version 14.2  08.09.2017';
  
  -- фиксация типа данных и маск.размерности для текстов сообщений
  g_errmsg          varchar2(3000);
  g_errmsg_dim      constant number not null := 3000;

  --
  --  типы для приема файлов зачислений
  --
  type header_id_t   is table of dpt_file_row.header_id%type        index by binary_integer;
  type filename_t    is table of dpt_file_row.filename%type         index by binary_integer;
  type dat_t         is table of dpt_file_row.dat%type              index by binary_integer;
  type nls_t         is table of dpt_file_row.nls%type              index by binary_integer;
  type branch_code_t is table of dpt_file_row.branch_code%type      index by binary_integer;
  type dpt_code_t    is table of dpt_file_row.dpt_code%type         index by binary_integer;
  type sum_t         is table of dpt_file_row.sum%type              index by binary_integer;
  type fio_t         is table of dpt_file_row.fio%type              index by binary_integer;
  type pasp_t        is table of dpt_file_row.pasp%type             index by binary_integer;
  type id_code_t     is table of dpt_file_row.id_code%type          index by binary_integer;
  type file_payoff_t is table of dpt_file_row.file_payoff_date%type index by binary_integer;
  type payoff_date_t is table of dpt_file_row.payoff_date%type      index by binary_integer;
  type ref_t         is table of dpt_file_row.ref%type              index by binary_integer;
  type acc_type_t    is table of dpt_file_row.acc_type%type         index by binary_integer;
  type info_id_t     is table of dpt_file_row.info_id%type          index by binary_integer;

  -- служебная функция: возвращает версию заголовка пакета
  function header_version return varchar2;

  -- служебная функция: возвращает версию тела пакета
  function body_version return varchar2;

  -- заполнение процентной карточки
  procedure fill_interest_cardandrate
   (p_depaccid    in  accounts.acc%type,
    p_depaccnum   in  accounts.nls%type,
    p_depaccur    in  accounts.kv%type,
    p_depaccname  in  accounts.nms%type,
    p_depaccmask  in  accounts.nbs%type,
    p_bankcode    in  accounts.kf%type,
    p_branch      in  accounts.branch%type,
    p_dptype      in  dpt_vidd.vidd%type,
    p_intaccid    in  accounts.acc%type,
    p_startdate   in  date);

  -- открытие договора
  procedure create_contract
   (p_custid        in   social_contracts.rnk%type,
    p_soctypeid     in   social_contracts.type_id%type,
    p_agencyid      in   social_contracts.agency_id%type,
    p_contractnum   in   social_contracts.contract_num%type,
    p_contractdate  in   social_contracts.contract_date%type,
    p_cardaccount   in   social_contracts.card_account%type,
    p_pensionnum    in   social_contracts.pension_num%type,
    p_details       in   social_contracts.details%type,
    p_contractacc   out  social_contracts.acc%type,
    p_contractid    out  social_contracts.contract_id%type);

  -- оплата файла зачислений
  procedure pay_bankfile
   (p_header_id     in  dpt_file_header.header_id%type,
    p_typeid        in  social_file_types.type_id%type,
    p_tt            in  tts.tt%type default 'DBF');

  -- оплата файла зачислений-2
  procedure pay_bankfile_ext
   (p_header_id  in  dpt_file_header.header_id%type,
    p_typeid     in  social_file_types.type_id%type,
    p_tt         in  tts.tt%type default 'DBF');

  -- оплата файла зачислений (ГБ)
  procedure pay_bankfile_ext_center
   (p_header_id  in  dpt_file_header.header_id%type,
    p_typeid     in  social_file_types.type_id%type,
    p_agency_id     in  social_agency.agency_id%type,
    p_tt         in  tts.tt%type default 'DBF');

  -- начисление процентов по социальным договорам в конце месяца
  procedure auto_make_int
   (p_contractid  in  social_contracts.contract_id%type,
    p_runid       in  dpt_jobs_jrnl.run_id%type,
    p_branch      in  branch.branch%type,
    p_bdate       in  fdat.fdat%type,
    p_mode        in  number);

  -- капитализация процентов по социальным договорам
  procedure auto_payout_int
   (p_contractid  in  social_contracts.contract_id%type,
    p_runid       in  dpt_jobs_jrnl.run_id%type,
    p_branch      in  branch.branch%type,
    p_bdate       in  fdat.fdat%type);

  -- проверка существования карточного счета
  function check_tm_card
   (p_cardaccount  social_contracts.card_account%type,
    p_branch       social_contracts.branch%type default null)
    return number;

  -- проверка существования карточного счета в портфеле пенсионеров
  function is_valid_social_card
   (p_cardaccount  social_contracts.card_account%type,
    p_branch       social_contracts.branch%type default sys_context('bars_context','user_branch'))
    return number;

  -- регистрация дополнительных соглашений
  procedure p_supplementary_agreement
   (p_contractid  in   social_trustee.contract_id%type,
    p_flagid      in   dpt_vidd_flags.id%type,
    p_trustrnk    in   social_trustee.trust_rnk%type,
    p_trustid     out  number);

  -- проверка корректности заданных счетов перед открытием нового договора
  procedure check_agency_account
   (p_agntype  in      social_agency_acctypes.agntype%type,
    p_acctype  in      social_agency_acctypes.acctype%type,
    p_branch   in      branch.branch%type,
    p_account  in out  accounts.nls%type,
    p_error       out  number,
    p_comment     out  varchar2);

  -- открытие или изменение параметров договора с ОСЗ
  procedure open_agency
   (p_agntype       in      social_agency.type_id%type,
    p_branch        in      social_agency.branch%type,
    p_agnname       in      social_agency.name%type,
    p_contractnum   in      social_agency.contract%type,
    p_contractdat   in      social_agency.date_on%type,
    p_agnaddress    in      social_agency.address%type,
    p_agnphone      in      social_agency.phone%type,
    p_agndetails    in      social_agency.details%type,
    p_debitaccnum   in out  accounts.nls%type,
    p_creditaccnum  in out  accounts.nls%type,
    p_cardaccnum    in out  accounts.nls%type,
    p_comissaccnum  in out  accounts.nls%type,
    p_agencyid      in out  social_agency.agency_id%type);

  -- закрытие договора с ОСЗ
  procedure close_agency
   (p_agencyid   in  social_agency.agency_id%type,
    p_closedate  in  social_agency.date_off%type default trunc(sysdate));

  -- створення заголовку файла
  procedure create_file_header
   (p_filename        in   dpt_file_header.filename%type,
    p_header_length   in   dpt_file_header.header_length%type,
    p_dat             in   dpt_file_header.dat%type,
    p_info_length     in   dpt_file_header.info_length%type,
    p_mfo_a           in   dpt_file_header.mfo_a%type,
    p_nls_a           in   dpt_file_header.nls_a%type,
    p_mfo_b           in   dpt_file_header.mfo_b%type,
    p_nls_b           in   dpt_file_header.nls_b%type,
    p_dk              in   dpt_file_header.dk%type,
    p_sum             in   dpt_file_header.sum%type,
    p_type            in   dpt_file_header.type%type,
    p_num             in   dpt_file_header.num%type,
    p_has_add         in   dpt_file_header.has_add%type,
    p_name_a          in   dpt_file_header.name_a%type,
    p_name_b          in   dpt_file_header.name_b%type,
    p_nazn            in   dpt_file_header.nazn%type,
    p_branch_code     in   dpt_file_header.branch_code%type,
    p_dpt_code        in   dpt_file_header.dpt_code%type,
    p_exec_ord        in   dpt_file_header.exec_ord%type,
    p_ks_ep           in   dpt_file_header.ks_ep%type,
    p_type_id         in   dpt_file_header.type_id%type,
    p_agency_type     in   dpt_file_header.agency_type%type,
    p_header_id       out  dpt_file_header.header_id%type,
    p_version         in   dpt_file_header.file_version%type   default '1',
    p_recheck_agency  in   dpt_file_header.recheck_agency%type default 1 );

  -- створення стрічки файла
  procedure create_file_row_group
   (p_header_id    in    header_id_t,
    p_filename     in   filename_t,
    p_dat          in   dat_t,
    p_nls          in   nls_t,
    p_branch_code  in   branch_code_t,
    p_dpt_code     in   dpt_code_t,
    p_sum          in   sum_t,
    p_fio          in   fio_t,
    p_pasp         in   pasp_t,
    p_info_id      out  info_id_t);

  -- створення стрічок файла нового формату
  procedure create_file_row_ext_group
   (p_header_id    in   header_id_t,
    p_filename     in   filename_t,
    p_dat          in   dat_t,
    p_nls          in   nls_t,
    p_branch_code  in   branch_code_t,
    p_dpt_code     in   dpt_code_t,
    p_sum          in   sum_t,
    p_fio          in   fio_t,
    p_id_code      in   id_code_t,
    p_file_payoff  in   file_payoff_t,
    p_payoff_date  in   payoff_date_t,
    p_acc_type     in   acc_type_t,
    p_info_id      out  info_id_t);

  -- створення стрічки файла
  procedure create_file_row
   (p_header_id    in   dpt_file_row.header_id%type,
    p_filename     in   dpt_file_row.filename%type,
    p_dat          in   dpt_file_row.dat%type,
    p_nls          in   dpt_file_row.nls%type,
    p_branch_code  in   dpt_file_row.branch_code%type,
    p_dpt_code     in   dpt_file_row.dpt_code%type,
    p_sum          in   dpt_file_row.sum%type,
    p_fio          in   dpt_file_row.fio%type,
    p_pasp         in   dpt_file_row.pasp%type,
    p_info_id      out  dpt_file_row.info_id%type);

  -- створення стрічки файла нового формату
  procedure create_file_row_ext
   (p_header_id    in    dpt_file_row.header_id%type,
    p_filename     in    dpt_file_row.filename%type,
    p_dat          in    dpt_file_row.dat%type,
    p_nls          in    dpt_file_row.nls%type,
    p_branch_code  in    dpt_file_row.branch_code%type,
    p_dpt_code     in    dpt_file_row.dpt_code%type,
    p_sum          in    dpt_file_row.sum%type,
    p_fio          in    dpt_file_row.fio%type,
    p_id_code      in    dpt_file_row.id_code%type,
    p_file_payoff  in    dpt_file_row.file_payoff_date%type,
    p_payoff_date  in    dpt_file_row.payoff_date%type,
    p_acc_type     in    dpt_file_row.acc_type%type,
    p_info_id      out   dpt_file_row.info_id%type);

  -- проставлення agency_id для прийнятого файла
  procedure set_agencyid (p_header_id  in  dpt_file_row.header_id%type);

  -- Перевірка рахунка
  function check_account
  ( p_nls       in   accounts.nls%type,
    p_branch    in   accounts.branch%type,
    p_id_code   in   customer.okpo%type,
    p_nmk       in   customer.nmk%type,
    p_acc_type  in   dpt_file_row.acc_type%type
  ) return varchar2;
  
  -- Перевірка рахунка по saldo
  procedure check_account_access
  ( p_nls       in   accounts.nls%type,
    p_branch    in   accounts.branch%type,
    p_id_code   in   customer.okpo%type,
    p_nmk       in   customer.nmk%type,
    p_acc_type  in   dpt_file_row.acc_type%type,
    p_res       out  number);

  -- Перевірка чи закритий рахунок
  procedure check_account_closed
   (p_nls       in   accounts.nls%type,
    p_branch    in   accounts.branch%type,
    p_id_code   in   customer.okpo%type,
    p_nmk       in   customer.nmk%type,
    p_acc_type  in   dpt_file_row.acc_type%type,
    p_res       out  number) ;

  -- Копіювання файлу зарахувань
  procedure file_copy
   (p_header_id      in   dpt_file_header.header_id%type,
    p_header_id_new  out  dpt_file_header.header_id%type);

  -- Перевірка допустимості вибраного органу соц. захисту депозитному договору
  function ck_social_agency
   (p_dpt_id            in  social_contracts.contract_id%type,
    p_social_agency_id  in  social_agency.agency_id%type)
    return number;

  -- Видалення файла зарахувань
  procedure file_delete (p_header_id  in  dpt_file_header.header_id%type);

  -- Перевірка можливості видалення файлу зарахувань, 1 - можна, 0 - ні
  function can_be_deleted (p_header_id in dpt_file_header.header_id%type)
    return number;

  -- Функция печати номера и даты договора в назначении платежа
  function f_nazn
   (p_type    in  char,                               -- симв.код
    p_dpt_id  in  social_contracts.contract_id%type)  -- идентификатор договора
    return varchar2;

  -- функція підтягування реального рахунку проплати для соц. файлів
  -- p_return_type:         0 - nls
  --                1 - client_name
  --                2 - client_okpo
  function f_file_account
   (p_accnum       in  accounts.nls%type,
    p_acccur       in  accounts.kv%type,
    p_bankmfo      in  accounts.kf%type,
    p_iscard       in  number,
    p_okpo         in  customer.okpo%type,
    p_nmk          in  customer.nmk%type,
    p_acc_type     in  dpt_file_row.acc_type%type,
    p_return_type  in  number)
    return varchar2;

  --
  -- подготовка к закрытию социального договора
  --
  procedure prepare2closdeal
   (p_contractid  in  number,   -- идентификатор соц.договора
    p_sum2payoff  out number);  -- сумма догоовра к выплате

  -- закрытие социального договора
  procedure close_contract (p_contractid  in  social_contracts.contract_id%type);

end DPT_SOCIAL;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPT_SOCIAL 
is
  
  g_body_version  constant varchar2(64) := 'version 13.30  08.09.2017';
  g_modcode       constant varchar2(3)  := 'SOC';

type acc_rec is record (id     accounts.acc%type,
                        num    accounts.nls%type,
                        cur    accounts.kv%type,
                        name   accounts.nms%type,
                        code   customer.okpo%type,
                        saldo  accounts.ostc%type,
                        pap    accounts.pap%type);
--
--
--
function HEADER_VERSION return varchar2
is
begin
  return 'Package header DPT_SOCIAL ' || g_header_version || '.';
end HEADER_VERSION;

--
--
--
function BODY_VERSION return varchar2
is
begin
  return 'Package body DPT_SOCIAL '   || g_body_version || '.';
end BODY_VERSION;

--
-- пошук групи доступу пенсійних рахунків
--
FUNCTION get_accgrp (p_branch branch.branch%type) RETURN groups_acc.id%type
IS
  l_title   varchar2(60)         := 'dptsocial.getaccgrp';
  l_tagname branch_tags.tag%type := 'SOCIAL_GRP';
  l_accgrp  groups_acc.id%type;
BEGIN

  BEGIN
    SELECT g.id
      INTO l_accgrp
      FROM branch_parameters b, groups_acc g
     WHERE to_number(b.val) = g.id
       AND b.tag = l_tagname
       AND b.branch = p_branch;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_accgrp := 13;
  END;

  bars_audit.trace('%s група доступу = %s', l_title, to_char(l_accgrp));
  RETURN l_accgrp;

END get_accgrp;

--
-- відкриття рахунків по соц.договорам
--
PROCEDURE open_contract_accounts
  (p_modcode  in   char,
   p_custid   in   accounts.rnk%type,
   p_bankcode in   accounts.kf%type,
   p_branch   in   accounts.branch%type,
   p_dealnum  in   social_contracts.contract_num%type,
   p_accmask  in   accounts.nbs%type,
   p_acccur   in   accounts.kv%type,
   p_acctype  in   accounts.tip%type,
   p_accid    out  accounts.acc%type,
   p_accnum   out  accounts.nls%type,
   p_accname  out  accounts.nms%type)
IS
  l_title    varchar2(60) := 'dptsocial.openacc';
  l_accuser  staff.id%type;
  l_accgrp   groups_acc.id%type;
  l_accnum   accounts.nls%type;
  l_accname  accounts.nms%type;
  l_accid    accounts.acc%type;
  l_tmp      number(38);
BEGIN
  bars_audit.trace('%s mod = %s, rnk = %s, branch = %s, dealnum = %s,
                       nbs = %s, kv = %s, acctype = %s',
                    l_title, p_modcode, to_char(p_custid), p_branch, p_dealnum,
                    p_accmask, to_char(p_acccur), p_acctype);

  l_accuser := gl.aUID;
  l_accgrp  := get_accgrp (p_branch);
  bars_audit.trace('%s вик. - %s, група - %s', l_title, to_char(l_accuser), to_char(l_accgrp));

  -- замість ідентифікатора договору передаємо № договору
  l_accnum  := substr (f_newnls2 (0, p_modcode, p_accmask, p_custid, p_dealnum), 1, 14);
  l_accnum  := vkrzn  (substr(p_bankcode, 1, 5), l_accnum);
  l_accname := substr (f_newnms  (0, p_modcode, p_accmask, p_custid, p_dealnum), 1, 70);
  bars_audit.trace('%s рахунок № %s - %s', l_title, l_accnum, l_accname);

  BEGIN
    op_reg(99, 0, 0, l_accgrp, l_tmp, p_custid, l_accnum, p_acccur, l_accname, p_acctype, l_accuser, l_accid);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_nerror(g_modcode, 'SOCACC_OPEN_FAILED', l_accnum, to_char(p_acccur), sqlerrm);
  END;

  p_accid   := l_accid;
  p_accnum  := l_accnum;
  p_accname := l_accname;
  bars_audit.trace('%s відкрито рахунок %s (%s)', l_title, p_accnum, to_char(p_accid));

END open_contract_accounts;

--
-- заповнення процентної картки та відсоткової ставки по рахунку
--
PROCEDURE fill_interest_CardAndRate
  (p_depaccid    in  accounts.acc%type,
   p_depaccnum   in  accounts.nls%type,
   p_depaccur    in  accounts.kv%type,
   p_depaccname  in  accounts.nms%type,
   p_depaccmask  in  accounts.nbs%type,
   p_bankcode    in  accounts.kf%type,
   p_branch      in  accounts.branch%type,
   p_dptype      in  dpt_vidd.vidd%type,
   p_intaccid    in  accounts.acc%type,
   p_startdate   in  date)
IS
  l_title      varchar2(60) := 'dptsocial.fillintcard';
  l_expaccid   accounts.acc%type;
  l_viddrow    dpt_vidd%rowtype;
  l_intpaynum  int_accn.nlsb%type;
  l_intpayname int_accn.namb%type;
  l_intpaymfo  int_accn.mfob%type;
  l_intpaytt   int_accn.ttb%type;
  l_indirate   int_ratn.ir%type;
  l_baserate   int_ratn.br%type;
  l_dptype     dpt_vidd.vidd%type;
BEGIN

  SELECT * INTO l_viddrow FROM dpt_vidd WHERE vidd = p_dptype;

  -- рахунок процентних витрат
  l_dptype := p_dptype;

  BEGIN
    l_expaccid := dpt.get_expenseacc (p_dptype  => l_dptype,
                                      p_balacc  => p_depaccmask,
                                      p_curcode => p_depaccur,
                                      p_branch  => p_branch);
    -- l_expaccid := f_proc_dr(p_depaccid, 4, 3, 'DPT');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'EXPACC_NOT_FOUND');
  END;
  bars_audit.trace('%s рахунок процентних витрат (acc=%s)', l_title, to_char(l_expaccid));

  -- сплата відсотків - на основний рахунок (капіталізація)
  IF l_viddrow.comproc = 1 THEN
     bars_audit.trace('%s капіталізація відсотків', l_title);
     l_intpaynum  := substr(p_depaccnum,  1, 14);
     l_intpayname := substr(p_depaccname, 1, 38);
     l_intpaymfo  := p_bankcode;
     l_intpaytt   := null;
     bars_audit.trace('%s параметри сплати відсотків (МФО, рахунок, отримувач) = (%s, %s, %s)',
                      l_title, l_intpaymfo, l_intpaynum, l_intpayname);
  END IF;

  -- заповнення відсоткової картки
  BEGIN
    INSERT INTO int_accn
      (acc, id, acra, acrb,
       metr, basey, freq, io, tt,
       ttb, kvb, nlsb, mfob, namb)
    VALUES
     (p_depaccid, 1, p_intaccid, l_expaccid,
      l_viddrow.metr, l_viddrow.basey, l_viddrow.freq_n, l_viddrow.tip_ost, NVL(l_viddrow.tt,'%%1'),
      l_intpaytt, p_depaccur, l_intpaynum, l_intpaymfo, l_intpayname);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_nerror(g_modcode, 'FILL_INTCARD_FAILED', p_depaccnum, to_char(p_depaccur), sqlerrm);
  END;
  bars_audit.trace('%s заповнена відсоткова картка по рахунку %s', l_title, p_depaccnum);

  -- заповнення відсоткової ставки
  IF l_viddrow.basem = 1 THEN  -- фіксована ставка
     l_baserate := null;
     l_indirate := dpt.f_calc_rate (l_viddrow.vidd, l_viddrow.duration, l_viddrow.duration_days, 0);
     IF l_indirate IS NULL THEN
        l_indirate := getbrat(p_startdate, l_viddrow.br_id, p_depaccur, 0);
     END IF;
  ELSE                         -- плаваюча ставка
     l_baserate := l_viddrow.br_id;
     l_indirate := null;
  END IF;
  bars_audit.trace('%s ставки (інд, баз) = (%s, %s)', l_title, to_char(l_indirate), to_char(l_baserate));

  BEGIN
    INSERT INTO int_ratn (acc, id, bdat, br, ir)
    VALUES (p_depaccid, 1, p_startdate, l_baserate, l_indirate);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_nerror(g_modcode, 'FILL_INTRATE_FAILED', p_depaccnum, to_char(p_depaccur), sqlerrm);
  END;
  bars_audit.trace('%s заповнена відсоткова ставка по рахунку %s', l_title, p_depaccnum);

END fill_interest_CardAndRate;

--
-- відкриття соціального договору
--
PROCEDURE create_contract
  (p_custid        IN   social_contracts.rnk%type,
   p_soctypeid     IN   social_contracts.type_id%type,
   p_agencyid      IN   social_contracts.agency_id%type,
   p_contractnum   IN   social_contracts.contract_num%type,
   p_contractdate  IN   social_contracts.contract_date%type,
   p_cardaccount   IN   social_contracts.card_account%type,
   p_pensionnum    IN   social_contracts.pension_num%type,
   p_details       IN   social_contracts.details%type,
   p_contractacc   OUT  social_contracts.acc%type,
   p_contractid    OUT  social_contracts.contract_id%type)
IS
  l_title      varchar2(60)       := 'dptsocial.createdeal';
  l_branch     branch.branch%type := sys_context('bars_context','user_branch');
  l_bankcode   banks.mfo%type     := sys_context('bars_context','user_mfo');
  l_custname   customer.nmk%type;
  l_agencyname social_agency.name%type;
  l_soctype    social_dpt_types%rowtype;
  l_dpttype    dpt_vidd%rowtype;
  l_dealnum    social_contracts.contract_num%type;
  l_contractid social_contracts.contract_id%type;
  l_depaccid   accounts.acc%type;
  l_depaccnum  accounts.nls%type;
  l_depaccname accounts.nms%type;
  l_intaccid   accounts.acc%type;
  l_intaccnum  accounts.nls%type;
  l_intaccname accounts.nms%type;
  l_modcode    char(3);
  l_s180       specparam.s180%type;
  l_s181       specparam.s181%type;
  l_r011       specparam.r011%type;
  l_r013       specparam.r013%type;
BEGIN

  bars_audit.trace('%s рег.№ клієнта = %s, вид договору = %s, ОСЗ = %s', l_title,
                   to_char(p_custid), to_char(p_soctypeid), to_char(p_agencyid));

  bars_audit.trace('%s договір № %s від %s', l_title,
                   p_contractnum, to_char(p_contractdate,'dd.mm.yy'));

  bars_audit.trace('%s карт.рахунок № %s, пенс.справа № %s, підробиці: %s', l_title,
                   p_cardaccount, p_pensionnum, p_details);

  -- пошук клієнта
  BEGIN
    SELECT nmk INTO l_custname
      FROM customer
     WHERE rnk = p_custid AND custtype = 3 AND date_off IS NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'CUST_NOT_FOUND', to_char(p_custid));
  END;
  bars_audit.trace('%s кліент № %s - %s', l_title, to_char(p_custid), l_custname);

  -- пошук органу соц.захисту
  BEGIN
    SELECT name INTO l_agencyname
      FROM social_agency
     WHERE agency_id = p_agencyid AND date_off IS NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'AGENCY_NOT_FOUND', to_char(p_agencyid));
  END;
  bars_audit.trace('%s ОСЗ № %s - %s', l_title, to_char(p_agencyid), l_agencyname);

  -- тип договору с органом соц.захисту
  BEGIN
    SELECT * INTO l_soctype FROM social_dpt_types
     WHERE type_id = p_soctypeid AND activity = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'SOCDEALTYPE_NOT_FOUND', to_char(p_soctypeid));
  END;
  bars_audit.trace('%s тип договору № %s - %s', l_title, to_char(p_soctypeid), l_soctype.name);

  -- параметри відповідного технічного виду договору
  BEGIN
    SELECT * INTO l_dpttype FROM dpt_vidd WHERE vidd = l_soctype.dpt_vidd;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'SOCVIDD_NOT_FOUND', to_char(l_soctype.dpt_vidd));
  END;
  bars_audit.trace('%s вид договору № %s - %s', l_title, to_char(l_dpttype.vidd), l_dpttype.type_name);

  -- перевірка заповнення обов'язкових реквізитів договору
  IF (l_soctype.acc_type IN ('PDM','PCD') AND p_pensionnum IS NULL) THEN
    bars_error.raise_nerror(g_modcode, 'PENSNUM_IS NULL');
  END IF;

   -- розрахунок коду модуля: SOC = пенсіонери / EMP = безробітні
  l_modcode := CASE
               WHEN l_soctype.acc_type IN ('PDM', 'PCD')        THEN 'SOC'
               ELSE /* l_soctype.acc_type IN ('EMP', 'EMC') */       'EMP'
               END;
  bars_audit.trace('%s код модуля - %s', l_title, l_modcode);

  -- ідентифікатор договору
  BEGIN
    SELECT bars_sqnc.get_nextval('S_CC_DEAL') INTO l_contractid FROM dual;
    l_contractid := get_id_ddb(l_contractid);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_nerror(g_modcode, 'GET_CONTRACTID_FAILED');
  END;
  bars_audit.trace('%s ідентифікатор договору = %s', l_title, to_char(l_contractid));

  -- номер договора
  l_dealnum := nvl(p_contractnum, to_char(l_contractid));
  bars_audit.trace('%s договір № %s', l_title, l_dealnum);


  -- відкриття основного рахунку
  open_contract_accounts (p_modcode  =>  l_modcode,
                          p_custid   =>  p_custid,
                          p_bankcode =>  l_bankcode,
                          p_branch   =>  l_branch,
                          p_dealnum  =>  l_contractid,
                          p_accmask  =>  l_dpttype.bsd,
                          p_acccur   =>  l_dpttype.kv,
                          p_acctype  =>  l_soctype.acc_type,
                          p_accid    =>  l_depaccid,
                          p_accnum   =>  l_depaccnum,
                          p_accname  =>  l_depaccname);

  bars_audit.trace('%s відкрито рахунок № %s (%s)', l_title, l_depaccnum, to_char(l_depaccid));

  -- договір із нарахуванням відсотків
  IF (l_dpttype.bsd != l_dpttype.bsn AND l_dpttype.br_id > 0) THEN

    bars_audit.trace('%s договір передбачає нарахування відсотків', l_title);

    -- відкриття рахунку нарахованих відсотків
    open_contract_accounts (p_modcode  =>  l_modcode,
                            p_custid   =>  p_custid,
                            p_bankcode =>  l_bankcode,
                            p_branch   =>  l_branch,
                            p_dealnum  =>  l_contractid,
                            p_accmask  =>  l_dpttype.bsn,
                            p_acccur   =>  l_dpttype.kv,
                            p_acctype  =>  l_soctype.acc_type,
                            p_accid    =>  l_intaccid,
                            p_accnum   =>  l_intaccnum,
                            p_accname  =>  l_intaccname);
    bars_audit.trace('%s відкрито рахунок № %s (%s)', l_title, l_intaccnum, to_char(l_intaccid));

    -- заповнення процентної картки та відсоткової ставки
    fill_interest_CardAndRate (p_depaccid    =>  l_depaccid,
                               p_depaccnum   =>  l_depaccnum,
                               p_depaccur    =>  l_dpttype.kv,
                               p_depaccname  =>  l_depaccname,
                               p_depaccmask  =>  l_dpttype.bsd,
                               p_bankcode    =>  l_bankcode,
                               p_branch      =>  l_branch,
                               p_dptype      =>  l_dpttype.vidd,
                               p_intaccid    =>  l_intaccid,
                               p_startdate   =>  nvl(p_contractdate, gl.bdate));
    bars_audit.trace('%s заповнена відсоткова картка', l_title);

  END IF; -- договір із нарахуванням відсотків

  -- заповнення спецпараметрів рахунків
  dpt.fill_specparams (p_depaccid  =>  l_depaccid,
                       p_intaccid  =>  l_intaccid,
                       p_depnbs    =>  l_dpttype.bsd,
                       p_intnbs    =>  l_dpttype.bsn,
                       p_begdate   =>  nvl(p_contractdate, gl.bdate),
                       p_enddate   =>  null,
                       p_dpttype   =>  l_dpttype.vidd,
                       p_idg       =>  l_dpttype.idg,
                       p_ids       =>  l_dpttype.ids,
                       p_amraccid  =>  null,
                       p_amrnbs    =>  null);

  /*
  l_s180 := substr(fs180(l_depaccid), 1, 1);
  l_s181 := substr(fs181(l_depaccid), 1, 1);
  l_r013 := '9';
  insert into specparam (acc, s180, s181, r013)
  values (l_depaccid, l_s180, l_s181, l_r013);
  if l_intaccid is not null then
     begin
       select r011
         into l_r011
         from kl_r011
        where (r020r011 = l_dpttype.bsd or r020r011 is null)
          and (r020     = l_dpttype.bsn)
          and (d_open  <= gl.bdate)
          and (d_close >= gl.bdate or d_close is null);
     exception
       when others then
         l_r011 := null;
     end;
     insert into specparam (acc, s180, s181, r011)
     values (l_intaccid, l_s180, l_s181, l_r011);
  end if;
  */

  -- відкриття договору
  BEGIN
    INSERT INTO social_contracts
      (contract_id, type_id, agency_id, branch,
       rnk, acc, contract_num, contract_date,
       card_account, pension_num, details)
    VALUES
      (l_contractid, p_soctypeid, p_agencyid, l_branch,
       p_custid, l_depaccid, l_dealnum, p_contractdate,
       p_cardaccount, p_pensionnum, p_details);
  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_error(g_modcode, 'FILL_CONTRACT_FAILED', sqlerrm);
  END;
  bars_audit.trace('%s відкрито договір № %s (%s)', l_title, l_dealnum, to_char(l_contractid));


  p_contractid  := l_contractid;
  p_contractacc := l_depaccid;

  bars_audit.trace('%s вихід', l_title);

END create_contract;

--
-- призначення платежу та загальні суми зарахувань на поточн/карт.рах. з файлу
--
procedure get_filedata_uni
  (p_headerid  in  dpt_file_header.header_id%type,
   p_branch    in  dpt_file_row.branch%type,       -- branch | null
   p_marked    in  number,                         -- 0      | 1
   p_filesumD  out number,
   p_filesumC  out number,
   p_filenazn  out dpt_file_header.nazn%type)
is
  title  varchar2(60) := 'dptsocial.getfiledatauni';
  l_branch branch.branch%type := '/'||getglobaloption('GLB-MFO')||'/';
begin

  bars_audit.trace('%s entry, header %s, branch %s, marked %s', title,
                   to_char(p_headerid), p_branch, to_char(p_marked));
  begin
    select nazn
      into p_filenazn
      from dpt_file_header
     where header_id = p_headerid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND', to_char(p_headerid));
  end;

  l_branch := nvl(p_branch, l_branch);
  bars_audit.trace('%s l_branch = %s', title, l_branch);

  select nvl(sum(decode(is_valid_social_card(nls, l_branch), 0, sum,   0)), 0),
         nvl(sum(decode(is_valid_social_card(nls, l_branch), 0, 0  , sum)), 0)
    into p_filesumd, p_filesumc
    from dpt_file_row
   where header_id = p_headerid
     and branch    = decode(p_branch, null, branch, p_branch)
     and incorrect = 0
     and closed    = 0
     and excluded  = 0
     and ref is null
     and marked4payment = decode(p_marked, 0, marked4payment, p_marked);

  bars_audit.trace('%s exit with %s, %s, %s', title,
                   to_char(p_filesumD), to_char(p_filesumC), p_filenazn);

end get_filedata_uni;

--
-- пошук рахунку
--
FUNCTION get_acc_params (p_accid in accounts.acc%type) return acc_rec
IS
 l_title     varchar2(60) := 'dptsocial.getaccpars';
 l_accparams acc_rec;
BEGIN

  bars_audit.trace('%s entry, accid => %s', l_title, to_char(p_accid));

  IF p_accid IS NULL THEN
     l_accparams := NULL;
  ELSE
     SELECT a.acc, a.nls, a.kv, substr(a.nms, 1, 38), c.okpo, a.ostc, a.pap
       INTO l_accparams
       FROM accounts a, customer c
      WHERE a.rnk = c.rnk AND a.acc = p_accid;
  END IF;

  bars_audit.trace('%s exit with %s', l_title, l_accparams.num);

  RETURN l_accparams;

END get_acc_params;

--
-- пошук транз.рахунків ОСЗ
--
PROCEDURE get_agency_accounts
  (p_agencyrow  in   social_agency%rowtype,
   p_debitacc   out  acc_rec,
   p_creditacc  out  acc_rec,
   p_cardacc    out  acc_rec,
   p_comissacc  out  acc_rec)
IS
   l_title     varchar2(60) := 'dptsocial.getagnaccS';
BEGIN

  bars_audit.trace('%s %s = (%s, %s, %s, %s)', l_title, to_char(p_agencyrow.agency_id),
                   to_char(p_agencyrow.debit_acc), to_char(p_agencyrow.credit_acc),
                   to_char(p_agencyrow.card_acc),  to_char(p_agencyrow.comiss_acc));

  -- рахунок дебеторської заборгованості (м.б. NULL)
  BEGIN
    p_debitacc := get_acc_params (p_agencyrow.debit_acc);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'DEBITACC_NOT_FOUND',
                              to_char(p_agencyrow.agency_id),
                              to_char(p_agencyrow.debit_acc));
  END;
  bars_audit.trace('%s debit: %s/%s - %s', l_title,
                   p_debitacc.num, to_char(p_debitacc.cur), p_debitacc.name);

  -- рахунок кредиторської заборгованості для поточних рахунків
  BEGIN
    p_creditacc := get_acc_params (p_agencyrow.credit_acc);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'CREDITACC_NOT_FOUND',
                              to_char(p_agencyrow.agency_id),
                              to_char(p_agencyrow.credit_acc));
  END;
  bars_audit.trace('%s credit: %s/%s - %s', l_title,
                    p_creditacc.num, to_char(p_creditacc.cur), p_creditacc.name);

  -- рахунок кредиторської заборгованості для карткових рахунків
  BEGIN
    p_cardacc := get_acc_params (p_agencyrow.card_acc);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'CARDACC_NOT_FOUND',
                              to_char(p_agencyrow.agency_id),
                              to_char(p_agencyrow.card_acc));
  END;
  bars_audit.trace('%s card: %s/%s - %s', l_title,
                    p_cardacc.num, to_char(p_cardacc.cur), p_cardacc.name);

  -- рахунок комісійних доходів (м.б. NULL)
  BEGIN
    p_comissacc := get_acc_params (p_agencyrow.comiss_acc);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'COMISS_NOT_FOUND',
                              to_char(p_agencyrow.agency_id),
                              to_char(p_agencyrow.comiss_acc));
  END;
  bars_audit.trace('%s comiss: %s/%s - %s', l_title,
                   p_comissacc.num, to_char(p_comissacc.cur), p_comissacc.name);

END get_agency_accounts;

--
-- перевірка достатньості коштів на рахунку
--
procedure check_acc_saldo (p_accrec in acc_rec, p_amount in number)
is
  title  varchar2(60) := 'dptsocial.checkaccsal';
begin

  bars_audit.trace('%s entry, account %s/%s, amount %s', title,
                   p_accrec.num, to_char(p_accrec.cur), to_char(p_amount));

  if (p_accrec.pap != 3 and p_amount > 0 and p_amount > p_accrec.saldo) then
      bars_error.raise_nerror(g_modcode, 'RED_SALDO',
                              p_accrec.num,            to_char(p_accrec.cur),
                              to_char(p_accrec.saldo), to_char(p_amount));
  end if;

  bars_audit.trace('%s exit', title);

end check_acc_saldo;

--
-- заповлення дод.реквізитів документу
--
PROCEDURE fill_docvalues
  (p_docref  in  operw.ref%type,
   p_doctag  in  operw.tag%type,
   p_docval  in  operw.value%type)
IS
  l_title  varchar2(60) := 'dptsocial.filldocval';
BEGIN
  bars_audit.trace('%s entry, ref=>%s, tag=>%s, val=>%s', l_title,
                   to_char(p_docref), p_doctag, p_docval);

  IF p_docval IS NULL THEN
     NULL;
  ELSE
     INSERT INTO operw (ref, tag, value) VALUES (p_docref, p_doctag, p_docval);
  END IF;

  bars_audit.trace('%s exit', l_title);

EXCEPTION
  WHEN OTHERS THEN
    bars_error.raise_nerror(g_modcode, 'FILL_DOCVAL_FAILED',p_doctag, to_char(p_docref), sqlerrm);
END fill_docvalues;

--
-- внутр.функция поиска контрсчетов и кода ОКПО подразделения
--
procedure get_branchparams
 (p_branch   in   branch.branch%type,   -- подразделение
  p_corracc  out  accounts.nls%type,    -- контрсчет подразделения
  p_cardacc  out  accounts.nls%type,    -- контрсчет для карточек
  p_okpo     out  customer.okpo%type)   -- код ОКПО
is
  title   varchar2(60)           := 'dptsocial.getbranchpars';
  par_tm  params$global.par%type := 'TM_TRANS';
  tag_cor branch_tags.tag%type   := 'CORRACC';
  tag_rnk branch_tags.tag%type   := 'RNK';
  nulcode varchar2(14)           := '0000000000';
begin

  bars_audit.trace('%s entry, branch => %s', title, p_branch);

  p_corracc := null;
  p_cardacc := null;

  -- код ОКПО
  select nvl(max(okpo), nulcode)
    into p_okpo
    from customer
   where rnk = branch_edit.getbranchparams(p_branch, tag_rnk);

  bars_audit.trace('%s exit with %s, %s, %s', title, p_corracc, p_cardacc, p_okpo);

end get_branchparams;

--
-- внутр.функция поиска текущего / карточного счета с указанным номером
--
function look4acc
( p_accnum   in  accounts.nls%type,
  p_acccur   in  accounts.kv%type,
  p_bankmfo  in  accounts.kf%type,
  p_iscard   in  number,
  p_okpo     in  customer.okpo%type,
  p_nmk      in  customer.nmk%type,
  p_acc_type in  dpt_file_row.acc_type%type
) RETURN acc_rec
is
  title     varchar2(60) := 'dptsocial.look4acc';
  l_acc     acc_rec;
  l_acc_pk  accounts.acc%type;
  l_dazs    accounts.dazs%type;
  l_acc_w4  accounts.acc%type;
begin

  bars_audit.trace( '%s: Entry with ( num=%s, cur=%s, mfo=%s, card=%s ).', title,
                    p_accnum, to_char(p_acccur), p_bankmfo, to_char(p_iscard) );

  begin
    select a.acc, a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo, a.ostc, a.pap
      into l_acc
      from accounts a
         , customer c
     where a.rnk  = c.rnk
       and a.kf   = p_bankmfo
       and a.nls  = p_accnum
       and a.kv   = p_acccur
       and a.dazs is null;
       bars_audit.trace('%s balaccount found, accid = %s', title, to_char(l_acc.id));
  exception
    when no_data_found then
      l_acc.num := null;
      bars_audit.trace('%s balaccount not found', title);
  end;

  if (l_acc.num is null) then
    if (p_iscard = 1) then
      begin
        select a.acc,    a.dazs, b.acc_w4
          into l_acc_pk, l_dazs, l_acc_w4
          from accounts a,
               bpk_acc  b
         where a.kf  = p_bankmfo
           and a.nls = p_accnum
           and a.kv  = p_acccur
           and a.acc = b.acc_pk;

        bars_audit.trace( '%s acc=%s, dazs=%s, acc_w4=%s', title,
                           to_char(l_acc_pk), to_char(l_dazs,'dd/mm/yyyy'), to_char(l_acc_w4) );

        -- якщо рахунок закритий але вказано АСС нового рахунку
        if ((l_dazs is Not Null) AND (l_acc_w4 is Not Null)) then
          l_acc_pk := l_acc_w4;
        end if;

        select a.acc, a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo, a.ostc, a.pap
          into l_acc
          from accounts a,
               customer c
         where a.acc = l_acc_pk
           and a.dazs is null
           and a.rnk = c.rnk;

        bars_audit.trace('%s cardaccount found, accid = %s', title, to_char(l_acc.id));

      exception
        when no_data_found then
          -- можливо нам дали технічний рахунок ПЦ
          begin
            select a.acc, a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo, a.ostc, a.pap
              into l_acc
              from obpc_acct pc, tabval t,
                   accounts   a, customer c
             where a.rnk        = c.rnk
               and a.kf         = pc.kf
               and a.kv         = t.kv
               and t.lcv        = pc.currency
               and a.nls        = pc.lacct
               and pc.card_acct = p_accnum
               and a.kf         = p_bankmfo
               and a.kv         = p_acccur
               and a.dazs       is null;

            bars_audit.trace( '%s cardaccount found, accid = %s', title, to_char(l_acc.id) );
          exception
            when no_data_found or too_many_rows then
              l_acc.num := null;
              bars_audit.trace('%s cardaccount not found', title);
          end;
      end;
    else
      begin
        select a.acc, a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo, a.ostc, a.pap
          into l_acc
          from accounts a, customer c
         where a.rnk    = c.rnk
           and (a.tip = p_acc_type or p_acc_type is null)
           and a.kf     = p_bankmfo
           and a.nlsalt = p_accnum
           and a.kv     = p_acccur
           and a.dazs   is null
           and a.nbs in ('2620','2625','8620')
           and a.branch in ( select CHILD_BRANCH
                               from DPT_FILE_SUBST
                              where PARENT_BRANCH = sys_context('bars_context','user_branch') )
        ;
        bars_audit.trace( '%s migraccount found, accid = %s', title, to_char(l_acc.id) );
      exception
        when no_data_found or too_many_rows then
          
          begin
            select a.acc, a.nls, a.kv, substr(c.nmk, 1, 38), c.okpo, a.ostc, a.pap
              into l_acc
              from accounts a, customer c
             where a.rnk    = c.rnk
               and (a.tip = p_acc_type or p_acc_type is null)
               and a.kf     = p_bankmfo
               and a.nlsalt = p_accnum
               and p_okpo   not like '0000%'
               and c.okpo   = p_okpo
               and a.kv     = p_acccur
               and a.nbs in ('2620','2625','8620')
               and a.dazs   is null;
            exception
              when no_data_found or too_many_rows then
                l_acc.num := null;
                bars_audit.trace('%s migraccount not found', title);
          end;
          
       end;
     end if;
  end if;

  bars_audit.trace( '%s exit with acc %s (%s)', title, l_acc.num, to_char(l_acc.id) );

  return l_acc;

end look4acc;
--
-- оплата файла зачисления пенсии / мат.помощи - UNI
--
procedure pay_bankfile_uni
 (p_headerid   in  dpt_file_header.header_id%type,
  p_agencyid   in  social_agency.agency_id%type,
  p_typeid     in  social_file_types.type_id%type,
  p_tt         in  tts.tt%type,
  p_marked     in  number,
  p_centre     in  branch.branch%type)
is
  title           varchar2(60)       := 'dptsocial.payfileuni';
  l_bankcode      banks.mfo%type     := sys_context('bars_context','user_mfo');
  l_branch        branch.branch%type := sys_context('bars_context','user_branch');
  l_bdate         fdat.fdat%type     := gl.bdate;
  l_baseval       tabval.kv%type     := gl.baseval;
  l_userid        staff.id%type      := gl.auid;
  l_bankokpo      customer.okpo%type;
  l_agency        social_agency%rowtype;
  l_agencyid      social_agency.agency_id%type;
  l_tarifid       social_agency_type.tarif_id%type;
  l_filetype      social_file_types.type_name%type;
  l_nazn          oper.nazn%type;
  l_filenazn      dpt_file_header.nazn%type;
  l_filesumD      number(38);
  l_filesumC      number(38);
  l_comissum      number(38);
  l_cardaccount   oper.nlsb%type;
  l_corraccount   oper.nlsb%type;
  l_debitacc      acc_rec;
  l_creditacc     acc_rec;
  l_cardacc       acc_rec;
  l_comissacc     acc_rec;
  l_accA          acc_rec;
  l_accB          acc_rec;
  l_tmcard        varchar2(14);
  l_integer       integer;
  l_custname        dpt_file_row.fio%type;
  l_ref             oper.ref%type;
  l_errflg          boolean;
  l_errmsg          g_errmsg%type;
  l_comisstt        tts.tt%type;
  l_cardtt          tts.tt%type := 'PKR';
  l_tt              oper.tt%type;
  l_newaccount      constant varchar2(20) := 'НОВИЙ';
  l_newaccount2      constant varchar2(6) := '^[0]+$';
  l_penssionnum     constant social_contracts.pension_num%type := ' - ';
  l_comment         constant social_contracts.details%type     := 'Відкритий при імпорті файла зарахування № ';
  l_acc             accounts.acc%type;
  l_clientid        customer.rnk%type;
  l_agencyid_new    social_agency.agency_id%type;
  l_soctypeid       social_dpt_types.type_id%type;
  l_contractid      social_contracts.contract_id%type;
  l_skzb            social_file_types.sk_zb%type;
  l_nbs4comiss      constant varchar2(5) := '2620%';
  l_nazn4comiss     oper.nazn%type;
  l_local_comissum  number(38) := 0;
  l_curbranch       branch.branch%type := sys_context('bars_context','user_branch');
  --
  -- internal function
  --
  function get_paydate2str
  ( p_date   dpt_file_row.payoff_date%type
  ) return varchar2
  is
    l_retval varchar2(20);
  begin
    if (p_date is NULL) then
      l_retval := null;
    else
      begin
        select name_plain||' '||to_char(p_date, 'YYYY')
          into l_retval
          from meta_month
         where N = extract (month from p_date);
      exception
        when others then
          bars_audit.error( title||': помилка перетворення дати '||to_char(p_date, 'DD/MM/YYYY')||
                            dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace() );
          l_retval := null;
      end;
    end if;

    RETURN l_retval;

  end get_paydate2str;

begin

  bars_audit.trace('%s entry, header=>%s, agency=>%s, type=>%s, tt=>%s, marked=>%s, centre=>%s',
                   title, to_char(p_headerid), to_char(p_agencyid), to_char(p_typeid),
                   p_tt, to_char(p_marked), p_centre);

  bars_audit.trace('%s текущее подразделение - %s', title, l_branch);

  -- умолчательное назначение платежа (и проверка существования операции)
  begin
  select nvl(nazn, name) into l_nazn from tts where tt = p_tt;
  exception
    when no_data_found then
    bars_error.raise_nerror(g_modcode, 'PAYTT_NOT_FOUND', p_tt);
  end;
  bars_audit.trace('%s назначение платежа для операции %s - %s', title, p_tt, l_nazn);

  -- вид зачисления
  begin
    select type_name, sk_zb, tt into l_filetype, l_skzb, l_cardtt from social_file_types where type_id = p_typeid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'FILETYPE_NOT_FOUND', to_char(p_typeid));
  end;
  bars_audit.trace('%s вид зачисления - %s', title, l_filetype);

  -- операция выплаты на карточку
  begin
    select tt into l_cardtt from tts where tt = l_cardtt;
  exception
    when no_data_found then
      l_cardtt := p_tt;
  end;
  bars_audit.trace('%s операция выплаты на карточку - %s', title, l_cardtt);

  for cur_branch in
     (select branch, agency_id     -- стандартная обработка
        from dpt_file_row
       where header_id = p_headerid
         and p_centre is null
         and excluded = 0
         and marked4payment = 1
       group by branch, agency_id
       union all
      select p_centre, p_agencyid  -- обработка в центре
        from dual
       where p_centre is not null)
  loop

    if ( l_branch = cur_branch.branch )
    then
      null;
    else

      bars_context.set_context;

      -- представляемся подразделением
      l_branch := cur_branch.branch;
      bars_context.subst_branch(l_branch);
      bars_audit.trace('%s представились подразделением %s', title, l_branch);

    end if;

    -- реквизиты органа соц.защиты
    begin
      select * into l_agency from social_agency where agency_id = cur_branch.agency_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_modcode, 'AGENCY_NOT_FOUND', to_char(cur_branch.agency_id));
    end;
    bars_audit.trace('%s ОСЗ № %s - %s', title, to_char(l_agency.agency_id), l_agency.name);

    if p_centre is not null then
       -- заполнение ОСЗ для всех строк файла
       delete from dpt_file_agency where header_id = p_headerid;
       update dpt_file_row
          set agency_id   = l_agency.agency_id
        where header_id   = p_headerid;
    end if;

    -- проверка существования файла + общие суммы зачислений на карточные/текущие счета
    get_filedata_uni (p_headerid => p_headerid,
                      p_branch   => (case when p_centre is null then l_branch else null end),
                      p_marked   => p_marked,
                      p_filesumD => l_filesumD,
                      p_filesumC => l_filesumC,
                      p_filenazn => l_filenazn);
    bars_audit.trace('%s сумма зачисления на карт./текущ.счета = %s/%s', title,
                     to_char(l_filesumC), to_char(l_filesumD));

    -- транзитные счета
    get_agency_accounts (p_agencyrow  => l_agency,
                         p_debitacc   => l_debitacc,
                         p_creditacc  => l_creditacc,
                         p_cardacc    => l_cardacc,
                         p_comissacc  => l_comissacc);
    bars_audit.trace('%s счет дебет.задолж: %s/%s,'
                     ||' счет кредит.задолж(текущ): %s/%s,'
                     ||' счет кредит.задолж(карт): %s/%s,'
                     ||' счет комисс.доходов: %s/%s', title,
                     l_debitacc.num,  to_char(l_debitacc.cur),
                     l_creditacc.num, to_char(l_creditacc.cur),
                     l_cardacc.num,   to_char(l_cardacc.cur),
                     l_comissacc.num, to_char(l_comissacc.cur));

    -- контрсчета и код ОКПО подразделения
    get_branchparams (p_branch   => l_branch,       -- код подразделения
                      p_corracc  => l_corraccount,  -- контрсчет подразделения
                      p_cardacc  => l_cardaccount,  -- контрсчет для карточек
                      p_okpo     => l_bankokpo);    -- код ОКПО подразделения

    bars_audit.trace('%s к/счет подразд - %s, к/счет карт. - %s, код ОКПО - %s',
                     title, l_corraccount,  l_cardaccount, l_bankokpo);

    -- взыскание комиссии
    select tarif_id into l_tarifid from social_agency_type where type_id = l_agency.type_id;
    bars_audit.trace('%s код тарифа за РКО - %s', title, to_char(l_tarifid));
    if l_tarifid is not null then
       -- сума комиссии - только на зачисления на текущие счета
       l_comissum := nvl(f_tarif(l_tarifid, l_comissacc.cur, l_comissacc.num, l_filesumd), 0);
       l_comisstt := 'K'||substr('00'||to_char(l_tarifid), -2, 2);
       begin
         select nazn into l_nazn from tts where tt = l_comisstt;
     l_nazn4comiss := l_nazn;
       exception
         when no_data_found then
           bars_error.raise_nerror(g_modcode, 'COMISSTT_NOT_FOUND', to_char(l_tarifid));
       end;
    else
       l_comissum := 0;
    end if;
    bars_audit.trace('%s сума комиссии = %s, операция - %s', title, to_char(l_comissum), l_comisstt);

  l_comissum := 0;

    -- проверка наличия средств на транзитных счетах ОСЗ
    if (l_debitacc.num is not null) then
        check_acc_saldo (l_debitacc,  (l_filesumD + l_filesumC + l_comissum));
    else
        check_acc_saldo (l_creditacc, (l_filesumD + l_comissum));
        check_acc_saldo (l_cardacc,   (l_filesumC));
    end if;

    bars_audit.trace('%s зачисление общих сумм на транзитные счета...', title);

    l_nazn := substr('Зарахування коштів згідно отриманих списків. '
                   ||' Тип виплати: '||l_filetype||'.Без ПДВ', 1, 160);

    if l_agency.debit_acc is not null then
       if l_filesumd > 0 then
          dpt_web.paydoc (p_dptid      => null,
                          p_vdat       => l_bdate,
                          p_brancha    => l_branch,
                          p_nlsa       => l_debitacc.num,
                          p_mfoa       => l_bankcode,
                          p_nama       => substr(l_debitacc.name, 1, 38),
                          p_ida        => l_debitacc.code,
                          p_kva        => l_debitacc.cur,
                          p_sa         => l_filesumD,
                          p_branchb    => l_branch,
                          p_nlsb       => l_creditacc.num,
                          p_mfob       => l_bankcode,
                          p_namb       => substr(l_creditacc.name, 1, 38),
                          p_idb        => l_creditacc.code,
                          p_kvb        => l_creditacc.cur,
                          p_sb         => l_filesumD,
                          p_nazn       => l_nazn,
                          p_nmk        => substr(l_creditacc.name, 1, 38),
                          p_tt         => p_tt,
                          p_vob        => null,
                          p_dk         => 1,
                          p_sk         => null,
                          p_userid     => l_userid,
                          p_type       => null,
                          p_ref        => l_ref,
                          p_err_flag   => l_errflg,
                          p_err_msg    => l_errmsg);
          if l_errflg then
             bars_error.raise_nerror(g_modcode, 'PAYDOC_FAILED',
                                     l_debitacc.num, l_creditacc.num, to_char(l_filesumD), l_errmsg);
          end if;
          bars_audit.trace('%s референс %s: %s -> %s на %s', title, to_char(l_ref),
                            l_debitacc.num, l_creditacc.num, to_char(l_filesumd));
       end if;

       if l_filesumC > 0 then
          dpt_web.paydoc (p_dptid      => null,
                          p_vdat       => l_bdate,
                          p_brancha    => l_branch,
                          p_nlsa       => l_debitacc.num,
                          p_mfoa       => l_bankcode,
                          p_nama       => substr(l_debitacc.name,  1, 38),
                          p_ida        => l_debitacc.code,
                          p_kva        => l_debitacc.cur,
                          p_sa         => l_filesumC,
                          p_branchb    => l_branch,
                          p_nlsb       => l_cardacc.num,
                          p_mfob       => l_bankcode,
                          p_namb       => substr(l_cardacc.name, 1, 38),
                          p_idb        => l_cardacc.code,
                          p_kvb        => l_cardacc.cur,
                          p_sb         => l_filesumC,
                          p_nazn       => l_nazn,
                          p_nmk        => substr(l_cardacc.name, 1, 38),
                          p_tt         => p_tt,
                          p_vob        => null,
                          p_dk         => 1,
                          p_sk         => null,
                          p_userid     => l_userid,
                          p_type       => null,
                          p_ref        => l_ref,
                          p_err_flag   => l_errflg,
                          p_err_msg    => l_errmsg);
          if l_errflg then
             bars_error.raise_nerror(g_modcode, 'PAYDOC_FAILED',
                                     l_debitacc.num, l_cardacc.num, to_char(l_filesumC), l_errmsg);
          end if;
          bars_audit.trace('%s референс %s: %s -> %s на %s', title, to_char(l_ref),
                            l_debitacc.num, l_cardacc.num, to_char(l_filesumC));
       end if;
    end if;

    -- взыскание комиссии за РКО
    if l_comissum > 0 then

       if l_comissacc.num is null then
          bars_error.raise_nerror(g_modcode, 'COMISS_NOT_FOUND', to_char(l_agencyid), to_char(l_agency.comiss_acc));
       end if;

       bars_audit.trace('%s взыскание комиссии за РКО', title);
       dpt_web.paydoc (p_dptid      => null,
                       p_vdat       => l_bdate,
                       p_brancha    => l_branch,
                       p_nlsa       => l_creditacc.num,
                       p_mfoa       => l_bankcode,
                       p_nama       => substr(l_creditacc.name, 1, 38),
                       p_ida        => l_creditacc.code,
                       p_kva        => l_creditacc.cur,
                       p_sa         => l_comissum,
                       p_branchb    => l_branch,
                       p_nlsb       => l_comissacc.num,
                       p_mfob       => l_bankcode,
                       p_namb       => substr(l_comissacc.name, 1, 38),
                       p_idb        => l_comissacc.code,
                       p_kvb        => l_comissacc.cur,
                       p_sb         => l_comissum,
                       p_nazn       => l_nazn,
                       p_nmk        => substr(l_comissacc.name, 1, 38),
                       p_tt         => l_comisstt,
                       p_vob        => null,
                       p_dk         => 1,
                       p_sk         => null,
                       p_userid     => l_userid,
                       p_type       => null,
                       p_ref        => l_ref,
                       p_err_flag   => l_errflg,
                       p_err_msg    => l_errmsg);
       if l_errflg then
          bars_error.raise_nerror(g_modcode, 'PAYDOC_FAILED',
                                  l_creditacc.num, l_comissacc.num,
                                  to_char(l_comissum), l_errmsg);
       end if;
       bars_audit.trace('%s референс %s: %s -> %s на %s', title, to_char(l_ref),
                        l_creditacc.num, l_comissacc.num, to_char(l_comissum));
    end if;

    bars_audit.trace('%s зачисление сумм на клиентские счета...', title);
    for filedata in
       (select info_id, to_char(info_id) nd, nls, branch_code,
               dpt_code, sum, fio, branch, payoff_date, id_code, acc_type
          from dpt_file_row
         where header_id = p_headerid
           and incorrect = 0
           and closed    = 0
           and excluded  = 0
           and ref is null
           and sum  > 0
           and marked4payment = decode(p_marked, 0, marked4payment, p_marked)
           and branch         = nvl2(p_centre, branch, cur_branch.branch)
         order by info_id)
    loop

      bars_audit.trace('%s № %s, ФИО = %s, счет = %s, сумма = %s', title,
                       filedata.nd, filedata.fio, filedata.nls, to_char(filedata.sum));
      l_accA   := null;
      l_accB   := null;
      l_tmcard := null;
      l_nazn   := null;

    l_local_comissum := nvl(f_tarif(l_tarifid, l_comissacc.cur, l_comissacc.num, filedata.sum), 0);

      -- удаление лишних пробелов в ФИО клиента
      l_integer  := 0;
      l_custname := trim(filedata.fio);
      if instr(l_custname, '  ') > 0 then
         while l_integer < length(l_custname) loop
           l_custname := replace (l_custname, '  ', ' ');
           l_integer := l_integer + 1;
         end loop;
      end if;

      if (filedata.nls = l_newaccount /*or regexp_like(filedata.nls,l_newaccount2)*/) then

        l_clientid := null;

        -- I. открытие клиента и счета
        dpt_web.p_open_vklad_rnk (p_clientname     => trim(filedata.fio),
                                  p_client_name    => fio (trim (filedata.fio), 2),
                                  p_client_surname => fio (trim (filedata.fio), 1),
                                  p_client_patr    => fio (trim (filedata.fio), 3),
                                  p_clientcode     => nvl(filedata.id_code,'000000000'),
                                  p_clientid       => l_clientid,
                                  p_usagemode      => 'IO');
        begin
          select agency_id
            into l_agencyid_new
            from v_socialagencies_ext a, dpt_file_header h
           where a.agency_branch = filedata.branch
             and h.header_id     = p_headerid
             and a.agency_type   = h.agency_type
             and rownum = 1;
        exception when no_data_found then
          bars_error.raise_nerror(g_modcode, 'AG_TYPE_NOT_FOUND', filedata.branch, p_headerid);
        end;

        begin
          select dt.dpt_vidd
            into l_soctypeid
            from social_agency          a,
                 social_agency_dpttypes t,
                 social_dpt_types       dt
           where a.agency_id  = l_agencyid_new
             and a.type_id    = t.agntype
             and dt.type_id   = t.dpttype
             and dt.card_type = 0
             and dt.activity  = 1;
        exception
          when no_data_found or too_many_rows then
            bars_error.raise_nerror(g_modcode, 'SOC_TYPE_NOT_FOUND', l_agencyid_new);
        end;

        dpt_web.create_deposit(p_vidd       => l_soctypeid,
                               p_rnk        => l_clientid,
                               p_nd         => null,
                               p_sum        => 0,
                               p_nocash     => 1,
                               p_datz       => gl.bdate,
                               p_namep      => null,
                               p_okpop      => null,
                               p_nlsp       => null,
                               p_mfop       => null,
                               p_fl_perekr  => null,
                               p_name_perekr=> null,
                               p_okpo_perekr=> null,
                               p_nls_perekr => null,
                               p_mfo_perekr => null,
                               p_comment    => l_comment || to_char(p_headerid),
                               p_dpt_id     => l_contractid,
                               p_datbegin    => gl.bdate);
        select nls
          into filedata.nls
          from accounts a, dpt_deposit d
         where a.acc = d.acc
           and d.deposit_id = l_contractid;

        update dpt_file_row
           set nls = filedata.nls
         where info_id = filedata.info_id;

      end if;
      if is_valid_social_card (filedata.nls, l_branch) > 0 then
         -- карточный счет
         l_accA.num  := l_cardacc.num;      -- 2924xxx
         l_accA.cur  := l_cardacc.cur;
         l_accA.code := l_cardacc.code;
         l_accA.name := l_cardacc.name;
         l_nazn      := substr('Поповнення карткового рахунку № '||filedata.nls||', '||l_custname
                             ||'. Тип виплати: '||l_filetype||'. Без ПДВ', 1, 160);
         l_tmcard    := null;
         l_tt        := l_cardtt;
         l_accb      := look4acc (p_accnum   => filedata.nls,
                                  p_acccur   => l_acca.cur,
                                  p_bankmfo  => l_bankcode,
                                  p_iscard   => 1,
                                  p_okpo     => filedata.id_code,
                                  p_nmk      => filedata.fio,
                                  p_acc_type => filedata.acc_type);
         if l_accb.num is null then
            bars_error.raise_nerror(g_modcode, 'FILEACC_NOT_FOUND',
                                    filedata.nls, TO_CHAR(l_accA.cur), filedata.fio);
         end if;
      else
         -- текущий счет
         l_tmcard    := null;
         l_tt        := p_tt;
         l_accA.num  := l_creditacc.num;
         l_accA.cur  := l_creditacc.cur;
         l_accA.code := l_creditacc.code;
         l_accA.name := l_creditacc.name;
         l_accb      := look4acc (p_accnum   => filedata.nls,
                                  p_acccur   => l_acca.cur,
                                  p_bankmfo  => l_bankcode,
                                  p_iscard   => 0,
                                  p_okpo     => filedata.id_code,
                                  p_nmk      => filedata.fio,
                                  p_acc_type => filedata.acc_type);
         if l_accb.num is null then
            bars_error.raise_nerror(g_modcode, 'FILEACC_NOT_FOUND',
                                    filedata.nls, TO_CHAR(l_accA.cur), filedata.fio);
         end if;

         l_nazn := SUBSTR( 'Зарахування коштів на поточний рахунок '||l_custname||' від '||l_agency.name||
                           '. Тип виплати: '||l_filetype||--' за '||get_paydate2str(filedata.payoff_date) ||
                           '. Без ПДВ', 1, 160 );
      end if;

      bars_audit.trace('%s отправитель: %s/%s - %s',  title, l_accA.num, to_char(l_accA.cur), l_accA.name);
      bars_audit.trace('%s получатель:  %s/%s - %s ', title, l_accB.num, to_char(l_accB.cur), l_accB.name);

      if l_tmcard is null then
    if l_accB.num like l_nbs4comiss and l_local_comissum > 0 then
/*
      -- представимся подразделением, которое инициирует платеж
      IF l_curbranch != l_branch THEN
        bars_context.subst_branch(l_branch);
      END IF;
      bars_audit.trace('%s представились подразделением %s', title, l_branch);
*/
      gl.ref (l_ref);

/*
            INSERT INTO oper
         (ref, tt, vob, nd, dk, sk, pdat, vdat, datd,
        id_a, nam_a, mfoa, nlsa, kv, s,
        id_b, nam_b, mfob, nlsb, kv2, s2,
        userid, nazn)
      VALUES
         (l_ref, l_tt, dpt_web.get_vob (l_accA.cur, l_accB.cur, l_tt, null), to_char(l_ref), 1, null, sysdate, l_bdate, l_bdate,
        l_accA.code, substr(l_accA.name, 1, 38), l_bankcode, l_accA.num, l_accA.cur, filedata.sum,
        l_accB.code, substr(l_accB.name, 1, 38), l_bankcode, l_accB.num, l_accB.cur, filedata.sum,
        l_userid, l_nazn);
*/

        gl.in_doc3 (ref_    =>  l_ref,
            tt_     =>  l_tt,                                 dk_     =>  1,
            vob_    =>  dpt_web.get_vob (l_accA.cur, l_accB.cur, l_tt, null),      uid_    =>  null,
            nazn_   =>  l_nazn,                               nd_     =>  to_char(l_ref),
            vdat_   =>  l_bdate,                              kv_     =>  l_accA.cur,
            data_   =>  l_bdate,                              s_      =>  filedata.sum,
            pdat_   =>  sysdate,                              kv2_    =>  l_accB.cur,
            datp_   =>  sysdate,                              s2_     =>  filedata.sum,
            nlsa_   =>  l_accA.num,                           nlsb_   =>  l_accB.num,
            mfoa_   =>  l_bankcode,                           mfob_   =>  l_bankcode,
            nam_a_  =>  substr(l_accA.name, 1, 38),                    nam_b_  =>  substr(l_accB.name, 1, 38),
            id_a_   =>  l_accA.code,                           id_b_   =>  l_accB.code,
            sk_     =>  null,                                 d_rec_  =>  null,
            id_o_   =>  null,                                 sign_   =>  null,
            sos_    =>  0,                                    prty_   =>  0);

      bars_audit.trace('%s gl.in_doc3 ref = %s ', title, to_char(l_ref));

      paytt (null, l_ref,   l_bdate, l_tt, 1,
             l_accA.cur, l_accA.num, filedata.sum,
             l_accB.cur, l_accB.num, filedata.sum);

      paytt (null, l_ref,   l_bdate, l_comisstt, 1,
             l_accB.cur, l_accB.num, l_local_comissum,
             l_comissacc.cur, l_comissacc.num, l_local_comissum);

      l_local_comissum := 0;
    else
       dpt_web.paydoc (p_dptid      => null,
               p_vdat       => l_bdate,
               p_brancha    => l_branch,
               p_nlsa       => l_accA.num,
               p_mfoa       => l_bankcode,
               p_nama       => substr(l_accA.name, 1, 38),
               p_ida        => l_accA.code,
               p_kva        => l_accA.cur,
               p_sa         => filedata.sum,
               p_branchb    => l_branch,
               p_nlsb       => l_accB.num,
               p_mfob       => l_bankcode,
               p_namb       => substr(l_accB.name, 1, 38),
               p_idb        => l_accB.code,
               p_kvb        => l_accB.cur,
               p_sb         => filedata.sum,
               p_nazn       => l_nazn,
               p_nmk        => substr(l_accB.name, 1, 38),
               p_tt         => l_tt,
               p_vob        => null,
               p_dk         => 1,
               p_sk         => null,
               p_userid     => l_userid,
               p_type       => null,
               p_ref        => l_ref,
               p_err_flag   => l_errflg,
               p_err_msg    => l_errmsg);
    end if;

         insert into operw (ref,tag,value) values (l_ref, 'SK_ZB', l_skzb);
         if l_errflg then
            bars_error.raise_nerror(g_modcode, 'PAYDOC_FAILED', l_accA.num, l_accB.num,
                                               to_char(filedata.sum), l_errmsg);
         end if;
      end if;
      bars_audit.trace('%s референс %s: %s -> %s на %s', title, to_char(l_ref),
                       l_accA.num, l_accB.num, to_char(filedata.sum));

      if p_marked = 0 then
         update dpt_file_row set ref = l_ref where info_id = filedata.info_id;
      else
         update dpt_file_row set ref = l_ref, marked4payment = 0 where info_id = filedata.info_id;
      end if;

      -- заполнение доп.реквизита
      fill_docvalues (l_ref, 'SOCTP', l_filetype);

    end loop;

  end loop; -- cur_branch

  bars_context.set_context;

end pay_bankfile_uni;

--
-- оплата файла зачисления пенсии / мат.помощи - I
--
procedure pay_bankfile
 (p_header_id  in  dpt_file_header.header_id%type,
  p_typeid     in  social_file_types.type_id%type,
  p_tt         in  tts.tt%type  default 'DBF')
is
  title  varchar2(60) := 'dptsocial.payfile';
begin

  bars_audit.trace('%s entry, header=>%s, type=>%s, tt=>%s', title,
                    to_char(p_header_id), to_char(p_typeid), p_tt);

  pay_bankfile_uni (p_headerid  =>  p_header_id,
                    p_agencyid  =>  null,
                    p_typeid    =>  p_typeid,
                    p_tt        =>  p_tt,
                    p_marked    =>  0,
                    p_centre    =>  null);

  bars_audit.trace('%s exit', title);

end pay_bankfile;

--
-- оплата файла зачисления пенсии / мат.помощи  - II
--
procedure pay_bankfile_ext
 (p_header_id  in  dpt_file_header.header_id%type,
  p_typeid     in  social_file_types.type_id%type,
  p_tt         in  tts.tt%type  default 'DBF')
is
  title  varchar2(60) := 'dptsocial.payfileExt';
begin

  bars_audit.trace('%s entry, header=>%s, type=>%s, tt=>%s', title,
                    to_char(p_header_id), to_char(p_typeid), p_tt);

  pay_bankfile_uni (p_headerid  =>  p_header_id,
                    p_agencyid  => null,
                    p_typeid    =>  p_typeid,
                    p_tt        =>  p_tt,
                    p_marked    =>  1,
                    p_centre    =>  null);

  bars_audit.trace('%s exit', title);

end pay_bankfile_ext;

--
-- оплата файла зачисления пенсии / мат.помощи - III
--
procedure pay_bankfile_ext_center
 (p_header_id  in  dpt_file_header.header_id%type,
  p_typeid     in  social_file_types.type_id%type,
  p_agency_id  in  social_agency.agency_id%type,
  p_tt         in  tts.tt%type  default 'DBF')
is
  title        varchar2(60)       := 'dptsocial.payfileCnt';
  l_mainbranch branch.branch%type := '/'||getglobaloption('GLB-MFO')||'/';
  l_currbranch branch.branch%type := sys_context('bars_context','user_branch');
begin

  bars_audit.trace('%s entry, header=>%s, type=>%s, agency=>%s, tt=>%s', title,
                   to_char(p_header_id), to_char(p_typeid), to_char(p_agency_id), p_tt);

  if l_currbranch = l_mainbranch then
     pay_bankfile_uni (p_headerid  =>  p_header_id,
                       p_agencyid  =>  p_agency_id,
                       p_typeid    =>  p_typeid,
                       p_tt        =>  p_tt,
                       p_marked    =>  1,
                       p_centre    =>  l_mainbranch);
  else
    bars_error.raise_nerror(g_modcode, 'USER_NOT_ALLOWED', l_currbranch);
  end if;

  bars_audit.trace('%s exit', title);

end pay_bankfile_ext_center;

--
-- нарахування відсотків по соц.договорах в кінці місяця
--
procedure auto_make_int
  (p_contractid  in  social_contracts.contract_id%type,
   p_runid       in  dpt_jobs_jrnl.run_id%type,
   p_branch      in  branch.branch%type,
   p_bdate       in  fdat.fdat%type,
   p_mode        in  number)
is
  title       constant varchar2(60) := 'dptsocial.makeint';
  l_valdate   date;
  l_acrdate   date;
  l_tmp       number;
  l_error     boolean;
begin

  bars_audit.trace('%s entry, branch=>%s, bdate=>%s, runid=>%s, contractid=>%s, mode=>%s',
                   title, p_branch, to_char(p_bdate,'dd.mm.yyyy'),
                   to_char(p_runid), to_char(p_contractid), to_char(p_mode));

  if (nvl(p_runid, 0) = 0 and p_contractid = 0) then
    bars_error.raise_nerror(g_modcode, 'JOB_RUNID_NOT_FOUND');
  end if;

  if p_contractid = 0 then
     -- начисление процентов по соц.договорам подразделения %s...
     bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOMAKEINTMNTH_ENTRY', p_branch));
  end if;

  -- расчет даты выполняения и граничной даты начисления процентов в конце месяца
  dpt_web.get_mnthintdates (p_bnkdate  => p_bdate,    -- текущая банк.дата
                            p_isfixed  => 'N',        -- признак срочного вклада (Y-срочный, N-до востреб.)
                            p_valdate  => l_valdate,  -- дата выполнения начисления
                            p_acrdate  => l_acrdate,  -- граничная дата начисления
                            p_mode     => p_mode);    -- режим запуска функции

  if p_bdate != l_valdate then
     -- нарушен регламент начисления процентов в конце месяца
     bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOMAKEINTMNTH_DENIED'));
     return;
  end if;

  insert into int_queue
        (kf, branch, deal_id, deal_num, deal_dat, cust_id,
         int_id, acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso,
         acc_open, acc_amount, int_details, int_tt, mod_code)
  select /*+ ORDERED*/
         a.kf, a.branch, s.contract_id, s.contract_num, s.contract_date, a.rnk,
         i.id, a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
         a.daos, null, null, nvl(i.tt, '%%1'), 'SOC'
    from social_contracts s, accounts a, int_accn i, tabval t
   where s.acc        = a.acc
     and s.acc        = i.acc
     and i.id         = 1
     and a.kv         = t.kv
     and s.branch     = p_branch
     and p_contractid = 0
     and (   (i.acr_dat is null)
         or (i.acr_dat < l_acrdate and i.stp_dat is null)
         or (i.acr_dat < l_acrdate and i.stp_dat > i.acr_dat))
   union all
  select /*+ ORDERED*/
         a.kf, a.branch, s.contract_id, s.contract_num, s.contract_date, a.rnk,
         i.id, a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
         a.daos, null, null, nvl(i.tt, '%%1'), 'SOC'
    from social_contracts s, accounts a, int_accn i, tabval t
   where s.acc         = a.acc
     and s.acc         = i.acc
     and i.id          = 1
     and a.kv          = t.kv
     and s.branch      = p_branch
     and p_contractid != 0
     and s.contract_id = p_contractid
     and (   (i.acr_dat is null)
          or (i.acr_dat < l_acrdate and i.stp_dat is null)
          or (i.acr_dat < l_acrdate and i.stp_dat > i.acr_dat));

  make_int (p_dat2      => l_acrdate,
            p_runmode   => 1,
            p_runid     => p_runid,
            p_intamount => l_tmp,
            p_errflg    => l_error);


  if p_contractid = 0 then
     -- начисление процентов по соц.договорам подразделения %s выполнено
     bars_audit.info(bars_msg.get_msg (g_modcode, 'AUTOMAKEINTMNTH_DONE', p_branch));
  end if;

end auto_make_int;

--
-- виплата відсотків по соц.договорах в останній робочий день місяца
--
PROCEDURE auto_payout_int
  (p_contractid  IN  social_contracts.contract_id%type,
   p_runid       IN  dpt_jobs_jrnl.run_id%type,
   p_branch      IN  branch.branch%type,
   p_bdate       IN  fdat.fdat%type)
IS
   l_title      varchar2(80) := 'dptsocial.payint';
   l_firstdate  date;
   l_amount     number;
   l_apldat     int_accn.apl_dat%type;
   l_nazn       oper.nazn%type;
   l_ref        oper.ref%type;
   l_errmsg     g_errmsg%type;
   l_errflg     boolean;
   l_status     number(1);

BEGIN

  bars_audit.trace('%s соц.договір № %s, запуск № %s, підрозділ %s, банк.дата %s',
                   l_title, to_char(p_contractid), to_char(p_runid),
                   p_branch, to_char(p_bdate,'DD/MM/YYYY'));

  IF (nvl(p_runid, 0) = 0 AND p_contractid = 0) THEN
      bars_error.raise_nerror(g_modcode, 'JOB_RUNID_NOT_FOUND');
  END IF;
  bars_audit.trace('%s № запуска: %s', l_title, to_char(p_runid));

  -- перший робочий день поточного місяця
  SELECT min(fdat) INTO l_firstdate
    FROM fdat
   WHERE fdat >= add_months (last_day(p_bdate), -1) + 1 and fdat <= p_bdate;

  bars_audit.trace('%s перший робочий день поточного місяця - %s',
                   l_title, to_char(l_firstdate, 'dd/mm/yyyy'));

  IF (p_bdate != l_firstdate OR l_firstdate IS NULL) THEN
     bars_audit.trace('%s сьогодні - не перший робочий день місяца', l_title);
     RETURN;
  END IF;

  bars_audit.trace('%s сьогодні - перший робочий день місяца', l_title);

  FOR d IN
     (SELECT -- один депозит
             p.branch BRANCHA, s.contract_id, s.contract_num, s.contract_date,
             s.acc, p.acc ACCA, p.kv, i.nazn, c.rnk, substr(c.nmk,1,38) NMK,
             p.kf               MFOA, i.mfob               MFOB,
             p.nls              NLSA, i.nlsb               NLSB,
             substr(p.nms,1,38) NAMA, substr(i.namb,1,38)  NAMB,
             c.okpo             IDA,  c.okpo               IDB
        FROM social_contracts s, accounts p, customer c, int_accn i
       WHERE s.acc = i.acc
         AND i.acra = p.acc
         AND i.id = 1
         AND s.rnk = c.rnk
         AND p.ostb = p.ostc
         AND p.ostc > 0
         AND p.dazs IS NULL
         AND i.nlsb IS NOT NULL
         AND i.mfob IS NOT NULL
         AND s.contract_id = p_contractid
         AND p_contractid <> 0
         AND s.branch = p_branch
       UNION ALL
      SELECT -- депозитный портфель подразделения (p_contractid = 0)
             p.branch, s.contract_id, s.contract_num, s.contract_date,
             s.acc, p.acc, p.kv, i.nazn, c.rnk, substr(c.nmk,1,38),
             p.kf               MFOA, i.mfob               MFOB,
             p.nls              NLSA, i.nlsb               NLSB,
             substr(p.nms,1,38) NAMA, substr(i.namb,1,38)  NAMB,
             c.okpo             IDA,  c.okpo               IDB
        FROM social_contracts s, accounts p, customer c, int_accn i
       WHERE s.acc = i.acc
         AND i.acra = p.acc
         AND i.id = 1
         AND s.rnk = c.rnk
         AND p.ostb = p.ostc
         AND p.ostc > 0
         AND p.dazs IS NULL
         AND i.nlsb IS NOT NULL
         AND i.mfob IS NOT NULL
         AND p_contractid = 0
         AND s.branch = p_branch
       ORDER BY 1, 2)
  LOOP

    bars_audit.trace('%s соц.договір № %s (%s)', l_title, d.contract_num, to_char(d.contract_id));

    l_errflg  := FALSE;
    l_errmsg  := NULL;
    l_amount  := NULL;
    l_ref     := NULL;

    SAVEPOINT sp_payout;

    -- блокування процентної картки по рахунку
    BEGIN
      SELECT apl_dat INTO l_apldat FROM int_accn WHERE acc = d.acc AND id = 1
      FOR UPDATE NOWAIT;
      bars_audit.trace('%s заблокована процентна картка по соц.договору № %s (%s)',
                        l_title, d.contract_num, to_char(d.contract_id));
    EXCEPTION
      WHEN OTHERS THEN
        l_errflg := TRUE;
        l_errmsg := SUBSTR(l_title||'помилка блокування %-ної картки '
                                  ||'по рахунку #'||to_char(d.acc)
                                  ||': '||SQLERRM, 1, g_errmsg_dim);
        ROLLBACK TO sp_payout;
        GOTO nextrec;
    END;

    -- залишок на рахунку нарахованих відсотків
    BEGIN
      SELECT ost INTO l_amount FROM sal WHERE acc = d.acca AND fdat = p_bdate;
      bars_audit.trace('%s залишок на рахунку нарах.відсотків = %s', l_title, to_char(l_amount));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        l_errflg := TRUE;
        l_errmsg  := SUBSTR(l_title||'помилка обчисленні залишку '
                                   ||'на рахунку #'||to_char(d.acca)
                                   ||' на '||to_date(p_bdate,'DD/MM/YYYY')
                                   ||': '||SQLERRM, 1, g_errmsg_dim);
        ROLLBACK TO sp_payout;
        GOTO nextrec;
    END;

    -- Назначение платежа
    l_nazn := SUBSTR('Капіталізація нарахованих відсотків '||
                     'по договору про обслуговування пенс.рахунку № '||
                     trim(d.contract_num)||
                     ' від '||to_char(d.contract_date,'dd/MM/yyyy'),
                     1, 160);
    bars_audit.trace('%s призначення платежу = %s', l_title, l_nazn);

    IF l_amount > 0 THEN
       -- оплата
       dpt_web.paydoc (p_dptid    =>  null     ,
                       p_vdat     =>  p_bdate  ,
                       p_brancha  =>  d.brancha,
                       p_nlsa     =>  d.nlsa   ,
                       p_mfoa     =>  d.mfoa   ,
                       p_nama     =>  substr(d.nama, 1, 38),
                       p_ida      =>  d.ida    ,
                       p_kva      =>  d.kv     ,
                       p_sa       =>  l_amount ,
                       p_branchb  =>  d.brancha,
                       p_nlsb     =>  d.nlsb   ,
                       p_mfob     =>  d.mfob   ,
                       p_namb     =>  substr(d.namb, 1, 38),
                       p_idb      =>  d.idb    ,
                       p_kvb      =>  d.kv     ,
                       p_sb       =>  l_amount ,
                       p_nazn     =>  l_nazn   ,
                       p_nmk      =>  substr(d.nmk, 1, 38),
                       p_tt       =>  null     ,
                       p_vob      =>  null     ,
                       p_dk       =>  1        ,
                       p_sk       =>  null     ,
                       p_userid   =>  null     ,
                       p_type     =>  4        ,
                       p_ref      =>  l_ref    ,
                       p_err_flag =>  l_errflg ,
                       p_err_msg  =>  l_errmsg );

       IF l_errflg THEN
          ROLLBACK TO sp_payout;
          GOTO nextrec;
       ELSE
          bars_audit.financial(l_title||'референс документа = '||to_char(l_ref));
          IF p_runid > 0 THEN
             -- запись в журнал
             dpt_jobs_audit.p_save2log (p_runid      => p_runid,
                                        p_dptid      => null,
                                        p_dealnum    => d.contract_num,
                                        p_branch     => p_branch,
                                        p_ref        => l_ref,
                                        p_rnk        => d.rnk,
                                        p_nls        => d.nlsa,
                                        p_kv         => d.kv,
                                        p_dptsum     => null,
                                        p_intsum     => l_amount,
                                        p_status     => 1,
                                        p_errmsg     => l_errmsg,
                                        p_contractid => d.contract_id);
          END IF;
       END IF;

    END IF;  -- l_amount_int > 0

    UPDATE int_accn SET apl_dat = p_bdate WHERE acc = d.acc AND id = 1;

    <<nextrec>>
    -- виплата %% по портфелю -> запис в журнал автомат.операцій та перехід до наступного запису
    IF (p_runid > 0 AND l_errflg) THEN
        bars_audit.error (l_title||'помилка оплати: '||l_errmsg);
        dpt_jobs_audit.p_save2log (p_runid      => p_runid,
                                   p_dptid      => null,
                                   p_dealnum    => d.contract_num,
                                   p_branch     => p_branch,
                                   p_ref        => l_ref,
                                   p_rnk        => d.rnk,
                                   p_nls        => d.nlsa,
                                   p_kv         => d.kv,
                                   p_dptsum     => null,
                                   p_intsum     => l_amount,
                                   p_status     => -1,
                                   p_errmsg     => l_errmsg,
                                   p_contractid => d.contract_id);
    ELSE
       IF l_errflg THEN
          bars_error.raise_nerror(g_modcode, 'PAYDOC_FAILED', d.nlsa, d.nlsb, to_char(l_amount), l_errmsg);
       END IF;
    END IF;

  END LOOP; -- d

END auto_payout_int;

--
-- перевірка: чи є заданий рахунок картковим
--
function check_tm_card
 (p_cardaccount social_contracts.card_account%type,
  p_branch      social_contracts.branch%type default null)
  return number
is
  title        varchar2(60)       := 'dptsocial.checktmcard';
  baseval      tabval.kv%type     := gl.baseval;
  l_exists     number(1);
begin

  bars_audit.trace('%s entry, cardacc=>%s', title, p_cardaccount);

  l_exists := 0;

  bars_audit.trace('%s exit with %s', title, to_char(l_exists));

  return l_exists;

end check_tm_card;

--
-- перевірка: чи зв'язаний даний картковий рахунок із соц.договором
--
function is_valid_social_card
 (p_cardaccount  social_contracts.card_account%type,
  p_branch       social_contracts.branch%type default sys_context('bars_context','user_branch'))
  return number
is
  title          varchar2(60)       := 'dptsocial.isvalidcard';
  initbranch     branch.branch%type := sys_context('bars_context','user_branch');
  l_cnt          number(38);
  l_kv           tabval.kv%type     := gl.baseval;
  l_cardacc_type  varchar2(3)        :='PK%';
  l_cardacc_type2  varchar2(3)        :='W4%';
begin

  bars_audit.trace('%s entry, cardacc=>%s, branch=>%s', title, p_cardaccount, p_branch);

  select count(*) into l_cnt from social_contracts
   where card_account = p_cardaccount and closed_date is null;

  if l_cnt = 0 then
   select count(*)
     into l_cnt
     from obpc_acct pc, tabval t, accounts a, customer c
    where a.rnk        = c.rnk
      and a.kf         = pc.kf
      and a.kv         = t.kv
      and t.lcv        = pc.currency
      and a.nls        = pc.lacct
      and pc.card_acct = p_cardaccount
      and a.kf         = bars_context.extract_mfo(p_branch)
      and a.kv         = l_kv
      and a.dazs       is null;
  end if;

  if l_cnt = 0 then
    select count(*) into l_cnt from accounts
     where nls = p_cardaccount
       and (tip like l_cardacc_type or tip like l_cardacc_type2);
  end if;

  bars_audit.trace('%s %s active deals with cardacc %s', title, to_char(l_cnt), p_cardaccount);


  return (case when l_cnt = 0 then 0 else 1 end);

end is_valid_social_card;

--
-- оформлення додаткової угоди до соц.договору
--
PROCEDURE p_supplementary_agreement
 (p_contractid IN  social_trustee.contract_id%type,
  p_flagid     IN  dpt_vidd_flags.id%type,
  p_trustrnk   IN  social_trustee.trust_rnk%type,
  p_trustid    OUT number)
IS
  l_title        varchar2(60)               := 'dptsocial.agrmnt';
  l_branch       social_trustee.branch%type := sys_context('bars_context', 'user_branch');
  l_activity     social_trustee.fl_act%type := 1;
  l_custid       social_contracts.rnk%type;
  l_typeid       social_contracts.type_id%type;
  l_trustname    customer.nmk%type;
  l_templateid   social_trustee.template_id%type;
  l_trusttype    social_trustee.trust_type%type;
  l_trusttyperec dpt_trustee_type%rowtype;
  l_revoke       number(1);
  l_addnum       social_trustee.add_num%type;
  l_adddat       social_trustee.add_dat%type;
  l_trustid      social_trustee.trust_id%type;
  l_undoid       social_trustee.trust_id%type;
BEGIN

  bars_audit.trace('%s соц.договір № %s, тип ДУ № %s, дов.особа № %s', l_title,
                   to_char(p_contractid), to_char(p_flagid), to_char(p_trustrnk));

  -- перевірка існування соц.логовору
  BEGIN
    SELECT rnk, type_id
      INTO l_custid, l_typeid
      FROM social_contracts
     WHERE contract_id = p_contractid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      bars_error.raise_nerror(g_modcode, 'CONTRACT_NOT_FOUND', to_char(p_contractid));
  END;
  bars_audit.trace('%s клієнт - вкладник № %s', l_title, to_char(l_custid));
  bars_audit.trace('%s вид договору - %s',      l_title, to_char(l_typeid));

  IF l_custid = p_trustrnk THEN
    -- клієнт - власник договору не може бути довіреною особою
    bars_error.raise_nerror(g_modcode, 'TRUSTCUST_INVALID');
  END IF;

  -- перевірка існування довіреної особи
  BEGIN
    SELECT nmk INTO l_trustname FROM customer WHERE rnk = p_trustrnk;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- не знайдена довірена особа № ...
      bars_error.raise_nerror(g_modcode, 'TRUSTCUST_NOT_FOUND', to_char(p_trustrnk));
  END;
  bars_audit.trace('%s довірена особа %s', l_title, l_trustname);

  -- шаблон додаткової угоди
  BEGIN
    SELECT id INTO l_templateid
      FROM v_socialtemplate
     WHERE flag_id = p_flagid AND type_id = l_typeid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- заборонено заключення дод.угоди типу для типу договору № ...
      bars_error.raise_nerror(g_modcode, 'TRUSTYPE_DENIED', to_char(p_flagid), to_char(l_typeid));
  END;
  bars_audit.trace('%s шаблон дод.угоди = %s', l_title, l_templateid);

  -- тип довіреної особи   --- ПОКА КОРЯВО!!!
  IF    p_flagid = 21 THEN l_trusttype := 'T';  l_revoke := 0;
  ELSIF p_flagid = 22 THEN l_trusttype := 'T';  l_revoke := 1;
  ELSIF p_flagid = 23 THEN l_trusttype := 'H';  l_revoke := 0;
  ELSIF p_flagid = 24 THEN l_trusttype := 'H';  l_revoke := 1;
  ELSE                     l_trusttype := null; l_revoke := null;
  END IF;

  BEGIN
    SELECT * INTO l_trusttyperec FROM dpt_trustee_type WHERE id = l_trusttype;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- не знайдений тип довіреної особи (тип дод.угоди ..)
      bars_error.raise_nerror(g_modcode, 'TRUSTTYPE_NOT_FOUND', to_char(p_flagid));
  END;
  bars_audit.trace('%s тип дов.особи = %s', l_title, l_trusttype);
  bars_audit.trace('%s флаг відмови = %s',  l_title, to_char(l_revoke));

  -- делегування або анулювання дод.угоди
  IF l_revoke = 1 THEN
    -- пошук первинної дод.угоди, яку анулює дана угода
    BEGIN
      SELECT trust_id INTO l_undoid
        FROM social_trustee
       WHERE contract_id = p_contractid
         AND trust_rnk = p_trustrnk
         AND trust_type = l_trusttype
         AND fl_act = 1
         AND undo_id IS NULL;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- не знайдена первинна дод.угода, яка має бути анульована даною угодою
        bars_error.raise_nerror(g_modcode, 'PRIMARY_TRUST_NOT_FOUND');
    END;
    bars_audit.trace('%s анулюється дод.угода № %s', l_title, to_char(l_undoid));
    UPDATE social_trustee SET fl_act = 0 WHERE trust_id = l_undoid;
  END IF;

  -- ідентифікатор дод.угоди
  SELECT bars_sqnc.get_nextval('s_social_trustee') INTO l_trustid FROM dual;
  l_trustid := get_id_ddb(l_trustid);
  bars_audit.trace('%s ідентифікатор дод.угоди = %s', l_title, to_char(l_trustid));

  -- номер та дата додаткової угоди
  SELECT to_char(nvl(max(add_num),0) + 1), bankdate
    INTO l_addnum, l_adddat
    FROM social_trustee
   WHERE contract_id = p_contractid;
  bars_audit.trace('%s дод.угода № %s від %s', l_title, l_addnum, to_char(l_adddat,'dd/mm/yy'));

  -- запис дод.угоди
  BEGIN
    INSERT INTO social_trustee
      (trust_id, trust_type, trust_rnk, contract_id, rnk,
       add_num, add_dat, fl_act, undo_id, branch, template_id)
    VALUES
      (l_trustid, l_trusttype, p_trustrnk, p_contractid, l_custid,
       l_addnum, l_adddat, l_activity, l_undoid, l_branch, l_templateid);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      -- дубль доп.угоди
      bars_error.raise_nerror(g_modcode, 'TRUSTEE_DUPLICATE',
                                         to_char(p_flagid),
                                         to_char(p_trustrnk),
                                         to_char(p_contractid));
    WHEN OTHERS THEN
      -- помилка оформлення дод.угоди типу № %s до соц.договору № %s
      bars_error.raise_nerror(g_modcode, 'TRUSTOPEN_FAILED',
                                         to_char(p_flagid),
                                         to_char(p_contractid),
                                         sqlerrm);
  END;

  p_trustid := l_trustid;

  bars_audit.trace('%s відкрито дод.угоду № %s (%s) до соц.договору № %s',
                   l_title, l_addnum, to_char(l_trustid), to_char(p_contractid));


END p_supplementary_agreement;

--
-- код ближ.родительского подразделения, в котором могут быть открыты счета ОСЗ
--
function get_parentbranch (p_branch in branch.branch%type)
  return branch.branch%type
is
  l_parent branch.branch%type;
begin
  select p.branch
    into l_parent
    from branch p
   where p.branch != p_branch
     and p.branch  = substr(p_branch, 1, length(p.branch))
     and length(p.branch) + 7 = length(p_branch);
  return l_parent;
exception
  when no_data_found or too_many_rows then
    return null;
end get_parentbranch;

--
-- проверка корректности указанного счета перед привязкой его к ОСЗ
--
PROCEDURE prepare_agency_account
 (p_prepare  in      integer,                             -- вывод сообщения/ошибки
  p_branch   in      branch.branch%type,                  -- код подразделения
  p_agntype  in      social_agency_acctypes.agntype%type, -- тип  ОСЗ
  p_acctype  in      social_agency_acctypes.acctype%type, -- тип счета
  p_accnum   in out  accounts.nls%type,                   -- номер счета
  p_accid       out  accounts.acc%type,                   -- внутр.номер счета
  p_errflg      out  number,                              -- флаг ошибки (0/1)
  p_comment     out  varchar2)                            -- текст сообщения
IS
  l_title           varchar2(60)   := 'dptsocial.prepagnacc';
  l_currency        tabval.kv%type := gl.baseval;
  l_bankcode        banks.mfo%type;
  l_branch          branch.branch%type;
  l_accid           accounts.acc%type;
  l_accmask         accounts.nbs%type;
  l_accname         accounts.nms%type;
  l_closdate        accounts.dazs%type;
  l_acctype_allowed number;
  l_accmask_allowed number;
BEGIN
  bars_audit.trace('%s тип ОСЗ = %s, тип рахунку = %s', l_title, to_char(p_agntype), p_acctype);
  bars_audit.trace('%s рахунок = %s, підрозділ = %s',   l_title, p_accnum,           p_branch);

  p_accid    := NULL;
  p_errflg   := 0;
  p_comment  := NULL;
  l_bankcode := bars_context.extract_mfo(p_branch);

  -- пошук рахунку
  BEGIN
    SELECT acc, nms, dazs, nbs, branch
      INTO l_accid, l_accname, l_closdate, l_accmask, l_branch
      FROM accounts
     WHERE nls = p_accnum
       AND kv = l_currency
       AND kf = l_bankcode;
    bars_audit.trace('%s знайдено рахунок № %s (%s) - %s', l_title, p_accnum, to_char(l_accid), l_accname);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_accmask := SUBSTR(p_accnum, 1, 4);
      bars_audit.trace('%s рахунок № %s не знайдено', l_title, p_accnum);
  END;

  -- перевірка № 1: знайдений рахунок належить підрозділу, в якому відкривається ОСЗ
  IF l_branch != p_branch THEN
     bars_audit.trace('%s рахунок відкритий в підрозділі %s', l_title, l_branch);
     -- знайдений рахунок належить батьківському підрозділу
     IF l_branch = get_parentbranch (p_branch) THEN
        bars_audit.trace('%s рахунок відкритий в батьківському підрозділі %s', l_title, l_branch);
     ELSE
       IF p_prepare = 1  THEN
          p_errflg  := 1;
          p_comment := 'Рахунок № '||p_accnum||' відкритий в іншому підрозділі '||l_branch;
          RETURN;
       ELSE
          bars_error.raise_nerror(g_modcode, 'FOREIGN_AGENCY_ACC', p_accnum, l_branch);
       END IF;
     END IF;
  END IF;

  -- перевірка № 2: знайдений рахунок відкритий
  IF l_closdate IS NOT NULL THEN
     bars_audit.trace('%s дата закриття рахунку = %s', l_title, to_char(l_closdate,'dd.mm.yy'));
     IF p_prepare = 1  THEN
        p_errflg  := 1;
        p_comment := 'Рахунок № '||p_accnum||' було закрито '||to_char(l_closdate,'dd.mm.yy');
        RETURN;
     ELSE
        bars_error.raise_nerror(g_modcode, 'AGENCY_ACC_CLOSED', p_accnum, to_char(l_closdate,'dd.mm.yy'));
     END IF;
  END IF;

  -- перевірка № 3: допустимість тріади (бал.рах, тип рах, тип ОСЗ)
  bars_audit.trace('%s бал.рах. = %s', l_title, l_accmask);

  SELECT nvl(sum(decode(acctype, p_acctype, 1, 0)), 0),
         nvl(sum(decode(acctype, p_acctype, decode(accmask, l_accmask, 1, 0), 0)), 0)
    INTO l_acctype_allowed, l_accmask_allowed
    FROM social_agency_acctypes
   WHERE agntype = p_agntype;

  IF (l_acctype_allowed = 0 AND l_accmask IS NOT NULL) THEN
     IF p_prepare = 1 THEN
        p_errflg  := 1;
        p_comment := 'Заборонено використання рахунку вказаного типу для даного типу ОСЗ';
        RETURN;
     ELSE
        bars_error.raise_nerror(g_modcode, 'INVALID_AGENCY_ACC_TYPE', p_acctype, to_char(p_agntype));
     END IF;
  ELSIF (l_acctype_allowed = 1 AND (l_accmask_allowed = 0 OR l_accmask IS NULL)) THEN
     IF p_prepare = 1 THEN
        p_errflg  := 1;
        p_comment := 'Неприпустимий балансовий рахунок '||l_accmask||' для даного типу рахунку';
        RETURN;
     ELSE
        bars_error.raise_nerror(g_modcode, 'INVALID_AGENCY_BAL_ACC', l_accmask, p_acctype);
     END IF;
  ELSE
    bars_audit.trace('%s дозволена тріада (тип ОСЗ, тип рах, бал.рах) = (%s, %s, %s)',
                     l_title, to_char(p_agntype), p_acctype, l_accmask);
  END IF;

  IF (l_accid IS NOT NULL) THEN

     IF p_prepare = 1 THEN
        p_errflg  := 0;
        p_comment := 'Знайдений рахунок '||p_accnum||' - '||l_accname;
        RETURN;
     ELSE
        bars_audit.trace('%s можливе використання рахунку %s (%s)', l_title, p_accnum, to_char(l_accid));
        p_accid := l_accid;
     END IF;

  ELSE

     IF p_accnum IS NOT NULL THEN

        p_accnum := VKRZN (substr(l_bankcode, 1, 5), p_accnum);

        IF p_prepare = 1 THEN
           p_errflg  := 1;
           p_comment := 'Заборона автовідкриття рахунку. Введіть правильний рахунок! '||p_accnum;
           RETURN;
        ELSE
           bars_audit.trace('%s буде відкрито рахунок %s', l_title, p_accnum);
           p_accid := null;
        END IF;
     ELSE
       bars_audit.trace('%s рахунок не заданий і не використовується', l_title);
       p_accid := l_accid;
     END IF;

  END IF;

END prepare_agency_account;

--
--
--
PROCEDURE check_agency_account
 (p_agntype  IN      social_agency_acctypes.agntype%type,
  p_acctype  IN      social_agency_acctypes.acctype%type,
  p_branch   IN      branch.branch%type,
  p_account  IN OUT  accounts.nls%type,
  p_error       OUT  number,
  p_comment     OUT  varchar2)
IS
  l_title     varchar2(60)       := 'dptsocial.checkagnacc';
  l_curbranch branch.branch%type := sys_context('bars_context','user_branch');
  l_accid     accounts.acc%type;
BEGIN

  -- представимось підрозділом p_branch в тому випадку,
  -- коли ми відкриваємо ОСЗ для підлеглих підрозділів
  IF p_branch != l_curbranch THEN
     bars_context.subst_branch(p_branch);
     bars_audit.trace('%s зміна підрозділу з %s на %s', l_title, l_curbranch, p_branch);
  END IF;

  prepare_agency_account(p_prepare  => 1,
                         p_branch   => p_branch,
                         p_agntype  => p_agntype,
                         p_acctype  => p_acctype,
                         p_accnum   => p_account,
                         p_accid    => l_accid,
                         p_errflg   => p_error,
                         p_comment  => p_comment);

  bars_audit.trace('%s флаг помилки = %s : %s', l_title, to_char(p_error), p_comment);

  bars_context.set_context;

END check_agency_account;

--
-- внутрішня процедура відкриття рахунку для органу соц.захисту
--
PROCEDURE get_agency_acc
 (p_agntype  IN  social_agency_acctypes.agntype%type,
  p_acctype  IN  social_agency_acctypes.acctype%type,
  p_branch   IN  branch.branch%type,
  p_accnum   IN  accounts.nls%type,
  p_accid    OUT accounts.acc%type)
IS
  l_title     varchar2(60) := 'dptsocial.getagnacc';
  l_accnum    accounts.nls%type;
  l_accid     accounts.acc%type;
  l_temp      number;
  l_comment   varchar2(4000);
  l_bankcode  banks.mfo%type;
  l_currency  tabval.kv%type;
  l_accuser   staff.id%type;
  l_accgrp    groups_acc.id%type;
  l_custid    customer.rnk%type;
  l_accname   accounts.nms%type;
  l_tagname   branch_tags.tag%type := 'RNK';
BEGIN

  bars_audit.trace('%s тип ОСЗ = %s, тип рахунку = %s', l_title, to_char(p_agntype), p_acctype);
  bars_audit.trace('%s рахунок = %s, підрозділ = %s',   l_title, p_accnum,           p_branch);

  l_accnum := p_accnum;

  prepare_agency_account (p_prepare  => 0,
                          p_branch   => p_branch,
                          p_agntype  => p_agntype,
                          p_acctype  => p_acctype,
                          p_accnum   => l_accnum,
                          p_accid    => l_accid,
                          p_errflg   => l_temp,
                          p_comment  => l_comment);

  IF l_accid IS NOT NULL THEN

     p_accid  := l_accid;
     bars_audit.trace('%s рахунок %s (%s) вже відкрито => вихід', l_title, p_accnum, to_char(p_accid));

  ELSIF l_accnum IS NULL THEN

     p_accid  := l_accid;
     bars_audit.trace('%s рахунок не використовується => вихід', l_title);

  ELSE

    l_bankcode := bars_context.extract_mfo(p_branch);
    l_accuser  := gl.auid;
    l_currency := gl.baseval;
    l_accgrp   := 13;

    -- клієнт, на якого буде відкрито рахунок
    BEGIN
      SELECT to_number(val) INTO l_custid
        FROM branch_parameters
       WHERE branch = p_branch AND tag = l_tagname;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- не знайдений клієнт, на якого відкриваються рахунки органів соц.захисту підрозділу
        bars_error.raise_nerror(g_modcode, 'AGENCY_ACC_OWNER_NOT_FOUND', p_branch);
    END;

    bars_audit.trace('%s РНК = %s', l_title, to_char(l_custid));

    -- назва рахунку
    SELECT substr(account_name||' '||agency_typename, 1, 70)
      INTO l_accname
      FROM v_socialagencyacctypes
     WHERE agency_typeid  = p_agntype
       AND account_typeid = p_acctype
       AND account_maskid = substr(l_accnum, 1, 4);

    bars_audit.trace('%s назва рахунку %s/%s - %s', l_title, l_accnum, to_char(l_currency), l_accname);

    BEGIN
      op_reg(99, 0, 0, l_accgrp, l_temp, l_custid, l_accnum, l_currency, l_accname, 'ODB', l_accuser, l_accid);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        bars_error.raise_nerror(g_modcode, 'DUPL_AGENCY_ACC', l_accnum);
      WHEN OTHERS THEN
        bars_error.raise_nerror(g_modcode, 'OPEN_AGENCY_ACC_ERROR', l_accnum, sqlerrm);
    END;

    p_accid  := l_accid;
    bars_audit.trace('%s відкрито рахунок %s (%s)', l_title, p_accnum, to_char(p_accid));

  END IF;

END get_agency_acc;

--
-- реєстрація / редагування договору з органом соц.захисту
--
procedure open_agency
 (p_agntype       in      social_agency.type_id%type,
  p_branch        in      social_agency.branch%type,
  p_agnname       in      social_agency.name%type,
  p_contractnum   in      social_agency.contract%type,
  p_contractdat   in      social_agency.date_on%type,
  p_agnaddress    in      social_agency.address%type,
  p_agnphone      in      social_agency.phone%type,
  p_agndetails    in      social_agency.details%type,
  p_debitaccnum   in out  accounts.nls%type,
  p_creditaccnum  in out  accounts.nls%type,
  p_cardaccnum    in out  accounts.nls%type,
  p_comissaccnum  in out  accounts.nls%type,
  p_agencyid      in out  social_agency.agency_id%type)
is
  title           varchar2(60)       := 'dptsocial.openagn';
  l_curbranch     branch.branch%type := sys_context('bars_context','user_branch');
  l_typename      social_agency_type.type_name%type;
  l_tarifid       social_agency_type.tarif_id%type;
  l_branchname    branch.name%type;
  l_agencyid      social_agency.agency_id%type;
  l_date_off      social_agency.date_off%type;
  l_debitaccid    accounts.acc%type;
  l_creditaccid   accounts.acc%type;
  l_cardaccid     accounts.acc%type;
  l_comissaccid   accounts.acc%type;
begin

  bars_audit.trace('%s запуск, ОСЗ № %s - %s, тип %s, підрозділ - %s', title,
                   to_char(p_agencyid), p_agnname, to_char(p_agntype), p_branch);
  bars_audit.trace('%s запуск, рахунки (%s, %s, %s, %s)', title,
                   p_debitaccnum, p_creditaccnum, p_cardaccnum, p_comissaccnum);

  -- перевірка корректності заданого типу ОСЗ
  begin
    select type_name, tarif_id
      into l_typename, l_tarifid
      from social_agency_type
     where type_id = p_agntype;
  exception
    when no_data_found then
      -- не коректно заданий тип органу соц.захисту %s
      bars_error.raise_nerror(g_modcode, 'AGENCY_TYPE_NOT_FOUND', to_char(p_agntype));
  end;
  
  bars_audit.trace('%s тип ОСЗ = %s, тариф № %s', title, l_typename, to_char(l_tarifid));

  -- перевірка корректності заданого коду підрозділу
  begin
    select name 
      into l_branchname 
      from branch 
     where branch = p_branch;
  exception
    when no_data_found then
      -- не коректно заданий код підрозділу %s
      bars_error.raise_nerror(g_modcode, 'BRANCH_NOT_FOUND', p_branch);
  end;
  
  if ( p_branch != l_curbranch )
  then
    bars_context.subst_branch(p_branch);
    bars_audit.trace('%s зміна підрозділу з %s на %s', title, l_curbranch, p_branch);
  end if;
  
  -- пошук / відкриття рахунків
  bars_audit.trace('%s пошук / відкриття рахунків для ОСЗ...', title);
  begin
    get_agency_acc (p_agntype  =>  p_agntype,
                    p_acctype  =>  'D',
                    p_branch   =>  p_branch,
                    p_accnum   =>  p_debitaccnum,
                    p_accid    =>  l_debitaccid);
  exception
    when bars_error.err then
      bars_error.raise_nerror(g_modcode, 'SOC_AGENCY_DEBIT_ACC_ERROR', p_debitaccnum, sqlerrm);
  end;
  
  bars_audit.trace('%s рах.дт.заборг.= %s (%s)', title, p_debitaccnum, to_char(l_debitaccid));

  begin
    get_agency_acc (p_agntype  =>  p_agntype,
                    p_acctype  =>  'K',
                    p_branch   =>  p_branch,
                    p_accnum   =>  p_creditaccnum,
                    p_accid    =>  l_creditaccid);
  exception
    when bars_error.err then
      bars_error.raise_nerror(g_modcode, 'SOC_AGENCY_CREDIT_ACC_ERROR', p_creditaccnum, sqlerrm);
  end;
  
  bars_audit.trace('%s рах.кт.заборг.(поточн) = %s (%s)', title, p_creditaccnum, to_char(l_creditaccid));

  begin
    get_agency_acc (p_agntype  =>  p_agntype,
                    p_acctype  =>  'C',
                    p_branch   =>  p_branch,
                    p_accnum   =>  p_cardaccnum,
                    p_accid    =>  l_cardaccid);
  exception
    when bars_error.err then
      bars_error.raise_nerror(g_modcode, 'SOC_AGENCY_CARD_ACC_ERROR', p_cardaccnum, sqlerrm);
  end;
  
  bars_audit.trace('%s рах.кт.заборг.(картк) = %s (%s)', title, p_cardaccnum, to_char(l_cardaccid));

  begin
    get_agency_acc (p_agntype  =>  p_agntype,
                    p_acctype  =>  'M',
                    p_branch   =>  p_branch,
                    p_accnum   =>  p_comissaccnum,
                    p_accid    =>  l_comissaccid);
  exception
    when bars_error.err then
      bars_error.raise_nerror(g_modcode, 'SOC_AGENCY_COMISS_ACC_ERROR', p_comissaccnum, sqlerrm);
  end;
  
  bars_audit.trace('%s рах.коміс.доходів = %s (%s)', title, p_comissaccnum, to_char(l_comissaccid));

  if p_agencyid is null 
  then -- відкриття договору з ОСЗ
    
    begin
      
      select AGENCY_ID
        into l_agencyid
        from SOCIAL_AGENCY
       where TYPE_ID = p_agntype
         and BRANCH  = p_branch
         and DATE_OFF Is Null;
      
      bars_error.raise_nerror( g_modcode, 'AGENCY_ALREADY_EXISTS', to_char(p_agntype), p_branch, to_char(l_agencyid) );
      
    exception
      when NO_DATA_FOUND then
        
        insert
          into SOCIAL_AGENCY
             ( AGENCY_ID, TYPE_ID, NAME, BRANCH
             , DEBIT_ACC, CREDIT_ACC, CARD_ACC, COMISS_ACC
             , CONTRACT, DATE_ON, ADDRESS, PHONE, DETAILS )
        values
             ( bars_sqnc.get_nextval('s_social_agency'), p_agntype, p_agnname, p_branch
             , l_debitaccid, l_creditaccid, l_cardaccid, l_comissaccid
             , p_contractnum, NVL(p_contractdat, gl.bdate)
             , p_agnaddress, p_agnphone, p_agndetails )
        return AGENCY_ID
          into p_agencyid;
    
        bars_audit.trace('%s відкритий договір з ОСЗ № %s', title, to_char(p_agencyid));
        
    end;
    
  else -- зміна реквізитів договору з ОСЗ

    begin
      
      select DATE_OFF 
        into l_date_off
        from SOCIAL_AGENCY
       where AGENCY_ID = p_agencyid;
      
      if ( l_date_off Is Not Null )
      then
        bars_error.raise_nerror( g_modcode, 'AGENCY_ALREADY_CLOSED', to_char(p_agencyid) );
      end if;
      
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror( g_modcode, 'AGENCY_NOT_FOUND', to_char(p_agencyid));
    end;

     update social_agency
        set debit_acc  = l_debitaccid,
            credit_acc = l_creditaccid,
            card_acc   = l_cardaccid,
            comiss_acc = l_comissaccid,
            type_id    = p_agntype,
            branch     = p_branch,
            date_on    = p_contractdat,
            contract   = substr(p_contractnum, 1, 30),
            name       = substr(p_agnname,     1, 100),
            address    = substr(p_agnaddress,  1, 100),
            phone      = substr(p_agnphone,    1, 20),
            details    = substr(p_agndetails,  1, 100)
      where agency_id  = p_agencyid
        and ( nvl(debit_acc,  0)        != nvl(l_debitaccid,     0)
           or nvl(credit_acc, 0)        != nvl(l_creditaccid,    0)
           or nvl(card_acc,   0)        != nvl(l_cardaccid,      0)
           or nvl(comiss_acc, 0)        != nvl(l_comissaccid,    0)
           or nvl(type_id,    0)        != nvl(p_agntype,        0)
           or nvl(branch,     '_')      != nvl(p_branch,         '_')
           or nvl(contract,   '_')      != nvl(p_contractnum,    '_')
           or nvl(name,       '_')      != nvl(p_agnname,        '_')
           or nvl(address,    '_')      != nvl(p_agnaddress,     '_')
           or nvl(phone,      '_')      != nvl(p_agnphone,       '_')
           or nvl(details,    '_')      != nvl(p_agndetails,     '_')
           or nvl(date_on,    gl.bdate) != nvl(p_contractdat,    gl.bdate)
            );

     if sql%rowcount > 0 
     then
       bars_audit.trace('%s змінені параметри договору з ОСЗ № %s', title, to_char(p_agencyid));
     end if;

  end if;

  bars_context.set_context;
  
  bars_audit.trace('%s вихід з ОСЗ № %s', title, to_char(p_agencyid));

end open_agency;
--
--
--
PROCEDURE close_agency
( p_agencyid   IN  social_agency.agency_id%type,
  p_closedate  IN  social_agency.date_off%type DEFAULT trunc(sysdate)
) IS
  title        varchar2(60)  := 'dptsocial.closagn';
  l_agencyrec  social_agency%rowtype;
BEGIN

  bars_audit.trace('%s ОСЗ № %s закривається %s', title,
                   to_char(p_agencyid), to_char(p_closedate,'dd.mm.yyyy'));

  begin
    select * 
      into l_agencyrec 
      from social_agency 
     where agency_id = p_agencyid;
  exception
    when NO_DATA_FOUND then
      -- не знайдений ОСЗ
      bars_error.raise_nerror( g_modcode, 'AGENCY_NOT_FOUND', to_char(p_agencyid) );
  end;

  IF l_agencyrec.date_off IS NOT NULL 
  THEN
    bars_error.raise_nerror( g_modcode, 'AGENCY_ALREADY_CLOSED', to_char(p_agencyid), l_agencyrec.name );
  END IF;

  IF (p_closedate < l_agencyrec.date_on) 
  THEN
    bars_error.raise_nerror( g_modcode, 'AGENCY_INVALIDCLOSDATE' );
  END IF;

  bars_context.subst_branch(l_agencyrec.branch);

  UPDATE social_agency SET date_off = p_closedate WHERE agency_id = p_agencyid;

  bars_audit.info('Закрито орган соц.захисту '||l_agencyrec.name
                ||' (№ '||to_char(p_agencyid)||')'
                ||' підрозділу '||l_agencyrec.branch);

  bars_context.set_context;

END close_agency;

--
-- створення заголовку файла
--
procedure create_file_header
( p_filename       in  dpt_file_header.filename%type,
  p_header_length  in  dpt_file_header.header_length%type,
  p_dat            in  dpt_file_header.dat%type,
  p_info_length    in  dpt_file_header.info_length%type,
  p_mfo_a          in  dpt_file_header.mfo_a%type,
  p_nls_a          in  dpt_file_header.nls_a%type,
  p_mfo_b          in  dpt_file_header.mfo_b%type,
  p_nls_b          in  dpt_file_header.nls_b%type,
  p_dk             in  dpt_file_header.dk%type,
  p_sum            in  dpt_file_header.sum%type,
  p_type           in  dpt_file_header.type%type,
  p_num            in  dpt_file_header.num%type,
  p_has_add        in  dpt_file_header.has_add%type,
  p_name_a         in  dpt_file_header.name_a%type,
  p_name_b         in  dpt_file_header.name_b%type,
  p_nazn           in  dpt_file_header.nazn%type,
  p_branch_code    in  dpt_file_header.branch_code%type,
  p_dpt_code       in  dpt_file_header.dpt_code%type,
  p_exec_ord       in  dpt_file_header.exec_ord%type,
  p_ks_ep          in  dpt_file_header.ks_ep%type,
  p_type_id        in  dpt_file_header.type_id%type,
  p_agency_type    in  dpt_file_header.agency_type%type,
  p_header_id      out dpt_file_header.header_id%type,
  p_version        in  dpt_file_header.file_version%type   default '1',
  p_recheck_agency in  dpt_file_header.recheck_agency%type default 1)
is
  title      constant  varchar2(64) := 'dptsocial.crtfilehdr';
  l_agency_type        dpt_file_header.agency_type%type;
  l_hdr_id             dpt_file_header.header_id%type;
begin
  
  bars_audit.trace( '%s: Entry with ( p_filename=%s, p_dat=%s, p_type_id=%s ).', title
                  , p_filename, to_char(p_dat,'dd.mm.yyyy'), to_char(p_type_id) );
  
  if ( p_type_id is null )
  then
    bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Не вказано тип зарахування' );
  else
    if ( p_agency_type is null )
    then
      l_agency_type := p_type_id;
    else
      l_agency_type := p_agency_type;
    end if;
  end if;

--begin
--
--  select HEADER_ID
--    into l_hdr_id
--    from DPT_FILE_HEADER
--   where DAT      = p_dat
--     and TYPE_ID  = p_type_id
--     and FILENAME = p_filename;
--
--  begin
--    FILE_DELETE( l_hdr_id );
--  exception
--    when OTHERS then
--
--      if ( sqlerrm like '%SOC-00084%' ) -- Заборонено видалення оплачених файлів зарахувань
--      then -- Заборонена зміна оплачених файлів
--        bars_error.raise_nerror( g_modcode, 'BF_IS_PAID', to_char(l_hdr_id), sys_context('bars_context','user_branch') );
--      else
--        bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', sqlerrm );
--      end if;
--
--  end;
--
--exception
--  when NO_DATA_FOUND then
--    null;
--  when TOO_MANY_ROWS then
--    bars_error.raise_nerror( g_modcode, 'GENERAL_ERROR_CODE', 'Файл '||p_filename||' вже був прийнятий датою '||to_char(p_dat,'dd.mm.yyyy') );
--end;

  l_hdr_id := bars_sqnc.get_nextval('S_FILE_HEADER');

  insert
    into DPT_FILE_HEADER
       ( HEADER_ID, FILENAME, HEADER_LENGTH, DAT,INFO_LENGTH,
         MFO_A, NLS_A, MFO_B, NLS_B, DK, SUM, TYPE, NUM, HAS_ADD,
         NAME_A, NAME_B, NAZN, BRANCH_CODE, DPT_CODE, EXEC_ORD, KS_EP,
         TYPE_ID, AGENCY_TYPE, FILE_VERSION, RECHECK_AGENCY, USR_ID )
  values
       ( l_hdr_id, p_filename, p_header_length, p_dat, p_info_length,
         p_mfo_a, p_nls_a, p_mfo_b, p_nls_b, p_dk, p_sum, p_type, p_num, p_has_add,
         p_name_a, p_name_b, p_nazn, p_branch_code, p_dpt_code, p_exec_ord, p_ks_ep,
         p_type_id, l_agency_type, p_version, p_recheck_agency, USER_ID() );
  
  insert
    into DPT_FILE_ROW_ACCUM
       ( HEADER_ID, FILENAME, DAT, INFO_LENGTH, SUM )
  values
       ( l_hdr_id, p_filename, p_dat, 0, 0 );

  p_header_id := l_hdr_id;

end create_file_header;

--
-- створення стрічок файла старого формату
--
procedure create_file_row_group
 (p_header_id    in   header_id_t,
  p_filename     in   filename_t,
  p_dat          in   dat_t,
  p_nls          in   nls_t,
  p_branch_code  in   branch_code_t,
  p_dpt_code     in   dpt_code_t,
  p_sum          in   sum_t,
  p_fio          in   fio_t,
  p_pasp         in   pasp_t,
  p_info_id      out  info_id_t)
is
begin

  for i in 1..p_header_id.count
  loop
      create_file_row (p_header_id(i),
                       p_filename(i),
                       p_dat(i),
                       p_nls(i),
                       p_branch_code(i),
                       p_dpt_code(i),
                       p_sum(i),
                       p_fio(i),
                       p_pasp(i),
                       p_info_id(i));
  end loop;

end create_file_row_group;

--
-- створення стрічок файла нового формату
--
procedure create_file_row_ext_group
 (p_header_id    in  header_id_t,
  p_filename     in  filename_t,
  p_dat          in  dat_t,
  p_nls          in  nls_t,
  p_branch_code  in  branch_code_t,
  p_dpt_code     in  dpt_code_t,
  p_sum          in  sum_t,
  p_fio          in  fio_t,
  p_id_code      in  id_code_t,
  p_file_payoff  in  file_payoff_t,
  p_payoff_date  in  payoff_date_t,
  p_acc_type   in  acc_type_t,
  p_info_id      out info_id_t)
is
begin

  for i in 1..p_header_id.count
  loop
      create_file_row_ext (p_header_id(i),
                           p_filename(i),
                           p_dat(i),
                           p_nls(i),
                           p_branch_code(i),
                           p_dpt_code(i),
                           p_sum(i),
                           p_fio(i),
                           p_id_code(i),
                           p_file_payoff(i),
                           p_payoff_date(i),
                           p_acc_type(i),
                           p_info_id(i));
  end loop;

end create_file_row_ext_group;

--
-- внутренняя процедура проверки доступа к заданному подразделению
--
procedure check_branch_access
( p_branch     in  branch.branch%type, -- заданное подразделение
  p_ourbranch  in  branch.branch%type, -- текущее подразделение
  p_accessflg  out number             -- 1 = доступ разрешен, 0 = не разрешен
) is
  title varchar2(60):= 'dptsocial.checkbr4access';
begin

  bars_audit.trace( '%s entry, branch=>%s, ourbranch=>%s', title, p_branch, p_ourbranch );

  if p_branch = p_ourbranch
  then
    p_accessflg := 1;
  else
    select (case when count(*) = 0 then 0 else 1 end)
      into p_accessflg
      from dpt_file_subst
     where parent_branch = p_ourbranch and p_branch like child_branch || '%';
  end if;
  
  bars_audit.trace( '%s exit with %s', title, to_char(p_accessflg) );

end check_branch_access;

--
-- створення стрічки файла
--
procedure CREATE_FILEROW_UNI
( p_header_id    in   dpt_file_row.header_id%type,
  p_filename     in   dpt_file_row.filename%type,
  p_dat          in   dpt_file_row.dat%type,
  p_nls          in   dpt_file_row.nls%type,
  p_branch_code  in   dpt_file_row.branch_code%type,
  p_dpt_code     in   dpt_file_row.dpt_code%type,
  p_sum          in   dpt_file_row.sum%type,
  p_fio          in   dpt_file_row.fio%type,
  p_pasp         in   dpt_file_row.pasp%type,
  p_id_code      in   dpt_file_row.id_code%type,
  p_file_payoff  in   dpt_file_row.file_payoff_date%type,
  p_payoff_date  in   dpt_file_row.payoff_date%type,
  p_acc_type     in   dpt_file_row.acc_type%type,
  p_marked       in   number,
  p_info_id      out  dpt_file_row.info_id%type)
is
  title         varchar2(30)       := 'dpt_social.create_filerow_uni';
  l_curkf       accounts.kf%type   := sys_context('bars_context','user_mfo');
  l_kv          tabval.kv%type     := gl.baseval;
  l_curbranch   branch.branch%type := sys_context('bars_context','user_branch');
  l_branch      branch.branch%type;
  l_incorrect   dpt_file_row.incorrect%type;
  l_closed      dpt_file_row.closed%type;
  l_excluded    dpt_file_row.excluded%type;
  l_fio         dpt_file_row.fio%type;
  l_nls         dpt_file_row.nls%type;
  l_res         number(1);

  --
  -- OBU
  --
  l_newaccount     constant varchar2(20)                      := 'НОВИЙ';
  l_newaccount2    constant varchar2(6)                       := '^[0]+$';
  l_penssionnum    constant social_contracts.pension_num%type := ' - ';
  l_comment        constant social_contracts.details%type     := 'Відкритий при імпорті файла зарахування № ';
  l_dealcreated    dpt_file_row.deal_created%type             := 0;

  l_acc            accounts.acc%type;
  l_tip            accounts.tip%type; -- COBUMMFO-7501
  l_rnk            customer.rnk%type;
  l_agencyid       social_agency.agency_id%type;
  l_soctypeid      social_dpt_types.type_id%type;
  l_contractid     social_contracts.contract_id%type;

  l_nmk            varchar2(256);
  l_okpo           varchar2(14);
  l_marked         number;
  l_id_code        dpt_file_row.id_code%type;
  l_err_msg        dpt_file_row.err_msg%type;
begin

  bars_audit.trace('%s entry, header=>%s,filename=>%s,nls=>%s,fio=>%s, marked=>%s',
                   title, to_char(p_header_id), p_filename, p_nls, p_fio, to_char(p_marked));

  -- перекодировка кракозябр
  l_fio := REGEXP_REPLACE(translate(p_fio, 'Ўў', 'Іі'), '['||CHR(01)||'-'||CHR(29)||']','ї');
  bars_audit.trace('%s перекодировка ФИО клиента %s --> %s', title, p_fio, l_fio);

  l_branch    := null;
  l_incorrect := null;
  l_closed    := null;
  l_nls       := p_nls;
  l_marked    := p_marked;
  l_excluded  := 0;
  l_id_code   := trim(p_id_code);

  if (p_nls = l_newaccount /*or regexp_like(p_nls,l_newaccount2)*/) 
  then
    -- I. открытие клиента и счета
    l_branch       := l_curbranch;
    l_incorrect    := 0;
    l_closed       := 0;
    l_dealcreated  := 1;

  else
    -- II. поиск счета и определение его статуса
    begin
      select 0, decode(dazs, null, 0, 1), branch, rnk, acc, tip
        into l_incorrect, l_closed, l_branch, l_rnk, l_acc, l_tip
        from accounts
       where (nls = p_nls or nlsalt = p_nls) --COBUMMFO-7501
         and kv  = l_kv
         and kf  = l_curkf;

      if ((l_closed = 1) AND l_tip like 'W4%'/* COBUMMFO-7501 (SubStr(p_nls,1,4)='2625')*/)
      then
        begin
          select a.nls, a.branch, a.rnk, 0, 0
            into l_nls, l_branch, l_rnk, l_incorrect, l_closed
            from accounts a,
                 bpk_acc  b
           where b.acc_pk = l_acc
             and b.acc_w4 = a.acc
             and a.dazs is null;
          bars_audit.trace('%s закритий рахунок %s замінено на  %s', title, p_nls, l_nls);
        exception
          when NO_DATA_FOUND then
            -- якщо новий рах. для w4 не вказано або він закритий залишаєм без змін
            null;
        end;
      end if;
      bars_audit.trace('%s счет %s найден в балансе %s', title, p_nls, l_branch);
    exception
      when no_data_found then
        begin
          select 0, 0, branch, rnk
            into l_incorrect, l_closed, l_branch, l_rnk
            from social_contracts
           where card_account = p_nls
             and closed_date is null
           group by branch, rnk;
          bars_audit.trace('%s счет %s карт.для соц.деп. в %s', title, p_nls, l_branch);
        exception
          when no_data_found or too_many_rows then
            begin
              select 0, decode(a.dazs, null, 0, 1), a.branch, a.rnk
                into l_incorrect, l_closed, l_branch, l_rnk
                from accounts a
               where a.nlsalt = p_nls
                 and (a.tip = p_acc_type or p_acc_type is null)
                 and a.kv = l_kv
                 and a.kf = l_curkf
              and a.nbs in ('2620','2625','8620')
              and a.branch in ( select CHILD_BRANCH
                                  from DPT_FILE_SUBST 
                                 where PARENT_BRANCH = sys_context('bars_context','user_branch') );
              bars_audit.trace('%s альт.счет %s найден в балансе %s', title, p_nls, l_branch);
            exception
              when no_data_found or too_many_rows then
                begin
                  select 0, decode(a.dazs, null, 0, 1), a.branch, a.rnk
                    into l_incorrect, l_closed, l_branch, l_rnk
                    from ACCOUNTS a
                    join CUSTOMER c
                      on ( c.RNK = a.RNK )
                   where a.KF     = l_curkf
                     and a.NLSALT = p_nls
                     and a.KV     = l_kv
                     and (a.tip = p_acc_type or p_acc_type is null)
                     and l_id_code not like '0000%'
                     and c.okpo = l_id_code
                     and a.nbs in ('2620','2625','8620')
                     and a.branch like sys_context('bars_context','user_branch_mask');
                  bars_audit.trace( '%s альт.счет %s найден в балансе %s', title, p_nls, l_branch );
                exception
                  when no_data_found or too_many_rows then
--                  begin
--                    select 0, decode (a.dazs, null, 0, 1), a.branch, a.rnk
--                      into l_incorrect, l_closed, l_branch, l_rnk
--                      from obpc_acct pc
--                         , tabval t
--                         , accounts a
--                     where a.kf         = pc.kf
--                       and a.kv         = t.kv
--                       and t.lcv        = pc.currency
--                       and a.nls        = pc.lacct
--                       and pc.card_acct = p_nls
--                       and a.kf         = l_curkf
--                       and a.kv         = l_kv;
--                    bars_audit.trace('%s счет %s найден в obpc_acct в балансе %s', title, p_nls, l_branch);
--                  exception
--                    when no_data_found or too_many_rows then
                        l_incorrect := 1;
                        l_err_msg   := 'Не занайдено рахунок '||p_nls;
                        l_closed    := 0;
                        l_branch    := l_curbranch;
--                  end;
                end;
            end;
        end;
    end;

  end if;

--if (l_incorrect + l_closed = 0) 
--then

--  -- для карт.счета BRANCH := текущий, т.к. карт.счета открыты на балансе ГБ
--  if is_valid_social_card (l_nls, l_branch) = 1 
--  then
--    l_branch := l_curbranch;
--  end if;

--  -- проверка доступа к подразделению l_branch
--  check_branch_access (l_branch, l_curbranch, l_res);

--  if l_res = 1 
--  then
--    bars_audit.trace('%s подразделение %s доступно', title, l_branch);
--    l_incorrect := 0;
--  else
--    bars_audit.trace('%s подразделение %s не доступно', title, l_branch);
--    l_incorrect := 1;
--  end if;

--end if;

  bars_audit.trace('%s счет %s в %s, флаг ошибки-%s, флаг закрытия-%s', title,
                   p_nls, l_branch, to_char(l_incorrect), to_char(l_closed));
  
  begin
    
    select nmk, okpo
      into l_nmk, l_okpo
      from customer
     where rnk = l_rnk;

    if l_okpo    = '99999'
    or l_okpo    like '0%'
    or l_id_code = '99999'
    or l_id_code like '0%'
    then
      l_marked := 1;
    elsif l_okpo != l_id_code
    then
      l_marked    := 0;
      l_incorrect := 1;
      l_err_msg   := 'ІПН клієнта в АБС '||l_okpo||' не відповідає ІПН у файлі '||l_id_code;
    end if;

  exception
    when no_data_found then
      null;
  end;

  insert 
    into DPT_FILE_ROW
       ( INFO_ID, HEADER_ID, FILENAME, DAT, NLS,
         BRANCH_CODE, DPT_CODE, SUM, FIO, PASP,
         ID_CODE, FILE_PAYOFF_DATE, PAYOFF_DATE, MARKED4PAYMENT,
         REF, INCORRECT, CLOSED, EXCLUDED, BRANCH, DEAL_CREATED, ACC_TYPE, ERR_MSG )
  values
       ( bars_sqnc.get_nextval('s_file_info'), p_header_id, p_filename, p_dat, l_nls,
         p_branch_code, p_dpt_code, p_sum, l_fio, p_pasp,
         l_id_code, p_file_payoff, p_payoff_date, l_marked,
         null, l_incorrect, l_closed, l_excluded, l_branch, l_dealcreated, p_acc_type, l_err_msg )
  returning info_id
       into p_info_id;

end create_filerow_uni;

--
-- створення стрічки файла
--
procedure CREATE_FILE_ROW
 (p_header_id    in   dpt_file_row.header_id%type,
  p_filename     in   dpt_file_row.filename%type,
  p_dat          in   dpt_file_row.dat%type,
  p_nls          in   dpt_file_row.nls%type,
  p_branch_code  in   dpt_file_row.branch_code%type,
  p_dpt_code     in   dpt_file_row.dpt_code%type,
  p_sum          in   dpt_file_row.sum%type,
  p_fio          in   dpt_file_row.fio%type,
  p_pasp         in   dpt_file_row.pasp%type,
  p_info_id      out  dpt_file_row.info_id%type)
is
  title  varchar2(60) := 'dptsocial.createfilerow';
begin

  bars_audit.trace('%s entry, header=>%s,filename=>%s,nls=>%s,fio=>%s', title,
                   to_char(p_header_id), p_filename, p_nls, p_fio);

  CREATE_FILEROW_UNI( p_header_id    =>  p_header_id,
                      p_filename     =>  p_filename,
                      p_dat          =>  p_dat,
                      p_nls          =>  p_nls,
                      p_branch_code  =>  p_branch_code,
                      p_dpt_code     =>  p_dpt_code,
                      p_sum          =>  p_sum,
                      p_fio          =>  p_fio,
                      p_pasp         =>  p_pasp,
                      p_id_code      =>  null,
                      p_file_payoff  =>  null,
                      p_payoff_date  =>  null,
                      p_marked       =>  null,
                      p_acc_type     =>  null,
                      p_info_id      =>  p_info_id );

  bars_audit.trace('%s exit with %s', title, to_char(p_info_id));
  
end CREATE_FILE_ROW;

--
-- створення стрічки файла нового формату
--
procedure create_file_row_ext
 (p_header_id    in     dpt_file_row.header_id%type,
  p_filename     in     dpt_file_row.filename%type,
  p_dat          in     dpt_file_row.dat%type,
  p_nls          in     dpt_file_row.nls%type,
  p_branch_code  in     dpt_file_row.branch_code%type,
  p_dpt_code     in     dpt_file_row.dpt_code%type,
  p_sum          in     dpt_file_row.sum%type,
  p_fio          in     dpt_file_row.fio%type,
  p_id_code      in     dpt_file_row.id_code%type,
  p_file_payoff  in     dpt_file_row.file_payoff_date%type,
  p_payoff_date  in     dpt_file_row.payoff_date%type,
  p_acc_type     in     dpt_file_row.acc_type%type,
  p_info_id         out dpt_file_row.info_id%type)
is
  title  varchar2(60) := 'dptsocial.createfilerowExt';
begin

  bars_audit.trace('%s entry, header=>%s,filename=>%s,nls=>%s,fio=>%s', title,
                   to_char(p_header_id), p_filename, p_nls, p_fio);

  create_filerow_uni (p_header_id    =>  p_header_id,
                      p_filename     =>  p_filename,
                      p_dat          =>  p_dat,
                      p_nls          =>  p_nls,
                      p_branch_code  =>  p_branch_code,
                      p_dpt_code     =>  p_dpt_code,
                      p_sum          =>  p_sum,
                      p_fio          =>  p_fio,
                      p_pasp         =>  null,
                      p_id_code      =>  p_id_code,
                      p_file_payoff  =>  p_file_payoff,
                      p_payoff_date  =>  p_payoff_date,
                      p_marked       =>  1,
                      p_acc_type     =>  p_acc_type,
                      p_info_id      =>  p_info_id);

  bars_audit.trace('%s exit with %s', title, to_char(p_info_id));

end create_file_row_ext;

--
-- проставлення agency_id для нового! прийнятого файла
--
procedure SET_AGENCYID
( p_header_id in dpt_file_row.header_id%type
) is
  title          varchar2(60) := 'dptsocial.setagnid';
  l_agency_id    social_agency.agency_id%type;
  l_branch       social_agency.branch%type;
begin
  
  bars_audit.trace( '%s Entry with ( p_header_id=%s ).', title, to_char(p_header_id) );
  
  begin
    select a.AGENCY_ID, a.BRANCH
      into l_agency_id, l_branch
      from SOCIAL_AGENCY   a
      join DPT_FILE_HEADER h
        on ( h.BRANCH = a.BRANCH and h.AGENCY_TYPE = a.TYPE_ID )
     where h.HEADER_ID = p_header_id
       and a.DATE_OFF Is Null
       and ROWNUM = 1;
  exception
    when NO_DATA_FOUND then
      begin
        
        select h.BRANCH
          into l_branch
          from DPT_FILE_HEADER h
         where h.HEADER_ID = p_header_id;
        
        bars_error.raise_nerror( g_modcode, 'AG_TYPE_NOT_FOUND', l_branch, p_header_id );
        
      exception
        when NO_DATA_FOUND then
          bars_error.raise_nerror( g_modcode, 'FILE_NOT_FOUND', to_char(p_header_id) );
      end;
  end;
  
  bars_audit.trace( '%s найден ОСЗ № %s для %s', title, to_char(l_agency_id), l_branch );
  
  update DPT_FILE_AGENCY
     set AGENCY_ID = l_agency_id
   where HEADER_ID = p_header_id;
  
  if ( sql%rowcount = 0 )
  then
    insert
      into DPT_FILE_AGENCY
         ( HEADER_ID, BRANCH, AGENCY_ID )
    values
         ( p_header_id, l_branch, l_agency_id );
  end if;
  
  update DPT_FILE_ROW
     set AGENCY_ID = l_agency_id
   where HEADER_ID = p_header_id;
  
  bars_audit.trace('%s Exit.', title );
  
end SET_AGENCYID;

  -- Перевірка рахунка
  function CHECK_ACCOUNT
  ( p_nls       in     accounts.nls%type,
    p_branch    in     accounts.branch%type,
    p_id_code   in     customer.okpo%type,
    p_nmk       in     customer.nmk%type,
    p_acc_type  in     dpt_file_row.acc_type%type
  ) return varchar2
  is
    title   constant   varchar2(64)   := 'dpt_social.check_account';
    l_ccy_id           tabval.kv%type := gl.baseval;
    l_err_msg          varchar2(1024) := null;
    l_csl_dt           date;
  begin
    
    bars_audit.trace('%s: entry, nls=>%s, branch=>%s, id_code=>%s.', title, p_nls, p_branch, p_id_code );
    
    begin
      
      select DAZS
        into l_csl_dt
        from ACCOUNTS -- SALDO
       where KF  = BARS_CONTEXT.EXTRACT_MFO(p_branch)
         and NLS = p_nls
         and KV  = l_ccy_id;
      
      if ( l_csl_dt Is Not Null )
      then
        l_err_msg := 'Рахунок '||p_nls||'/'||to_char(l_ccy_id)||' закритий!';
      end if;
      
    exception
      when NO_DATA_FOUND then
        l_err_msg := 'Рахунок '||p_nls||'/'||to_char(l_ccy_id)||' не знайдено!';
    end;
    
    bars_audit.trace('%s: exit, err_msg=>%s.', title, l_err_msg );
    
    return l_err_msg;
    
  end CHECK_ACCOUNT;
--
-- Перевірка доступу на перегляд до рахунку (повертає 0 / 1)
--
procedure CHECK_ACCOUNT_ACCESS
( p_nls      in   accounts.nls%type,
  p_branch   in   accounts.branch%type,
  p_id_code  in   customer.okpo%type,
  p_nmk      in   customer.nmk%type,
  p_acc_type in   dpt_file_row.acc_type%type,
  p_res      out  number)
is
  l_title      varchar2(60)       := 'dptsocial.checkaccess';
  l_initbranch branch.branch%type := sys_context('bars_context','user_branch');
  l_currency   tabval.kv%type     := gl.baseval;
  l_newaccount     constant varchar2(20)                      := 'НОВИЙ';
  l_newaccount2    constant varchar2(6) := '^[0]+$';
begin

  bars_audit.trace('%s entry, nls=>%s, branch=>%s', l_title, p_nls, p_branch);

  if ( p_nls = l_newaccount /*or regexp_like(p_nls,l_newaccount2)*/)
  then
    p_res := 1;
    return;
  end if;

  select count(*)
    into p_res
    from saldo
   where kf     = bars_context.extract_mfo(p_branch)
     and nls    = p_nls
     and kv     = l_currency
--   and branch = p_branch
  ;

  if ( p_res = 0 )
  then
    select count (*)
      into p_res
      from accounts a
     where a.nlsalt = p_nls
       and (a.tip = p_acc_type or p_acc_type is null)
       and a.kv     = l_currency
       and a.kf     = bars_context.extract_mfo(p_branch)
       and a.branch = p_branch
       and a.nbs in ('2620','2625','8620');
  end if;
  
  if ( p_res = 0 )
  then
     select count (*)
       into p_res
       from accounts a, customer c
      where a.rnk    = c.rnk
        and a.nlsalt = p_nls
        and (a.tip = p_acc_type or p_acc_type is null)
        and p_id_code not like '0000%'
        and c.okpo   = p_id_code
        and a.kv     = l_currency
        and a.kf     = bars_context.extract_mfo (p_branch)
--      and a.branch = p_branch
        and a.nbs in ('2620','2625','8620');
  end if;
  
  if ( p_res = 0 )
  then
     select count (*)
       into p_res
       from obpc_acct pc, tabval t, accounts a
      where a.kf         = pc.kf
        and a.kv         = t.kv
        and t.lcv        = pc.currency
        and a.nls        = pc.lacct
        and pc.card_acct = p_nls
        and a.kf         = bars_context.extract_mfo (p_branch)
        and a.kv         = l_currency
        and a.branch     = p_branch;
  end if;

  bars_audit.trace('%s exit with %s', l_title, to_char(p_res));

end CHECK_ACCOUNT_ACCESS;

--
-- Перевірка закриття рахунку (повертає 0-відкритий / 1-закритий)
--
procedure CHECK_ACCOUNT_CLOSED
( p_nls      in   accounts.nls%type,
  p_branch   in   accounts.branch%type,
  p_id_code  in   customer.okpo%type,
  p_nmk      in   customer.nmk%type,
  p_acc_type in   dpt_file_row.acc_type%type,
  p_res      out  number
) is
  l_title         varchar2(64)          := 'dptsocial.checkclosed';
  l_initbranch    branch.branch%type    := sys_context('bars_context','user_branch');
  l_currency      tabval.kv%type        := gl.baseval;
  l_newaccount    constant varchar2(20) := 'НОВИЙ';
  l_newaccount2   constant varchar2(6)  := '^[0]+$';
begin

  bars_audit.trace('%s entry, nls=>%s, branch=>%s', l_title, p_nls, p_branch);

  if ( p_nls = l_newaccount /*or regexp_like(p_nls,l_newaccount2)*/) 
  then
    p_res := 0;
     return;
  end if;

  select count(*)
    into p_res
    from saldo
   where kf  = bars_context.extract_mfo(p_branch)
     and nls = p_nls
     and kv  = l_currency
     and dazs is not null;

  if ( p_res = 0 )
  then
    select count(*)
      into p_res
      from accounts a
     where a.kf     = bars_context.extract_mfo(p_branch)
       and a.nlsalt = p_nls
       and (a.tip = p_acc_type or p_acc_type is null)
       and a.kv     = l_currency
       and a.branch = p_branch
       and a.dazs is not null
       and a.nbs in ('2620','2625','8620');
  end if;

  if ( p_res = 0 )
  then
    select count (*)
      into p_res
      from accounts a
      join customer c
        on ( c.rnk = a.rnk )
     where a.kf     = bars_context.extract_mfo(p_branch)
       and a.nlsalt = p_nls
       and (a.tip = p_acc_type or p_acc_type is null)
       and p_id_code not like '0000%'
       and c.okpo   = p_id_code
       and a.kv     = l_currency
--     and a.branch = p_branch
       and a.dazs is not null
       and a.nbs in ('2620','2625','8620');
  end if;

  bars_audit.trace('%s exit with %s', l_title, to_char(p_res));

end check_account_closed;

--
-- Копіювання файлу зарахувань
--
procedure file_copy
 (p_header_id      in   dpt_file_header.header_id%type,
  p_header_id_new  out  dpt_file_header.header_id%type)
is
  l_title     varchar2(60) := 'dptsocial.filecopy';
  l_header    dpt_file_header%rowtype;
  l_row       dpt_file_row%rowtype;
  l_rowinfo   dpt_file_row.info_id%type;
  l_agency    dpt_file_agency%rowtype;
begin

  -- dpt_file_header
  select * into l_header from dpt_file_header where header_id = p_header_id;

  if l_header.filename not like '.%' then
     p_header_id_new := null;
     return;
  end if;

  select get_id_ddb(bars_sqnc.get_nextval('s_file_header')) into p_header_id_new from dual;
  l_header.header_id := p_header_id_new;
  insert into dpt_file_header values l_header;

  -- dpt_file_row
  for l_row in (select * from dpt_file_row where header_id = p_header_id)
  loop

      select get_id_ddb(bars_sqnc.get_nextval('s_file_info')) into l_rowinfo from dual;
      l_row.info_id   := l_rowinfo;
      l_row.header_id := p_header_id_new;
      l_row.ref       := null;
      insert into dpt_file_row values l_row;

  end loop;

  -- dpt_file_agency
  for l_agency in (select * from dpt_file_agency where header_id = p_header_id)
  loop

      l_agency.header_id := p_header_id_new;
      insert into dpt_file_agency values l_agency;

  end loop;

end file_copy;

--
-- Перевірка відповідності ОСЗ соц.договору (0 - не відповідає, 1 - відповідає)
--
function ck_social_agency
 (p_dpt_id            in  social_contracts.contract_id%type,
  p_social_agency_id  in  social_agency.agency_id%type)
  return number
is
  l_title   varchar2(60) := 'dptsocial.ckagency';
  l_result  number(1)    := 0;
begin

  bars_audit.trace('%s entry, dptid=>%s, agencyid=>%s', l_title,
                   to_char(p_dpt_id), to_char(p_social_agency_id));

  select count(*)
    into l_result
    from v_socialagencies sa
   where sa.agency_id = p_social_agency_id
     and sa.agency_type = (select s.type_id
                             from social_agency s, v_socialcontracts c
                            where c.contract_id = p_dpt_id
                              and c.agency_id = s.agency_id);

  bars_audit.trace('%s exit with %s', l_title, to_char(l_result));

  return l_result;

end ck_social_agency;

--
-- Видалення файла зарахувань
--
procedure file_delete(p_header_id  in  dpt_file_header.header_id%type)
is
  title  varchar2(60) := 'dptsocial.filedelete';
begin

  bars_audit.trace('%s entry, headerid => %s', title, to_char(p_header_id));

  if ( can_be_deleted(p_header_id) = 0 )
  then
    bars_error.raise_nerror(g_modcode, 'BF_CANT_BE_DELETED', to_char(p_header_id), sqlerrm);
  end if;

  delete from dpt_file_row_upd   where row_id in ( select info_id from dpt_file_row where header_id = p_header_id );
  delete from dpt_file_agency    where header_id = p_header_id;
  delete from dpt_file_row       where header_id = p_header_id;
  delete from dpt_file_row_accum where header_id = p_header_id;
  delete from dpt_file_header    where header_id = p_header_id;

  bars_audit.trace('%s exit, file № %s succ.deleted', title, to_char(p_header_id));

end file_delete;

--
-- Перевірка можливості видалення файлу зарахувань  (1 - можна, 0 - ні)
--
function can_be_deleted( p_header_id  in  dpt_file_header.header_id%type)
  return number
is
  title  varchar2(60) := 'dptsocial.canbedel';
  l_res  number(1);
begin

  bars_audit.trace( '%s entry, headerid => %s', title, to_char(p_header_id) );

  select count(header_id)
    into l_res
    from dpt_file_header h
   where h.header_id = p_header_id
     and h.header_id not in
                           (select r.header_id
                              from dpt_file_row r
                             where r.header_id = h.header_id
                               and r.ref is not null);

  bars_audit.trace('%s exit with %s', title, to_char(l_res));

  return l_res;

end can_be_deleted;


-- ======================================================================================
function f_nazn
  (p_type   char,                             -- U / R = укр / рус
   p_dpt_id social_contracts.contract_id%type)   -- идентификатор вклада
   return varchar2
is
   l_dealnum  social_contracts.contract_num%type;
   l_dealdat  social_contracts.contract_date%type;
   l_nazn     oper.nazn%type;
begin

  begin
    select nvl(contract_num, to_char(contract_id)), contract_date
      into l_dealnum, l_dealdat
      from social_contracts
     where contract_id = p_dpt_id;
  exception
    when no_data_found then
  return null;
  end;

  l_nazn := l_dealnum || case when p_type = 'R' then ' от ' else ' від ' end || f_dat_lit(l_dealdat, p_type);

  return l_nazn;

END f_nazn;

-- ======================================================================================
  -- функція підтягування реального рахунку проплати для соц. файлів
  -- p_return_type:
  -- 0 - nls
  -- 1 - client_name
  -- 2 - client_okpo
FUNCTION f_file_account
( p_accnum        in  accounts.nls%type,
  p_acccur        in  accounts.kv%type,
  p_bankmfo       in  accounts.kf%type,
  p_iscard        in  number,
  p_okpo          in  customer.okpo%type,
  p_nmk           in  customer.nmk%type,
  p_acc_type      in  dpt_file_row.acc_type%type,
  p_return_type   in  number
) return varchar2
is
  l_res           acc_rec;
  l_return_value  varchar2(256);
begin

  l_return_value := null;

  l_res := look4acc( p_accnum   => p_accnum,
                     p_acccur   => p_acccur,
                     p_bankmfo  => p_bankmfo,
                     p_iscard   => p_iscard,
                     p_okpo     => p_okpo,
                     p_nmk      => p_nmk,
                     p_acc_type => null );

  case p_return_type
  when 0 then l_return_value := l_res.num;
  when 1 then l_return_value := substr(l_res.name,1,256);
  when 2 then l_return_value := l_res.code;
  end case;

  return l_return_value;

end f_file_account;

--
-- подготовка к закрытию социального договора
--
procedure prepare2closdeal
 (p_contractid  in  number,   -- идентификатор соц.договора
  p_sum2payoff  out number)   -- сумма догоовра к выплате
is
  title      varchar2(60)     := 'dptsocial.prepare2closdeal';
  l_bdat     date             := gl.bdate;
  l_intid    int_accn.id%type := 1;
  l_deal     social_contracts%rowtype;
  l_depacc   accounts%rowtype;
  l_intacc   accounts%rowtype;
  l_custname customer.nmk%type;
  l_custcode customer.okpo%type;
  l_acrdat   int_accn.acr_dat%type;
  l_stpdat   int_accn.stp_dat%type;
  l_inttt    int_accn.tt%type;
  l_mfob     int_accn.mfob%type;
  l_nlsb     int_accn.nlsb%type;
  l_namb     int_accn.namb%type;
  l_intsum   number;
  l_nazn     oper.nazn%type;
  l_ref      oper.ref%type;
  l_noint    boolean := false;
  l_errflg   boolean;
  l_errmsg   varchar2(3000);
begin

  bars_audit.trace('%s entry, deal № %s', title, to_char(p_contractid));

  -- поиск соц.договора
  begin
    select * into l_deal from social_contracts where contract_id = p_contractid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'CONTRACT_NOT_FOUND', to_char(p_contractid));
  end;

  -- проверка допустимости закрытия договора (уже открыт, но еще не закрыт)
  if l_deal.contract_date > l_bdat then
     -- соц.договор № %s еще не вступил в силу
     bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_NOT_OPENED_YET', l_deal.contract_num);
  end if;
  if l_deal.closed_date is not null then
     -- соц.договор № %s уже закрыт
     bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_ALREADY_CLOSED', l_deal.contract_num);
  end if;

  -- реквизиты клиента
  begin
    select nmk, okpo into l_custname, l_custcode from customer where rnk = l_deal.rnk;
  exception
    when no_data_found then
      -- не найден клиент - владелец соц.договора № %s
      bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_CUST_NOT_FOUND', l_deal.contract_num);
  end;
  bars_audit.trace('%s customer %s', title, l_custname);

  -- реквизиты основного счета
  begin
    select * into l_depacc from accounts where acc = l_deal.acc for update of ostb nowait;
  exception
    when others then
      -- ошибка чтения реквизитов основного счета по соц.договору № %s: %s
      bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_DEPACC_NOT_FOUND', l_deal.contract_num, sqlerrm);
  end;
  bars_audit.trace('%s deposit account %s', title, l_depacc.nls);

  -- проверка отсутствия незавизированных документов по основному счету
  if l_depacc.ostc != l_depacc.ostb or l_depacc.ostf != 0 then
     -- по счету %s/%s найдены незавизированные документы
     bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INVALID_SALDO', l_depacc.nls, to_char(l_depacc.kv));
  end if;
  bars_audit.trace('%s deposit amount = %s', title, to_char(l_depacc.ostc));

  -- поиск процентного счета и получение его реквизитов (если есть)
  begin
    select acra, acr_dat, stp_dat, nvl(tt, '%%1'), mfob, nlsb, namb
      into l_intacc.acc, l_acrdat, l_stpdat, l_inttt, l_mfob, l_nlsb, l_namb
      from int_accn
     where acc = l_deal.acc and id = l_intid and acra is not null;
    bars_audit.trace('%s acrdat = %s, stpdat = %s', title, to_char(l_acrdat), to_char(l_stpdat));
  exception
    when no_data_found then
      l_noint := true;
  end;

  if not l_noint then  -- договор с начислением процентов

     -- реквизиты процентного счета
     begin
       select * into l_intacc from accounts where acc = l_intacc.acc for update of ostb nowait;
     exception
       when others then
         -- ошибка чтения реквизитов процентного счета по соц.договору № %s: %s
         bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INTACC_NOT_FOUND', l_deal.contract_num, sqlerrm);

     end;
     bars_audit.trace('%s interest account %s', title, l_intacc.nls);


     -- проверка отсутствия незавизированных документов по процентному счету
     if l_intacc.ostc != l_intacc.ostb or l_intacc.ostf != 0 then
        -- по счету %s/%s найдены незавизированные документы
        bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INVALID_SALDO', l_intacc.nls, to_char(l_intacc.kv));
     end if;
     bars_audit.trace('%s interest amount = %s', title, to_char(l_intacc.ostc));

     -- начисление процентов по вчерашний день включит.с порождением документа
     insert into int_queue
           (deal_id, deal_num, deal_dat,
            kf, branch, cust_id,
            int_id, acc_id, acc_num, acc_cur, acc_nbs,
            acc_name, acc_iso, acc_open, acc_amount,
            int_details, int_tt, mod_code)
     select l_deal.contract_id, l_deal.contract_num, l_deal.contract_date,
            l_depacc.kf, l_depacc.branch, l_depacc.rnk,
            l_intid, l_depacc.acc, l_depacc.nls, l_depacc.kv, l_depacc.nbs,
            substr(l_depacc.nms, 1, 38), t.lcv, l_depacc.daos, null,
            null, l_inttt, g_modcode
       from tabval t
      where t.kv = l_depacc.kv
        and (  (l_acrdat is null)
            or (l_acrdat < l_bdat - 1 and l_stpdat is null)
            or (l_acrdat < l_bdat - 1 and l_stpdat > l_acrdat) );

     make_int (p_dat2      => (l_bdat - 1),
               p_runmode   => 1,
               p_runid     => 0,
               p_intamount => l_intsum,
               p_errflg    => l_errflg);

     if l_errflg then
        -- ошибка начисления процентов по соц.договору № %s: %s
        bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_MAKEINT_FAILED', l_deal.contract_num, sqlerrm);
     end if;
     bars_audit.trace('%s interest accrued = %s', title, to_char(l_intsum));

     -- уточним и залочим плановый остаток на процентном счете
     begin
       select ostb into l_intacc.ostb from accounts where acc = l_intacc.acc for update of ostb nowait;
     exception
       when others then
         -- ошибка чтения реквизитов процентного счета по соц.договору № %s: %s
         bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INTACC_NOT_FOUND', l_deal.contract_num, sqlerrm);
     end;

     -- если есть остаток и получатель, то выплатим проценты
     if (l_intacc.ostb > 0 and l_mfob is not null and l_nlsb is not null) then

        bars_audit.trace('%s payoff %s to %s/%s', title, to_char(l_intacc.ostb), l_nlsb, l_mfob);

        -- назначение платежа !!! сделать по-людски
        l_nazn := SUBSTR('Капіталізація нарахованих відсотків '||
                         'по договору про обслуговування пенс.рахунку № '||
                         trim(l_deal.contract_num)||
                         ' від '||to_char(l_deal.contract_date,'dd/MM/yyyy'),
                         1, 160);

        -- оплата
        dpt_web.paydoc (p_dptid    => null,
                        p_vdat     => l_bdat,
                        p_brancha  => l_intacc.branch,
                        p_nlsa     => l_intacc.nls,
                        p_mfoa     => l_intacc.kf,
                        p_nama     => substr(l_intacc.nms, 1, 38),
                        p_ida      => l_custcode,
                        p_kva      => l_intacc.kv,
                        p_sa       => l_intacc.ostb,
                        p_branchb  => l_intacc.branch,
                        p_nlsb     => l_nlsb,
                        p_mfob     => l_mfob,
                        p_namb     => substr(l_namb, 1, 38),
                        p_idb      => l_custcode,
                        p_kvb      => l_intacc.kv,
                        p_sb       => l_intacc.ostb,
                        p_nazn     => l_nazn,
                        p_nmk      => substr(l_custname, 1, 38),
                        p_tt       => null,
                        p_vob      => null,
                        p_dk       => 1,
                        p_sk       => null,
                        p_userid   => null,
                        p_type     => 4,
                        p_ref      => l_ref,
                        p_err_flag => l_errflg,
                        p_err_msg  => l_errmsg);
        if l_errflg then
           -- ошибка выплаты процентов по соц.договору № %s: %s
           bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_PAYINT_FAILED', l_deal.contract_num, l_errmsg);
        end if;
        bars_audit.trace('%s ref (%s->%s=%s) = %s', title,
                         l_intacc.nls, l_nlsb, to_char(l_intacc.ostb), to_char(l_ref));
     end if; -- (l_intacc.ostb > 0)

     -- проверка: плановый остаток на процентном счете должен быть нулевым
     begin
       select ostb into l_intacc.ostb from accounts where acc = l_intacc.acc;
     exception
       when others then
         -- ошибка чтения реквизитов процентного счета по соц.договору № %s: %s
         bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INTACC_NOT_FOUND', l_deal.contract_num, sqlerrm);
     end;

     if l_intacc.ostb != 0 then
        -- по счету %s/%s найдены незавизированные документы
        bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_INVALID_SALDO', l_intacc.nls, to_char(l_intacc.kv));
     end if;

  end if; -- (not l_noint)

  -- уточняем и возвращаем плановый остаток на депозитном счете
  begin
    select ostb into l_depacc.ostb from accounts where acc = l_depacc.acc;
  exception
    when others then
      -- ошибка чтения реквизитов основного счета по соц.договору № %s: %s
      bars_error.raise_nerror(g_modcode, 'PREPARE2CLOS_DEPACC_NOT_FOUND', l_deal.contract_num, sqlerrm);
  end;

  p_sum2payoff := l_depacc.ostb;

  bars_audit.trace('%s exit with %s', title, to_char(p_sum2payoff));

end prepare2closdeal;

--
-- внутр.процедура перевірки можливості закриття рахунку
--
procedure iget_accpermit2clos
 (p_accid     in  accounts.acc%type,  -- внутр.№ рахунку
  p_closdate  in  accounts.dazs%type, -- бажана дата закриття рахунку
  p_permitid  out number,             -- 1 - закриття дозволено, 0 - закриття заборонено
  p_permitmsg out varchar2)           -- пояснення щодо заборони
is
  l_acc  accounts%rowtype;
begin

  -- параметри рахунку
  select * into l_acc from accounts where acc = p_accid;

  -- дата останнього руху
  select max(fdat) into l_acc.dapp from saldoa where acc = l_acc.acc;

  if (l_acc.ostc != 0 or l_acc.ostb != 0 or l_acc.ostf != 0) then
      -- 'ненульові залишки на рахунку %s / %s'
      p_permitid  := 0;
      p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_INVALID_ACCREST', l_acc.nls, to_char(l_acc.kv));
  elsif (l_acc.daos > p_closdate) then
      -- 'рахунок %s / %s ще не відкритий'
      p_permitid  := 0;
      p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_INVALID_ACCOPEN', l_acc.nls, to_char(l_acc.kv));
  elsif (l_acc.dapp > p_closdate) then
      -- 'знайдено майбутні обороти по рахунку %s / %s'
      p_permitid  := 0;
      p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_INVALID_ACCTURNS', l_acc.nls, to_char(l_acc.kv));
  else
      p_permitid  := 1;
      p_permitmsg := null;
  end if;

exception
  when no_data_found then
    -- 'не знайдений рахунок (acc=%s)'
    p_permitid  := 0;
    p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_ACC_NOT_FOUND', to_char(p_accid));
end iget_accpermit2clos;

--
-- внутр.процедура перевірки сплати всіх відсотків по договору
--
procedure iget_interestdebt
 (p_accid     in  accounts.acc%type,   -- депозитний рахунок
  p_dat       in  accounts.dazs%type, -- бажана дата закриття рахунку
  p_permitid  out number,             -- 1 - закриття дозволено, 0 - закриття заборонено
  p_permitmsg out varchar2)           -- пояснення щодо заборони
is
  l_amount  number;
  l_errflg  boolean;
begin

  insert into int_queue
         (kf, branch, cust_id, int_id, acc_id, acc_num, acc_cur,
          acc_nbs, acc_name, acc_iso, acc_open,  mod_code)
  select a.kf, a.branch, a.rnk, i.id, a.acc, a.nls, a.kv,
         a.nbs, substr(a.nms, 1, 38), t.lcv, a.daos, 'SOC'
    from accounts a, int_accn i, tabval t
   where a.acc = i.acc
     and i.id  = 1
     and a.kv  = t.kv
     and a.acc = p_accid
     and (   (i.acr_dat is null)
          or (i.acr_dat < p_dat - 1 and i.stp_dat is null)
          or (i.acr_dat < p_dat - 1 and i.stp_dat > i.acr_dat));

  make_int (p_dat2      => p_dat - 1,
            p_runmode   => 0, -- без проводок
            p_runid     => 0,
            p_intamount => l_amount,
            p_errflg    => l_errflg);

  if l_amount > 0 then
     -- недонараховані відсотки
     p_permitid  := 0;
     p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_INTDEBT_FOUND');
  else
     p_permitid  := 1;
     p_permitmsg := null;
  end if;

end iget_interestdebt;

--
-- перевірка можливості закриття соціального договору
--
procedure iget_permit2clos
 (p_contract    in   social_contracts%rowtype, -- дані про договір
  p_permitid    out  number,                   -- 1 - закриття дозволено, 0 - закриття заборонено
  p_permitmsg   out  varchar2)                 -- пояснення щодо заборони
is
  title     constant varchar2(60) :='dptsocial.getpermit2clos:';
  l_dat     date                  := gl.bdate;
  l_intacc  accounts.acc%type;
begin

  bars_audit.trace('%s entry, contract № %s', title, to_char(p_contract.contract_id));

  if (p_contract.contract_date > l_dat) then

      --  договір ще не відкритий
      p_permitid  := 0;
      p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_NOT_OPENED_YET');

  elsif (p_contract.closed_date is not null) then

      -- договір вже закритий
      p_permitid  := 0;
      p_permitmsg := bars_msg.get_msg(g_modcode, 'CLOSDENIED_ALREADY_CLOSED');

  else

      -- перевірка допустимості закриття депозитного рахунку
      iget_accpermit2clos (p_contract.acc, l_dat, p_permitid, p_permitmsg);

      if p_permitid = 1 then
         -- чи передбачає договір нарахування відсотків
         begin
           select acra into l_intacc from int_accn where id = 1 and acc = p_contract.acc;

           -- перерірка "всі відсотки нараховані і сплачені"
           iget_interestdebt (p_contract.acc, l_dat, p_permitid, p_permitmsg);

           if p_permitid = 1 then
              -- перевірка допустимості закриття процентного рахунку
              iget_accpermit2clos (l_intacc, l_dat, p_permitid, p_permitmsg);
           end if;
         exception
           when no_data_found then null;
         end;
      end if;

  end if;

  bars_audit.trace('%s exit with (%s, %s)', title, to_char(p_permitid), p_permitmsg);

end iget_permit2clos;

--
-- закриття соціального договору
--
procedure close_contract
 (p_contractid  in  social_contracts.contract_id%type)
is
  title       constant varchar2(60) := 'dptsocial.closecontract:';
  l_dat       constant date         := gl.bdate;
  l_soc       social_contracts%rowtype;
  l_permitid  number(1);
  l_permitmsg varchar2(3000);
begin

  bars_audit.trace('%s entry, contractid=>%s', title, to_char(p_contractid));

  begin
    select * into l_soc from social_contracts where contract_id = p_contractid;
  exception
    when no_data_found then
      bars_error.raise_nerror(g_modcode, 'CONTRACT_NOT_FOUND', to_char(p_contractid));
  end;

  iget_permit2clos (l_soc, l_permitid, l_permitmsg);
  bars_audit.trace('%s iget_permit2clos => (%s,%s)', title, to_char(l_permitid), l_permitmsg);

  if l_permitid = 0 then
     -- заборонено закриття соц.договору № %s: %s
     bars_error.raise_nerror(g_modcode, 'CLOSE_CONTRACT_DENIED', l_soc.contract_num, l_permitmsg);
  end if;

  -- закриття всіх активних дод.угод про права 3-іх осіб
  update social_trustee
     set fl_act = 0
   where contract_id = p_contractid
     and fl_act = 1;

  -- закриття поточного рахунку
  update accounts
     set dazs = dat_next_u(l_dat, 1)
   where acc  = l_soc.acc
     and dazs is null;

  -- закриття процентного рахунку
  update accounts
     set dazs = dat_next_u(l_dat, 1)
   where acc  = (select acra from int_accn where acc = l_soc.acc and id = 1)
     and dazs is null;

  -- закриття договору
  update social_contracts
     set closed_date = l_dat
   where contract_id = p_contractid;

  -- Закрито договір № %s від %s (реф.%s)
  bars_audit.financial( bars_msg.get_msg(g_modcode, 'CLOSE_CONTRACT_SUCC_DONE',
                                         l_soc.contract_num,
                                         to_char(l_soc.contract_date, 'dd.mm.yyyy'),
                                         to_char(p_contractid)  ) );

exception
  when others then
    bars_error.raise_nerror(g_modcode, 'CLOSE_CONTRACT_FAILED',
                           l_soc.contract_num, to_char(p_contractid), sqlerrm);
end close_contract;


END DPT_SOCIAL;
/
 show err;
 
PROMPT *** Create  grants  DPT_SOCIAL ***
grant EXECUTE                                                                on DPT_SOCIAL      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_SOCIAL      to DPT_ROLE;
grant EXECUTE                                                                on DPT_SOCIAL      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_social.sql =========*** End *** 
 PROMPT ===================================================================================== 
 