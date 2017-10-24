

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FGA_TRACER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FGA_TRACER ***

  CREATE OR REPLACE PROCEDURE BARS.FGA_TRACER (object_schema varchar2,object_name varchar2,policy_name varchar2) is
  --
  -- Трассировка идентификаторов пользователя, сессии, текущего SQL-запроса и его BIND-переменных
  --
begin
  bars_audit.trace('FGA: user_id=%s, client_identifier=%s%scurrent_sql=%s%scurrent_bind=%s',
    sys_context('bars_global','user_id'),
    sys_context('userenv','client_identifier'),chr(10),
    sys_context('userenv','current_sql',4000),chr(10),
    sys_context('userenv','current_bind',4000)
  );
end fga_tracer;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FGA_TRACER.sql =========*** End **
PROMPT ===================================================================================== 
