
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/teller_tools.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TELLER_TOOLS is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 21.08.2017 11:57:19
  -- Updated : 16-03-2018
  -- Purpose : Пакет для обслуговування операцій з теллерами

  g_package_name    constant varchar2(20)  := 'Teller_Tools';
  g_header_version  constant varchar2(64)  := 'version 3.6 10/05/2019';

  g_user_id      constant  number        := user_id;
  g_bars_dt      constant  date          := gl.bd;

  type t_record is record (tt varchar2(3)
                          ,cur number
                          ,sum_cur number
                          ,sum_uah number
                          ,sw integer
                          ,status varchar2(2));



/*
  принадлежность операции к операция Единого окна Profix
*/

  function is_sw_oper (p_ref in number)
    return integer;


  procedure ins_cash_opers (p_doc_ref in number
                           ,p_nonatm  in number default null
                           ,p_atm     in number default null);


  function get_cash_amount return varchar2;

  /*
   проверка пользователя не его возможность работать с ролью теллера
   возвращает 0 - пользователь не может быть теллером
              1 - пользователь может быть теллером
  */
  function is_teller (p_user in number default g_user_id)
    return integer;
  function is_teller (p_user in varchar2
                     ,p_sbonflag in number default 0)
    return integer;

  /* функция проверяет - надо ли дергать веб-сервис для устройства.
     0  - нет
     1  - да
  */
  function is_need_to_soap
    return integer;

  /*включение/выключение роли теллера для текущего пользователя */
  procedure set_teller (p_switch integer) ;
  procedure set_teller (p_user in varchar2, p_switch in boolean);

  function check_lim_operation (p_rec t_record
                               ,p_warning in integer default 0
                               ,p_err out varchar2)
    return number;

  /*1 - текущий пользователь работает с ролью теллера
    0 - текущий пользователь не работает с ролью теллера*/
  function  get_teller return integer;

  /* информация по теллеру для вывода в интерфейс */
--  function get_teller_info return varchar2;
  function get_teller_info (p_user in varchar2 default user_name)  return varchar2;




  function  write_oper (p_op_code       in varchar2
                       ,p_op_curr       in number
                       ,p_op_amount     in number
                       ,p_op_amount_uah in number
                       ,p_doc_ref       in number default null
                       ,p_sw            in number default 0
                       )
    return number;

  procedure send_message (p_receiver in varchar2,
                          p_msg      in varchar2);


  function get_teller (p_user in varchar2)
    return integer;

  function get_teller (p_user in number)
    return integer;

  procedure save_tts (p_userid in number := g_user_id);
  procedure set_teller_tts (p_userid number := g_user_id);
  procedure restore_tts (p_userid in number default g_user_id
                        ,p_dt     in date   default g_bars_dt);

  procedure role_switch (p_flag in number, p_userid in number := g_user_id);

  function validate_teller_operation (p_op_code  in varchar2
                                     ,p_op_cur   in varchar2
                                     ,p_op_sum   in number
                                     ,p_sw       in number
                                     ,p_errtxt out varchar2)
    return number;

  function is_cash_operation (p_op_code in varchar2)
    return number;

  function is_button_visible (p_op_code in varchar2  default null)
    return number;

  function get_equipment_info return varchar2;

  function refresh_device_status
    return varchar2;

  function get_type_operation (p_op_code in varchar2)
    return varchar2;

  function get_type_operation (p_doc_ref in number)
    return varchar2;

  function registry_sbon_operation (p_user      in varchar2
                                   ,p_user_ip   in varchar2 default null
                                   ,p_op_code   in varchar2
                                   ,p_op_amount in number
                                   ,p_errtxt    out varchar2)
    return number;

  function update_oper (p_id in number
                       ,p_user_ip   in varchar2 default null
                       ,p_action in varchar2
                       ,p_errtxt out varchar2)
    return number;


  function is_coins_need (p_amount in number)
    return number;


-- Вызов сервиса StoreCashin
  function store_request (p_docref in number     -- референс документа
                         ,p_errtxt out varchar2) -- сообщение об ошибке
    return number;

  function cancel_operation (p_docref in number
                            ,p_errtxt out varchar2)
    return number;

-- Окончание работы с
  function end_request (p_docref in number          -- референс документа
                       ,p_atm_amount     in number  -- сумма, которая прошла через АТМ
                       ,p_non_atm_amount in number  -- сумма, которая прошла через сейф
                       ,p_errtxt out varchar2)      -- сообщение об ошибке
    return number;

-- выполнение операции с мелкими купюрами и монетами
  function change_request (p_docref  in number
                          ,p_curcode in varchar2
                          ,p_amount  in number
                          ,p_errtxt  out varchar2)
    return number;

-- сообщение для кнопки с купюрами и монетами
  function get_change_msg (p_docref in number)  -- референс документа
    return varchar2;

  function get_window_status_new (p_doc_ref   in out number
                                 ,p_warning   in number
                                 ,p_amount    out number
                                 ,p_currency  out varchar2
                                 ,p_oper_desc out varchar2
                                 ,p_atm       out varchar2)
    return varchar2;
  function get_window_status (p_doc_ref   in out number
                             ,p_warning   in number
                             ,p_amount    out number
                             ,p_currency  out varchar2
                             ,p_oper_desc out varchar2
                             ,p_atm       out varchar2
                             ,p_reject_flag out integer)
    return varchar2;



  function make_request (p_oper_ref in number
                        ,p_errtxt   out varchar2)
    return number;


  function confirm_request (p_docref     in number
                           ,p_atm_amount out number
                           ,p_errtxt     out varchar2)
  return number;

  function get_request_name (p_state in varchar2)
    return varchar2;

  function get_atm_amount (p_amount_txt out varchar2)
    return number;

  procedure send_msg2boss (p_msg in varchar2);

  function reg_sbon (p_errtxt out varchar2)
    return number;

  procedure send_mail2boss (p_addr in varchar2
                           ,p_body in clob);

  function check_doclist (p_doclist in  number_list
                         ,p_errtxt  out varchar2)
    return number;

  function storno_doclist (p_doclist in  number_list
                          ,p_errtxt  out varchar2)
    return number;


  procedure compute_teller_stats (p_cnt_in  out number
                                 ,p_sum_in  out number
                                 ,p_cnt_out out number
                                 ,p_sum_out out number);

  function get_teller_doc_status (p_doc_ref in number)
    return number;


  function validate_visa (p_visa in number
                         ,p_docref in number
                         ,p_errtxt out varchar2)
    return number;

  function is_teller_doc (p_docref in number)
    return number;

  function start_cashin (p_cur_code in varchar2 default '980'
                        ,p_errtxt out varchar2)
    return number;
  function StoreCashin (p_errtxt out varchar2)
    return number;
  function EndCashin (p_non_atm_amount in number
                     ,p_curcode        in varchar2 default '980'
                     ,p_errtxt out varchar2)
    return number;
  function CancelCashin (p_errtxt out varchar2)
    return number;

  function EndCashout (p_non_atm_amount in number
                      ,p_curcode        in varchar2 default '980'
                      ,p_errtxt out varchar2)
    return number;

  function EndCashout (p_errtxt out varchar2)
    return integer;


  procedure confirm_tox (p_oper_ref in number
                        ,p_doc_ref  in number);

  function check_doc (p_opercode in  varchar2
                     ,p_amn      in  number
                     ,p_amnuah   in  number
                     ,p_curcode  in  varchar2
                     ,p_docref   in  number default null
                     ,p_errtxt   out varchar2)
    return number ;

  procedure refresh_cash;

  procedure create_collect_oper;

function check_doc (p_opercode in  varchar2
                     ,p_amn      in  number
                     ,p_amnuah   in  number
                     ,p_curcode  in  varchar2
                     ,p_docref   in  number default null
                     ,p_dk       in  number
                     ,p_nlsa     in varchar2
                     ,p_nlsb     in varchar2
                     ,p_errtxt   out varchar2)
    return number;

  function delete_TOX (p_id     in integer
                      ,p_errtxt out varchar2)
    return number;

  function reject_doc (p_doc_ref in number
                      ,p_errtxt  out varchar2)
    return integer;

  function check_teller_status (p_errtxt out varchar2)
    return integer;

  function reset_atm_fault (p_errtxt out varchar2)
    return number;


  procedure set_atm_fault (p_flag in number default 1
                          ,p_atm in varchar2 default null
                          ,p_user in varchar2 default null);
                          
  procedure resolve_atm_fault (p_atm_id in varchar2
                              ,p_tel_id in number);

end teller_tools;
/
CREATE OR REPLACE PACKAGE BODY BARS.TELLER_TOOLS is

  g_min_banknote constant  number := 10;
  g_body_version constant  varchar2(64)  := 'version 3.6 10/05/2019';
  g_ws_name      varchar2(100) := sys_context('bars_global', 'host_name');
  g_eq_url       constant  varchar2(100) := case get_teller
                                              when 0 then null
                                              else teller_utils.get_device_url()
                                            end;
  g_eq_type      varchar2(1) := teller_utils.get_equip_type;
  g_cur_doc      teller_opers.id%type;
  g_cur_op       teller_cash_opers.op_type%type;
  g_cur_curr     teller_cash_opers.cur_code%type;
  -- генерация сообщения об ошибке с протоколированием в sec_audit
  procedure raise_error (p_progname in varchar2
                        ,p_err      in varchar2);


  procedure raise_error (p_progname in varchar2
                        ,p_err      in varchar2)
    is
    v_err varchar2(2000) := substr(p_progname||'. Помилка при роботі: '||p_err,1,2000);
  begin
    bars_audit.error(v_err);
    raise_application_error(-20100,v_err);
  end;



  function check_atm 
    return integer
    is
    v_ret integer;
  begin
    select nvl(t.blocked,0) 
      into v_ret
      from teller_atm_status t
      where t.equip_ip = g_eq_url
        and t.work_date = g_bars_dt;
    return v_ret;
  exception
    when no_data_found then 
      return 0;
    when others then
      logger.error('Teller. Check_ATM. Error: '||sqlerrm);
      raise;
  end check_atm;

--

  procedure save_cash_oper (p_doc_ref  in number
                           ,p_op_type  in varchar2
                           ,p_cur_code in varchar2
                           ,p_atm_amn  in number
                           ,p_non_atm  in number
                           ,p_oper_amn in number
                           ,p_final    in integer default 0)
    is
    v_doc_ref number;
    v_oper_ref number;
    v_oper_type teller_cash_opers.op_type%type;
    v_oper_tt   teller_opers.oper_ref%type;
    v_final     integer := p_final;
    v_oper_st   teller_opers.state%type;
  begin

if p_oper_amn <= 2 then
  logger.info('teller   : '||dbms_utility.format_call_stack);
--  raise;
end if;
/*
    merge into teller_cash_opers tco
      using (select p_doc_ref  doc_ref,
                    p_op_type  op_type,
                    p_cur_code cur_code,
                    p_atm_amn  amount,
                    p_non_atm  non_atm
               from dual) t
      on (tco.doc_ref = t.doc_ref and tco.op_type = t.op_type)
      when matched then update
        set cur_code  = t.cur_code,
            atm_amount= t.amount,
            non_atm_amount = t.non_atm,
            last_dt   = sysdate,
            last_user = sys_context('userenv','host')
      when not matched then insert (doc_ref, op_type, cur_code, atm_amount, non_atm_amount, last_dt, last_user)
                            values (t.doc_ref, t.op_type, t.cur_code, t.amount, t.non_atm, sysdate, sys_context('userenv','host'));*/


logger.info('v_final = '||v_final||', g_eq_type = '||g_eq_type);
  if (nvl(v_final,0)  = 0 and g_eq_type = 'M') or v_oper_tt = 'TOX' or v_final = 2 then
    v_final := 1;
  end if;
  begin
    select id, doc_ref, coalesce(p_op_type,get_type_operation(doc_ref)), oper_ref
      into v_doc_ref, v_oper_ref, v_oper_type, v_oper_tt
      from teller_opers
      where id = p_doc_ref;
  exception
    when no_data_found then
      v_doc_ref := p_doc_ref;
  end;
    if v_oper_type != 'NONE' then
      update teller_cash_opers
        set atm_amount    = nvl(p_atm_amn,0)
           ,non_atm_amount= case g_eq_type
                              when 'M' then p_oper_amn
                              else nvl(p_non_atm,0)
                            end
           ,oper_amount   = p_oper_amn
           ,last_dt       = sysdate
           ,last_user     = g_ws_name
           ,op_type       = v_oper_type
           ,atm_status    = case v_final
                              when 1 then 2
                              else decode(v_oper_tt,'TOX',2,atm_status)
                            end
        where doc_ref = v_doc_ref
          and op_type = p_op_type
          and cur_code= teller_utils.get_r030(p_cur_code);
      if sql%rowcount = 0 then
        insert into teller_cash_opers (doc_ref, op_type, cur_code, atm_amount, non_atm_amount, oper_amount, last_dt, last_user,atm_status)
                               values (v_doc_ref, v_oper_type, teller_utils.get_r030(p_cur_code), nvl(p_atm_amn,0),
                                       case g_eq_type
                                         when 'M' then p_oper_amn
                                         else nvl(p_non_atm,0)
                                       end,
                                       p_oper_amn, sysdate, g_ws_name,decode(v_final,1,2,0));
      end if;
    end if;

  v_oper_st := case v_oper_type
                 when 'IN' then 'IN'
                 when 'OUT' then 'O0'
                 when 'RIN' then 'RI'
                 when 'ROUT' then'RO'
               end;
  update teller_opers
    set state = nvl(v_oper_st,state)
    where id = v_doc_ref
      and state != nvl(v_oper_st,state)
      and oper_ref != 'TOX';

  exception
    when others then
      bars_audit.info('save_cash_opers: '||dbms_utility.format_call_stack);
  end;
--
  procedure ins_cash_opers (p_doc_ref in number
                           ,p_nonatm  in number default null
                           ,p_atm     in number default null)
    is
    v_cnt integer := 0;
    v_op_state teller_opers.state%type;
  begin
    select state into v_op_state
      from teller_opers
      where id = p_doc_ref;
    if v_op_state like 'R%' then
      -- отмена операции. Выполняем исключительно операции АТМ
      insert into teller_cash_opers (doc_ref,
                                     op_type,
                                     cur_code,
                                     atm_amount,
                                     non_atm_amount,
                                     oper_amount,
                                     atm_status)
        select p_doc_ref,
               case op_type
                 when 'IN' then 'ROUT'
                 when 'OUT' then 'RIN'
                 else 'NONE'
               end,
               cur_code,
               0,
               case g_eq_type
                 when 'M' then non_atm_amount
                 else 0
               end,
               atm_amount+non_atm_amount,
               0
          from teller_cash_opers t
          where doc_ref = p_doc_ref
            and not op_type like 'R%'
            and (atm_status >0  or g_eq_type = 'M')
            and not exists (select 1 from teller_cash_opers o where o.doc_ref = p_doc_ref and op_type = case t.op_type when 'IN' then 'ROUT' when 'OUT' then 'RIN' else 'NONE' end and atm_status>0);
      return;
    end if;
--    delete from teller_cash_opers where doc_ref = p_doc_ref;
    for r in (select doc_type, kv, sum(s) s
                from (select case d.dk
                               when 0 then case when op.state like 'R%' then 'ROUT' else 'IN' end
                               when 1 then case when op.state like 'R%' then 'RIN' else 'OUT' end
                               else 'NONE'
                             end doc_type
                           , d.s s
                           , a.kv
                        from  opldok d, accounts a, teller_opers op
                        where op.id = p_doc_ref
                          and d.ref = op.doc_ref
                          and d.acc = a.acc
                          and a.nls like '100%')
               group by doc_type, kv
               order by doc_type, kv
              )
    loop
      save_cash_oper(p_doc_ref, r.doc_type,r.kv,nvl(p_atm,0),nvl(p_nonatm,0),r.s/100);
/*      if v_cnt = 0 then
        update teller_opers set state = decode(r.doc_type,'IN','IN','OUT','O0','RIN','RI','ROUT','RO',state)
          where id = p_doc_ref;
        v_cnt :=1 ;
      end if;*/
    end loop;
  end ins_cash_opers;


  function is_sw_oper (p_ref in number)
    return integer
    is
    v_num integer := 0;
  begin
    select count(1) into v_num
      from teller_oper_define tod, oper op
      where op.ref = p_ref
        and op.tt = tod.oper_code
        and tod.sw_flag = 1;
    if v_num>0 then
      return 1;
    end if;
    return 0;
  end ;
  --

  -- возвращает строку из двух знаков.
  -- Первый - количество предупреждений по лимиту остатка, второй - количество предупреждений по лимиту операции
  function get_warning_cnt (p_op_code in varchar2
                           ,p_op_curr in number)
    return varchar2
    is
    v_progname constant varchar2(100) := g_package_name || '.GET_WARNING_CNT';
    v_err      varchar2(2000);
    v_ret      number;
    v_num      number;
  begin
    select nvl(max(ts.warnings),0)
      into v_ret
      from teller_state ts
      where ts.user_ref = g_user_id
        and work_date   = g_bars_dt;

    select max(top.is_warning)
      into v_num
      from teller_opers top
      where top.user_ref = g_user_id
        and top.oper_ref = p_op_code
        and top.work_date = g_bars_dt
--        and top.cur_code = p_op_curr
        and nvl(top.is_warning,-1) != -1;

    return to_char(v_ret)||to_char(v_num);
  exception
    when others then
      v_err := 'Помилка отримання інформації щодо кількості порушення лімітів Теллера'||sqlerrm;
      raise_error(v_progname, v_err);
  end;

  -- функция определяет необходимость работы с Web Services для оборудования теллера
  function is_need_to_soap
    return integer
    is
    v_ret integer;
  begin
    select case
             when equip_type = 'A' then 1
             else 0
           end
      into v_ret
      from teller_equipment_dict ted,
           teller_stations ts
      where g_ws_name = ts.station_name
        and ts.equip_ref = ted.equip_code;

    return v_ret;
  end;

  -- сумма доступного принятия наличных
  function get_user_amount
    return number
    is
    v_progname varchar2(30) := g_package_name||'.get_user_amount';
    v_ret number;
  begin
    select sum((tco.atm_amount + tco.non_atm_amount) * decode(tco.op_type,'IN',1,'RIN',1,-1)
                * decode(tv.kv,980,1,rato(tv.kv,g_bars_dt)))
      into v_ret
      from teller_opers op, teller_cash_opers tco, tabval tv
      where op.user_ref = g_user_id
        and op.work_date = g_bars_dt
        and (nvl(op.doc_ref,op.id) = tco.doc_ref or op.id = tco.doc_ref)
        and tco.cur_code  in (to_char(tv.kv), tv.lcv)
        and op.state != 'RJ'
        and ((op.oper_ref = 'TOX' and exists (select 1 from oper o where o.ref = op.doc_ref and o.sos = 5))
             or op.oper_ref != 'TOX') ;

    v_ret := teller_utils.get_eq_limit() - nvl(v_ret,0);
    if v_ret<0 then
      v_ret := 0;
    end if;
    return v_ret;
  exception
    when others then
      raise_error(v_progname, sqlerrm);
  end;

  function get_cash_amount
    return varchar2
    is
    v_progname constant varchar2(30) := g_package_name||'.get_cash_amount';
    v_ret varchar2(100);
  begin
