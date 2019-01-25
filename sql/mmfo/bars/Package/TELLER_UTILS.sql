
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/teller_utils.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TELLER_UTILS is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 11-Jan-18 10:45:26
  -- Updated : 16-03-2018
  -- Purpose : common functions
  g_package_name    constant varchar2(20)  := 'Teller_Utils';
  g_header_version  constant varchar2(64)  := 'version 2.1 26/10/2018';

  g_last_time date;
  c_teller_ctx_name    constant varchar2(20) := 'BARS_TELLER_CTX';
  c_teller_ctx_eq_type constant varchar2(20) := 'TELLER_EQ_TYPE';
  c_teller_ctx_eq_id   constant varchar2(20) := 'TELLER_EQ_ID';
  c_teller_ctx_lim     constant varchar2(20) := 'TELLER_LIMIT';
  c_teller_eq_ip       constant varchar2(20) := 'TELLER_IP';
  c_teller_eq_full_ip  constant varchar2(20) := 'TELLER_FULL_IP';

  procedure log_time (p_step in varchar2);



  function teller_arms (p_armcode in varchar2)
    return integer;

  function get_active_tt 
    return varchar;

  function get_active_oper
    return number;

  function get_active_oper_ref
    return number;

  function get_active_curcode
    return varchar2;

  function get_in_amount (p_doc_ref  in number
                         ,p_currency out varchar2)
    return number;

  function get_out_amount (p_doc_ref  in number
                          ,p_currency out varchar2)
    return number;

  function get_r030 (p_cur_code in varchar2)
    return number;

  function get_cur_code (p_cur_code in varchar2)
    return varchar2;

  function get_cur_name (p_cur_code in number)
    return varchar2;

  procedure set_active_oper (p_doc_ref in number);

  function get_cur_nonatm_amount (p_curcode in varchar2 default 980)
    return number;

  procedure set_context (p_user in number default user_id);
  procedure clear_context (p_user in number default user_id);

  function get_eq_id return number ;

  function get_eq_limit return number;

  function get_equip_type return varchar2;

  function get_device_url return varchar2;

  function get_device_full_url
    return varchar2;

  function create_cashout_message
    return varchar2;

  function create_cashin_message
    return varchar2;

  function check_open_opers (p_oper_type in varchar2)
    return number;

  function get_tox_flag 
    return integer;


