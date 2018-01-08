

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAL_AUDIT_CONNECT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAL_AUDIT_CONNECT ***

  CREATE OR REPLACE TRIGGER BARS.TAL_AUDIT_CONNECT 
after logon on database
/*
  Триггер вызывает пустую процедуру только для прямых соединений, 
  не через proxy-пользователя. 
  Выполнение процедуры протоколируется с помощью системного аудита.
  Таким образом отслеживаются соединения к БД. 
  Простой способ а-ля AUDIT SESSION не подходит, 
  т.к. появляется очень много соединений через proxy-пользователя при работе из WEB.   
*/
begin
  if sys_context ('userenv', 'proxy_user') is null and ora_login_user<>'APPSERVER' then
  	 audit_me;
  end if;  
end; 




/
ALTER TRIGGER BARS.TAL_AUDIT_CONNECT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAL_AUDIT_CONNECT.sql =========*** E
PROMPT ===================================================================================== 