/*    select sum(case
             when o.dbt like '100%' and not o.crd like '100%'
               then o.amount_uah
             when o.crd like '100%' and not o.dbt like '100%'
               then 0-o.amount_uah
             else
               0
           end)
      into v_ret
      from teller_opers o
      where o.user_ref  = g_user_id
        and o.work_date = g_bars_dt;*/
    for r in (
              select tco.cur_code, sum(tco.atm_amount * case when op_type in ('IN','RIN') then 1 else -1 end) atm_amount,
                               sum(tco.non_atm_amount * case when op_type in ('IN','RIN') then 1 else -1 end) non_atm_amount
                from teller_cash_opers tco,
                     teller_opers op
                where op.work_date = gl.bd
                  and op.user_ref = g_user_id
                  and (nvl(op.doc_ref,op.id) = tco.doc_ref or op.id = tco.doc_ref)
                group by tco.cur_code)
    loop
      if v_ret is not null then
        v_ret := v_ret || '<br/>';
      end if;
      v_ret := v_ret || r.cur_code||': '||to_char(/*r.atm_amount+*/r.non_atm_amount);
    end loop;

    return v_ret;
  exception
    when others then
      bars_audit.info(v_progname||'. Помилка отримання залишку для Теллера'||sqlerrm);
      return -1;
  end;


/*
  0 - в лимит не вписались, но разрешаем выполнять
  1 - всё ок
  -1 - в лимит не вписались, операцию выполнять нельзя
*/

  function check_lim_operation (p_rec t_record
                               ,p_warning in integer default 0
                               ,p_err out varchar2
                               )
    return number
    is
    v_progname varchar2(50) := g_package_name||'.check_lim_operation';
    v_lim    number;
    v_sum_uah     number := round(p_rec.sum_cur * case p_rec.cur
                                                    when 980 then 1
                                                    else rato(p_rec.cur,g_bars_dt)
                                                   end,2);
    v_warning_cnt varchar2(2);
    v_warn        number;
    v_cash_type   varchar2(100);
    v_user_amount number := get_user_amount();
    v_errtxt      varchar2(4000);
    v_cnt_in      number;
    v_sum_in      number;
    v_cnt_out     number;
    v_sum_out     number;
  begin


    if p_rec.tt = 'TOX' then
      return 0;
    end if;
    select count(1)
      into v_cnt_in
      from teller_state ts,
           teller_opers op,
           teller_cash_opers co,
           oper o
      where ((g_eq_type = 'A' and  ts.eq_ip = g_eq_url)
             or
             (g_eq_type = 'M' and ts.user_ref = user_id)
            )
        and ts.work_date = g_bars_dt
        and ts.user_ref = op.user_ref
        and op.work_date = ts.work_date
        and op.oper_ref = 'TOX'
        and op.id = co.doc_ref
        and co.op_type = 'IN'
        and op.doc_ref = o.ref
        and o.sos = 5;
    if v_cnt_in = 0 then
      p_err := 'Заборонено виконувати операцію з обслуговування клієнта до проведення підкріплення';
      return -2;
    end if;
    compute_teller_stats(v_cnt_in, v_sum_in, v_cnt_out, v_sum_out);
    begin
      if get_type_operation(p_rec.tt) = 'OUT' and p_rec.sum_uah>(v_sum_in-v_sum_out) then
        p_err := 'Поточний залишок коштів Теллера ['||to_char(v_sum_in-v_sum_out,'FM999999999D99')||'] менше суми видаткової операції ['||p_rec.sum_uah||']!';
        return -1;
      end if;
    end;
-- выбираем допустимый лимит операции по коду операции и валюте
    begin
      select max_amount, nvl(tod.need_req,get_type_operation(p_rec.tt))
        into v_lim, v_cash_type
        from teller_oper_define tod
        where tod.oper_code = p_rec.tt
          and tod.equip_ref = teller_utils.get_eq_id();
--      v_ret := 1;
    exception
      when no_data_found then
        p_err := 'Операція [tt = '||p_rec.tt||'] відсутня в переліку операцій Теллера';
        return -2;
      when others then
        bars_audit.info(v_progname||': '||sqlerrm);
    end;

    if p_warning = 1 then
      v_warning_cnt := get_warning_cnt(p_rec.tt, p_rec.cur);  -- кол=во уже выданных предупреждений
    else
      v_warning_cnt := '00';
    end if;

    v_warn :=to_number(substr(v_warning_cnt,2,1));
    if v_sum_uah > v_lim then   -- сумма операции больше допустимой по данному коду
      p_err := 'Для операції з кодом '||p_rec.tt||'  встановлений ліміт '||to_char(v_lim,'FM99,999,999.00')||
               ' менше суми проведення '||to_char(v_sum_uah,'FM99,999,999.00');

      if v_warn >=2 or p_rec.sw = 0 then     -- по операции было больше двух предупреждений либо она не из единого окна
        p_err := p_err || chr(10)||' Виконання операції заборонено!';
        return -1;                                      -- блокируем
      else
        -- формируем информационное сообщение о превышении лимита
        p_err := p_err||chr(10)||
                 '(попередження № '||to_char(nvl(v_warn,0)+1)||')';
        if v_warn = 1 then -- уже было одно предупреждение. Потому это надо отправить руководителю
          send_msg2boss('Теллер '||user_name||chr(10)||p_err);
        end if;
        return nvl(v_warn,0)+1;
      end if;
    end if;
    v_warn := to_number(substr(v_warning_cnt,1,1));
    if v_cash_type = 'IN' and  v_sum_uah>v_user_amount then  -- сумма операции больше, чем возможная сумма принятия наличных
      v_errtxt := 'Операція [tt = '||p_rec.tt||'] в валюті '||to_char(p_rec.cur)||' призведе до порушення ліміту залишку Теллера.'||
               'Можлива сума операції (в грн): '||to_char(v_user_amount,'FM99999999D00')||', сума поточної операції '||to_char(v_sum_uah,'FM99999999D00');
      if p_rec.sw = 1 then
        v_errtxt := v_errtxt ||'(попередження № '||to_char(nvl(v_warn,0)+1)||')';
      end if;
      p_err := v_errtxt;
      if v_warn>=2 or p_rec.sw = 0 then                                -- уже было 2 предупреждения или операция не из единого окна
        p_err := p_err || chr(10)||' Виконання операції заборонено!';
        return -1;                                                                -- блокируем
      else
        -- формируем  информационное сообщение
        if v_warn = 1 then -- уже было одно предупреждение. Потому это надо отправить руководителю
          send_msg2boss('Теллер '||user_name||chr(10)||p_err);
        end if;
        return nvl(v_warn,0)+1;
      end if;
    end if;

    return 0; -- всё ок, продолжаем работу.

  exception
    when others then
      bars_audit.info(v_progname||': '||sqlerrm);
      raise_error(v_progname,sqlerrm);
  end;

  -- функция определения возможности пользователя работать в роли Теллера
  function is_teller (p_user in number default g_user_id)
    return integer
    is
    v_progname varchar2(100) := g_package_name||'.IS_TELLER';
--    v_userid   staff$base.id%type := p_user;
    v_ret integer;
  begin

--raise_error(v_progname, sys_context(bars_context.GLOBAL_CTX, bars_context.CTXPAR_USERNAME));
bars_audit.info('Teller. p_user = '||p_user);
    select count(1)
      into v_ret
      from teller_users t
      where t.user_id = p_user
        and g_bars_dt between t.valid_from and nvl(t.valid_to,g_bars_dt);
    if v_ret >0 then
      return 1;
    else
      return 0;
    end if;
    return 0;
  exception
    when no_data_found then
      raise_error(v_progname,'Не знайдено користувача '||user||' в довіднику теллерів');
    when others then
      raise_error(v_progname, sqlerrm);
  end is_teller;
--

  function is_teller (p_user in varchar2
                     ,p_sbonflag in number default 0)
    return integer
    is
    v_progname varchar2(100) := g_package_name||'.IS_TELLER';
    v_userid   staff$base.id%type;
    v_ret integer;
    v_err varchar2(4000);
  begin
    logger.info('TELLER: p_user = '||p_user||', flag = '||p_sbonflag);
    if p_sbonflag = 1 then
      begin
        select user_id
          into v_userid
          from staff_ad_user sau
          where upper(sau.active_directory_name)  = upper(p_user);
      exception
        when others then
          v_userid := null;
          return 0;
      end;
    else
      select id
        into v_userid
        from staff$base
        where logname = upper(p_user);
    end if;

    logger.info('TELLER: v_user_id = '||v_userid);
    select count(1)
      into v_ret
      from teller_users t
      where t.user_id = v_userid
        and g_bars_dt between t.valid_from and nvl(t.valid_to,g_bars_dt);
    logger.info('TELLER: v_ret = '||v_ret);
    if v_ret >0 then
      return 1;
    else
      return 0;
    end if;
    return 0;
  exception
    when others then
      v_err := substr(sqlerrm,1,4000);
      logger.info('TELLER: error = '||v_err);
      raise_error(v_progname, v_err);
  end is_teller;


/*
  возможность выполнения указанной операции с использованием указанного оборудования для пользователя в роли Теллера
*/
  function is_oper_available (p_op_code  in varchar2
                             ,p_equip_code in number)
    return integer
    is
    v_progname varchar2(30) := g_package_name||'. IS_OPER_AVAILABLE';
    v_ret integer := 0;
    v_err varchar2(2000);
  begin
    select count(1) into v_ret
      from teller_oper_define tod
      where tod.oper_code = p_op_code
        and tod.equip_ref = p_equip_code;
    if v_ret > 0 then
      return 1;
    else
      return 0;
    end if;
    return v_ret;
  exception
    when others then
      v_err := substr(v_progname||'. Помилка при роботі функції: '||sqlerrm,1,2000);
      bars_audit.error(v_err);
      raise_application_error(-20100,v_err);
  end;
--



  /* формирование информационной строки для отображения Теллеру
  */
  function get_teller_info (p_user in varchar2 default user_name)
    return varchar2
    is
    v_ret varchar2(2000);
    v_cnt_in number;
    v_sum_in number;
    v_cnt_out number;
    v_sum_out number;
    v_teller_limit number;
    v_amn          number;
--    v_dt date  := gl.bd;
  begin
    compute_teller_stats(v_cnt_in, v_sum_in, v_cnt_out, v_sum_out);
    v_teller_limit := teller_utils.get_eq_limit();
    v_amn := v_teller_limit-(v_sum_in-v_sum_out);
    select 'Банківська дата                 : '||to_char(g_bars_dt,'dd.mm.yyyy')||', '||'<br/>'||
           'встановлений ліміт              : '||to_char(v_teller_limit,'FM99,999,999.00','nls_numeric_characters = ''.,''')||'грн.,'||'<br/>'||
           'Приймання готівки:'||to_char(v_cnt_in,'FM9999') ||' операцій, сума: '||to_char(v_sum_in,'FM99,999,990.00','nls_numeric_characters = ''.,''')||','||'<br/>'||
           'Видача готівки   : '||to_char(v_cnt_out,'FM9999')||' операцій, сума: '||to_char(v_sum_out,'FM99,999,990.00','nls_numeric_characters = ''.,''')||','||'<br/>'||
           'в т.ч., з перевищенням ліміту '||to_char(t.warnings)||' операцій,'||'<br/>'||
           case sign(v_amn)
             when 1  then 'допустима сума прийняття готівки: '
             when -1 then 'ліміт залишку перевищений на     :'
             else ''
           end ||to_char(abs(v_amn),'FM99,999,999.00')||'грн.'||'<br/>'
--           ||'залишок коштів для виплати      : <br/>'||get_cash_amount()
      into v_ret
      from teller_state t, staff$base s
      where s.logname = p_user
        and t.user_ref = s.id
        and t.work_date = g_bars_dt;

    return v_ret;
  exception
    when no_data_found then
      return 'Не знайдено інформації щодо роботи користувача '||sys_context(bars_context.GLOBAL_CTX, bars_context.CTXPAR_USERNAME)||' в ролі "Теллер"';
    when others then
      return 'При отриманні інформації щодо поточного стану роботи користувача в ролі "Теллер" виникла помилка '||sqlerrm;
  end get_teller_info;

  function get_equipment_info return varchar2
    is
    v_ret varchar2(2000);
    v_atm_amn xmltype;
    v_amn_plat number;
    v_amn_collect number;
    v_amn_tempo varchar2(1000);
    v_id  number;
  begin
    v_id := teller_utils.get_eq_id;
    if teller_utils.get_equip_type() = 'M' then
      v_ret := 'Автоматичне обладнання не підключено';
      return v_ret;
    end if;
    v_ret := teller_soap_api.InventoryOperation;
    if teller_soap_api.get_user_sessionID is null then
      v_ret := 'Не вдалось отримати інформацію про обладнання';
      return v_ret;
    end if;
    select amount
      into v_atm_amn
      from teller_atm_status
      where equip_ip  = g_eq_url
        and work_date = g_bars_dt;
    v_ret := '<b>'||teller_soap_api.get_current_dev_status_desc()||chr(10)||'</b>Залишки: ';
    for cur in (select distinct cur_code
                  from (select cur_code
                          from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                                        'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=4]/Denomination' passing v_atm_amn
                                 columns
                                   cur_code varchar2(3) path '@n:cc',
                                   pieces   number      path 'n:Piece')
                          where pieces >0
                        union
                        select cur_code
                          from teller_atm_units u,
                               xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                      'http://www.glory.co.jp/gsr.xsd' as "n"),
                                        'soapenv:Envelope/soapenv:Body/n:InventoryResponse/CashUnits/CashUnit[@n:unitno=$i]/Denomination' passing v_atm_amn, u.unitno as "i"
                                  columns
                                  cur_code varchar2(3) path '@n:cc')
                           where u.equip_id = v_id )
                                  )
    loop

--      for r in (
                select /*t.cur_code, */sum(t.nominal * nvl(t.pieces,0)) amn
                  into v_amn_plat
                  from xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                              'http://www.glory.co.jp/gsr.xsd' as "n"),
                               'soapenv:Envelope/soapenv:Body/n:InventoryResponse/Cash[@n:type=4]/Denomination[@n:cc=$i]' passing v_atm_amn, cur.cur_code as "i"
                               columns
                                 cur_code varchar2(3) path '@n:cc',
                                 nominal  number      path '@n:fv',
                                 pieces   number      path 'n:Piece') t;
                  /*group by cur_code)*/
--      loop

  /*
          <CashUnit n:unitno="4059" n:st="1" n:nf="1800" n:ne="200" n:max="2000">
  */


        select sum(t1.nominal * nvl(t1.pieces,0))
          into v_amn_collect
          from teller_atm_units u,
               xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                            'http://www.glory.co.jp/gsr.xsd' as "n"),
                             'soapenv:Envelope/soapenv:Body/n:InventoryResponse/CashUnits/CashUnit[@n:unitno=$i]/Denomination[@n:cc=$c]' passing v_atm_amn, u.unitno as "i", cur.cur_code as "c"
                             columns
                               cur_code varchar2(3) path '@n:cc',
                               nominal  number      path '@n:fv',
                               pieces   number      path 'n:Piece',
                               rev      number      path '@n:rev') t1
          where u.equip_id = v_id;
--            and t1.cur_code = r.cur_code;
        if v_amn_plat + nvl(v_amn_collect,0) >0 then
          v_ret := v_ret||'<br/><b>АТМ</b>:<br/>Валюта '||cur.cur_code||', сума: ДОСТУПНІ - '||to_char(nvl(v_amn_plat,0),'FM9999999D99');
          if v_amn_collect != 0 then
            v_ret := v_ret ||'(ЗНОШЕНІ - '||to_char(v_amn_collect)||')';
          end if;
        end if;
--      end loop;
    end loop; --currency

    select listagg(teller_utils.get_cur_name(ts.cur_code)||':'||ts.non_atm_amount,'<br/>') within group (order by cur_code)
      into v_amn_tempo
      from v_teller_state ts
      where ts.user_ref = g_user_id
        and nvl(ts.non_atm_amount,0) != 0;
    v_ret:=v_ret||'<br/><b>Темпокасса</b>: <br/>'||v_amn_tempo;
    return v_ret;
  exception
    when no_data_found then
      v_id := teller_soap_api.StatusOperation();
      v_ret := get_equipment_info();
      return v_ret;
    when others then
      v_ret := 'Не вдалось отримати інформацію щодо стану обладнання. <br/>Помилка: '||sqlerrm;
      bars_audit.info(v_ret);
      return v_ret;
  end get_equipment_info;

  function get_teller
    return integer
    is
    v_progname varchar2(100):=g_package_name||'. GET_TELLER_STATE';
  begin

--bars_audit.info('g_user_id = '||g_user_id||chr(10)||dbms_utility.format_call_stack());
  for r in (select * from teller_state where user_ref = g_user_id and work_date = g_bars_dt and status = 'A'
    )
  loop
    return 1;

  end loop;
  return 0;
  exception
    when no_data_found then
      return 0;
    when others then
      raise_error(v_progname, sqlerrm);
  end;
--

  procedure set_teller (p_switch integer)
    is
    v_progname varchar2(100) := g_package_name||'.SET_TELLER';
    v_userid staff$base.id%type := g_user_id;
    v_err varchar2(2000);
    v_sta varchar2(1);
    v_new_sta varchar2(1);
    v_num number;
  begin
    -- проверка на наличие параметров для текущего пользователя
    begin
      select count(1) into v_num
        from teller_users tu
        where tu.user_id = g_user_id;
      if v_num = 0 then
        raise_application_error(-20100,'Користувач '||user_name||' не внесений до довідника теллерів!');
      end if;

      select count(1) into v_num
        from teller_stations ts
        where ts.station_name = g_ws_name;
      if v_num = 0 then
        raise_application_error(-20100,'Для користувача '||user_name||' не налаштовано довідник "Робоча станція - тип техніки"! (Робоча станція :'||g_ws_name||')');
      end if;
    end;

    /* надо выполнить проверку на корректность окончания дня в предыдущей дате.
       признак того, что Теллер не закончил работу в предыдущий день - невостановленные права.
       Потому надо в teller_tt_history дату для записей с типом "Т" поменять на текущую
    */
/*    if p_switch = 1 then
      for r in (select distinct th.work_date
                  from teller_tt_history th
                  where th.g_user_id = g_user_id
                    and th.action = 'T'
                    and th.work_date < g_bars_dt)
      loop
--        restore_tts(g_user_id, r.work_date);

      end loop;
    elsif p_switch = 0 then
      null;
    end if;*/


    begin
      select status
        into v_sta
        from teller_state
        where user_ref = g_user_id
          and work_date = g_bars_dt;
    exception
      when no_data_found then
        v_sta := null;
    end;

    if teller_tools.is_teller() = 0 then
      v_err := v_progname||'. Спроба включити/виключити роль "Теллер" для користувача, якого немає в довіднику теллерів';
      bars_audit.error(v_err);
      raise_application_error(-20100, v_err);
    end if;

    if v_sta = 'A' and p_switch = 1 then  -- пользователь с активной ролью Теллера и ему эту роль хотят включить
      v_err := v_progname||'. Користувач '||g_ws_name||' вже працює з роллю "Теллер" в банківській даті '||g_bars_dt;
--      role_switch(1);
      v_new_sta := v_sta;
      bars_audit.info(v_err);
      teller_utils.set_context;
    elsif v_sta = 'A' and p_switch = 0then  -- пользователь с активной ролью Теллера и её хотят выключить
      update teller_state
        set status = 'C'
        where user_ref = v_userid
          and work_date = g_bars_dt;
      v_new_sta := 'C';
      teller_utils.clear_context;
--      role_switch(0);
    elsif v_sta = 'C' and p_switch = 1 then  -- пользователь с "закрытой на сегодня" ролью Теллера и ее хотят включить
      v_err := 'УВАГА Можливість повторної активації теллера в банківському дні '||to_char(g_bars_dt,'dd.mm.yyyy')||' заборонена!';
--      v_err := v_progname||'. Спроба включити роль Теллера користувачу, який вже припинив працювати з цією роллю в банкіській даті '||to_char(g_bars_dt,'dd.mm.yyyy');
      bars_audit.info(v_err);
      raise_application_error(-20100,v_err);
      update teller_state
        set status = 'A',
            EQ_IP  = g_eq_url
        where user_ref = v_userid
          and work_date = gl.bd;
      teller_utils.set_context;
