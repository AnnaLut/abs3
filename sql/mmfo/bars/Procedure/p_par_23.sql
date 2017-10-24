

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PAR_23.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PAR_23 ***

  CREATE OR REPLACE PROCEDURE BARS.P_PAR_23 (p_dat01 date, p_acc accounts.acc%type, p_nd nbu23_rez.nd%type, p_ta number,
       p_fin    out  nbu23_rez.fin%type,
       p_obs    out  nbu23_rez.obs%type,
       p_kat    out  nbu23_rez.kat%type,
       p_k      out  nbu23_rez.k%type,
       p_irr    out  nbu23_rez.irr%type)
is

/* Версия 1.0 29-12-2016
   Параметры по 23 постанове из прошлого месяца
*/


begin
   begin
      select fin, obs, nvl(kat,1), k, irr into p_fin, p_obs, p_kat, p_k, p_irr from nbu23_rez
      where fdat = p_dat01 and nd = p_nd and tipa = p_ta and rownum = 1;
   exception when no_data_found then p_fin := 1; p_obs := 1; p_kat := 1; p_k := 0; p_irr := NULL;
   end;
end;
/
show err;

PROMPT *** Create  grants  P_PAR_23 ***
grant EXECUTE                                                                on P_PAR_23        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PAR_23        to RCC_DEAL;
grant EXECUTE                                                                on P_PAR_23        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAR_23.sql =========*** End *** 
PROMPT ===================================================================================== 
