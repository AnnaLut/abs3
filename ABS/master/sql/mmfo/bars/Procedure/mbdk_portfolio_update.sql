

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MBDK_PORTFOLIO_UPDATE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MBDK_PORTFOLIO_UPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.MBDK_PORTFOLIO_UPDATE (p_ND cc_add.nd%type, p_N_NBU cc_add.n_nbu%type, p_D_NBU date) IS

/* Версия 1.0

   Изменение параметров договора МБДК 2700
*/

begin
    update cc_add set n_nbu = p_n_nbu, d_nbu = p_d_nbu where nd = p_nd and adds = 0;
end;
/
show err;

PROMPT *** Create  grants  MBDK_PORTFOLIO_UPDATE ***
grant EXECUTE                                                                on MBDK_PORTFOLIO_UPDATE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBDK_PORTFOLIO_UPDATE to RCC_DEAL;
grant EXECUTE                                                                on MBDK_PORTFOLIO_UPDATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MBDK_PORTFOLIO_UPDATE.sql ========
PROMPT ===================================================================================== 
