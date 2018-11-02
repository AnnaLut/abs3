PROMPT ===================================================================================== 
PROMPT *** Run *** =========== Scripts /Sql/BARS/Package/DPT_UI.sql =============*** Run ***
PROMPT ===================================================================================== 

create or replace package DPT_UI is
  head_ver constant varchar2(64) := 'version 1.01  16.10.2018';
  head_awk constant varchar2(512) := '';
  --
  --  служебные функции
  --
  function header_version return varchar2;
  function body_version return varchar2;
  
  procedure check_MDPL_vidd_deposit(p_vidd in dpt_vidd.vidd%type,
                               p_rnk     in customer.rnk%type);

END DPT_UI;
/

show errors;

CREATE OR REPLACE PACKAGE BODY DPT_UI is
  --
  -- constants
  --
  body_ver constant varchar2(32) := 'version 1.01  16.10.2018';
  body_awk constant varchar2(512) := '';

  modcod constant varchar2(3) := 'DPT';
  nlchr  constant char(2) := chr(13) || chr(10);

  --
  -- variables
  --

  --
  -- types
  --
  type t_dptacclist is table of accounts.acc%type;

  --
  -- определение версии заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package DPT_UTILS header ' || head_ver || '.' || chr(10) || 'AWK definition: ' || chr(10) || head_awk;
  end header_version;

  --
  -- возвращает версию тела пакета DPT
  --
  function body_version return varchar2 is
  begin
    return 'Package DPT_UTILS body ' || body_ver || '.' || chr(10) || 'AWK definition: ' || chr(10) || body_awk;
  end body_version;

  function get_rnk_depbalance_ondate(p_rnk customer.rnk%type, p_date date, p_kv tabval$global.kv%type) return number
  is
    l_title          varchar2(30) := 'get_rnk_depbal_dat: ';
    l_balance        number;
    l_date           date;
  begin
    l_balance := 0;

    if p_date is null then
      l_date := gl.bDATE;
    else
      l_date := p_date;
    end if;

    bars_audit.trace('%s p_rnk = %s / p_date = %s / p_kv = %s / balance = %s', l_title, to_char(p_rnk), to_char(p_date, 'DD.MM.YYYY'), 
                         to_char(p_kv), to_char(l_balance));

    select nvl(sum(fost(a.acc, l_date)),0)
    into l_balance
    from accounts a
    where a.rnk = p_rnk
    and a.kv = p_kv
    and a.nbs = '2630';

    return l_balance;
    
  end get_rnk_depbalance_ondate;
    

  procedure check_MDPL_vidd_deposit(p_vidd in dpt_vidd.vidd%type,
                               p_rnk     in customer.rnk%type) is
    l_title          varchar2(30) := 'check_MDPL: ';
    l_control_date   date;
    l_bdate          date := gl.bDATE;
    l_type_code      dpt_types.type_code%type;
    l_control_balance number;
    l_min_balance     number;
    l_current_balance number;
    l_future_balance  number;
    t_dptacc         t_dptacclist;
    l_vidd_rec       dpt_vidd%rowtype;
    l_vidd_tag_rec   dpt_vidd_tags%rowtype;

  BEGIN

   bars_audit.trace('%s p_vidd = %s / p_rnk = %s ', l_title, to_char(p_vidd), to_char(p_rnk));

   begin
    select *
      into l_vidd_rec
      from dpt_vidd
     where vidd = p_vidd;
   exception when no_data_found then
     bars_error.raise_nerror(modcod, 'VIDD_NOT_FOUND', to_char(p_vidd));
   end;

   if l_vidd_rec.type_cod = 'MDPL' then

   -- контрольная дата - дата начала действия вида
   if l_vidd_rec.datn is null then
       bars_error.raise_nerror(modcod, 'VIDD_DATN_NOT_FOUND', to_char(l_vidd_rec.vidd));
   else
      l_control_date := trunc(l_vidd_rec.datn);
   end if;

    -- определяем минимально-допустимый баланс на деп.счетах клиента для данного вида вклада
    begin
     select to_number(dvp.val)
     into   l_min_balance
     from dpt_vidd_params dvp
     where dvp.vidd = l_vidd_rec.vidd
     and dvp.tag = 'MIN_DEPBALANCE';
    exception
     when no_data_found then
       bars_error.raise_nerror(modcod, 'MIN_DEPBALANCE_FAILED', to_char(l_vidd_rec.vidd));
     when others then
       begin
         select *
         into l_vidd_tag_rec
         from dpt_vidd_tags
         where tag = 'MIN_DEPBALANCE';

         bars_error.raise_nerror(modcod, 'VIDDPARAM_CHECK_FAILED', 'MIN_DEPBALANCE', l_vidd_tag_rec.name, 'MIN_DEPBALANCE');
       exception when others then
         bars_error.raise_nerror(modcod, 'VIDDPARAM_NOT_FOUND', 'MIN_DEPBALANCE');
       end;
     end;

   bars_audit.trace('%s Мин.допустимый баланс на деп.счетах клиента = %s', l_title, to_char(l_min_balance));

   -- определяем баланс по депозитам на контрольную дату

    select nvl(sum(fost(a.acc, l_control_date - 1)),0)
    into l_control_balance
    from accounts a, 
         dpt_deposit_clos ddc,
         dpt_vidd dv 
    where a.rnk = p_rnk
      and a.kv = l_vidd_rec.kv
      and a.nbs = '2630'
      and ddc.acc = a.acc
      and ddc.idupd = (select max(idupd) from dpt_deposit_clos d where d.acc = ddc.acc and d.rnk = ddc.rnk)
      and dv.vidd = ddc.vidd
      and dv.type_cod <> 'MDPL';
      

    bars_audit.trace('%s на дату %s баланс по депозитам - %s', l_title, to_char(l_control_date,'DD.MM.YYYY'), to_char(l_control_balance));

    if l_control_balance <= l_min_balance then
       bars_error.raise_nerror(modcod, 'NOT_ENOUGH_BALANCE', to_char(l_control_date, 'DD.MM.YYYY'), to_char(l_control_balance/100)||' грн.');
    end if;

    -- определяем баланс по действующим депозитам на текущую банковскую дату

    select nvl(sum(fost(a.acc, l_bdate)),0), nvl(sum(a.ostb),0)
    into l_current_balance, l_future_balance
    from accounts a, 
         dpt_deposit_clos ddc,
         dpt_vidd dv 
    where a.rnk = p_rnk
      and a.kv = l_vidd_rec.kv
      and a.nbs = '2630'
      and ddc.acc = a.acc
      and ddc.idupd = (select max(idupd) from dpt_deposit_clos d where d.acc = ddc.acc and d.rnk = ddc.rnk)
      and dv.vidd = ddc.vidd
      and dv.type_cod <> 'MDPL';

    bars_audit.trace('%s на дату %s баланс по действующим депозитам - %s', l_title, to_char(l_bdate,'DD.MM.YYYY'), to_char(l_current_balance));

    if l_current_balance < l_control_balance then
       bars_error.raise_nerror(modcod, 'CURRENT_BALANCE_LESS_CONTROL', to_char(l_current_balance/100)||' грн.', to_char(l_control_date, 'DD.MM.YYYY'), to_char(l_control_balance/100)||' грн.');
    end if;

    if l_current_balance <= l_min_balance then
       bars_error.raise_nerror(modcod, 'NOT_ENOUGH_BALANCE', to_char(l_bdate, 'DD.MM.YYYY'), to_char(l_current_balance/100)||' грн.');
    end if;
    
    if l_current_balance > l_future_balance then
       bars_error.raise_nerror(modcod, 'FUTURE_BALANCE_LESS_CURRENT');
    end if;

    end if;

  end check_MDPL_vidd_deposit;

END DPT_UI;
/


show errors;

grant EXECUTE on DPT_UI to ABS_ADMIN;
grant EXECUTE on DPT_UI to BARSUPL;
grant EXECUTE on DPT_UI to BARS_ACCESS_DEFROLE;
grant EXECUTE on DPT_UI to DPT;
grant EXECUTE on DPT_UI to DPT_ADMIN;
grant EXECUTE on DPT_UI to DPT_ROLE;
grant EXECUTE on DPT_UI to VKLAD;
grant EXECUTE on DPT_UI to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** =========== Scripts /Sql/BARS/Package/DPT_UI.sql =============*** End ***
PROMPT ===================================================================================== 
