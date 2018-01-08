

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_1S.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_1S ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_1S ("B", "E", "KOD3K", "TAG", "DAT", "RNK", "SOS", "NTIK", "NBS", "OB22", "ACC", "NLS", "S") AS 
  select B, E, KOD3K, NVL(swap_tag,deal_tag) tag, dat, rnk, sos , ntik, nbs, ob22, acc, nls,  Sum(s) S     from V_FXANI_0P
 group by B, E, KOD3K, NVL(swap_tag,deal_tag) ,    dat, rnk, sos , ntik, nbs, ob22, acc, nls;

PROMPT *** Create  grants  V_FXANI_1S ***
grant SELECT                                                                 on V_FXANI_1S      to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXANI_1S      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_1S      to START1;
grant SELECT                                                                 on V_FXANI_1S      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_1S.sql =========*** End *** ===
PROMPT ===================================================================================== 
