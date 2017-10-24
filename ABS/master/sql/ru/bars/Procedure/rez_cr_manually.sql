

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_CR_MANUALLY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_CR_MANUALLY ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_CR_MANUALLY (p_dat01 date) IS

/* Версия 1.0 03-04-2017
   Ручной резерв (корректировка)
   -------------------------------------
*/

begin
   for k in ( select * from REZ_ND_PD_LGD where fdat = p_dat01 )
   LOOP
      p_ead_pd_LGD(p_dat01, k.RNK, k.ND, k.PD, k.LGD, k.fin);
   end LOOP;
end;
/
show err;

PROMPT *** Create  grants  REZ_CR_MANUALLY ***
grant EXECUTE                                                                on REZ_CR_MANUALLY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_CR_MANUALLY to RCC_DEAL;
grant EXECUTE                                                                on REZ_CR_MANUALLY to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_CR_MANUALLY.sql =========*** E
PROMPT ===================================================================================== 
