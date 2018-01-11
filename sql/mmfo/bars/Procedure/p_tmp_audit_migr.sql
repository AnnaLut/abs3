

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TMP_AUDIT_MIGR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TMP_AUDIT_MIGR ***

  CREATE OR REPLACE PROCEDURE BARS.P_TMP_AUDIT_MIGR (p_string_value in VARCHAR2)
 as
 pragma autonomous_transaction;
 begin
 insert into TMP_AUDIT_MIGR values (p_string_value, sysdate);
 commit;
 end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TMP_AUDIT_MIGR.sql =========*** 
PROMPT ===================================================================================== 