end Teller_utils;
/
CREATE OR REPLACE PACKAGE BODY BARS.TELLER_UTILS is

  g_bars_dt      constant date   := gl.bd;
  g_body_version constant varchar2(64)  := 'version 3.1 11/12/2018';
  g_user_host    constant varchar2(50)  := sys_context('bars_global', 'host_name');
  g_user_id      constant number        := user_id;

  procedure SetTellerState (p_eq_id    in varchar2
                           ,p_eq_ip    in varchar2
                           ,p_user_ip  in varchar2
                           ,p_user_lim in number)
    is
  begin
    update teller_state ts
      set ts.max_limit = p_user_lim
         ,ts.eq_type   = p_eq_id
         ,ts.user_ip   = p_user_ip
         ,ts.eq_ip     = p_eq_ip
         ,ts.branch    = bc.current_branch_code
      where ts.user_ref = g_user_id
        and ts.work_date = g_bars_dt;
  end SetTellerState;

  function GetTellerParam (p_param in varchar2)
    return varchar2
    is
    v_ret varchar2(100);
  begin
    select case p_param
             when 'EQ_ID' then ts.eq_type
             when 'EQ_IP' then ts.eq_ip
             when 'US_IP' then ts.user_ip
           end
      into v_ret
      from teller_state ts
      where user_ref = g_user_id
        and work_date = g_bars_dt;
    return v_ret;
  exception
    when others then
      return null;
  end GetTellerParam;

  procedure log_time (p_step in varchar2)
    is
  begin
    bars_audit.info('Teller time '||nvl(p_step,'')||': '||to_char(systimestamp,'hh24:mi:ss.ff')||', '||to_char(systimestamp-nvl(g_last_time,systimestamp)));
    g_last_time := systimestamp;
  end;


  function char2number (p_str in char)
    return number
    is
    v_dec varchar2(1) := substr(trim(to_char(1/3,'0D99')),2,1);
  begin
    return to_number(replace(replace(p_str,'.',v_dec),',',v_dec));
  end;


  function teller_arms (p_armcode in varchar2)
    return integer
    is
    v_teller_flag integer;
  begin
    v_teller_flag := teller_tools.get_teller;
    if user_name = 'ABSADM01' then return 1; end if;
    if v_teller_flag = 1 and p_armcode = 'TELL' then
      return 1;
    elsif v_teller_flag = 0 and p_armcode != 'TELL' then
      return 1;
    else
      return 0;
    end if;
  exception
    when others then return 1;
  end;

  function get_active_tt
    return varchar
    is
    v_ret varchar2(3);
  begin
    select op.oper_ref
      into v_ret
      from teller_state ts,
           teller_opers op
      where ts.user_ref = g_user_id
        and ts.work_date = g_bars_dt
        and ts.active_oper = op.id;
     return v_ret;
   exception
     when others then
       logger.info('Teller.Get_Active_TT error: '||sqlerrm);
       return null;
  end get_active_tt;

  function get_active_oper
    return number
    is
    v_ret number;
  begin

    select active_oper
      into v_ret
      from teller_state
      where user_ref = g_user_id
        and work_date = g_bars_dt;

    return v_ret;
  exception
    when no_data_found then
      return 0;
    when others then
      bars_audit.info('get_active_oper error: '||sqlerrm);
      return 0;
  end get_active_oper;

  function get_active_oper_ref
    return number
    is
    v_ret number;
  begin
    select op.doc_ref
      into v_ret
      from teller_state ts, teller_opers op
      where ts.user_ref = g_user_id
        and ts.work_date = g_bars_dt
        and ts.active_oper = op.id;

    return v_ret;
  exception
    when no_data_found then
      return 0;
    when others then
      bars_audit.info('get_active_oper_ref error: '||sqlerrm);
      return 0;
  end get_active_oper_ref;


  function get_active_curcode
    return varchar2
    is
  begin

    for r in (select id, doc_ref, state, active_cur
                from teller_opers
                where get_active_oper() in (doc_ref,id)
             )
    loop
      return r.active_cur;
    end loop;
    return null;
  end get_active_curcode;

  function get_in_amount (p_doc_ref  in number
                         ,p_currency out varchar2)
    return number
    is
    v_ret number;
    v_rowid varchar2(1000);
  begin
/*    for r in (select sum(o.s) s, t.lcv,t.NAME
                from opldok o, accounts a, tabval t
                where ref = p_doc_ref
                  and o.acc = a.acc
                  and a.nls like '100%'
                  and dk = 0
                  and a.kv = t.kv
                group by t.lcv,t.NAME)
*/
    select cur_code, (nvl(atm_amount,0)+nvl(non_atm_amount,0)), rowid
      into p_currency, v_ret, v_rowid
      from teller_cash_opers tco
      where tco.doc_ref = p_doc_ref
        and tco.atm_status in (0,1)
        and tco.op_type in ('IN','RIN')
        and rownum = 1
      order by tco.op_type, tco.cur_code;

    update teller_cash_opers
      set atm_status = case
                         when rowid = v_rowid then 1
                         when atm_status = 1 then 2
                         else 0
                       end
      where doc_ref = p_doc_ref
        and atm_status in (0,1);
    return v_ret;
  exception
    when others then
      bars_audit.info('Teller_utils.get_in_amount: Помилка отримання суми проведення [p_doc_ref = '||p_doc_ref||']');
      p_currency := null;
      return 0;
  end get_in_amount;

  function get_out_amount (p_doc_ref  in number
                          ,p_currency out varchar2)
    return number
    is
    v_ret number;
    v_rowid varchar2(1000);
  begin
