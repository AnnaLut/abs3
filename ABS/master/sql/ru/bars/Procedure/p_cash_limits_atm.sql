

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CASH_LIMITS_ATM.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CASH_LIMITS_ATM ***

  CREATE OR REPLACE PROCEDURE BARS.P_CASH_LIMITS_ATM (P_ACC number,
                             P_BRANCH varchar2,
                             P_LIM_CURRENT number,
                             P_LIM_MAX number,
                             P_LIM_DATE date) is
begin
update BARS.V_CASH_LIMITS_ATM set LIM_CURRENT = P_LIM_CURRENT, LIM_MAX = P_LIM_MAX, LIM_DATE = P_LIM_DATE where ACC = P_ACC and BRANCH = P_BRANCH;
end;
/
show err;

PROMPT *** Create  grants  P_CASH_LIMITS_ATM ***
grant EXECUTE                                                                on P_CASH_LIMITS_ATM to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CASH_LIMITS_ATM.sql =========***
PROMPT ===================================================================================== 
