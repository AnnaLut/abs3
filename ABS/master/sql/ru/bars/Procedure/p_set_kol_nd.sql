PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/P_SET_KOL_ND.sql ========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_SET_KOL_ND ***

CREATE OR REPLACE PROCEDURE BARS.P_SET_KOL_ND (p_dat01 date, p_nd integer, p_tipa integer, kol_n number) IS

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату - звітність
   -------------------------------------
*/

BEGIN
   begin

      update kol_nd_dat   set dat   = p_dat01 , nd   = p_nd  , tipa = p_tipa, kol = kol_n   where  nd = p_nd and dat = p_dat01 and tipa = p_tipa ;

      IF SQL%ROWCOUNT=0 then
         Insert into BARS.kol_nd_dat  (dat    , nd  , tipa  , kol  ) Values (p_dat01, p_nd, p_tipa, kol_n);
      END IF;
   end; 
END;
/
show err;

PROMPT *** Create  grants  P_SET_KOL_ND ***
grant EXECUTE   on P_SET_KOL_ND    to BARS_ACCESS_DEFROLE;
grant EXECUTE   on P_SET_KOL_ND    to RCC_DEAL;
grant EXECUTE   on P_SET_KOL_ND    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SET_KOL_ND.sql =========*** End 
PROMPT ===================================================================================== 

