

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PRIOCOM_FGA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PRIOCOM_FGA ***

  CREATE OR REPLACE PROCEDURE BARS.P_PRIOCOM_FGA (object_schema varchar2,object_name varchar2,policy_name varchar2) is
/**
 Процедура для протоколирования доступа к объектам *priocom* с помощью FGA
 */
begin
  priocom_audit.trace(sys_context('userenv','current_sql'));
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PRIOCOM_FGA.sql =========*** End
PROMPT ===================================================================================== 
