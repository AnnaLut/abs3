

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_AUDIT_SQL_STMT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_AUDIT_SQL_STMT ***

  CREATE OR REPLACE PROCEDURE BARS.P_AUDIT_SQL_STMT (object_schema varchar2,object_name varchar2,policy_name varchar2) is
begin
  bars_audit.info('FGA: '||sys_context('userenv','current_sql'));
end; 
/
show err;

PROMPT *** Create  grants  P_AUDIT_SQL_STMT ***
grant EXECUTE                                                                on P_AUDIT_SQL_STMT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_AUDIT_SQL_STMT.sql =========*** 
PROMPT ===================================================================================== 
