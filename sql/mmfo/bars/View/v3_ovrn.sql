

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V3_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V3_OVRN ("OK", "ND", "FDAT", "ACC", "LIM", "KV", "NLS", "PR") AS 
  select l.OK, l.ND, l.fdat, l.acc, l.lim/100 LIM, a.kv, a.nls  , l.PR
from accounts a, OVR_LIM l
where l.acc = a.acc
  and l.ND  =      to_number( pul.Get_Mas_Ini_Val('ND' ) )
  and l.acc = NVL( to_number( pul.Get_Mas_Ini_Val('ACC') ), a.acc) ;

PROMPT *** Create  grants  V3_OVRN ***
grant SELECT                                                                 on V3_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3_OVRN         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
