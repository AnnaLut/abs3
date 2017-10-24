

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_CR_DP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBU23_CR_DP ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBU23_CR_DP (p_dat01 date) IS

/* Версия 1.0 29-01-2017
   Заполнение данных в NBU23_REZ (дополнительные параметры)
   -------------------------------------

*/

 l_s080   specparam.s080%type  ;

BEGIN
   return;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало REZ_CR --> NBU23_REZ (DP) 351 ');

   for k in (select   ACC, OVKR, P_DEF, OVD  , OPD, FIN_Z, tip_fin
             from     REZ_CR where fdat = p_dat01 and OVKR || P_DEF || OVD || OPD || FIN_Z is not null
            )
   LOOP

      l_s080 := f_get_s080 (p_dat01,k.tip_fin, k.fin_z);
      update NBU23_rez set OVKR = k.OVKR, P_DEF = k.P_DEF, OVD = k.OVD, OPD = k.OPD, FIN_Z = k.FIN_Z, s080_Z = l_s080
      where  fdat = p_dat01 and acc=k.acc;

   end LOOP;

   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец REZ_CR --> NBU23_REZ (DP) 351 ');
END;
/
show err;

PROMPT *** Create  grants  P_NBU23_CR_DP ***
grant EXECUTE                                                                on P_NBU23_CR_DP   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NBU23_CR_DP   to RCC_DEAL;
grant EXECUTE                                                                on P_NBU23_CR_DP   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_CR_DP.sql =========*** End
PROMPT ===================================================================================== 