/*    for r in (select sum(o.s) s, t.NAME, t.lcv
                from opldok o, accounts a, tabval t
                where ref = p_doc_ref
                  and o.acc = a.acc
                  and a.nls like '100%'
                  and dk = 1
                  and a.kv = t.kv
                group by t.NAME, t.lcv)
    loop
      p_currency := r.lcv;
      return r.s/100;
    end loop;
    return 0;*/
    select cur_code, (nvl(atm_amount,0)+non_atm_amount), rowid
      into p_currency, v_ret, v_rowid
      from teller_cash_opers tco
      where tco.doc_ref = p_doc_ref
        and tco.atm_status in (0,1)
        and tco.op_type in ('OUT','ROUT')
        and rownum = 1
      order by tco.op_type, tco.cur_code;


    update teller_cash_opers
      set atm_status = case
                         when rowid = v_rowid then 1
                         when atm_status = 1 then 2
                         else 0
                       end
      where doc_ref = p_doc_ref
        and atm_status in (0,1);
    return v_ret;
  exception
    when others then
      bars_audit.info('Teller_utils.get_out_amount: Помилка отримання суми проведення [p_doc_ref = '||p_doc_ref||']'||sqlerrm);
      p_currency := null;
      return 0;

  end get_out_amount;

  function get_r030 (p_cur_code in varchar2)
    return number
    is
  begin
    for r in (select kv from tabval where lcv = p_cur_code or to_char(kv) = p_cur_code)
    loop
      return r.kv;
    end loop;
    return -1;
  end get_r030;

  function get_cur_code (p_cur_code in varchar2)
    return varchar2
    is
  begin
    for r in (select lcv from tabval where lcv = p_cur_code or to_char(kv) = p_cur_code)
    loop
      return r.lcv;
    end loop;
    return '';
  end get_cur_code;

  function get_cur_name (p_cur_code in number)
    return varchar2
    is
  begin
    for r in (select name from tabval where kv = p_cur_code)
    loop
      return r.name;
    end loop;
    return 'Невідома валюта з кодом '||p_cur_code;
  end get_cur_name;

  procedure set_active_oper (p_doc_ref in number)
    is
  begin
    update teller_state ts
      set ts.active_oper = p_doc_ref
      where ts.user_ref = g_user_id
        and ts.work_date = g_bars_dt;
  end set_active_oper;


  function get_cur_nonatm_amount (p_curcode in varchar2 default 980)
    return number
    is
    v_ret number;
    v_curr_oper_amn number;
  begin
    logger.info('g_user_id = '||g_user_id||', p_curcode = '||p_curcode);
    select v.non_atm_amount
      into v_ret
      from v_teller_state v
      where v.user_ref = g_user_id
        and get_r030(v.cur_code) = get_r030(p_curcode);

      select sum(non_atm_amount * case op_type
                                    when 'IN' then 1
                                    when 'RIN' then 1
                                    when 'OUT' then -1
                                    when 'ROUT' then -1
                                  end)
        into v_curr_oper_amn
        from teller_cash_opers co
        where doc_ref = get_active_oper()
          and exists (select 1 from teller_opers o where o.id = co.doc_ref and o.oper_ref = 'TOX')
          and atm_status = 2;
    return v_ret+nvl(v_curr_oper_amn,0);
  exception
    when no_data_found then
      return 0;
    when others then
      bars_audit.info('get_cur_nonatm_amount : '||sqlerrm);
      return 0;
  end get_cur_nonatm_amount;

  function get_eq_type
    return varchar2
    is
    v_ret varchar2(1);
  begin