--      role_switch(1);
      v_new_sta := 'A';
    elsif v_sta = 'C' and p_switch = 0 then -- пользователь с "закрытой на сегодня" ролью Теллера и ее хотят выключить
      v_err := v_progname||'. Спроба виключити роль Теллера користувачу, який вже припинив працювати з цією роллю в банкіській даті '||to_char(g_bars_dt,'dd.mm.yyyy');
--      role_switch(0);
      teller_utils.clear_context;
      bars_audit.info(v_err);
      v_new_sta := 'C';
    elsif v_sta is null and p_switch = 1 then  -- пользователь не работал с ролью Теллера сегодня и её хотят включить
--bars_audit.info('TELLER. '||sys_context('userenv','host'));
      insert into teller_state (user_ref,
                                work_date,
                                max_limit,
                                current_amount,
                                oper_count,
                                warnings,
                                status)
      select v_userid, g_bars_dt, ted.equip_limit, 0,0,0,'A'
        from teller_stations ts, teller_equipment_dict ted
        where ts.station_name = g_ws_name
          and ts.equip_ref = ted.equip_code;
--      role_switch(1);
      teller_utils.set_context;


      select status into v_new_sta
        from teller_state
        where user_ref = v_userid
          and work_date = g_bars_dt;
    elsif v_sta is null and p_switch = 0 then  -- пользователь не работал с ролью Теллера сегодня и её хотят выключить
      v_err := v_progname||'. Спроба виключити роль "Теллер" для користувача['||g_user_id||'.'||user_name||'], який з цією роллю в банківській даті '||to_char(g_bars_dt,'dd.mm.yyyy')||' не працював';
      bars_audit.info(v_err);
      v_new_sta := null;
      teller_utils.clear_context;
    end if;

    if v_sta = 'A' and p_switch = 0 and v_new_sta != 'C' then
      raise_error(v_progname,'Не вдалося відключити роль "Теллер" для користувача '||user_name);
    elsif nvl(v_sta,'C') = 'C' and p_switch = 1 and v_new_sta != 'A' then
      raise_error(v_progname,'Не вдалося підключити роль "Теллер" для користувача '||user_name);
    end if;

    if v_sta != v_new_sta then
       null;
--       bars_login.clear_session(bars_login.get_session_clientid());
    end if;

  exception
    when others then
      raise_error(v_progname, sqlerrm);
  end set_teller;
--
  procedure set_teller (p_user in varchar2, p_switch in boolean)
    is
    v_progname varchar2(100) := g_package_name||'.SET_TELLER';
    v_sta      varchar2(1);
    v_userid   staff$base.id%type;
    v_err      varchar2(2000);
  begin

    /* надо выполнить проверку на корректность окончания дня в предыдущей дате.
       признак того, что Теллер не закончил работу в предыдущий день - невостановленные права.
       Потому надо в teller_tt_history дату для записей с типом "Т" поменять на текущую
    */
    update teller_tt_history th
      set th.work_date = g_bars_dt
      where th.user_id = g_user_id
        and th.work_date < g_bars_dt
        and th.action = 'T';

    select id, (select status from teller_state where user_ref = s.id and work_date = g_bars_dt)
      into v_userid, v_sta
      from staff$base s
      where s.logname = upper(p_user);


    if teller_tools.is_teller(p_user) = 0 then
      v_err := v_progname||'. Спроба включити/виключити роль "Теллер" для користувача, якого немає в довіднику теллерів';
      bars_audit.error(v_err);
      raise_application_error(-20100, v_err);
    end if;

    if v_sta = 'A' and p_switch then  -- пользователь с активной ролью Теллера и ему эту роль хотят включить
      v_err := v_progname||'. Користувач '||p_user||' вже працює з роллю "Теллер" в банківській даті '||g_bars_dt;
      bars_audit.info(v_err);
    elsif v_sta = 'A' and not p_switch then  -- пользователь с активной ролью Теллера и её хотят выключить
      update teller_state
        set status = 'C'
        where user_ref = v_userid
          and work_date = g_bars_dt;
    elsif v_sta = 'C' and p_switch then  -- пользователь с "закрытой на сегодня" ролью Теллера и ее хотят включить
      v_err := 'УВАГА Можливість повторної активації теллера в банківському дні '||to_char(g_bars_dt,'dd.mm.yyyy')||' заборонена!';
      bars_audit.info(v_progname||'.'||v_err);
      raise_application_error(-20100,v_err);
/*      update teller_state
        set status = 'A'
        where user_ref = v_userid
          and work_date = g_bars_dt;*/
    elsif v_sta = 'C' and not p_switch then -- пользователь с "закрытой на сегодня" ролью Теллера и ее хотят выключить
      v_err := v_progname||'. Спроба виключити роль Теллера користувачу, який вже припинив працювати з цією роллю в банкіській даті '||to_char(g_bars_dt,'dd.mm.yyyy');
      bars_audit.info(v_err);
    elsif v_sta is null and p_switch then  -- пользователь не работал с ролью Теллера сегодня и её хотят включить
      insert into teller_state (user_ref,
                                work_date,
                                max_limit,
                                current_amount,
                                oper_count,
                                warnings,
                                status,
                                eq_type,
                                user_ip,
                                eq_ip,
                                branch)
      select v_userid, g_bars_dt, ted.equip_limit, 0,0,0,'A',ted.equip_type,ts.station_name,ts.url,bc.current_branch_code
        from teller_stations ts, teller_equipment_dict ted
        where ts.station_name = g_ws_name
          and ts.equip_ref = ted.equip_code;
    elsif v_sta is null and not p_switch then  -- пользователь не работал с ролью Теллера сегодня и её хотят выключить
      v_err := v_progname||'. Спроба виключити роль "Теллер" для користувача, який з цією роллю в банківській даті '||to_char(g_bars_dt,'dd.mm.yyyy')||' не працював';
      bars_audit.info(v_err);
    end if;

/*    merge into teller_state ts
      using (select gl.bDATE u_dt , v_userid u_usr,  ted.equip_limit u_lim
               from teller_users tu, teller_stations st, teller_equipment_dict ted
               where tu.g_user_id = v_userid
                 and sys_context('userenv','HOST') = st.station_name
                 and ted.equip_code = st.equip_ref) u
      on (ts.user_ref = u.u_usr and ts.work_date = u.u_dt)
      when matched then
        update set max_limit = u.u_lim,
                   current_amount = 0,
                   oper_count = 0,
                   warnings = 0,
                   status = 'C'
      when not matched then
        insert (user_ref, work_date, max_limit, current_amount, oper_count, warnings,status)
        values (u.u_usr, u.u_dt, u.u_lim, 0,0,0,'A');*/
--dbms_output.put_line('merge result : '||sql%rowcount||' rows inserted/updated');
--    end if;
  exception
    when others then
      raise_error(v_progname, sqlerrm);
  end set_teller; -- with param "user"


  procedure revoke_teller
    is
    v_progname varchar2(100) := g_package_name||'. REVOKE_TELLER';
    v_userid   staff$base.id%type;
  begin
    select id
      into v_userid
      from staff$base
      where logname = sys_context(bars_context.GLOBAL_CTX, bars_context.CTXPAR_USERNAME);
    update teller_state ts
      set ts.status = 'C'
      where ts.user_ref = v_userid
        and ts.work_date = g_bars_dt;
  exception
    when others then
      raise_error(v_progname, sqlerrm);
  end;
--

  function  write_oper (p_op_code       in varchar2
                       ,p_op_curr       in number
                       ,p_op_amount     in number
                       ,p_op_amount_uah in number
                       ,p_doc_ref       in number default null
                       ,p_sw            in number default 0
                       )
    return number
    is
    v_progname varchar2(30):= g_package_name||'. WRITE_OPER';
    v_err varchar2(2000);
    v_num number;
    v_rec t_record;
    v_ret number;
    v_op_type varchar2(4) := case
                               when p_doc_ref is not null then get_type_operation(p_doc_ref => p_doc_ref)
                               else get_type_operation(p_op_code => p_op_code)
                             end;
  begin
    for r in (select id from teller_opers
                where doc_ref = p_doc_ref)
    loop
      return r.id;
    end loop;

    -- проверяем наличие пользователя в справочнике теллеров для выбранного бранча
    select count(1) into v_num
      from teller_users tu, teller_stations ts
      where tu.user_id = g_user_id
        and ts.station_name = g_ws_name;
--        and tu.branch = sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_SELECTED_BRANCH)


    if v_num = 0 then
      v_err := 'Відсутній опис для користувача [id = '||g_user_id||', бранч = '||bars_context.CTXPAR_SELECTED_BRANCH||'] в довіднику "Теллери"';
      bars_audit.info(v_err);
      raise_error(v_progname, v_err);
    end if;


    select count(1) into v_num
      from teller_oper_define
      where oper_code = p_op_code
        and equip_ref = teller_utils.get_eq_id;
    if v_num = 0 and p_op_code != 'TOX' then
      v_err := 'Операція з кодом '||p_op_code||' відсутня в переліку операцій Теллера';
      bars_audit.info(v_err);
      raise_error(v_progname, v_err);

    end if;

    -- проверяем включенность роли теллера для пользователя
/*    if nvl(sys_context(bars_context.CONTEXT_CTX,'TELLER_STATE'),0) = 0 then
      v_err := 'Поточний стан теллера - відключений. Виконання операції неможливе';
dbms_output.put_line('2.'||v_err);
      raise_error(v_progname, v_err);
    end if;
*/

    v_rec.tt       := p_op_code;
    v_rec.cur      := p_op_curr;
    v_rec.sum_cur  := p_op_amount;
    if p_op_curr = 980 then
      v_rec.sum_uah := p_op_amount;
    else
      v_rec.sum_uah  := p_op_amount_uah;
    end if;
    v_rec.sw       := p_sw;
    v_num := check_lim_operation(v_rec, 1, v_err);
    logger.info('Teller vnum = '||v_num);
    if v_num >= 0 then

logger.info('Teller.write_oper. p_op_code = '||p_op_code||', v_op_type = '||v_op_type||', teller_utils.get_equip_type() = '||teller_utils.get_equip_type());
      case teller_utils.get_equip_type()
        when 'A' then

          case v_op_type
            when 'IN' then
              v_rec.status   := 'I0';
            when 'ALL' then
              v_rec.status   := 'I0';
            when 'OUT' then
              v_rec.status   := 'O0';
            when 'NONE' then
              v_rec.status   := 'OK';
            else
              v_rec.status   := 'IN';
            end case;
        when 'M' then
          v_rec.status   := 'OK';
          for r in (select case d.dk
                             when 0 then 'IN'
                             when 1 then 'OUT'
                             else 'NONE'
                           end doc_type
                         , d.sq
                      from opldok d, accounts a
                      where d.ref = p_doc_ref
                        and d.acc = a.acc
                        and a.nls like '100%')
          loop
            save_cash_oper(p_doc_ref, r.doc_type,p_op_curr,0,r.sq/100,r.sq/100);
          end loop;
        else
          v_rec.status   := 'IN';
      end case;

      insert into teller_opers (user_ref,
                                oper_ref,
                                exec_time,
                                cur_code,
                                amount,
                                amount_uah,
                                state,
                                doc_ref,
                                is_warning)
      values (g_user_id,
              v_rec.tt,
              sysdate,
              v_rec.cur,
              v_rec.sum_cur,
              v_rec.sum_uah,
              v_rec.status,
              p_doc_ref,
              v_num)
      returning id into v_ret;
      if get_type_operation(v_rec.tt) != 'NONE' then
        ins_cash_opers(v_ret,case g_eq_type when 'M' then v_rec.sum_cur else 0 end,0);
--        save_cash_oper(v_ret, get_type_operation(p_doc_ref), v_rec.cur, 0, v_rec.sum_cur);

      end if;
      update teller_state ts
        set ts.current_amount = nvl(ts.current_amount,0) + v_rec.sum_uah,
            ts.oper_count = nvl(ts.oper_count,0) + 1
        where ts.user_ref = g_user_id
          and ts.work_date = g_bars_dt;
    else
      raise_application_error(-20100,'Операція призведе до порушення ліміту Теллера: '||v_err);
    end if;
    return v_ret;
  exception
    when others then
--dbms_output.put_line('3.'||v_err);
      if sqlcode = -20100 then
        raise_application_error(-20100,sqlerrm);
      else
        raise_error(v_progname, sqlerrm);
      end if;
  end write_oper;


  procedure send_message (p_receiver in varchar2,
                          p_msg      in varchar2)
    is
  begin
    null;
  end send_message;




function get_teller (p_user in varchar2)
    return integer
    is
    v_progname varchar2(100):=g_package_name||'. GET_TELLER_STATE';
  begin
/*    select t.max_limit-t.current_amount,
           'Дата: '||to_char(g_bars_dt,'dd.mm.yyyy')||', '||chr(10)||
           'встановлений ліміт: '||to_char(t.max_limit,'FM99,999,999.00','nls_numeric_characters = ''.,''')||'грн.,'||chr(10)||
           'зроблено '||to_char(t.oper_count,'9999')||'операцій на загальну суму: '||to_char(t.current_amount,'FM99,999,999.00','nls_numeric_characters = ''.,''')||','||chr(10)||
           'в т.ч., з перевищенням ліміту '||to_char(t.warnings)
           ,s.id
           ,case
              when t.status = 'A' then 1
              when t.status = 'C' then -1
              else 0
            end

      into v_num,
           v_err,
           v_userid,
           v_ret
      from teller_state t, staff$base s
      where s.logname = upper(p_user)
        and t.user_ref = s.id
        and t.work_date = g_bars_dt;
   if v_ret = 1 then return 1;
   else return 0;
   end if;
   return 0;
  exception
    when no_data_found then
      return 0;
--      raise_error(v_progname, 'Не знайдено інформацію щодо роботи користувача [userid = '||p_userid||'] в ролі "Теллер" в банкіській даті '||to_char(g_bars_dt,'dd.mm.yyyy'));
    when others then
      raise_error(v_progname, sqlerrm);*/
    for r in (select 1
                from teller_state ts
                where user_ref = g_user_id
                  and work_date = g_bars_dt
                  and status = 'A'
      )
    loop
      return 1;

    end loop;
    return 0;
    exception
      when no_data_found then
        return 0;
      when others then
        raise_error(v_progname, sqlerrm);

  end;


function get_teller (p_user in number)
    return integer
    is
    v_progname varchar2(100):=g_package_name||'. GET_TELLER_STATE';
    v_ret number;
  begin


    select count(1)
      into v_ret
      from teller_state t
      where t.user_ref = p_user
        and t.work_date = g_bars_dt
        and t.status = 'A';
   if v_ret > 0 then return 1;
   else return 0;
   end if;
   return 0;
  exception
    when no_data_found then
      return 0;
--      raise_error(v_progname, 'Не знайдено інформацію щодо роботи користувача [userid = '||p_userid||'] в ролі "Теллер" в банкіській даті '||to_char(g_bars_dt,'dd.mm.yyyy'));
    when others then
      raise_error(v_progname, sqlerrm);
  end;


  procedure send_notification (p_receiver in varchar2)
    is
  begin
    for r in (select * from v$session v
                where v.USERNAME = user_name)
    loop
      null;
    end loop;
  end;

  function get_boss
    return varchar2_list
    is
    v_ret varchar2_list;
  begin
    return v_ret;
  end;

  /*
  сохраняем операции, которые были у пользователя до включения роли теллера
  */
  procedure save_tts (p_userid in number := g_user_id)
    is
  begin
      -- удаляем из истории сохранения всё, что сохраняли по этому пользователю
      delete from teller_tt_history tth
        where tth.tt_rec.id = p_userid
          and tth.work_date = g_bars_dt
          and tth.action = 'T';

      -- добавляем в историю сохранения все операции, которые будем потом отбирать у пользователя
      insert into teller_tt_history (user_id,
                                     work_date,
                                     action,
                                     tt_rec)
        select g_user_id,
                g_bars_dt,
                'T',
                t_staff_tts(tt      => st.tt,
                            id      => st.id,
                            approve => st.approve,
                            adate1  => st.adate1,
                            adate2  => st.adate2,
                            rdate1  => st.rdate1,
                            rdate2  => st.rdate2,
                            revoked => st.revoked,
                            grantor => st.grantor)
         from staff_tts st
          where st.id = p_userid
/*            and st.approve = 1
            and st.revoked = 0*/;

  end save_tts;

  /*
    пользователю устанавливаются в "допустимые" только те операции, которые описаны
    в справочнике операций теллера и по которым совпадает тип оборудования с тем, которое привязано
    к рабочему месту пользователя
  */
  procedure set_teller_tts (p_userid number := g_user_id)
    is
  begin
    if p_userid in (1,2009401) then
      return;
    end if;
    -- убираем из списка допустимых операции, которые были на момент включения роли теллера
    delete from staff_tts st
      where st.id = p_userid
/*        and st.approve = 1
        and st.revoked = 0*/;


    -- добавляем операции, которые допустимы для теллера
    insert into staff_tts (tt,
                           id,
                           approve,
                           adate1,
                           adate2,
                           rdate1,
                           rdate2,
                           revoked,
                           grantor)
      select distinct tod.oper_code, p_userid, 1, null, null, null, null, 0, 1
        from teller_oper_define tod, teller_stations ts, tts t
        where ts.station_name = g_ws_name
          and ts.equip_ref = tod.equip_ref
          and tod.oper_code = t.tt;

      -- убираем из истории сохраненных все операции, которые мы раньше выдавали этому пользователю в роли теллера
      delete from teller_tt_history tth where tth.tt_rec.id = p_userid and work_date = g_bars_dt and action = 'R';

      -- сохраняем в историю операции, которые пользователь получил в роли теллера (м.б. потом пригодится)
      insert into teller_tt_history (user_id,
                                     work_date,
                                     action,
                                     tt_rec)
        select g_user_id,
                g_bars_dt,
                'R',
                t_staff_tts(tt      => st.tt,
                            id      => st.id,
                            approve => st.approve,
                            adate1  => st.adate1,
                            adate2  => st.adate2,
                            rdate1  => st.rdate1,
                            rdate2  => st.rdate2,
                            revoked => st.revoked,
                            grantor => st.grantor)
         from staff_tts st
          where st.id = p_userid
/*            and st.approve = 1
            and st.revoked = 0*/;
  end set_teller_tts;

