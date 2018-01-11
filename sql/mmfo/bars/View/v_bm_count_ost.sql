

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BM_COUNT_OST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BM_COUNT_OST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BM_COUNT_OST ("FDAT", "ACC", "KV", "NLS", "BRANCH", "KOD", "NAME", "OB22", "C_INP") AS 
  select  To_date( PUL.GET('DAT_BM') , 'dd.mm.yyyy') FDAT,  a.ACC, a.KV, a.NLS, a.BRANCH, To_char(b.kod) KOD , b.NAME, a.ob22,
        (select C_INP from BM_COUNT where acc= a.acc and kod = to_char(b.kod) and fdat = To_date( PUL.GET('DAT_BM') , 'dd.mm.yyyy') )  C_INP
from v_GL a,      bank_metals b
where a.nls = PUL.GET('NLS_BM')
--and a.kv = b.kv
and  exists (select 1 from BM_COUNT where acc= a.acc and kod =  To_char(b.kod) );

PROMPT *** Create  grants  V_BM_COUNT_OST ***
grant SELECT                                                                 on V_BM_COUNT_OST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BM_COUNT_OST  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BM_COUNT_OST.sql =========*** End ***
PROMPT ===================================================================================== 
