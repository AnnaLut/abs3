

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FX_PL_CAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FX_PL_CAL ***

  CREATE OR REPLACE FORCE VIEW BARS.FX_PL_CAL ("B", "DAT", "KV", "SA", "KA", "SB", "KB", "S") AS 
  SELECT  B, DAT, KV, SUM(SA) SA, sum(KA) KA, SUM(SB) SB, sum(KB) KB, SUM(SA-SB) S 
from ( select V.B, V.E, dat_a DAT, kva KV, sum(suma)/100 SA, count(*) KA, 0             SB, 0        KB 
       from fx_deal x, V_SFDAT v  where x.dat_a >= v.b  GROUP BY V.B,V.E, dat_a,kva
   union all 
       select V.B, V.E, dat_b DAT, kvb KV, 0             SA,       0  KA, sum(sumb)/100 SB, count(*) KB 
       from fx_deal x, V_SFDAT v  where x.dat_B >= v.b GROUP BY V.B, V.E, dat_B, kvB    
) GROUP BY   B,  DAT  , KV;

PROMPT *** Create  grants  FX_PL_CAL ***
grant SELECT                                                                 on FX_PL_CAL       to BARSREADER_ROLE;
grant SELECT                                                                 on FX_PL_CAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_PL_CAL       to START1;
grant SELECT                                                                 on FX_PL_CAL       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FX_PL_CAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
