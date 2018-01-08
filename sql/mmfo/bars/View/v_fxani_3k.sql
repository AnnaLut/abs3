

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_3K.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_3K ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_3K ("B", "E", "KOD3K", "RNK", "SOS", "S", "NMK") AS 
  select f."B",f."E",f."KOD3K",f."RNK",f."SOS",f."S", c.nmk
from customer c, (select B,E,KOD3K,rnk,sos, Sum(s) S from V_FXANI_0P group by B,E,KOD3K,rnk,sos) f
where f.rnk = c.rnk ;

PROMPT *** Create  grants  V_FXANI_3K ***
grant SELECT                                                                 on V_FXANI_3K      to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXANI_3K      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_3K      to START1;
grant SELECT                                                                 on V_FXANI_3K      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_3K.sql =========*** End *** ===
PROMPT ===================================================================================== 
