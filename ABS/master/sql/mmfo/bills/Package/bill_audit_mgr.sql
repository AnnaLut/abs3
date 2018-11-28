
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/bill_audit_mgr.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BILLS.BILL_AUDIT_MGR is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 04-May-18 21:44:28
  -- Purpose : јудит / логи

g_header_version constant varchar2(64) := 'Version 1.0.0 03/07/2018';

function header_version return varchar2;
function body_version return varchar2;


-- Ћогирование действий пользовател€ (видны в истории)
procedure log_action (p_action    in bill_audit.action%type
                     ,p_key       in integer
                     ,p_params    in bill_audit.param_str%type
                     ,p_result    in bill_audit.result%type
                     ,p_log_level in bill_audit.log_level%type default 'INFO');

-- Ћогирование отладочных сообщений (не выводимых обычному пользователю) - обмен данными, Ё÷ѕ
procedure trace (p_action    in bill_audit.action%type
                ,p_key       in integer
                ,p_params    in bill_audit.param_str%type
                ,p_result    in bill_audit.result%type);

-- Ћогирование ошибок дл€ отладки (не выводимых обычному пользователю) - обмен данными, Ё÷ѕ
procedure error (p_action    in bill_audit.action%type
                ,p_key       in integer
                ,p_params    in bill_audit.param_str%type
                ,p_result    in bill_audit.result%type);

end BILL_AUDIT_MGR;
/
CREATE OR REPLACE PACKAGE BODY BILLS.BILL_AUDIT_MGR is


g_body_version constant varchar2(64) := 'Version 1.0.0 03/07/2018';
g_package_name constant varchar2(20) := 'bill_audit_mgr';


--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
    return 'Package header '||g_package_name|| ' ' || g_header_version;
end header_version;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
    return 'Package body '||g_package_name|| ' ' || g_body_version;
end body_version;



procedure log_action (p_action    in bill_audit.action%type
                     ,p_key       in integer
                     ,p_params    in bill_audit.param_str%type
                     ,p_result    in bill_audit.result%type
                     ,p_log_level in bill_audit.log_level%type default 'INFO')
  is
  pragma autonomous_transaction;
begin
  insert into bill_audit (id,
                          rec_date,
                          user_ref,
                          action,
                          key_id,
                          result,
                          param_str,
                          log_level)
   values (s_bill_audit_id.nextval,
           sysdate,
           bsm.f_username,
           p_action,
           p_key,
           substr(p_result, 1, 2000),
           p_params,
           p_log_level);
  commit;
end;

procedure trace (p_action    in bill_audit.action%type
                ,p_key       in integer
                ,p_params    in bill_audit.param_str%type
                ,p_result    in bill_audit.result%type)
is
begin
    log_action(p_action, p_key, p_params, p_result, 'TRACE');
end trace;

procedure error (p_action    in bill_audit.action%type
                ,p_key       in integer
                ,p_params    in bill_audit.param_str%type
                ,p_result    in bill_audit.result%type)
is
begin
    log_action(p_action, p_key, p_params, p_result, 'ERROR');
end error;

end BILL_AUDIT_MGR;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/bill_audit_mgr.sql =========*** End
 PROMPT ===================================================================================== 
 