/*
 восстановление списка операция для пользователя при отключении роли теллера
*/
  procedure restore_tts (p_userid in number default g_user_id
                        ,p_dt     in date   default g_bars_dt)
    is
  begin
    -- убираем все операции из списка
    delete from staff_tts st
    where st.id = p_userid;
    -- добавляем те операции, которые были у пользователя до включения роли теллера
    insert into staff_tts (tt,
                           id,
                           approve,
                           adate1,
                           adate2,
                           rdate1,
                           rdate2,
                           revoked,
                           grantor)
    select tth.tt_rec.tt,
           tth.tt_rec.id,
           tth.tt_rec.approve,
           tth.tt_rec.adate1,
           tth.tt_rec.adate2,
           tth.tt_rec.rdate1,
           tth.tt_rec.rdate2,
           tth.tt_rec.revoked,
           tth.tt_rec.grantor
      from teller_tt_history tth
      where tth.tt_rec.id = p_userid
        and tth.work_date = p_dt
        and tth.action = 'T';

    -- очищаем таблицу сохраненных операций по исполнителю
    delete from teller_tt_history tth
      where tth.tt_rec.id = tth.tt_rec.id
        and tth.work_date = p_dt
        and tth.action = 'T';


  end restore_tts;

  procedure role_switch (p_flag in number
                        ,p_userid in number := g_user_id)
    is
    v_progname constant varchar2(100) := g_package_name || '.ROLE_SWITCH';
    v_num number;
  begin
    return;
    if   (p_flag = 1 and get_teller(p_userid) = 0) -- что-то пошло не так - запрос на переключение, хотя Теллер сейчас не активен
      or (p_flag = 0 and get_teller(p_userid) = 1) -- или запрос на отключение для активного Теллера
    then
      bars_audit.info(v_progname||'. Попытка переключить роли для Теллера не совпадает с текущим состоянием теллера');
      return;
    end if;

    select count(1) into v_num
      from teller_tt_history tth
      where tth.user_id = p_userid
        and tth.action = 'T';
    if p_flag = 1 then -- включение роли теллера
      /* надо подумать, есть ли необходимость сейчас это делать.
         для этого надо пройтись по сохраненным ролям. Если там лежат роли в статусе "T" (typical),
         то переключать не надо - по идее, пользователю уже включены операции теллера
      */
      if v_num = 0 then -- не нашлось в истории ничего, значит, надо сохранить установленные операции и включить операции теллера
        save_tts;
        set_teller_tts;
      end if;
    elsif p_flag = 0 then
      if v_num > 0 then  -- есть сохраненные базовые операции, надо их вернуть.
        restore_tts;
      end if;
    end if;
  end;


  function validate_teller_operation (p_op_code  in varchar2
                                     ,p_op_cur   in varchar2
                                     ,p_op_sum   in number
                                     ,p_sw       in number
                                     ,p_errtxt   out varchar2)
    return number
    is
    v_record  t_record;
    v_num     number;
    v_cur     number;
  begin
    begin
      select tv.kv
        into v_cur
        from tabval tv
        where tv.lcv = p_op_cur or to_char(tv.kv) = p_op_cur;
    end;
    v_record.sum_cur := p_op_sum/100;
    v_record.sum_uah := case v_cur
                          when 980 then p_op_sum/100
                          else round(rato(v_cur,g_bars_dt) * p_op_sum/100,2)
                        end;
    v_record.tt      := p_op_code;
    v_record.cur     := v_cur;
    v_record.sw      := p_sw;

--bars_audit.info('TELLER. tt = '||p_op_code||', cur = '||p_op_cur||', sum '||p_op_sum||', sw = '||p_sw);

    v_num := check_lim_operation(v_record, 1, p_errtxt);
    bars_audit.info('TELLER. Проверка операции '||p_op_code||', вал.'||p_op_cur||', сумма '||p_op_sum/100||', sw = '||p_sw||'. Результат = '||v_num);
    if v_num != 0 then
      bars_audit.info('TELLER. '||p_errtxt);
    end if;
    return v_num;
  end validate_teller_operation;
--

  function is_cash_operation (p_op_code in varchar2)
    return number
    is
    v_progname constant varchar2(100) := g_package_name || '.IS_CASH_OPERATION';
    v_ret number;
  begin
    select count(1)
      into v_ret
      from teller_oper_define tod
      where tod.oper_code = p_op_code
        and nvl(tod.need_req,'NONE') != 'NONE';
    if v_ret>0 then
      return 1;
    end if;
    return 0;
  end is_cash_operation;
--
  function get_type_operation (p_op_code in varchar2)
    return varchar2
    is
    v_progname constant varchar2(100) := g_package_name || '.GET_TYPE_OPERATION';
  begin
    for r in (select * from teller_oper_define where oper_code = p_op_code)
    loop
      return r.need_req;
    end loop;
    return 'NONE';
  end get_type_operation;
--

--
  function get_type_operation (p_doc_ref in number)
    return varchar2
    is
    v_progname constant varchar2(100) := g_package_name || '.GET_TYPE_OPERATION';
    v_ret number := 0;
    v_in_flag   number := 0;
    v_out_flag  number := 0;
    v_flag integer := -1;
  begin
logger.info('teller doc_ref = '||p_doc_ref);
    for r in (select 1
                from teller_opers op
                where abs(doc_ref) = abs(p_doc_ref)
                  and oper_ref = 'SBN'
                  and op.user_ref = g_user_id)
    loop
      return 'IN';
    end loop;
    for op in (select dk, nlsa, nlsb from oper where ref = p_doc_ref)
    loop
logger.info('dk = '||op.dk||', nlsa = '||op.nlsa||', nlsb = '||op.nlsb);
      if (op.dk = 0 and op.nlsb like '100%')
         or
         (op.dk = 1 and op.nlsa like '100%') then
        v_in_flag := 1;
      elsif (op.dk = 1 and op.nlsb like '100%')
            or
            (op.dk = 0 and op.nlsa like '100%') then
        v_out_flag := 1;
      end if;
      v_flag := 1;
    end loop;
logger.info('teller step1. v_in_flag= '||v_in_flag||', v_out_flag = '||v_out_flag);
    if v_flag = -1 then
      return null;
    end if;
    for r in (select d.dk, a.nls
                from opldok d, accounts a
                where d.ref = p_doc_ref
                  and d.acc = a.acc)
    loop
      if r.dk = 0 and r.nls like '100%' then -- приход кассы
        v_in_flag := 1;
      elsif r.dk = 1 and r.nls like '100%' then -- выдача кассы
        v_out_flag := 1;
      end if;
    end loop;
    if (v_in_flag = 1 and v_out_flag = 0) or p_doc_ref < 0 then -- только приход
      return 'IN';
    elsif (v_in_flag = 0 and v_out_flag = 1) then
      return 'OUT';
    elsif (v_in_flag = 1 and v_out_flag = 1) then
      return 'ALL';
    else
      return 'NONE';
    end if;

    for r in (select tod.need_req
                from teller_oper_define tod, oper o
                where o.ref = p_doc_ref
                  and tod.oper_code = o.tt
              union
              select tod.need_req
              from teller_oper_define tod
              where p_doc_ref < 0
                and tod.oper_code = 'SBN')
    loop
      return r.need_req;
    end loop;
    return 'NONE';
  end get_type_operation;
--

  function is_button_visible (p_op_code in varchar2 default null)
    return number
    is
    v_progname varchar2(100) := g_package_name|| '.IS_BUTTON_VISIBLE';
    v_ret      number;
  begin
    if get_teller() = 1 and (p_op_code is null or is_cash_operation(p_op_code) = 1) and teller_utils.get_equip_type = 'A' then
      if check_atm = 1 then
        return -1;
      else
        return 1;
      end if;
    end if;
    return 0;
  end;



  --

  function refresh_device_status
    return varchar2
    is
    v_ret varchar2(2000);
  begin
    v_ret := 'Обновлённая информация об устройстве после нажатия на специальную кнопочку'||chr(10)||
             'текущее состояние устройства: ВРОДЕ_РАБОТАЕТ'||chr(10)||
             'текущее действие            : СЧИТАЕТ ДЕНЮШКУ';
    return v_ret;
  end refresh_device_status;

  function registry_sbon_operation (p_user      in varchar2
                                   ,p_user_ip   in varchar2 default null
                                   ,p_op_code   in varchar2
                                   ,p_op_amount in number
                                   ,p_errtxt    out varchar2)
    return number
    is
    v_ret number;
    v_user number;
    v_num number;
    v_sql varchar2(2000);
  begin
--    p_errtxt  := 'Возвращаю что-то';
--    return 0;
    if length(p_op_code)>3 then
      p_errtxt := 'Код операции - больше 3х символов';
      return 0;
    end if;
    logger.info('Tel: '||p_user_ip);
    if p_user_ip is not null then
      g_ws_name := p_user_ip;
    end if;

    begin
      select user_id
        into v_user
        from staff_ad_user ad
        where upper(ad.active_directory_name)  = upper(p_user);
      bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                            p_userid    => v_user,
                            p_hostname  => nvl(p_user_ip,g_ws_name),
                            p_appname   => 'SBON');
    exception when others then null;
    end;

    logger.info('Теллер.СБОН. p_user = '||p_user||', p_user_ip = '||p_user_ip||', v_user = '||v_user);
    if is_teller(v_user) = 0 then
      p_errtxt := 'Користувач не є Теллером. Реєстрація операції не виконується!';
      return 0;
    else
      select count(1)
        into v_num
        from teller_state ts
        where ts.user_ref = v_user
          and ts.work_date = gl.bDATE
          and ts.status = 'A';
     if v_num = 0 then
       p_errtxt := 'Роль "Теллер" в банківському дні '||to_char(g_bars_dt,'dd.mm.yyyy')||' не активована. Реєстрація проведення неможлива!';
       return 0;
     end if;
    end if;
    v_ret := validate_teller_operation(p_op_code => p_op_code,
                                       p_op_cur  => 'UAH',
                                       p_op_sum  => p_op_amount*100,
                                       p_sw      => 0,
                                       p_errtxt  => p_errtxt);
    if v_ret != 0 then
      return 0;
    end if;
    v_ret := write_oper(p_op_code       => p_op_code,
                        p_op_curr       => 980,
                        p_op_amount     => p_op_amount,
                        p_op_amount_uah => p_op_amount);
    insert into teller_cash_opers (doc_ref,
                                   op_type,
                                   cur_code,
                                   atm_amount,
                                   non_atm_amount,
                                   oper_amount,
                                   last_dt,
                                   last_user)
      values(v_ret,'IN',980,0,0,p_op_amount,sysdate,g_user_id);
    update teller_opers
      set doc_ref = 0-v_ret
         ,state = 'S0'
      where id = v_ret;
    teller_utils.set_active_oper(0-v_ret);
/*    v_num := update_oper(p_id     => v_ret,
                         p_action => 'CONFIRM',
                         p_errtxt => p_errtxt);*/
    return nvl(v_ret,0);
  exception
    when others then
      p_errtxt := sqlerrm;
      return 0;
  end registry_sbon_operation;

  function update_oper (p_id in number
                       ,p_user_ip   in varchar2 default null
                       ,p_action in varchar2
                       ,p_errtxt out varchar2)
    return number
    is
    v_status varchar2(2);
  begin
    select state
      into v_status
      from teller_opers
      where id = p_id;

    if p_action in ('APPROVE','CONFIRM') then
      if v_status = 'RJ' then
        p_errtxt := 'Операція СБОН+ (id = '||p_id||') знаходиться в статусі відмінена.  Підтвердження неможливе!';
        return 0;
      elsif v_status = 'OK' then
        p_errtxt := 'Операція СБОН+ (id = '||p_id||') вже підтверджена!';
        return 0;
      elsif v_status != 'S0' then
        p_errtxt := 'Операція СБОН+ (id = '||p_id||') знаходиться в процесі обробки Теллером.';
        return 0;
      end if;
      update teller_opers op
        set op.state = case teller_utils.get_equip_type
                         when 'A' then 'I0'
                         else 'OK'
                       end
        where id = p_id;