--bars_audit.info('g_ws_name = '||g_ws_name);
/*    for r in (select ed.equip_type
                from teller_stations ts,
                     teller_equipment_dict ed
                where ts.station_name = g_user_host
                  and ts.equip_ref = ed.equip_code
             )
    loop
      return r.equip_type;
    end loop;*/
    return GetTellerParam('EQ_ID');
  end;


  procedure create_context
    is
    pragma autonomous_transaction;
  begin
    execute immediate 'CREATE OR REPLACE CONTEXT BARS_TELLER_CTX USING BARS.TELLER_UTILS ACCESSED GLOBALLY';
  end;


  procedure set_context (p_user in number default user_id)
    is
    v_num number;
  begin
    if teller_tools.get_teller() = 0 then
      return;
    end if;
/*    select count(1)
      into v_num
      from dba_context
      where namespace = 'BARS_TELLER_CTX';
    if v_num = 0 then
      create_context;
    end if;
*//*
  c_teller_ctx_eq_type constant varchar2(1)  := 'TELLER_EQ_TYPE';
  c_teller_ctx_eq_id   constant number       := 'TELLER_EQ_ID';
  c_teller_ctx_lim     constant number       := 'TELLER_LIMIT';
  c_teller_eq_ip       constant varchar2(20) := 'TELLER_IP';
*/
/*    sys.dbms_session.set_context(namespace => c_teller_ctx_name,
                                 attribute => c_teller_ctx_eq_type,
                                 value     => teller_utils.get_eq_type,
                                 username  => user_name,
                                 client_id => v_clid);
*/

    for r in (select ed.equip_limit, ts.url, ed.equip_type
                from teller_stations ts
                    ,teller_equipment_dict ed
                where ts.station_name = g_user_host
                  and ed.equip_code = ts.equip_ref)
    loop
/*      sys.dbms_session.set_context(namespace => c_teller_ctx_name,
                                   attribute => c_teller_ctx_lim,
                                   value     => r.equip_limit,
                                   username  => user_name,
                                   client_id => v_clid);

      sys.dbms_session.set_context(namespace => c_teller_ctx_name,
                                   attribute => c_teller_eq_ip,
                                   value     => r.url,
                                   username  => user_name,
                                   client_id => v_clid);

*/
      SetTellerState(r.equip_type,r.url, g_user_host,r.equip_limit);
    end loop;


  end set_context;


  procedure clear_context (p_user in number default user_id)
    is
  begin
    null;
/*    dbms_session.clear_context(namespace => c_teller_ctx_name,
                               client_id => sys_context('userenv', 'client_identifier'));*/
  end;

  function get_ctx_param(p_param in varchar2)
    return varchar2
    is
    v_num number;
  begin
    select count(1)
      into v_num
      from dba_context
      where namespace = 'BARS_TELLER_CTX';
    if v_num = 0 then
      set_context;
    end if;
    case p_param
      when c_teller_ctx_eq_type then
        return sys_context(c_teller_ctx_name,c_teller_ctx_eq_type);
      when c_teller_ctx_eq_id then
        return sys_context(c_teller_ctx_name,c_teller_ctx_eq_id);
      when c_teller_ctx_lim then
        return sys_context(c_teller_ctx_name,c_teller_ctx_lim);
      else
        return '???';
    end case;
  end get_ctx_param;

  function get_equip_type
    return varchar2
    is
    v_ret varchar2(100);-- := get_ctx_param(c_teller_ctx_eq_type);
  begin
    return nvl(GetTellerParam('EQ_ID'),'M');
  end get_equip_type;

  function get_eq_id return number
