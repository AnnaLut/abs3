

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BM_COUNT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BM_COUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BM_COUNT ("ACC", "KV", "NLS", "BRANCH", "KOD", "NAME", "FDAT", "C_INP", "DOS0", "DOS1", "KOS1", "KOS0", "C_OUT", "OB22") AS 
  select x.acc, a.kv, a.nls, a.branch, x.kod, b.name ,  x.FDAT, x.C_Inp, x.dos0, x.dos1 , x.kos1 , x.kos0 ,  x.C_Out , a.ob22
from v_GL a, BM_COUNT x , bank_metals b where a.acc= x.acc and to_char(b.kod) = x.kod ;

PROMPT *** Create  grants  V_BM_COUNT ***
grant SELECT                                                                 on V_BM_COUNT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BM_COUNT      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BM_COUNT.sql =========*** End *** ===
PROMPT ===================================================================================== 