--      logger.info(
    elsif p_action = 'REJECT' then
      if teller_utils.get_equip_type = 'A' then
        update teller_opers op
          set op.state = 'RO'
          where id = p_id;
        p_errtxt := 'Статус операції змінений на відмінена. Виконайте необхідні дії з АТМ';
      else
        update teller_opers
          set state = 'RJ'
          where id = p_id;
        p_errtxt := 'Операція СБОН+ відмінена';
      end if;
    end if;
    return 1;
  exception when no_data_found then
    p_errtxt := 'Не знайдено операцію СБОН з ID = '||p_id;
    return 0;
  end update_oper;

  function is_coins_need (p_amount in number)
    return number
    is
    v_ret number;
  begin
    if (p_amount/g_min_banknote - round(p_amount/g_min_banknote)) = 0 then
      return 0;
    else
      return 1;
    end if;
    return 0;
  end is_coins_need;

  function store_request (p_docref in number, p_errtxt out varchar2)
    return number
    is
    v_ret number;
  begin
    p_errtxt := 'Всё ОК. Положите еще денюшку в устройство!';
    return 1;
  end store_request;

  function end_request (p_docref         in number
                       ,p_atm_amount     in number
                       ,p_non_atm_amount in number
                       ,p_errtxt         out varchar2)
    return number
    is
    v_ret number;
    v_next_state varchar2(2);
    v_doc_ref number := case nvl(p_docref,0)
                          when 0 then teller_utils.get_active_oper_ref()
                          when -1 then teller_utils.get_active_oper_ref()
                          else p_docref
                        end;
    v_str     varchar2(100);
    v_state   varchar2(2);
    v_cur     number;
    v_optype  varchar2(3) := get_type_operation(v_doc_ref);
    v_non_atm_amn number;
    v_curr_oper_amn number;
    v_cancel_flag number;
    v_req_id      number;
    v_oper_id     number;
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

logger.info('End_request: p_doc_ref = '||p_docref||', p_atm = '||p_atm_amount||', p_nonatm = '||p_non_atm_amount||', v_doc_ref = '||v_doc_ref);
    refresh_cash;
    v_req_id := teller_soap_api.StatusOperation;
    if teller_soap_api.get_current_dev_status() in (1500,9200,2003) then
      p_errtxt := 'АТМ працює. Поточний статус: '||teller_soap_api.get_current_dev_status_desc();
      return 0;
    end if;
    begin
      select teller_utils.get_r030(op.active_cur)
            ,decode(substr(op.state,1,1),'R',1,0)
            ,id
            ,op.state
            ,doc_ref
        into v_cur
            ,v_cancel_flag
            ,v_ret
            ,v_state
            ,v_doc_ref
        from teller_opers op
        where op.doc_ref = v_doc_ref or (abs(op.doc_ref) =  abs(v_doc_ref) and op.oper_ref = 'SBN');
    exception
      when others then
        bars_audit.info('v_doc_ref = '||v_doc_ref);
        raise;
    end;

    v_oper_id := v_ret;

    case
      when v_state in ('ID','I0','II','IN') then  -- заканчиваем "штатный" приём налички
        save_cash_oper(v_oper_id, 'IN',v_cur,p_atm_amount,p_non_atm_amount,p_atm_amount+p_non_atm_amount,1);
      when v_state like 'O%'      then  -- заканчиваем "штатную" выдачу наличных
        save_cash_oper(v_oper_id, 'OUT',v_cur,p_atm_amount,p_non_atm_amount,p_atm_amount+p_non_atm_amount,1);
      when v_state in ('RI','R2','RD','RIN')         then  -- приём наличных при возврате
        save_cash_oper(v_oper_id, 'RIN',v_cur,p_atm_amount,p_non_atm_amount, p_atm_amount+p_non_atm_amount,1);
      when v_state in ('RX','RO','R0')          then -- выдача наличных при возврате
        save_cash_oper(v_oper_id, 'ROUT',v_cur,p_atm_amount,p_non_atm_amount,p_atm_amount+p_non_atm_amount,1);
      else
        null;
    end case;

    if v_state = 'OK' then
      p_errtxt := 'Операцій з документом не проводилось!';
      return 0;
    end if;
    teller_utils.set_active_oper(v_ret);
--    v_cur := teller_utils.get_active_curcode();
    if v_cancel_flag = 0 and ((v_optype = 'OUT' and p_non_atm_amount > 0) or (v_optype = 'IN' and p_non_atm_amount<0)) then
      v_non_atm_amn := abs(p_non_atm_amount);
      select non_atm_amount
        into v_curr_oper_amn
        from teller_cash_opers
        where doc_ref = v_ret;
      v_ret := teller_utils.get_cur_nonatm_amount(v_cur);
      if v_ret+v_curr_oper_amn < v_non_atm_amn then
        bars_audit.info('Залишок коштів в темпокасі в валюті '||v_cur||'['||v_ret||'] менше необхідного ['||v_non_atm_amn||']!');
        p_errtxt := 'Залишок коштів в темпокасі в валюті '||v_cur||'['||v_ret||'] менше необхідного ['||v_non_atm_amn||']!';
        return 0;
      end if;
/*    else
      v_cur := teller_utils.get_active_curcode();
      select ts.non_atm_amount
        into v_ret
        from v_teller_state ts
        where ts.user_ref = to_char(g_user_id)
          and ts.cur_code = to_char(v_cur);
      if (v_optype = 'OUT' and p_non_atm_amount>v_ret)
         or
         (v_optype = 'IN' and 0-p_non_atm_amount>v_ret) then
        bars_audit.info('Залишок коштів в темпокасі в валюті '||v_cur||'['||v_ret||'] менше необхідного ['||v_non_atm_amn||']!');
        p_errtxt := 'Залишок коштів в темпокасі в валюті '||v_cur||'['||v_ret||'] менше необхідного ['||v_non_atm_amn||']!';
      end if;*/
    end if;

    for r in (select o.*, get_type_operation(v_doc_ref) op_type from teller_opers o where doc_ref = v_doc_ref)
    loop
      v_state := r.state;
/*      if r.state not in ('OX','OR','OS','RS','ID','I0','IN','RD','RS','RI','R2','RO','RX','RC') and p_atm_amount != 0 then
        p_errtxt := 'Операція з АТМ не завершена!';
        return 0;
      els*/
      if r.state in ('ID','I0','IN')  then
        if r.op_type in ('IN') then -- Операция по приёму наличных, надо закрывать окно
          v_next_state := 'OK';
        elsif r.op_type = 'ALL' then
          v_next_state := 'O0';
        else
          p_errtxt := 'Невідомий тип операції '||r.op_type;
          return 0;
        end if;
      elsif r.state like 'O%' then
        if r.op_type in ('OUT','ALL') then
          v_next_state := 'OK';
        else
          p_errtxt := 'Невідомий тип операції '||r.op_type;
          return 0;
        end if;
      elsif r.state in ('RD','RS','RI','R2') then
        case r.op_type
          when 'IN' then
            v_next_state := 'RJ';
          when 'OUT' then
            v_next_state := 'RX';
          when 'ALL' then
            v_next_state := 'RO';
        end case;
      elsif r.state in ('RO','RX','RC','R0') then
        v_next_state := 'RJ';
      end if;
    end loop;

    -- новая логика получения следующего статуса.
    -- если есть какие-то незавершенные операции в кассовых, то берем статус из них.
    begin
      select case op_type
               when 'IN' then 'IN'
               when 'OUT' then 'O0'
               when 'RIN' then 'RI'
               when 'ROUT' then 'RO'
               else 'OK'
             end
        into v_next_state
        from (select op_type
                from teller_cash_opers
                  where doc_ref = v_oper_id
                    and atm_status in (0,1)
                    and rownum = 1
                  order by case op_type
                             when 'IN' then 1
                             when 'RIN' then 1
                             when 'OUT' then 2
                             when 'ROUT' then 2
                             else 3
                           end)
           where rownum = 1;
    exception
      when no_data_found then
        null;
    end;

/*    ins_cash_opers(p_doc_ref => teller_utils.get_active_oper(),
                   p_nonatm  => case v_next_state
                                  when 'RJ' then p_non_atm_amount
                                  else abs(p_non_atm_amount)
                                end,
                   p_atm     => p_atm_amount);
*/
    if v_next_state in ('OK','RJ')  then

      if teller_soap_api.get_user_sessionID() is not null then
        if teller_soap_api.ReleaseOperation() = 1 and teller_soap_api.CloseOperation() = 1 then
          update teller_state
            set active_oper = null
               ,session_id  = null
            where user_ref = g_user_id
              and work_date = g_bars_dt;

          null;
        else
          p_errtxt := 'Помилка при закінченні операції'||' '||p_errtxt;
          return 0;
        end if;
      end if;
    end if;

    update teller_opers
      set state = v_next_state,
          REQ_REF = null
      where doc_ref = v_doc_ref;

    teller_utils.set_active_oper(null);
    p_errtxt := 'Операцію з пристроєм завершено';

    return 1;
  exception
    when others then
      p_errtxt := sqlerrm;
      bars_audit.info(sqlerrm||': '||dbms_utility.format_call_stack);
      return 0;
  end end_request;

  function cancel_operation (p_docref in number
                            ,p_errtxt out varchar2)
    return number
    is
    v_optype   varchar2(4) := teller_tools.get_type_operation(p_docref);
    v_in_done  number := 0;
    v_out_done number := 0;
    v_next_state varchar2(2);
    v_num        number;
    v_oper_id    number;
  begin
    select state, id
      into v_next_state, v_oper_id
      from teller_opers
      where doc_ref = p_docref
        or  (oper_ref = 'SBN' and id = teller_utils.get_active_oper());
    if v_next_state in ('RO','RJ','RX') then
      p_errtxt := 'Операція вже відмінена';
      return 0;
    end if;

    if v_next_state = 'II' then -- выполняется операция приёма наличных, заканчиваем операцию приёма и активируем возврат средств
      v_num := teller_soap_api.CancelCashinOperation;
/*      select count(1) into v_num
        from teller_requests
        where oper_ref = get_active_oper
          and req_meth = 'StoreCashinOperation';
      if nvl(v_num,0) =  0 then
        v_num := teller_soap_api.EndCashinOperation;
      else
        v_num := teller_soap_api.CancelCashinOperation;
      end if;
*/      v_num := teller_soap_api.ReleaseOperation;
      v_num := teller_soap_api.CloseOperation;
      v_next_state := 'RJ';
      update teller_opers
        set state = v_next_state
        where doc_ref = p_docref;
/*      update teller_cash_opers
        set atm_amount = 0, non_atm_amount = 0
        where doc_ref = v_oper_id
          and ;*/
      return 1;
    end if;
--    if v_optype = 'ALL' then
/*      for rq in (select tr.req_type, tr.oper_amount
                   from teller_requests tr
                   where tr.oper_ref = p_docref
                     and trim(tr.status) = '0'
                     and tr.req_type in ('CashoutRequest','StartCashinRequest')
                   order by req_id desc
                )
      loop
        if rq.req_type = 'StartCashinRequest' and v_in_done = 0 then
          v_in_done := rq.oper_amount;
        elsif rq.req_type = 'CashoutRequest' and v_out_done = 0 then
          v_out_done := rq.oper_amount;
        end if;
      end loop;*/

    select count(1)
      into v_in_done
      from teller_cash_opers
      where doc_ref = (select id from teller_opers where doc_ref = p_docref)
        and op_type in ('IN','RIN')
        and atm_status >= 1;
/*    select count(1)
      into v_in_done
      from teller_oper_history toh
      where toh.op_ref = (select id from teller_opers where doc_ref = p_docref)
        and toh.old_status like 'I%';
*/
    select count(1)
      into v_out_done
      from teller_cash_opers
      where doc_ref = (select id from teller_opers where doc_ref = p_docref)
        and op_type in ('OUT','ROUT')
        and atm_status >= 1;
/*    select count(1)
      into v_out_done
      from teller_oper_history toh
      where toh.op_ref = (select id from teller_opers where doc_ref = p_docref)
        and toh.old_status like 'O%'
        and toh.old_status != 'OK';
*/

    if v_out_done != 0 then
      v_next_state := 'RI';
      p_errtxt := 'Відміна операції потребує внесення готівки!';
    elsif v_in_done != 0 then
      v_next_state := 'RO';
      p_errtxt := 'Відміна операції потребує видачі готівки!';
    else
      v_next_state := 'RJ';
/*      update teller_cash_opers
        set atm_amount = 0, non_atm_amount = 0
        where doc_ref = p_docref;
*/
    end if;

    update teller_opers
      set state = v_next_state
      where doc_ref = p_docref;

    update teller_state
      set active_oper = decode(v_next_state,'RJ',NULL,active_oper)
      where user_ref = g_user_id
        and work_date = g_bars_dt;
    return 1;
  exception
    when others then
      p_errtxt := 'Неможливо відмінити операцію '||sqlerrm;
      bars_audit.error(p_errtxt);
      return 0;
  end cancel_operation;


  function change_request (p_docref  in number
                          ,p_curcode in varchar2
                          ,p_amount  in number
                          ,p_errtxt  out varchar2)
    return number
    is
    v_ret number := 0;
    v_docref number := p_docref;
    v_curcode varchar2(3) := trim(replace(p_curcode,'[]'));
  begin

logger.info('Teller.change_request p_docref = '||p_docref||', p_curcode = '||p_curcode||', p_amount = '||p_amount);
    if p_docref = -1 then
      v_docref := teller_utils.get_active_oper();
    end if;
    if nvl(p_amount,0) is null then
      p_errtxt := 'Отримано нульову суму для решти. Операцію не виконуємо';
      return 0;
/*    elsif p_amount <0 then
     p_errtxt := 'Отримано від"ємну суму для решти. Операцію не виконуємо';
      return 0;*/
    end if;
    if teller_soap_api.CashOutOperation(p_curcode => teller_utils.get_cur_code(v_curcode), p_amount => abs(p_amount)) = 1 then

      for r in (
                select tr.oper_amount, case tr.status
                                         when '-1' then tr.response
                                         when '0 '  then 'Видано суму '||tr.oper_amount||' ['||v_curcode||']'
                                         else tr.response
                                       end
                                       as response
                  from teller_requests tr, teller_opers op
                  where (p_docref = op.doc_ref  or (abs(v_docref) = abs(op.doc_ref) and op.oper_ref = 'SBN'))
                    and (op.id = tr.oper_ref or (op.id = 0-tr.oper_ref and op.oper_ref = 'SBN'))
                    and tr.req_meth = 'CashoutOperation'
                 order by tr.req_id desc
               )
      loop
         v_ret := r.oper_amount;
         p_errtxt := r.response;
         exit;
      end loop;
      if v_ret != 0 then
       p_errtxt := 'Через АТМ видано суму '||v_ret||' ['||v_curcode||']';
      end if;

--      v_ret := 1;
    else
      p_errtxt := 'Помилка при виконанні операції';
      v_ret := 0;
    end if;

    return v_ret;
  end change_request;


  function get_change_msg (p_docref in number)
    return varchar2
    is
  begin
    return 'Для окончания операции Вам нужно внести в темпокассу сумму в размере 100500 грн (стопиццот гривень)';
  end get_change_msg;

  function get_window_status_new (p_doc_ref   in out number
                                 ,p_warning   in number
                                 ,p_amount    out number
                                 ,p_currency  out varchar2
                                 ,p_oper_desc out varchar2
                                 ,p_atm       out varchar2)
    return varchar2
    is
    v_ret varchar2(10) := '??';
    v_num number;
    v_oper_code varchar2(3);
    v_docref number := nvl(p_doc_ref,0);
  begin
    -- обновляем список кассовых операций
    refresh_cash;
    -- ТОХ проходит мимо
    begin
/*      select tt into v_oper_code
        from oper t, tts ts
        where ref = p_doc_ref
          and ;*/
      if v_oper_code = 'TOX' then
        p_oper_desc := 'Для операції "ТОХ" не потрібна робота з АТМ';
        return 'ER';
      end if;
    exception
      when no_data_found then null;
    end;

    -- нет оборудования
    if teller_utils.get_equip_type = 'M' then
      p_oper_desc := 'Оператор не працює з АТМ. Виконання цієї функції неможливо';
      return 'ER';
    end if;
    -- по операции нет кассовых проводок
    if get_type_operation(p_doc_ref) = 'NONE' then
      p_oper_desc := 'Операція не є касовою і не потребує роботи АТМ';
      return 'ER';
    end if;
    -- пришел СБОН
    if v_docref = 0 then
      for doc in (select op.doc_ref
                    from teller_opers op
                    where op.user_ref = g_user_id
                      and op.oper_ref = 'SBN'
                      and op.state in ('I0','I1','I2','II','ID','RO')
                    order by id)
      loop
        v_docref := doc.doc_ref;
        exit;
      end loop;
      if v_docref = 0 then
        p_oper_desc := 'Відсутні активні операції зі СБОН+ користувача. Можливо треба виконати реєстрацію операції СБОН+ в АБС.';
        return 'ER';
      end if;
    end if;

    -- выбираем текущее состояние документа
    begin
      select op.state,
             op.id
        into v_ret,
             v_num
        from teller_opers op
        where op.doc_ref = v_docref;
    exception
      when no_data_found then  -- если документ у нас еще не зарегистрирован, то его надо регистрировать
        for r in (select tt, kv, s, sq, is_sw_oper(p_doc_ref) sw_flag, get_type_operation(tt) oper_type
                    from oper
                    where ref = p_doc_ref)
        loop
          insert into teller_opers (oper_ref,
                                    cur_code,
                                    amount,
                                    amount_uah,
                                    doc_ref,
                                    is_sw_oper,
                                    state,
                                    is_warning
                                    )
            values (r.tt,
                    r.kv,
                    r.s/100,
                    r.sq/100,
                    p_doc_ref,
                    r.sw_flag,
                    case r.oper_type
                      when 'IN' then 'I0'
                      when 'ALL' then 'I0'
                      when 'OUT' then 'O0'
                      else 'OK'
                    end,
                    p_warning)
            returning id, state into v_num, v_ret;
          ins_cash_opers(v_num);  -- добавляем кассовые операции себе
        end loop;
    end;


    for r in (select tco.op_type, tco.cur_code, tco.atm_amount+tco.non_atm_amount amount
                from teller_cash_opers tco
                where tco.doc_ref = v_num
                  and tco.atm_status in (0,1)
                order by tco.op_type, tco.cur_code
             )
    loop
      v_ret      := r.op_type;
      p_amount   := r.amount;
      p_currency := r.cur_code;
      p_oper_desc:= case r.op_type
                      when 'IN'   then 'Отримання готівки від клієнта'
                      when 'OUT'  then 'Видача готівки клієнту'
                      when 'RIN'  then 'Отримання готівки від клієнта (відміна операції)'
                      when 'ROUT' then 'Повернення готівки клієнту (відміна операції'
                    end;
      exit;
    end loop;

    update teller_opers op
      set op.active_cur = p_currency
      where op.doc_ref = v_docref;
--bars_audit.info('windows status is '||v_ret);
    p_atm    := teller_soap_api.get_current_dev_status_desc();

  return v_ret;
  exception
    when others then
      p_oper_desc := 'Помилка при отриманні статусу вікна :'||sqlerrm;
      return 'ER';
  end get_window_status_new;


  function get_window_status (p_doc_ref   in out number
                             ,p_warning   in number
                             ,p_amount    out number
                             ,p_currency  out varchar2
                             ,p_oper_desc out varchar2
                             ,p_atm       out varchar2
                             ,p_reject_flag out integer)
    return varchar2
    is
    v_ret varchar2(10) := '??';
    v_num number;
    v_oper_code varchar2(3);
    v_docref number := nvl(p_doc_ref,0);
  begin
    p_reject_flag := 0;
    if p_doc_ref = -1 then
      p_oper_desc := 'Операцію СБОН+ оброблено успішно';
      return 'OK';
    end if;
    if check_atm = 1 then
      p_oper_desc := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 'ER';
    end if;
    refresh_cash;
    begin
      select tt into v_oper_code
        from oper
        where ref = p_doc_ref;
      if v_oper_code = 'TOX' then
        p_oper_desc := 'Для операції "ТОХ" не потрібна робота з АТМ';
        return 'ER';
      end if;
    exception
      when no_data_found then null;
    end;


    if teller_utils.get_equip_type = 'M' then
      p_oper_desc := 'Оператор не працює з АТМ. Виконання цієї функції неможливо';
      return 'ER';
    end if;

    if get_type_operation(p_doc_ref) = 'NONE' then
      p_oper_desc := 'Операція не є касовою і не потребує роботи АТМ';
      return 'ER';
    end if;

    if v_docref = 0 then
      for doc in (select op.doc_ref
                    from teller_opers op
                    where op.user_ref = g_user_id
                      and op.oper_ref = 'SBN'
                      and op.state in ('I0','I1','I2','II','ID','RO')
                    order by id)
      loop
        v_docref := doc.doc_ref;
        v_oper_code := 'SBN';
        exit;
      end loop;
      if v_docref = 0 then
        p_oper_desc := 'Відсутні активні операції зі СБОН+ користувача. Можливо треба виконати реєстрацію операції СБОН+ в АБС.';
        return 'ER';
      end if;
    end if;
    p_doc_ref := v_docref;
      select count(1)
        into v_num
        from teller_oper_define od
        where od.oper_code = v_oper_code
          and od.equip_ref = teller_utils.get_eq_id();
      if v_num = 0 then
        p_amount := 0;
        p_currency := null;
        p_oper_desc := 'Операція відсутня в довіднику операцій Теллера';
        return 'ER';
      end if;

    begin
      select op.state,
             op.id
        into v_ret,
             v_num
        from teller_opers op
        where op.doc_ref = v_docref;
    exception
      when no_data_found then
        for r in (select tt, kv, s, sq, is_sw_oper(p_doc_ref) sw_flag, get_type_operation(p_doc_ref) oper_type
                    from oper
                    where ref = p_doc_ref)
        loop
          insert into teller_opers (oper_ref,
                                    cur_code,
                                    amount,
                                    amount_uah,
                                    doc_ref,
                                    is_sw_oper,
                                    state,
                                    is_warning
                                    )
            values (r.tt,
                    r.kv,
                    r.s/100,
                    r.sq/100,
                    p_doc_ref,
                    r.sw_flag,
                    case r.oper_type
                      when 'IN' then 'I0'
                      when 'ALL' then 'I0'
                      when 'OUT' then 'O0'
                      else 'OK'
                    end,
                    p_warning)
            returning id, state into v_num, v_ret;
          ins_cash_opers(v_num,0,0);
--          save_cash_oper(v_num, v_ret, r.kv, 0, r.s/100);
        end loop;
    end;

    if v_ret like 'R%' and v_ret != 'RJ' and v_ret != 'RX' then
      p_reject_flag := 1;
      ins_cash_opers(v_num,0,0);
    end if;
    teller_utils.set_active_oper(v_num);
    if v_ret is null then
      p_oper_desc := 'Документ [REF = '||p_doc_ref||' має порожнє значення поля статус. Зв"яжіться, будь-ласка з адміністратором!';
      return 'ER';
    end if;

    for r in (select o.*, nvl(t.name,'СБОН+') name from teller_opers o, tts t where doc_ref = v_docref and o.oper_ref = t.tt and o.oper_ref != 'SBN'
              union all
              select o.*, 'СБОН+' name from teller_opers o where doc_ref = v_docref and  o.oper_ref = 'SBN'
             )
    loop
      if substr(r.state,1,1) = 'I' then
        v_ret := 'IN';
        p_oper_desc := 'Операція '||r.name||chr(13)||
                       'ПРИЙМАННЯ готівки від клієнта';
        if r.oper_ref = 'SBN' then
          p_amount := r.amount;
          p_currency := 'UAH';
        else
          p_amount := teller_utils.get_in_amount (r.id, p_currency);
        end if;
      elsif r.state in ('DN','OK') then
        select t.lcv
          into p_currency
          from tabval t
          where t.kv = r.cur_code;
        p_amount := r.amount;
        p_oper_desc := 'Операція '||r.name||chr(10)||
                       'Обслуговування клієнта завершено';
        v_ret := 'OK';
      elsif substr(r.state,1,1) = 'O' then
        p_oper_desc := 'Операція '||r.name||chr(10)||
                       'ВИДАЧА готівки клієнту';
        p_amount := teller_utils.get_out_amount (r.id, p_currency);
        v_ret := 'OUT';
      elsif r.state = 'RI' or r.state = 'R1' then -- отмена операции (приём выданных денег)
        v_ret := 'IN';
        p_oper_desc := 'ВІДМІНА операції '||r.name||chr(13)||
                       'ПРИЙМАННЯ готівки від клієнта';
        p_amount    := teller_utils.get_in_amount(r.id,p_currency);
      elsif r.state in ('RO','R0') then -- отмена операции (Выдача принятых денег)
        v_ret := 'OUT';
        p_oper_desc := 'ВІДМІНА операції '||r.name||chr(13)||
                       'Видача готівки клієнту';
        if r.oper_ref = 'SBN' then
          p_amount := r.amount;
          p_currency := 'UAH';
        else
          p_amount    := teller_utils.get_out_amount(r.id,p_currency);
        end if;
      elsif r.state in ('RJ','RX') then
        p_oper_desc := 'Документ знаходиться в статусі "відмінений"';
        p_amount    := 0;
        p_currency  := 'UAH';
        v_ret := 'RJ';
      else
        v_ret := '??';
      end if;
    end loop;

    update teller_opers op
      set op.active_cur = p_currency
      where op.doc_ref = v_docref;
--bars_audit.info('windows status is '||v_ret);
    p_atm    := teller_soap_api.get_current_dev_status_desc();
    p_currency := teller_utils.get_r030(p_currency);
logger.info('get_window_status: p_amount = '||p_amount||', p_currency = '||p_currency||', p_oper_desc = '||p_oper_desc||', p_atm = '||p_atm);
--    p_currency := teller_utils.get_cur_name(p_currency);
    return v_ret;
  exception
    when others then
      p_oper_desc := 'Помилка при отриманні статусу вікна :'||sqlerrm;
      return 'ER';
  end get_window_status;

  function make_request (p_oper_ref in number
                        ,p_errtxt   out varchar2)
    return number
    is
    v_progname varchar2(100) := g_package_name || '.MAKE_REQUEST';
    v_ret varchar2(2000);
    v_curcode number;
    v_oper_code tts.tt%type;
    v_oper_sum number;
    v_state varchar2(10) := '--';
    v_res   number;
    v_optype varchar2(4);
    v_doc_ref number := teller_utils.get_active_oper_ref();
    v_req_id  number;
  begin
    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    for r in (select *
                from teller_requests tr
                where tr.creator = user_name
                  and tr.creation_date >= trunc(sysdate)
                order by req_id desc)
    loop
--bars_audit.info(r.req_meth);
      if r.req_meth = 'StartCountOperation' then
        p_errtxt := 'Ви ініцюювали операцію з підрахунку. Перед початком інших дій необхідно закінчити підрахунок';
        return 0;
     end if;
     exit;
    end loop;

    v_req_id := teller_soap_api.StatusOperation;
    if teller_soap_api.get_current_dev_status() not in (1000,1500,9200) then
      p_errtxt := 'АТМ працює. Поточний статус: '||teller_soap_api.get_current_dev_status_desc();
      return 0;
    end if;

    if nvl(p_oper_ref,0) > 0 then
      if nvl(v_doc_ref,0) != p_oper_ref then
        update teller_state ts
          set active_oper = p_oper_ref
          where ts.user_ref = g_user_id
            and ts.work_date = g_bars_dt;
        v_doc_ref := p_oper_ref;
      end if;
    end if;

    v_optype := get_type_operation(v_doc_ref);
    for r in (select * from teller_opers where doc_ref = v_doc_ref) loop
      v_state := r.state;
      if v_state in ('IN','II','RD','ID') then
        if v_optype in ('IN','ALL') and v_state like 'I%' then
          v_state := 'I0';
        elsif v_optype in ('OUT') and v_state like 'RD' then
          v_state := 'RI';
        elsif v_optype = 'OUT' then
          v_state := 'O0';
        end if;
        update teller_opers
          set state = v_state
          where doc_ref = v_doc_ref;
      end if;
    end loop;
    if v_state = '--' then
      insert into teller_opers (oper_ref, cur_code, amount, amount_uah, doc_ref, is_sw_oper, state)
        select o.tt, o.kv, o.s/100, o.sq/100, v_doc_ref, is_sw_oper(v_doc_ref), decode(v_optype,'IN','I0','ALL','I0','OUT','O0','I0')
          from oper o
          where ref = v_doc_ref;
    end if;

    select state
      into v_state
      from teller_opers
      where doc_ref = v_doc_ref;

    if v_state = 'RI' then -- отмена операции с внесением наличных
--      if tellerOperOperation = 1 and OccupyOperation
      if teller_soap_api.StartCashinOperation = 1 then
        update teller_opers
          set state = 'R1'
          where doc_ref = v_doc_ref;
--        p_errtxt := 'Операція з АТМ виконується. Для завершення натисніть "Внести" або "Підтвердити"';
        p_errtxt := teller_soap_api.get_current_dev_status_desc();
      else
        p_errtxt := 'Неможливо виконати запит для терміналу';
      end if;
    elsif v_state in  ('RO','R0') then
      v_res := teller_soap_api.CashOutOperation;
    elsif v_state in ('II','R1') then
      v_res := teller_soap_api.StoreCashinOperation;
      select listagg(cur_code||': '||amn,', ') within group (order by null)
        into p_errtxt
        from (
          select cur_code, sum(nominal * pieces) amn
            from teller_requests r,
                 xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                             'http://www.glory.co.jp/gsr.xsd' as "n"),
                               'soapenv:Envelope/soapenv:Body/n:StoreCashinResponse/Cash/Denomination' passing r.xml_response
                                columns
                                cur_code varchar2(3) path '@n:cc',
                                nominal  number      path '@n:fv',
                                pieces   number      path 'n:Piece') t
            where r.req_id = teller_soap_api.get_active_request_id()
            group by cur_code);

      p_errtxt := 'В АТМ прийнято суму '||p_errtxt||',<br/>'||chr(13)||
             'АТМ очікує внесення готівки або закінчення операції';
    else
