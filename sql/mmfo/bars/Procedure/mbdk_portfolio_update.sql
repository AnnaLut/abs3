CREATE OR REPLACE PROCEDURE BARS.MBDK_PORTFOLIO_UPDATE(p_ND cc_add.nd%type, p_N_NBU cc_add.n_nbu%type, p_D_NBU date) IS

/* Версия 1.0 

   Изменение параметров договора МБДК 2700  
*/

begin
    update cc_add set n_nbu = p_n_nbu, d_nbu = p_d_nbu where nd = p_nd and adds = 0;
end;
/

show err;

grant execute on MBDK_PORTFOLIO_UPDATE to RCC_DEAL;
grant execute on MBDK_PORTFOLIO_UPDATE to start1;
grant execute on MBDK_PORTFOLIO_UPDATE to BARS_ACCESS_DEFROLE;

