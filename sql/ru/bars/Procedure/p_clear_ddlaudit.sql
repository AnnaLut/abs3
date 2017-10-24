

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CLEAR_DDLAUDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CLEAR_DDLAUDIT ***

  CREATE OR REPLACE PROCEDURE BARS.P_CLEAR_DDLAUDIT (p_date date)
is
begin
   delete from  bars.sec_ddl_audit where rec_date < p_date;
   commit;
end;
/
show err;

PROMPT *** Create  grants  P_CLEAR_DDLAUDIT ***
grant EXECUTE                                                                on P_CLEAR_DDLAUDIT to TECH001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CLEAR_DDLAUDIT.sql =========*** 
PROMPT ===================================================================================== 
