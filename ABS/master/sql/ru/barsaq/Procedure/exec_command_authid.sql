

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/EXEC_COMMAND_AUTHID.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EXEC_COMMAND_AUTHID ***

  CREATE OR REPLACE PROCEDURE BARSAQ.EXEC_COMMAND_AUTHID (p_command in varchar2) authid current_user as
-- выполение любого выражения с правами текущего пользователя (в контексте pl\sql текущая роль не учитываеться, таким способом можно обойти ограничение )
begin
    execute immediate p_command;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/EXEC_COMMAND_AUTHID.sql ========
PROMPT ===================================================================================== 
