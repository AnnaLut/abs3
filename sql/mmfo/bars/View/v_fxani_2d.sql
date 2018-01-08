

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_2D.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_2D ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_2D ("B", "E", "KOD3K", "TAG", "DAT", "RNK", "SOS", "NTIK", "S") AS 
  select B, E, KOD3K, NVL(swap_tag,deal_tag) tag, dat, rnk, sos , ntik, Sum(s) S       from V_FXANI_0P
 group by B, E, KOD3K, NVL(swap_tag,deal_tag) , dat, rnk, sos , ntik;

PROMPT *** Create  grants  V_FXANI_2D ***
grant SELECT                                                                 on V_FXANI_2D      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_2D      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_2D.sql =========*** End *** ===
PROMPT ===================================================================================== 