--    result_cache
    is
    v_ret number;
  begin
    logger.info('Tel : '||g_user_host);
    select ts.equip_ref
      into v_ret
      from  teller_stations ts, teller_state t
      where t.user_ref = g_user_id
        and t.work_date = g_bars_dt
        and ts.station_name = t.user_ip;
    return v_ret;
  exception
    when others then
      return 0;
  end get_eq_id;

  function get_eq_limit
    return number
    is
    v_ret number;
  begin
    select ts.max_limit
      into v_ret
      from teller_state ts
      where user_ref = g_user_id
        and work_date = g_bars_dt;
    return v_ret;
  exception
    when others then
      bars_audit.info('teller_utils.get_eq_limit: '||sqlerrm);
      return 0;
  end get_eq_limit;


  function get_device_url
    return varchar2
    is
    v_ret varchar2(100);
  begin
    v_ret := GetTellerParam('EQ_IP');
    return v_ret;
  end get_device_url;

  function get_device_full_url
    return varchar2
    is
    v_ret varchar2(100);
  begin
    select ts.c_type||'://'||ts.url
      into v_ret
      from teller_stations ts
      where ts.station_name = g_user_host;
    return v_ret;
  exception
    when no_data_found then
      bars_audit.info('Неможливо визначити адресу АТМ');
      return null;
  end get_device_full_url;



  function create_cashout_message
    return varchar2
    is
    v_oper_id integer;
    v_ret     varchar2(2000);
    v_tempo   varchar2(2000);
    v_collection_box varchar2(2000);
  begin

    if teller_utils.get_equip_type() != 'M' then
      begin
        select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.atm_amount),'<br/>') within group (order by op.cur_code)
          into v_ret
          from teller_opers op,
               teller_state ts,
               teller_cash_opers co
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt
            and op.id between ts.start_oper and ts.active_oper
            and co.doc_ref = op.id
            and op.amount != 0
            and op.state = 'OA';
        if v_ret is not null then
          v_ret := '<b>З АТМ вилучено</b>: <br/>'||v_ret;
        end if;
      exception
        when no_data_found then null;
        when others then v_ret := sqlerrm;
      end;

      begin
        select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.atm_amount),'<br/>') within group (order by op.cur_code)
          into v_collection_box
          from teller_opers op,
               teller_state ts,
               teller_cash_opers co
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt
            and op.id between ts.start_oper and ts.active_oper
            and co.doc_ref = op.id
            and op.amount != 0
            and op.state = 'OC';
        if v_collection_box is not null then
          v_collection_box := 'ЗНОШЕНІ: <br/>'||v_collection_box;
        end if;
      exception
        when no_data_found then null;
        when others then v_collection_box := sqlerrm;
      end;
    end if;

    begin
      select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.non_atm_amount),'<br/>') within group (order by op.cur_code)
        into v_tempo
        from teller_opers op,
             teller_state ts,
             teller_cash_opers co
        where ts.user_ref = g_user_id
          and ts.work_date = g_bars_dt
          and op.id between ts.start_oper and ts.active_oper
          and co.doc_ref = op.id
          and op.amount != 0
          and op.state = 'OT';
      if v_tempo is not null then
        v_tempo := '<b>З Темпокаси вилучено</b>: <br/>'||v_tempo;
      end if;
    exception
      when no_data_found then null;
      when others then v_tempo := sqlerrm;
    end;

    if v_ret is null and v_collection_box is null and v_tempo is null then
      v_ret := 'Немає коштів для вилучення!';
    else
      v_ret := v_ret||'<br/>'||v_collection_box||'<br/>'||v_tempo;
    end if;

    return v_ret;
  exception
    when others then
      v_ret := 'Помилка отримання інформації щодо отриманих коштів: '||sqlerrm;
      bars_audit.info('Teller: '||v_ret);
      return v_ret;
  end create_cashout_message;

  function create_cashin_message
    return varchar2
    is
    v_oper_id integer;
    v_ret     varchar2(2000);
    v_tempo   varchar2(2000);
    v_collection_box varchar2(2000);
  begin

    if teller_utils.get_equip_type() != 'M' then
      begin
        select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.atm_amount),'<br/>') within group (order by op.cur_code)
          into v_ret

          from teller_opers op,
               teller_state ts,
               teller_cash_opers co
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt
            and op.id between ts.start_oper and ts.active_oper
            and co.doc_ref = op.id
            and op.amount != 0
            and op.state = 'IA';
        if v_ret is not null then
          v_ret := '<b>В АТМ прийнято</b>: <br/>'||v_ret;
        end if;
      exception
        when no_data_found then null;
        when others then v_ret := sqlerrm;
      end;



      begin
        select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.atm_amount),'<br/>') within group (order by op.cur_code)
          into v_collection_box
          from teller_opers op,
               teller_state ts,
               teller_cash_opers co
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt
            and op.id between ts.start_oper and ts.active_oper
            and co.doc_ref = op.id
            and op.amount != 0
            and op.state = 'IC';
        if v_collection_box is not null then
          v_collection_box := 'ЗНОШЕНІ: <br/>'||v_collection_box;
        end if;
      exception
        when no_data_found then null;
        when others then v_collection_box := sqlerrm;
      end;
    end if;

      begin
        select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.non_atm_amount),'<br/>') within group (order by op.cur_code)
          into v_tempo
          from teller_opers op,
               teller_state ts,
               teller_cash_opers co
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt
            and op.id between ts.start_oper and ts.active_oper
            and co.doc_ref = op.id
            and op.amount != 0
            and op.state = 'IT';
        if v_tempo is not null then
          v_tempo := '<b>В Темпокасу прийнято</b>: <br/>'||v_tempo;
        end if;
      exception
        when no_data_found then null;
        when others then v_tempo := sqlerrm;
      end;

    if v_ret is null and v_collection_box is null and v_tempo is null then
      v_ret := 'Приймання коштів не виконувалось!';
    else
      v_ret := v_ret||'<br/>'||v_collection_box||'<br/>'||v_tempo;
    end if;

    return v_ret;
  exception
    when others then
      v_ret := 'Помилка отримання інформації щодо внесених коштів: '||sqlerrm;
      bars_audit.info('Teller: '||v_ret);
      return v_ret;
  end create_cashin_message;


  function check_open_opers (p_oper_type in varchar2)
    return number
    is
    v_ret number := 0;
  begin
    for r in (select 1
                from teller_opers op,
                     teller_cash_opers co
                where op.user_ref = g_user_id
                  and op.work_date = g_bars_dt
                  and op.oper_ref != 'TOX'
                  and (op.doc_ref = co.doc_ref or op.id = co.doc_ref)
                  and op.state not in ('RJ','OK','RX')
                  and ((p_oper_type = 'I' and co.op_type in ('IN','RIN'))
                       or
                       (p_oper_type = 'O' and co.op_type in ('OUT','ROUT'))
                      )
              union
              select 1
                from teller_opers op,
                     opldok od,
                     accounts a
                where op.user_ref = g_user_id
                  and op.oper_ref != 'TOX'
                  and op.work_date = g_bars_dt
                  and op.doc_ref = od.ref
                  and op.state not in ('RJ','OK','RX')
                  and od.acc = a.acc
                  and a.nls like '100%'
                  and od.dk = case p_oper_type
                                when 'I' then 0
                                when 'O' then 1
                              end
             )
    loop
      v_ret := 1;
    end loop;
    return v_ret;
  exception
    when others then
      bars_audit.info('Teller_utils.check_open_opers: ОШИБКА'||sqlerrm);
      return 0;
  end check_open_opers;


  function get_tox_flag
    return integer
    is
    v_ret integer;
  begin
logger.info('Teller. get_tox_flag: user_id = '||g_user_id);
    if get_eq_type = 'M' then
      return 0;
    end if;
    select nvl(tox_flag,0)
      into v_ret
      from teller_users tu
      where tu.user_id = g_user_id
        and g_bars_dt between tu.valid_from and nvl(tu.valid_to,g_bars_dt);
    return v_ret;
  end get_tox_flag;
end Teller_utils;
/
 show err;
 
PROMPT *** Create  grants  TELLER_UTILS ***
grant EXECUTE                                                                on TELLER_UTILS    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/teller_utils.sql =========*** End **
 PROMPT ===================================================================================== 
 