--    if v_state = 'IN' then -- старт приёма наличных
      for srv in (select *
                    from (select * from teller_ws_define where op_type = v_optype) wd
                    connect by prior oper_end_state = oper_start_state
                    start with oper_start_state = v_state
                    order by wd.ws_id)
      loop

        if substr(v_state,1,1) != substr(srv.oper_end_state,1,1) or srv.ws_type = 'F'
           or (v_state = 'R1' and srv.oper_end_state = 'RO') then -- будет переключение операции, тут нам делать нечего
          p_errtxt := 'Виконайте операцію "Підтвердити"';
          return -1;
        end if;

        if   v_state = srv.oper_start_state then
          execute immediate 'begin :1 := teller_soap_api.'||srv.funcname||'; end;' using out v_res;
          if v_res = 1 or srv.ws_name in ('ReleaseRequest','CloseRequest') then
            update teller_opers
              set state = srv.oper_end_state
              where doc_ref = v_doc_ref;
            v_state := srv.oper_end_state;
          else
            for r in (select tr.response
                        from teller_opers op,
                             teller_requests tr
                        where doc_ref = v_doc_ref
                          and op.req_ref = tr.req_id)
            loop
              p_errtxt := 'Помилка при роботі з терміналом. '||chr(13)||'Операція: '||srv.ws_name||', '||r.response;
            end loop;
            return 0;
          end if;
          if srv.ws_type = 'D' then
            p_errtxt := 'Операція з АТМ виконується. Для завершення натисніть "Внести" або "Підтвердити"';
            case
              when srv.ws_name like '%Cashin%' then
                p_errtxt:= 'АТМ очікує на внесення готівки'||chr(10)||p_errtxt;
              when srv.ws_name like '%CashOut%' then
                p_errtxt:= 'Заберіть готівку з вихідного отвору'||chr(10)||p_errtxt;
              else
                null;
            end case;
            return -1;
          end if;
        end if;
      end loop;
    end if;
/*

    select o.tt, o.kv, o.s
      into v_oper_code, v_curcode, v_oper_sum
      from oper o
      where ref = p_oper_ref;
    p_errtxt := teller_soap_api.make_request(v_oper_code, v_curcode, v_oper_sum);*/
--    commit;
    return 1;
  exception
    when no_data_found then
      bars_audit.error('Операцію з ref = '||v_doc_ref||' не знайдено в АБС. Некоректний виклик функції ('||sqlerrm||')');
      raise_application_error(-20100,'Операцію з ref = '||p_oper_ref||' не знайдено в АБС. Некоректний виклик функції('||sqlerrm||')');
    when others then
      bars_audit.error('Помилка при роботі функції: '||sqlerrm);
      raise_application_error(-20100,sqlerrm);
  end;

  function confirm_request (p_docref     in number
                           ,p_atm_amount out number
                           ,p_errtxt     out varchar2)
    return number
    is
    v_state   varchar2(2) := '--';
    v_res     number;
    v_op_tt   varchar2(3);
    v_op_type varchar2(100);
    v_req_id  integer;
    v_doc_ref number := case nvl(p_docref,0)
                          when 0 then teller_utils.get_active_oper()
                          when -1 then teller_utils.get_active_oper()
                          else p_docref
                        end;
    v_oper_ref number;
    v_curr_oper varchar2(10);
  begin
/*    if nvl(p_docref,0) = 0 then -- операція СБОН+
      update teller_opers
        set state = 'RO'
        where id = abs(v_doc_ref)
          and oper_ref = 'SBN'
          and state = 'S-';
     end if;
*/  --bars_audit.info('Teller.Confirm_request');

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    v_req_id := teller_soap_api.StatusOperation;
    if teller_soap_api.get_current_dev_status() not in (1000,1500,9200,2003) then
      p_errtxt := 'АТМ працює. Поточний статус: '||teller_soap_api.get_current_dev_status_desc();
      return 0;
    end if;

    select op.state, op.oper_ref, id, case
                                        when v_state like 'I%' then
                                          'IN'
                                        when v_state in ('RI','RD') then
                                          'RIN'
                                        when v_state like 'O%' and v_state != 'OK' then
                                          'OUT'
                                        when v_state = 'RO' then
                                          'ROUT'
                                      end case
      into v_state, v_op_tt, v_oper_ref, v_curr_oper
      from teller_opers op
      where op.doc_ref = v_doc_ref or (op.id = v_doc_ref and op.oper_ref = 'SBN');

    if v_op_tt = 'SBN' then
      if v_state like 'I%' or v_state = 'RI' then
        v_op_type := 'IN';
      elsif (v_state like 'O%' and v_state != 'OK') or v_state = 'RO' then
        v_op_type := 'OUT';
      end if;
    else
      v_op_type := get_type_operation(p_docref);
      if v_op_type = 'NONE' then
        v_op_type := get_type_operation(v_op_tt);
      end if;
    end if;
--    get_type_operation(v_op_tt);
Logger.info('Teller v_state = '||v_state);
    for r in (select *
                    from (select * from teller_ws_define where op_type = v_op_type) wd
                    connect by prior oper_end_state = oper_start_state
                    start with oper_start_state = v_state
                    order by wd.ws_id
            )
    loop
logger.info('Teller ws_name = '||r.funcname||' starting');
      execute immediate 'begin :1 := teller_soap_api.'||r.funcname||'; end;' using out v_res;
logger.info('Teller ws_name = '||r.funcname||' result = '||v_res);
      if v_res = 1 or r.ws_name in ('ReleaseRequest','CloseRequest') then
        update teller_opers
          set state = r.oper_end_state
          where doc_ref = v_doc_ref          ;
        commit;
        v_state := r.oper_end_state;
        p_errtxt := teller_soap_api.get_req_message();
      else
        p_errtxt := 'Помилка при роботі з терміналом. Операція: '||r.ws_name||', помилка ...';
        return 0;
      end if;
      if r.ws_type = 'F' then
        exit;
      end if;
    end loop;
    p_atm_amount := get_atm_amount(p_errtxt);
logger.info('tell v_oper_ref = '||v_oper_ref||', v_op_type = '||v_op_type||', p_atm_amount = '||p_atm_amount);
    update teller_cash_opers
      set atm_amount = p_atm_amount/*,
          non_atm_amount = nvl(non_atm_amount,0) - p_atm_amount*/
      where doc_ref = v_oper_ref
        and op_type like '%'||v_curr_oper;
logger.info('step5, atm_amount = '||p_atm_amount||', errtxt = '||p_errtxt);
--    bars_audit.info('TELLER returning p_errtxt = '||p_errtxt);
--    v_res := teller_soap_api.InventoryOperation(0);
--    if p_op_type = 'IN'
    p_errtxt := nvl(p_errtxt,'Операцій з АТМ не проводилось');
    return 1;
  exception
    when others then
      p_errtxt := 'Teller error: Виникла помилка при підтвердженні операції (ref = '||v_doc_ref||'): '||sqlerrm;
bars_audit.info(p_errtxt);
bars_audit.info(dbms_utility.format_call_stack);
      return 0;
  end confirm_request;

  function get_request_name (p_state in varchar2)
    return varchar2
    is
  begin
    if p_state in ('RI','R1','RD','R2') or p_state like 'I%' then return 'EndCashinRequest';
    elsif p_state in ('RO','RX') or p_state like 'O%' then return 'CashoutRequest';
    else return null;
    end if;
  end get_request_name;

  function get_atm_amount (p_amount_txt out varchar2)
    return number
    is
    v_ret number := 0;
    v_rq_name varchar2(20);
  begin
    for r in (select op.*,
                     get_request_name(op.state) rq_name
                from teller_opers op
                where op.doc_ref = teller_utils.get_active_oper_ref()
             )
    loop
logger.info('r.id = '||r.id||', r.rq_name = '||r.rq_name||', r.active_cur = '||r.active_cur);
      for rq in (select tr.oper_amount, tr.oper_amount_txt, tr.response
                     from teller_requests tr
                     where tr.oper_ref = r.id
                       and tr.req_type = r.rq_name
                       and tr.oper_currency in (r.active_cur,teller_utils.get_cur_code(r.active_cur))
                       and trim(tr.status) = '0'
                     order by tr.req_id desc)
      loop
        v_ret := v_ret + rq.oper_amount;
        p_amount_txt := p_amount_txt||'<br/>'||nvl(rq.oper_amount_txt, rq.response);
        if r.rq_name = 'CashoutRequest' then
          exit;
        end if;
      end loop;
    end loop;
    return v_ret;
  end get_atm_amount;




  procedure send_msg2boss (p_msg in varchar2)
    is
    v_err varchar2(2000);
    v_userlist varchar2(2000);
    v_username varchar2(100);
    v_pos   integer;
  begin
    for r in (select t.userlist
                from V_TELLER_BOSS_LIST t
                where t.user_id = g_user_id)
    loop
      v_userlist := r.userlist;
      loop
        v_pos := instr(v_userlist,',')-1;
        if v_pos <= 0 then
          v_pos := length(v_userlist);
        end if;
        v_username := substr(v_userlist,1,v_pos);
        begin
          bars.bms.push_msg_web(p_user_login => v_username,
                                p_message    => p_msg,
                                p_type_id    => 10);
        exception
          when others then null;
        end;

        insert into teller_inform_log (type_info,
                                       userid,
                                       username,
                                       receiver,
                                       msg_body,
                                       dt_send,
                                       dt_confirm)
        values ('Message',
                g_user_id,
                user_name,
                v_username,
                p_msg,
                sysdate,
                null);
        exit when v_pos = length(v_userlist);
        v_userlist := substr(v_userlist,v_pos+2);
      end loop;
    end loop;

  exception
    when others then
      v_err := 'Teller_tools.send_msg2boss: Помилка при відправці повідомлення боссу'||sqlerrm;
      bars_audit.error(v_err);
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TEL_MSG1',p_param1 => v_err);
  end send_msg2boss;

  procedure send_mail2boss (p_addr in varchar2
                           ,p_body in clob)
    is
  begin
    bars_mail.put_msg2queue(p_name    => '',
                            p_addr    => p_addr,
                            p_subject => 'TELLER. Превышение лимита!',
                            p_body    => p_body);

      insert into teller_inform_log (type_info,
                                     userid,
                                     username,
                                     receiver,
                                     msg_body,
                                     dt_send,
                                     dt_confirm)
      values ('EMail',
              g_user_id,
              user_name,
              p_addr,
              p_body,
              sysdate,
              null);

  end send_mail2boss;

  function reg_sbon (p_errtxt out varchar2)
    return number
    is
    v_num number;
  begin
    v_num := registry_sbon_operation(p_user      => 'OSCHADBANK\BONDARENKONA'
                                    ,p_op_code   => 'SBN',
                                     p_op_amount => 55.66,
                                     p_errtxt    => p_errtxt);

    v_num := update_oper(p_id      => v_num,
                         p_user_ip => g_ws_name,
                         p_action  => 'CONFIRM',
                         p_errtxt  => p_errtxt);
    return 1;
  end;


  function check_action (p_action in  varchar2
                        ,p_docref in  number
                        ,p_errtxt out varchar2
                        )
    return number
    is
    v_status varchar2(2);
    v_ret    number;
    v_opcode varchar2(3);
  begin
    if teller_utils.get_equip_type = 'M' or get_type_operation(p_doc_ref => p_docref) = 'NONE' then
      return 1;
    end if;
    select op.tt, (select count(1) from teller_oper_define where oper_code = op.tt and equip_ref = teller_utils.get_eq_id())
      into v_opcode, v_ret
      from oper op
      where op.ref = p_docref;
    if v_opcode != 'TOX' and v_ret = 0 then
      p_errtxt := 'Операція [tt = '||v_opcode||'] відсутня в переліку доступних операцій Теллера!';
      return 0;
    end if;
--logger.info('p_action = '||p_action||', p_docref = '||p_docref);
    if v_opcode = 'TOX' and p_action = 'STORNO' then
      p_errtxt := 'Операцію інкасації коштів неможливо сторнувати. Виконайте, будь ласка, операцію вилучення коштів через меню "Теллера"';
      return 0;
    end if;

    for r in (select op.state
                from teller_opers op
                where doc_ref = p_docref
              )
    loop
      if (p_action = 'VISA' and r.state = 'OK')
         or
         (p_action = 'STORNO' and  r.state in ('RJ','RX')) then
        v_ret := 1;
      elsif p_action = 'VISA' and  r.state in ('RJ','RX') then
        p_errtxt := 'Документ з ref = '||p_docref||' відбракований';
        v_ret := 0;
      elsif p_action = 'STORNO' and r.state = 'OK' then
        p_errtxt := 'Необхідно виконати відміну документа в вікні "Теллера"';
        v_ret := 0;
      elsif p_action = 'VISA' and  r.state like 'R%'  then
        p_errtxt := 'Документ з ref = '||p_docref||' в процесі відбракування';
        v_ret := 0;
      else
        p_errtxt := 'Документ з ref = '||p_docref||' має незавершені операції з АТМ';
        v_ret := 0;
      end if;
      if v_ret = 0 then
        return v_ret;
      end if;
    end loop;

    return v_ret;
  exception
    when no_data_found then
      return 1;
    when others then
      p_errtxt := 'Помилка '||sqlerrm;
      return 0;
  end check_action;

  function check_doclist (p_doclist in  number_list
                         ,p_errtxt  out varchar2)
    return number
    is
    v_num number;
    v_ret number := 1;
    v_errtxt varchar2(100);
  begin
    for r in (select column_value
                from table(cast(p_doclist as number_list)) t)
    loop
      if check_action('VISA',r.column_value, v_errtxt) = 0 then
        v_ret := 0;
        p_errtxt := p_errtxt||v_errtxt||chr(10);
      end if;
    end loop;
    return v_ret;
  exception
    when others then
      p_errtxt := 'При перевірці документу(ів) Теллера виникла помилка: '||sqlerrm;
      return 0;
  end check_doclist;

  function storno_doclist (p_doclist in  number_list
                          ,p_errtxt  out varchar2)
    return number
    is
    v_num number;
    v_ret number := 1;
    v_errtxt varchar2(100);
  begin
    for r in (select column_value
                from table(cast(p_doclist as number_list)) t)
    loop
      if check_action('STORNO',r.column_value, v_errtxt) = 0 then
        v_ret := 0;
        p_errtxt := p_errtxt||v_errtxt||chr(10);
      end if;
    end loop;
    return v_ret;
  exception
    when others then
      p_errtxt := 'Помилка при сторнуванні документа(ів) теллера: '||sqlerrm;
      return 0;
  end storno_doclist;



  procedure compute_teller_stats (p_cnt_in  out number
                                 ,p_sum_in  out number
                                 ,p_cnt_out out number
                                 ,p_sum_out out number
--                                 ,p_atmflag in number default 0
                                 )
    is
    v_dt date  := g_bars_dt;
    v_eq_type varchar2(1) := g_eq_type;
  begin
    teller_tools.refresh_cash;
/*    select sum(decode(tr.req_type,'EndCashinRequest',1,0)),
           sum(decode(tr.req_type,'EndCashinRequest',round(rato(v.kv,v_dt)*tr.oper_amount,2),0)),
           sum(decode(tr.req_type,'CashoutOperation',1,0)),
           sum(decode(tr.req_type,'CashoutOperation',round(rato(v.kv,v_dt)*tr.oper_amount,2),0))
      into p_cnt_in,
           p_sum_in,
           p_cnt_out,
           p_sum_out
      from teller_opers op, teller_requests tr, tabval v
      where op.user_ref = g_user_id
        and op.work_date = v_dt
        and tr.oper_ref = op.doc_ref
        and nvl(tr.oper_amount,0) != 0
        and tr.oper_currency = v.lcv;

*/
    select sum(case
                 when tco.op_type in ('IN','RIN') then
                   1
                 else 0
               end),
           sum(case
                 when tco.op_type in ('IN','RIN') then
                   round(decode(tv.kv,980,1,rato(tv.kv, v_dt)) * (tco.atm_amount+ tco.non_atm_amount/*case op.user_ref
                                                                                   when to_char(user_id) then tco.non_atm_amount
                                                                                   else              0
                                                                                 end*/),2)
                 else 0
               end),
           sum(case
                 when tco.op_type in ('OUT','ROUT') then
                   1
                 else 0
               end),
           sum(case
                 when tco.op_type in ('OUT','ROUT') then
                   round(decode(tv.kv,980,1,rato(tv.kv, v_dt)) * (tco.atm_amount+tco.non_atm_amount/*case op.user_ref
                                                                                   when to_char(user_id) then tco.non_atm_amount
                                                                                   else              0
                                                                                 end*/),2)
                 else 0
               end)
      into p_cnt_in,
           p_sum_in,
           p_cnt_out,
           p_sum_out
      from teller_opers op, tabval tv, teller_cash_opers tco, teller_state ts
      where ((v_eq_type = 'A' and  ts.eq_ip = g_eq_url)
             or
             (v_eq_type = 'M' and ts.user_ref = user_id)
            )
        and ts.work_date = v_dt
        and ts.user_ref = op.user_ref
        and op.work_date = ts.work_date
        and op.amount != 0
        and (nvl(op.doc_ref,op.id) = tco.doc_ref or op.id = tco.doc_ref)
        and tco.cur_code in (tv.lcv,to_char(tv.kv))
        and not (op.state = 'RJ' and v_eq_type = 'M')
        and ((op.oper_ref = 'TOX' and exists (select 1 from oper o where o.ref = op.doc_ref and o.sos = 5))
             or op.oper_ref != 'TOX') ;
     p_cnt_in := nvl(p_cnt_in,0);
     p_sum_in := nvl(p_sum_in,0);
     p_cnt_out := nvl(p_cnt_out,0);
     p_sum_out := nvl(p_sum_out,0);
  exception
    when others then
      bars_audit.info('Не вдалось отримати статистику по Теллеру!('||sqlerrm||')');
      null;
  end compute_teller_stats;

  function get_teller_doc_status (p_doc_ref in number)
    return number
    is
    v_progname varchar2(100) := g_package_name||'.get_teller_doc_status';
    v_errtxt   varchar2(2000);
    v_ret number;
  begin
    select case op.state
             when 'RJ' then -1
             when 'OK' then 1
             else 0
           end
      into v_ret
      from teller_opers op
      where op.doc_ref = p_doc_ref;
    return v_ret;
  exception
    when no_data_found then
      return -2;
    when others then
      v_errtxt := v_progname||'. Помилка при виклику функції: '||sqlerrm;
      bars_audit.error(v_errtxt);
      raise_application_error(-20100,v_errtxt);
  end;

  function validate_visa (p_visa in number
                         ,p_docref in number
                         ,p_errtxt out varchar2)
    return number
    is
    v_progname varchar2(100) := g_package_name || '.Validate_Visa';
    v_cnt number;
    v_rec t_record;
    v_errtxt varchar2(2000);
    v_teller_eq varchar2(1) := teller_utils.get_equip_type();
  begin

    select op.tt,
           op.kv,
           op.s/100,
           op.sq/100,
           is_sw_oper(p_docref),
           (select count(1) from teller_oper_define od where op.tt  = od.oper_code and od.equip_ref = teller_utils.get_eq_id())
      into v_rec.tt,
           v_rec.cur,
           v_rec.sum_cur,
           v_rec.sum_uah,
           v_rec.sw,
           v_cnt
      from oper op
      where op.ref = p_docref;

    if v_rec.tt = 'TOX' then
      return 0;
    end if;
    if v_cnt = 0 then
      p_errtxt := 'Операція [tt = '||v_rec.tt||'] не описана в довіднику операцій Теллера. Візування неможливе!';
      return -1;
    end if;


    select count(1) into v_cnt
      from teller_opers
      where doc_ref = p_docref;
    if v_cnt = 0 and check_lim_operation(p_rec => v_rec, p_err => p_errtxt) = -1 then
      return -1;
    end if;

    if v_teller_eq = 'A' then
      for r in (select * from teller_opers where doc_ref = p_docref)
      loop
        case p_visa
          when 1  then
            if r.state != 'OK' then
              p_errtxt := 'Документ Теллера не опрацьовано з АТМ, візування неможливе!';
              return -1;
            else
              return 1;
            end if;
          when 2 then
            if r.state != 'OK' then
              p_errtxt := 'Документ Теллера не опрацьовано з АТМ, візування неможливе!';
              return -1;
            else
              return 1;
            end if;
          when 3 then
            if r.state not in ('RJ','RX') then
              p_errtxt := 'Документ Теллера не опрацьовано з АТМ, візування неможливе!';
              return -1;
            else
              return 1;
            end if;
          else
            return 0;
        end case;
      end loop;
    else
      if p_visa = 3  then -- (сторно)
        update teller_opers
          set state = 'RJ'
          where doc_ref = p_docref;
