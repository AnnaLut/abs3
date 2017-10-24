

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PAR_ACCOUNTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PAR_ACCOUNTS ***

  CREATE OR REPLACE PROCEDURE BARS.P_PAR_ACCOUNTS (p_acc accounts.acc%type,
       p_isp    out  nbu23_rez.isp%type,
       p_branch out  nbu23_rez.branch%type,
       p_ob22   out  nbu23_rez.ob22%type)
is

/* Версия 1.0 03-01-2016
   Параметры по ACCOUNTS
   ISP
   BRANCH,
   OB22
*/


begin
   begin
      select isp, branch, ob22 into p_isp, p_branch, p_ob22 from accounts where acc = p_acc;
   exception when no_data_found then p_isp := NULL; p_branch := NULL; p_ob22 := NULL;
   end;
end;
/
show err;

PROMPT *** Create  grants  P_PAR_ACCOUNTS ***
grant EXECUTE                                                                on P_PAR_ACCOUNTS  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PAR_ACCOUNTS  to RCC_DEAL;
grant EXECUTE                                                                on P_PAR_ACCOUNTS  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAR_ACCOUNTS.sql =========*** En
PROMPT ===================================================================================== 
