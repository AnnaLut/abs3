

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V30_OVRN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V30_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V30_OVRN ("OK", "ND", "FDAT", "ACC", "LIM", "KV", "NLS", "PR") AS 
  select l.OK, l.ND, l.fdat, l.acc, l.lim/100 LIM, a.kv, a.nls  , l.PR
from accounts a, OVR_LIM l
where l.acc = a.acc  and l.ND  =      to_number( pul.Get_Mas_Ini_Val('ND' ) ) ;

PROMPT *** Create  grants  V30_OVRN ***
grant SELECT                                                                 on V30_OVRN        to BARSREADER_ROLE;
grant SELECT                                                                 on V30_OVRN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V30_OVRN        to START1;
grant SELECT                                                                 on V30_OVRN        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V30_OVRN.sql =========*** End *** =====
PROMPT ===================================================================================== 