/*        delete from teller_cash_opers
          where doc_ref = p_docref;*/
      elsif p_visa in (1,2) then
        declare
          v_amn number;
          v_lim number;
        begin
          select sum(od.sq/100 * decode(od.dk,0,1,-1))
            into v_amn
             from opldok od, accounts ac
             where ref = p_docref
               and od.acc = ac.acc
               and ac.nls like '100%';

          if v_amn > 0 then
            select sum((tco.atm_amount + tco.non_atm_amount) * decode(tco.op_type,'IN',1,'RIN',1,-1)
                        * decode(tv.kv,980,1,rato(tv.kv,g_bars_dt)))
              into v_lim
              from teller_opers op, teller_cash_opers tco, tabval tv
              where op.user_ref = g_user_id
                and op.work_date = g_bars_dt
                and (nvl(op.doc_ref,op.id) = tco.doc_ref or op.id = tco.doc_ref)
                and tco.cur_code  in (to_char(tv.kv), tv.lcv)
                and nvl(op.doc_ref,op.id) != p_docref;
            v_lim := teller_utils.get_eq_limit() - v_lim;
            if v_amn>v_lim then
              p_errtxt := 'Візування документа призведе до порушення ліміту залишку теллера: доступна сума = '||v_lim||', сума приймання = '||v_amn;
              return -1;
            end if;
          end if;
        end;
      end if;

    end if;

    return 0;
  exception
    when others then
      p_errtxt := v_progname ||'. '||sqlerrm;
      logger.info('TELLER: '||p_errtxt||dbms_utility.format_call_stack);
      return -1;
  end validate_visa;

  function is_teller_doc (p_docref in number)
    return number
    is
  begin
--    return 0;
    for r in (select oper_ref from teller_opers where doc_ref = p_docref)
    loop
      if r.oper_ref = 'TOX' then
        return 0;
      end if;
      return 1;
    end loop;
    return 0;
  end is_teller_doc;

  function start_cashin (p_cur_code in varchar2 default '980'
                        ,p_errtxt out varchar2)
    return number
    is
    v_ret number;
    v_id  number;
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;


    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    v_ret := teller_soap_api.get_current_dev_status();
    if v_ret not in (1000,1500,9200) then
      p_errtxt := teller_soap_api.get_current_dev_status_desc();
      return 0;
    end if;

    insert into teller_opers (oper_ref,
                              amount,
                              state,
                              cur_code,
                              active_cur
                              )
                values ('TOX',0,'IN',teller_utils.get_r030(p_cur_code),p_cur_code)
      returning id
      into v_id;
    teller_utils.set_active_oper(v_id);
    if teller_utils.get_equip_type() = 'M' then
      p_errtxt := 'Ініційована операція внесення грошей в темпокасу';
      return 0;
    end if;
    v_ret := teller_soap_api.OpenOperation;
    if v_ret = 1 then
      v_ret := teller_soap_api.OccupyOperation;
      if v_ret = 1 then
        v_ret :=teller_soap_api.StartCashinOperation;
        if v_ret = 1 then
          p_errtxt := 'Покладіть гроші до АТМ';
          v_ret := 1;
        else
          p_errtxt := 'Помилка при спробі розпочати роботу з АТМ.';
        end if;
      elsif v_ret = 3 then
        p_errtxt := 'АТМ заблокований іншим користувачем';
        v_ret := 0;
      else
        p_errtxt := 'Помилка при сбробі заблокувати АТМ. Код = '||v_ret;
        v_ret := 0;
      end if;
    end if;
    return v_ret;
  exception
    when others then
        p_errtxt := sqlerrm;
        return 0;
  end start_cashin;

  function StoreCashin (p_errtxt out varchar2)
    return number
    is
    v_ret number;
    v_num number := teller_utils.get_active_oper();
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    v_ret := teller_soap_api.StatusOperation;
    if teller_soap_api.get_current_dev_status() not in (1000,1500,9200,2003) then
      p_errtxt := 'АТМ працює. Поточний статус: '||teller_soap_api.get_current_dev_status_desc();
      return 0;
    end if;
    if teller_soap_api.StoreCashinOperation = 1 then
      select replace(nvl(tr.oper_amount_txt,'Операція приймання коштів не виконувалась'),', ','<br/>'),
             oper_amount
        into p_errtxt,
             v_ret
        from teller_requests tr
        where tr.req_id = teller_soap_api.get_last_cash_request_id;
/*      if v_ret > get_user_amount then
        v_ret := teller_soap_api.CancelCashinOperation();
        p_errtxt := 'Операція приймання готівки призведе до порушення ліміту "Теллера". Операція відмінена. Заберіть гроші в АТМ';
        return 0;
      end if;*/
      v_ret := 1;
    else
      p_errtxt := 'Ошибка при выполнении операции';
      v_ret := 0;
    end if;
    return v_ret;
  end;

  function EndCashin (p_non_atm_amount in number
                     ,p_curcode        in varchar2 default '980'
                     ,p_errtxt out varchar2)
    return number
    is
    v_ret number := 1;
    v_req_id number;
    v_oper_id number := teller_utils.get_active_oper();
    v_cur_code varchar2(3) := p_curcode;--teller_utils.get_active_curcode();
  begin
logger.info('Teller endcashin p_non_atm_amount = '||p_non_atm_amount||', p_curcode = '||p_curcode);

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    if p_non_atm_amount != 0 then

      if round(p_non_atm_amount * case p_curcode  
                                    when '980' then 1
                                    when 'UAH' then 1
                                    else rato(teller_utils.get_r030(p_curcode),g_bars_dt)
                                  end,2)>get_user_amount() then
        p_errtxt := 'Внесення в темпокассу призведе до порушення ліміту теллера!';
        return 0;
      end if;
      insert into teller_opers (oper_ref,
                            amount,
                            state,
                            cur_code,
                            active_cur
                            )
        values('TOX',p_non_atm_amount,'IT',teller_utils.get_r030(p_curcode),p_curcode)
        returning id
        into v_oper_id;

      save_cash_oper(v_oper_id,'IN',p_curcode,0,p_non_atm_amount,p_non_atm_amount,2);
      teller_utils.set_active_oper(v_oper_id);
    end if;

    if teller_utils.get_equip_type() != 'M' then
/*
      insert into teller_opers (oper_ref,
                                amount,
                                state,
                                cur_code
                                )
                  values ('TOX',p_non_atm_amount,'IT',teller_utils.get_r030(p_curcode))
        returning id
        into v_oper_id;
        teller_utils.set_active_oper(v_oper_id);

        save_cash_oper(v_oper_id,'IN',teller_utils.get_r030(p_curcode),0,p_non_atm_amount);
        teller_utils.set_active_oper(null);
        p_errtxt := 'В темпокасу прийнято суму '||p_non_atm_amount||' '||p_curcode;
        return 1;
    end if;
*/

      v_ret := Teller_Soap_Api.EndCashinOperation;
      v_req_id := teller_soap_api.get_last_cash_request_id;
      if v_ret = 1 then
/*      begin
        select replace(tr.oper_amount_txt,', ','<br/>'),
               tr.req_id,
               op.cur_code
          into p_errtxt,
               v_req_id,
               v_cur_code
          from teller_requests tr, teller_opers op
          where op.id = v_oper_id
            and tr.oper_amount!=0
            and op.req_ref = tr.req_id;
         if p_non_atm_amount!=0 then
           p_errtxt := p_errtxt||',<br/>'||'в темпокасу прийнято: '||p_non_atm_amount||' '||p_curcode;
         end if;
      exception
        when no_data_found then
          p_errtxt := 'Приймання банкнот в АТМ не виконувалось!<br/>Сума приймання в темпокасу: '||p_non_atm_amount||' '||p_curcode;
      end;
*//*
      select tr.req_id
        into v_req_id
        from teller_requests tr, teller_opers op
        where op.id = get_active_oper()
          and op.req_ref = tr.req_id;*/
-- сохраняем кассовую операцию по приходу
        for q in (select r.oper_amount amount
                    from teller_requests r/*,
                         tabval v,
                         xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                     'http://www.glory.co.jp/gsr.xsd' as "n"),
                                       'soapenv:Envelope/soapenv:Body/n:EndCashinResponse/Cash/Denomination' passing r.xml_response
                                        columns
                                        cur_code varchar2(3) path '@n:cc',
                                        nominal  number      path '@n:fv',
                                        pieces   number      path 'n:Piece') t*/
                    where req_id = v_req_id
                   /*  and t.cur_code = v.lcv
                      and t.cur_code = teller_utils.get_cur_code(v_cur_code)*/
                  )
        loop
/*          if q.cur_code != v_cur_code then
            null;
          end if;*/
/*        update teller_opers
          set amount = q.amount-- + p_non_atm_amount
          where id = v_oper_id
            and oper_ref = 'TOX'
            and cur_code = q.cur_code;
*/
          if q.amount != 0 then
            insert into teller_opers (oper_ref,
                                        amount,
                                        state,
                                        cur_code,
                                        active_cur
                                        )
              values ('TOX',q.amount,'IA',teller_utils.get_r030(p_curcode),teller_utils.get_r030(p_curcode))
              returning id
              into v_oper_id;

           save_cash_oper(v_oper_id,'IN',v_cur_code,q.amount,0,q.amount,2);
           teller_utils.set_active_oper(v_oper_id);
          end if;
        end loop;
        v_ret := teller_soap_api.InventoryOperation;


        if not (teller_soap_api.ReleaseOperation = 1 and teller_soap_api.CloseOperation = 1) then
--        p_errtxt := 'Помилка при звільненні сесії на АТМ';
          bars_audit.info('Помилка при звільненні сесії на АТМ');
--        return 0;
        end if;
      end if;
    end if;
    p_errtxt := teller_utils.create_cashin_message();
    delete from teller_opers where oper_ref = 'TOX' and amount = 0;
    teller_utils.set_active_oper(null);
    return v_ret;
  exception
   when others then
     p_errtxt := 'Виникла помилка при виконанні операції: '||sqlerrm;
     bars_audit.error(p_errtxt);
     return 0;
  end EndCashin;

  function CancelCashin (p_errtxt out varchar2)
    return number
    is
    v_ret number;
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    v_ret := Teller_Soap_Api.CancelCashinOperation;
    if v_ret = 1 then
      if not (teller_soap_api.ReleaseOperation = 1 and teller_soap_api.CloseOperation = 1) then
        p_errtxt := 'Помилка при звільненні сесії на АТМ';
        bars_audit.info(p_errtxt);
        return 0;
      end if;
      teller_utils.set_active_oper(null);
    end if;
    p_errtxt := 'Операцію завантаження АТМ відмінена';
    return v_ret;
  end CancelCashin;

  function EndCashout (p_non_atm_amount in number
                      ,p_curcode        in varchar2 default '980'
                      ,p_errtxt out varchar2)
    return number
    is
    v_ret number := -1;
    v_req_id number;
    v_curr_oper number;
    v_cur_code  number;
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

      v_curr_oper := teller_utils.get_active_oper();
      v_cur_code  := teller_utils.get_r030(p_curcode);
      if teller_utils.get_equip_type() = 'M' then
        insert into teller_opers (oper_ref,state,cur_code,amount)
          values ('TOX','OT',v_cur_code, p_non_atm_amount)
          returning id into v_ret;

        teller_utils.set_active_oper(v_ret);

        save_cash_oper(v_ret,'OUT',v_cur_code,0,p_non_atm_amount,p_non_atm_amount,2);
        p_errtxt := teller_utils.create_cashout_message;
        teller_utils.set_active_oper(null);
        return 1;
      end if;
--    if v_ret = 1 then
/*      for r in (select tr.oper_amount_txt
                  from teller_requests tr
                  where tr.oper_ref = v_curr_oper
                    and tr.req_meth = 'CollectOperation'
                  order by tr.req_id desc)
      loop
        p_errtxt := replace(r.oper_amount_txt,', ','<br/>');
        exit;
      end loop;*/
--      p_errtxt := 'Вилучено: '||p_errtxt;

      select max(tr.req_id)
        into v_req_id
        from teller_requests tr
        where tr.oper_ref = v_curr_oper
          and tr.req_meth = 'CollectOperation';
-- сохраняем кассовую операцию по приходу
/*      for q in (select cur_code, sum(nominal * pieces) amount
                  from teller_requests r,
                       xmltable(xmlnamespaces('http://schemas.xmlsoap.org/soap/envelope/' as "soapenv",
                                                   'http://www.glory.co.jp/gsr.xsd' as "n"),
                                     'soapenv:Envelope/soapenv:Body/n:CollectResponse/Cash/Denomination' passing r.xml_response
                                      columns
                                      cur_code varchar2(3) path '@n:cc',
                                      nominal  number      path '@n:fv',
                                      pieces   number      path 'n:Piece') t
                  where req_id = v_req_id
                  group by cur_code)
      loop
        v_ret := q.amount;
bars_audit.info('Teller: cash_oper after end cashout (2) request');
        save_cash_oper(teller_utils.get_active_oper,'OUT',q.cur_code,q.amount,p_non_atm_amount);
      end loop;*/
/*      if v_ret <= 0  then
        insert into teller_opers (oper_ref,state,cur_code,amount)
          values ('TOX','OU',v_cur_code, p_non_atm_amount)
          returning id into v_ret;
        teller_utils.set_active_oper(v_ret);
bars_audit.info('Teller: cash_oper after end cashout (3) request');
        save_cash_oper(teller_utils.get_active_oper,'OUT',teller_utils.get_r030(p_curcode),0,p_non_atm_amount);
      end if;*/
    if nvl(p_non_atm_amount,0) != 0 then
      insert into teller_opers (oper_ref,state,cur_code,amount)
        values ('TOX','OT',v_cur_code,p_non_atm_amount)
        returning id into v_curr_oper;

/*      insert into teller_cash_opers (doc_ref, op_type, cur_code,atm_amount, non_atm_amount,last_dt,last_user)
        values (v_curr_oper,'OUT',v_cur_code,0,p_non_atm_amount,sysdate,g_ws_name);*/
      teller_utils.set_active_oper(v_curr_oper);
      save_cash_oper(v_curr_oper,'OUT',v_cur_code,0,p_non_atm_amount,p_non_atm_amount,2);
    end if;
      p_errtxt := teller_utils.create_cashout_message;
      teller_utils.set_active_oper(null);
      v_ret := teller_soap_api.InventoryOperation;
/*      if not (teller_soap_api.ReleaseOperation = 1 and teller_soap_api.CloseOperation = 1) then
--        p_errtxt := 'Помилка при звільненні сесії на АТМ';
        bars_audit.info('Помилка при звільненні сесії на АТМ');
--        return 0;
      end if;*/
--    end if;
/*      if p_non_atm_amount != 0 then
        p_errtxt := p_errtxt ||'<br/>З Темпокаси видано '||p_non_atm_amount||' '||p_curcode;
      end if;
      p_errtxt := nvl(p_errtxt,'Не було видано жодної банкноти');
*/
    return v_ret;
  exception
    when no_data_found then
      p_errtxt := 'Не було видано жодної банкноти';
      return 1;
    when others then
      p_errtxt := 'Виникла помилка при виконанні операції: '||sqlerrm;
      bars_audit.error(p_errtxt);
      return 0;
  end EndCashout;


  function EndCashout (p_errtxt out varchar2)
    return integer
    is
    v_oper_id integer;
    v_tempo   varchar2(2000);
    v_collection_box varchar2(2000);
    v_num            number;
  begin

    if check_atm = 1 then
      p_errtxt := 'АТМ заблоковано в зв"язку з помилкою мережі. Необхідно виконати ручне врегулювання в меню теллера!';
      return 0;
    end if;

    for r in (select * from v_teller_state where user_ref = g_user_id and nvl(non_atm_amount,0) !=0)
    loop
      insert into teller_opers (oper_ref,state, amount,cur_code,req_ref)
        values ('TOX','OT',r.non_atm_amount,teller_utils.get_r030(r.cur_code),-1)
        returning id into v_oper_id;
      save_cash_oper(v_oper_id,'OUT',teller_utils.get_r030(r.cur_code),0,r.non_atm_amount,r.non_atm_amount,2);

/*      insert into teller_cash_opers (doc_ref,
                                     op_type,
                                     cur_code,
                                     atm_amount,
                                     non_atm_amount,
                                     last_dt,
                                     last_user,
                                     atm_status)
        values (v_oper_id,
                'OUT',
                teller_utils.get_r030(r.cur_code),
                0,
                r.non_atm_amount,
                sysdate,
                g_ws_name,
                2);*/
      teller_utils.set_active_oper(v_oper_id);
    end loop;

