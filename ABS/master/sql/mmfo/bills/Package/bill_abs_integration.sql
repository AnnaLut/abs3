
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/bill_abs_integration.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BILLS.BILL_ABS_INTEGRATION is

    g_header_version  constant varchar2(64)  := 'version 1.2 11/10/2018';

  -- Author  : VOLODYMYR.POHODA
  -- Created : 26-Jun-18 10:19:16
  -- Purpose : взаємодія з АБС
  
function get_oper_dt return date;

function get_account (p_product in varchar2
                     ,p_client  in number
                     ,p_cur     in varchar2
                     ,p_mfo     in number)
  return varchar2;

function make_prov (p_id       in opers.id%type
                   ,p_type     in integer
                   ,p_err_text out varchar2)
  return number;

function get_sign_status return number;
--
-- Обертка для получения текущего МФО (из контекста или глобального)
--
function f_ourmfo return number;

--
-- Обертка для получения текущего имени пользователя
--
function f_username return varchar2;

--
-- Обертка для получения текущего отделения пользователя
--
function f_user_branch return varchar2;

end BILL_ABS_INTEGRATION;
/
CREATE OR REPLACE PACKAGE BODY BILLS.BILL_ABS_INTEGRATION is

g_body_version constant varchar2(64) := 'Version 1.2 11/10/2018';
G_TRACE        constant varchar2(20) := 'BILL_ABS_INTEGRATION';


function get_oper_dt return date
  is
begin
  return bars.gl.bDATE;
end get_oper_dt;

function get_account (p_product in varchar2
                     ,p_client  in number
                     ,p_cur     in varchar2
                     ,p_mfo     in number)
  return varchar2
  is
  v_ret varchar2(14);
begin
  bars.bc.go(p_mfo);
  select nls
    into v_ret
    from bars.accounts
    where kf = coalesce(p_mfo,f_ourmfo)
      and nbs = substr(p_product,1,4)
      and ob22 = substr(p_product,5,2)
      and rnk = nvl(p_client,rnk)
      and kv = nvl(p_cur,980)
      and dazs is null
      and rownum = 1;
  return v_ret;
exception 
  when others then 
    bill_audit_mgr.log_action(p_action    => 'get_account',
                              p_key       => null,
                              p_params    => 'p_product = '||p_product||', p_client = '||nvl(to_char(p_client),'Пусто')||', p_cur = '||nvl(p_cur,'Пусто')||', p_mfo ='||p_mfo,
                              p_result    => 'Error: '||sqlerrm,
                              p_log_level => null);
    return null;
end get_account;

function make_prov (p_id       in opers.id%type
                   ,p_type     in integer
                   ,p_err_text out varchar2)
  return number
  is
  v_rec opers%rowtype;
  v_oper varchar2(3);
begin
  select * 
    into v_rec
    from opers
    where id = p_id;
  if p_type = 1 then
    v_oper := 'VS1';
  else
    v_oper := 'VS2';
  end if;
  for r in (select substr(d.nms,1,38) nam_a, substr(c.nms,1,38) nam_b, (select k.okpo from bars.customer k where k.rnk = d.rnk) as id_k
              from bars.accounts d,
                   bars.accounts c
              where d.nls = v_rec.dbt
                and d.kv = v_rec.cur_code
                and c.nls = v_rec.crd
                and c.kv = v_rec.cur_code)
  loop
    bars.gl.ref(v_rec.doc_ref);
    bars.gl.in_doc4(ref_   => v_rec.doc_ref,
                    tt_    => v_oper,
                    vob_   => case substr(v_rec.dbt,1,4)
                                when '9910' then 207
                                when '9819' then 206
                                else 6
                              end,
                    nd_    => substr(v_rec.doc_ref,1,10),
                    pdat_  => sysdate,
                    vdat_  => get_oper_dt,
                    dk_    => 1,
                    kv_    => v_rec.cur_code,
                    s_     => v_rec.amount*100,
                    kv2_   => v_rec.cur_code,
                    s2_    => v_rec.amount*100,
                    sq_    => 0,
                    sk_    => null,
                    sub_   => null,
                    data_  => trunc(sysdate),
                    datp_  => trunc(sysdate),
                    nam_a_ => r.nam_a,
                    nlsa_  => v_rec.dbt,
                    mfoa_  => v_rec.mfo,
                    nam_b_ => r.nam_b,
                    nlsb_  => v_rec.crd,
                    mfob_  => v_rec.mfo,
                    nazn_  => v_rec.purpose,
                    d_rec_ => null,
                    id_a_  => r.id_k,
                    id_b_  => r.id_k,
                    id_o_  => null,
                    sign_  => null,
                    sos_   => null,
                    prty_  => null,
                    uid_   => null);

    update opers
      set doc_ref = v_rec.doc_ref
      where id = p_id;

    bars.paytt(flg_  => 0,
               ref_  => v_rec.doc_ref,
               datv_ => get_oper_dt,
               tt_   => 'VS2',
               dk0_  => 1,
               kva_  => v_rec.cur_code,
               nls1_ => v_rec.dbt,
               sa_   => v_rec.amount*100,
               kvb_  => v_rec.cur_code,
               nls2_ => v_rec.crd,
               sb_   => v_rec.amount*100);
  end loop;
  if v_rec.doc_ref is null then
    p_err_text := 'Проводку не сформовано!';
    return -1;
  end if;
  return 0;
exception
  when no_data_found then 
    p_err_text := 'Не знайдено проведення з ID = '||p_id;
    return -1;
  when others then
    p_err_text := 'Помилка при оплаті проведення :'||sqlerrm;
    return -1;
end make_prov;

function f_ourmfo return number
    is
begin
    return to_number(bars.f_ourmfo);
exception
    when others then
        if sqlcode = -20000 then
            return to_number(bars.f_ourmfo_g);
        end if;
end f_ourmfo;


function get_sign_status return number
  is
begin
  return get_bill_param('SIGN_STATUS');
end;
--
-- Обертка для получения текущего имени пользователя
--
function f_username return varchar2
    is
begin
    return bars.user_name;
end f_username;

--
-- Обертка для получения текущего отделения пользователя
--
function f_user_branch return varchar2
    is
begin
    return sys_context('BARS_CONTEXT', 'USER_BRANCH');
end f_user_branch;


end BILL_ABS_INTEGRATION;
/
 show err;
 
PROMPT *** Create  grants  BILL_ABS_INTEGRATION ***
grant EXECUTE                                                                on BILL_ABS_INTEGRATION to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/bill_abs_integration.sql =========*
 PROMPT ===================================================================================== 
 