/*    begin
      select listagg(teller_utils.get_cur_name(op.cur_code)||': '||to_char(co.atm_amount),'<br/>') within group (order by op.cur_code)
        into p_errtxt
        from teller_opers op,
             teller_state ts,
             teller_cash_opers co
        where ts.user_ref = g_user_id
          and ts.work_date = g_bars_dt
          and op.id between ts.start_oper and ts.active_oper
          and co.doc_ref = op.id
          and op.state = 'OA';
      if p_errtxt is not null then
        p_errtxt := '<b>З АТМ вилучено</b>: <br/>'||p_errtxt;
      end if;
    exception
      when no_data_found then null;
      when others then p_errtxt := sqlerrm;
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
          and op.state = 'OC';
      if v_collection_box is not null then
        v_collection_box := 'ЗНОШЕНІ: <br/>'||v_collection_box;
      end if;
    exception
      when no_data_found then null;
      when others then v_collection_box := sqlerrm;
    end;

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
          and op.state = 'OT';
      if v_tempo is not null then
        v_tempo := '<b>З Темпокаси вилучено</b>: <br/>'||v_tempo;
      end if;
    exception
      when no_data_found then null;
      when others then v_tempo := sqlerrm;
    end;

  if p_errtxt is null and v_collection_box is null and v_tempo is null then
    p_errtxt := 'Немає чого вилучати!';
  else
    p_errtxt := p_errtxt||'<br/>'||v_collection_box||'<br/>'||v_tempo;
  end if;*/
  p_errtxt := teller_utils.create_cashout_message;
  teller_utils.set_active_oper(null);
  if teller_utils.get_equip_type = 'A' then
    v_num := teller_soap_api.InventoryOperation;
  end if;
  return 1;
  exception
    when others then
      p_errtxt := 'Помилка при вивантаженні АТМ: '||sqlerrm;
      bars_audit.info(p_errtxt);
      return 0;
  end EndCashout;

  procedure confirm_tox (p_oper_ref in number
                        ,p_doc_ref  in number)
    is
  begin
    for r in (select * from teller_collection_opers where id = p_oper_ref)
    loop
      execute immediate 'update teller_opers set doc_ref = '||p_doc_ref||', state = ''OK'' where id in ('||r.oper_ref||')';
      if sql%rowcount > 0 then
        bars_audit.info('teller_tools.confirm_tox. Для запису з ID = '||p_oper_ref||' записано референс документа '||p_doc_ref);
      else
        bars_audit.info('teller_tools.confirm_tox. Не знайдено запису з ID = '||p_oper_ref||' для операції ТОХ');
      end if;
    end loop;
    update teller_collection_opers
      set state = 'OK',
          doc_ref = p_doc_ref,
          last_dt = sysdate,
          CANDELETE = 0
      where id = p_oper_ref;
  exception
    when others then
      bars_audit.info('teller_tools.confirm_tox. При оновленні запису з ID = '||p_oper_ref||' виникла помилка'||sqlerrm);
  end;

  function check_doc (p_opercode in  varchar2
                     ,p_amn      in  number
                     ,p_amnuah   in  number
                     ,p_curcode  in  varchar2
                     ,p_docref   in  number default null
                     ,p_errtxt   out varchar2)
    return number
    is
    v_num integer := 0;
    v_rec t_record;
    v_amn number; --:= decode(p_amnuah,0,p_amn,p_amnuah)/100;
    v_sw_flag integer;
  begin

    if p_opercode = 'TOX' or teller_tools.get_teller() = 0 then
      v_num := 1;
      return v_num;
    end if;

    select count(1)
      into v_num
      from teller_opers op,
           teller_cash_opers co,
           oper o
      where op.user_ref = g_user_id
        and op.work_date = g_bars_dt
        and op.oper_ref = 'TOX'
        and op.id = co.doc_ref
        and co.op_type = 'IN'
        and op.doc_ref = o.ref
        and o.sos = 5;
    if v_num = 0 then
      p_errtxt := 'Заборонено виконувати операцію з обслуговування клієнта до проведення підкріплення';
      return -2;
    end if;

    if p_opercode = 'TOX' or teller_tools.get_teller() = 0 then
      v_num := 1;
      return v_num;
    end if;

    if nvl(p_amnuah,0) = 0  then
      if p_curcode = 980 then
        v_amn := p_amn/100;
      else
        v_amn := round(p_amn/100 * rato(p_kv => p_curcode, p_dat => gl.bd),2);
      end if;
    else
      v_amn := p_amnuah/100;
    end if;

    select count(1)
      into v_num
      from teller_stations ts
      where ts.station_name = g_ws_name;
    if v_num = 0 then
      p_errtxt := 'Відсутній опис робочої станції в довіднику "Робоча станція - тип техніки"';
      return -3;
    end if;
    v_num := 0;
    for r in (select max_amount, sw_flag
                from teller_oper_define
                where oper_code = p_opercode
                  and equip_ref = teller_utils.get_eq_id)
    loop
      v_sw_flag := nvl(r.sw_flag,0);
      if r.max_amount<v_amn and nvl(r.sw_flag,0) = 0 then
        p_errtxt := 'Для операції встановлений ліміт '||r.max_amount||'грн, який менше суми операції '||v_amn||'грн';
        return -1;
      end if;
      if get_type_operation(p_docref) = 'IN' and  v_amn > get_user_amount() and  nvl(r.sw_flag,0) = 0 then
        p_errtxt := 'Операція [tt = '||p_opercode||', amn = '||v_amn||'грн] призведе до порушення ліміту залишку теллера';
        return -2;
      elsif get_type_operation(p_op_code => p_opercode) = 'IN' and  v_amn > get_user_amount() and  nvl(r.sw_flag,0) = 0 then
        p_errtxt := 'Операція [tt = '||p_opercode||', amn = '||v_amn||'грн] призведе до порушення ліміту залишку теллера';
        return -2;
      end if;
      v_num := 1;
    end loop;
    if v_num = 0 then
      p_errtxt := 'Операція відсутня в довіднику "Операції Теллера та допустимі ліміти"';
      return -3;
    end if;
    v_num := write_oper(p_op_code       => p_opercode,
                        p_op_curr       => p_curcode,
                        p_op_amount     => p_amn/100,
                        p_op_amount_uah => p_amnuah/100,
                        p_doc_ref       => p_docref,
                        p_sw            => v_sw_flag);

    return 1;

  end;

  procedure refresh_cash
    is
  begin
    for r in (select op.id, op.doc_ref
                from teller_opers  op
                where user_ref = g_user_id
                  and work_date = g_bars_dt
                  and op.state not in (/*'I0','O0',*/'RJ','RX')
                  and not exists (select 1 from teller_cash_opers co where (co.doc_ref = op.doc_ref or co.doc_ref = op.id) and co.op_type != 'NONE')
                  and exists (select 1 from opldok where ref = op.doc_ref)
              )
    loop
      teller_tools.ins_cash_opers(p_doc_ref => r.id,p_nonatm => 0,p_atm => 0);
    end loop;


/*    delete from teller_cash_opers co
      where exists (select 1 from teller_opers op where (co.doc_ref = op.doc_ref or co.doc_ref = op.id) and op.state in ('RJ','RX'));*/
  end refresh_cash;


  procedure create_collect_oper
    is
    v_txt varchar2(160);
    v_flag integer :=1;
  begin
    update teller_collection_opers
      set state = 'RJ'
      where state = 'IN'
        and last_dt<trunc(sysdate);
    for r in (select teller_utils.get_r030(cur_code) cur_code, sum(op.amount) amount,  state, listagg(op.id,',') within group (order by state) ids
                from teller_opers op
                where user_ref = g_user_id
                  and work_date = gl.bDATE
                  and oper_ref = 'TOX'
                  and doc_ref is null
                  and amount != 0
                  and op.state in ('IC','IT','IA','OC','OT','OA')
                group by teller_utils.get_r030(cur_code), state
             )
    loop
      v_txt := case r.state
                     when 'IA' then 'Платіжні '
                     when 'IC' then 'зношені '
                     when 'IT' then 'дрібні '
                     when 'OA' then 'Платіжні '
                     when 'OC' then 'зношені '
                     when 'OT' then 'дрібні '
               end
               ||to_char(r.amount)||' '||teller_utils.get_cur_code(r.cur_code) ;
      if substr(r.state,2,1) != 'T' and r.amount >0 then
        v_flag := 0;
      end if;
      update  teller_collection_opers tco
        set tco.amount  = tco.amount + r.amount
           ,tco.purpose = substr(tco.purpose ||', '|| v_txt,1,160)
           ,tco.last_dt = sysdate
           ,tco.oper_ref = oper_ref||','||r.ids
           ,tco.Candelete = least(tco.candelete,v_flag)
        where tco.state = 'IN'
          and tco.cur = r.cur_code
          and tco.direction = substr(r.state,1,1)
          and tco.user_id = g_user_id;

      if sql%rowcount = 0 then
        insert into teller_collection_opers (id,
                                             oper_ref,
                                             state,
                                             amount,
                                             cur,
                                             purpose,
                                             doc_ref,
                                             last_dt,
                                             direction,
                                             user_id,
                                             candelete)
          values (s_teller_opers_id.nextval,
                  to_char(r.ids),
                  'IN',
                  r.amount,
                  r.cur_code,
                  substr(v_txt,1,160),
                  null,
                  sysdate,
                  substr(r.state,1,1),
                  g_user_id,
                  v_flag);
      end if;

      update teller_opers op
        set state = 'SN'
        where op.cur_code = r.cur_code
          and work_date = gl.bdate
          and user_ref = g_user_id
          and state = r.state;

    end loop;
  end create_collect_oper;

function check_doc (p_opercode in  varchar2
                     ,p_amn      in  number
                     ,p_amnuah   in  number
                     ,p_curcode  in  varchar2
                     ,p_docref   in  number default null
                     ,p_dk       in  number
                     ,p_nlsa     in varchar2
                     ,p_nlsb     in varchar2
                     ,p_errtxt   out varchar2)
    return number
    is
    v_num integer := 0;
    v_rec t_record;
    v_amn number; --:= decode(p_amnuah,0,p_amn,p_amnuah)/100;
    v_sw_flag integer;
  begin

    if p_opercode = 'TOX' or teller_tools.get_teller() = 0 then
      v_num := 1;
      return v_num;
    end if;

    select count(1)
      into v_num
      from teller_opers op,
           teller_cash_opers co,
           oper o,
           teller_state ts
      where ((g_eq_type = 'A' and  ts.eq_ip = g_eq_url)
             or
             (g_eq_type = 'M' and ts.user_ref = user_id)
            )
        and ts.user_ref = op.user_ref
        and op.work_date = g_bars_dt
        and op.oper_ref = 'TOX'
        and op.id = co.doc_ref
        and co.op_type = 'IN'
        and op.doc_ref = o.ref
        and o.sos = 5;
    if v_num = 0 then
      p_errtxt := 'Заборонено виконувати операцію з обслуговування клієнта до проведення підкріплення';
      return -2;
    end if;


    if nvl(p_amnuah,0) = 0  then
      if p_curcode = 980 then
        v_amn := p_amn/100;
      else
        v_amn := round(p_amn/100 * rato(p_kv => p_curcode, p_dat => gl.bd),2);
      end if;
    else
      v_amn := p_amnuah/100;
    end if;

    select count(1)
      into v_num
      from teller_stations ts
      where ts.station_name = g_ws_name;
    if v_num = 0 then
      p_errtxt := 'Відсутній опис робочої станції в довіднику "Робоча станція - тип техніки"';
      return -3;
    end if;
    v_num := 0;
    for r in (select max_amount, sw_flag
                from teller_oper_define
                where oper_code = p_opercode
                  and equip_ref = teller_utils.get_eq_id)
    loop
      v_sw_flag := nvl(r.sw_flag,0);
      if r.max_amount<v_amn and v_sw_flag = 0 then
        p_errtxt := 'Для операції встановлений ліміт '||r.max_amount||'грн, який менше суми операції '||v_amn||'грн';
        return -1;
      end if;
      if ((p_dk = 0 and p_nlsb like '100%') or (p_dk = 1 and p_nlsa like '100%'))
         and v_amn > get_user_amount() and v_sw_flag = 0 then
        p_errtxt := 'Операція [tt = '||p_opercode||', amn = '||v_amn||'грн] призведе до порушення ліміту залишку теллера';
        return -2;
      elsif p_docref is not null and get_type_operation(p_docref) = 'IN' and  v_amn > get_user_amount() and v_sw_flag = 0then
        p_errtxt := 'Операція [tt = '||p_opercode||', amn = '||v_amn||'грн] призведе до порушення ліміту залишку теллера';
        return -2;
      elsif get_type_operation(p_op_code => p_opercode) = 'IN' and  v_amn > get_user_amount() and v_sw_flag = 0 then
        p_errtxt := 'Операція [tt = '||p_opercode||', amn = '||v_amn||'грн] призведе до порушення ліміту залишку теллера';
        return -2;
      end if;
      v_num := 1;
    end loop;
    if v_num = 0 then
      p_errtxt := 'Операція '||p_opercode||' відсутня в довіднику "Операції Теллера та допустимі ліміти"';
      return -3;
    end if;
    v_num := write_oper(p_op_code       => p_opercode,
                        p_op_curr       => p_curcode,
                        p_op_amount     => p_amn/100,
                        p_op_amount_uah => p_amnuah/100,
                        p_doc_ref       => p_docref,
                        p_sw            => v_sw_flag);

    return 1;
  exception
    when others then
      logger.info('Teller: Помилка при перевірці документа Теллера: '||sqlerrm);
      return 1;
  end check_doc;

  function delete_TOX (p_id     in integer
                      ,p_errtxt out varchar2)
    return number
    is
    v_oper_list teller_collection_opers.oper_ref%type;
  begin
    for r in (select * from teller_collection_opers where id = p_id)
    loop
      if r.doc_ref is not null then
        p_errtxt := 'Заборонено видаляти операцію інкасації, по якій сформовані проведення!';
        return 1;
      end if;
      v_oper_list := r.oper_ref;
    end loop;
    delete from teller_opers
      where id in (SELECT column_value
                  FROM TABLE(tools.string_to_words(v_oper_list ,p_splitting_symbol => ','))
                  );

    delete from teller_collection_opers
      where id = p_id;

    return 0;
  end delete_TOX;

  function reject_doc (p_doc_ref in number
                      ,p_errtxt  out varchar2)
    return integer
    is
    v_ret integer;
  begin
    if teller_utils.get_equip_type() != 'M' and get_type_operation(p_doc_ref=>p_doc_ref) != 'NONE' then
      p_errtxt := 'Сторнування документів без обробки в вікні Теллера заборонено!';
      return 1;
    end if;
    for r in (select * from teller_opers where doc_ref = p_doc_ref)
    loop
      if r.oper_ref = 'TOX' then
        p_errtxt := 'Сторнування документів ТОХ для Теллера заборонено!';
        return 1;
      elsif r.state in ('RJ','RX') then
--        p_errtxt := 'Документ вже відмінений в документах теллера';
        v_ret := 0;
      elsif g_eq_type = 'M' then
        update teller_opers
          set state = 'RJ'
          where doc_ref = p_doc_ref;
        insert into teller_cash_opers (doc_ref,
                                       op_type,
                                       cur_code,
                                       atm_amount,
                                       non_atm_amount,
                                       oper_amount,
                                       atm_status,
                                       last_dt,
                                       last_user)
          select doc_ref, decode(op_type,'IN','ROUT','OUT','RIN'),cur_code,0,case g_eq_type
                                                                               when 'M' then non_atm_amount
                                                                               else 0
                                                                             end,
                non_atm_amount,2,sysdate,g_ws_name
            from teller_cash_opers
            where doc_ref = r.id;
      end if;
      v_ret := 0;
    end loop;
    return v_ret;
  end reject_doc;

  function check_teller_status (p_errtxt out varchar2)
    return integer
    is
    v_num number;
  begin
    select count(1)
      into v_num
      from teller_opers op, oper o
      where op.user_ref  = g_user_id
        and op.work_date = g_bars_dt
        and op.doc_ref   = o.ref
        and o.sos != 5 and o.sos>=0;
    if v_num>0 then
      p_errtxt := 'У користувача є незавізовані (або несторновані) проведення!';
    end if;

    for cur in (select tco.cur_code, sum(case tco.op_type
                             when 'IN' then 1
                             when 'RIN' then 1
                             when 'OUT' then -1
                             when 'ROUT' then -1
                             else 0
                          end * (tco.atm_amount + tco.non_atm_amount)
                         ) as diff
                  from teller_cash_opers tco, teller_opers op
                  where op.user_ref = g_user_id
                    and op.work_date = g_bars_dt
                    and op.id = tco.doc_ref
                    and op.state = 'OK'
                  group by tco.cur_code)
    loop
      if cur.diff != 0 then
        p_errtxt := p_errtxt ||case
                                 when length(p_errtxt)> 0 then '<br/>'
                                 else ''
                               end||
          'Залишок коштів Теллера в валюті '||cur.cur_code||' не нульовий: '||to_char(cur.diff)||'. Необхідно зробити повне вилучення!';
      end if;
    end loop;

    if p_errtxt is not null then
      return 0;
    else
      return 1;
    end if;
  end check_teller_status;

/* процедура установки статуса АТМ
-- АТМ, который надо проаллертить определяется из настроек пользователя, для которого выполняется операция, либо можно будет указать вручную в параметре p_atm
-- если процедура вызывается без параметров, то АТМ текущего пользователя будет заблокирован для операций
-- для того, чтобы снять блокировку надо вызвать процедуру с указанием в параметре p_flag значения 0
*/
  function reset_atm_fault (p_errtxt out varchar2)
    return number
    is
  begin
    set_atm_fault(p_flag => 0);
    return 1;
  end;
  procedure set_atm_fault (p_flag in number default 1
                          ,p_atm in varchar2 default null
                          ,p_user in varchar2 default null)
  is
    v_atm_url  varchar2(20) := nvl(p_atm,g_eq_url);
    v_oper_ref number       := teller_utils.get_active_oper;
    v_userid   number;
    v_bars_dt  date := g_bars_dt;
  begin
logger.info('Teller1. p_flag = '||p_flag||', p_atm = '||p_atm||', p_user = '||p_user);
    if check_atm = p_flag then
      logger.info('Teller ничего не делаем!');
      return;
    end if;
    if p_user is not null then
      select s.id into v_userid
        from staff$base s
        where s.logname = p_user;
      bars_login.login_user(sys_guid,v_userid, sys_context('userenv','host'),'Teller');
      bc.home;
      v_bars_dt := gl.bd;
      select ts.eq_ip, ts.active_oper
        into v_atm_url, v_oper_ref
        from teller_state ts
        where ts.user_ref =  v_userid
          and ts.work_date = v_bars_dt;
---      v_atm_url :=  teller_utils.get_device_url();
logger.info('Teller2. v_userid = '||v_userid||', v_atm_url = '||v_atm_url);
    end if;
    if p_flag = 0 then
      update teller_atm_status t
        set blocked = 0
        where t.equip_ip = v_atm_url
          and t.work_date = v_bars_dt;
    end if;
    -- установка признака блокировки по АТМ
    logger.info('v_atm_url = '||v_atm_url);
    logger.info('v_oper_ref = '||v_oper_ref);
    update teller_atm_status t
      set t.blocked = p_flag
      where t.equip_ip = v_atm_url
        and t.work_date = v_bars_dt
        and nvl(v_oper_ref,0)!= 0;
    logger.info('rows = '||sql%rowcount);
    -- для текущей кассовой операции выставляем признак "оборванной" для последующего ручногоразбора
    update teller_cash_opers c
      set c.atm_status = -1 
      where c.doc_ref = v_oper_ref
        and c.atm_status = 1;
    logger.info('rows2 = '||sql%rowcount);
    update teller_state ts
    set active_oper = null
    where ts.user_ref = v_userid 
      and ts.work_date = v_bars_dt;
    null;
  end set_atm_fault;

  procedure resolve_atm_fault (p_atm_id in varchar2
                              ,p_tel_id in number)
  is
    v_num number;
  begin
    update teller_atm_opers
      set oper_ref = p_tel_id
      where rowid = CHARTOROWID(p_atm_id);
    
    update teller_cash_opers o
      set o.atm_status = 2
      where o.doc_ref = p_tel_id
        and o.atm_status = 1;

    select count(1) into v_num
      from teller_atm_opers ta
      where ta.eq_ip = g_eq_url
        and trunc(ta.oper_time)>g_bars_dt
        and ta.oper_ref is null
        and ta.amount != 0;
    if v_num = 0 then
      update teller_atm_status ts
        set ts.blocked = 0
        where ts.equip_ip = g_eq_url  
          and ts.work_date = g_bars_dt;
    end if;
  end resolve_atm_fault;



end teller_tools;
/
 show err;
 
PROMPT *** Create  grants  TELLER_TOOLS ***
grant EXECUTE                                                                on TELLER_TOOLS    to BARS_CONNECT;
grant EXECUTE                                                                on TELLER_TOOLS    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/teller_tools.sql =========*** End **
 PROMPT ===================================================================================== 
 