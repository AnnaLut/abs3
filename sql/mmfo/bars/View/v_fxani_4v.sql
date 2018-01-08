

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_4V.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_4V ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_4V ("B", "E", "KOD3K", "SOS", "S") AS 
  select B, E, KOD3K, sos, Sum(s) S     from V_FXANI_0P group by B, E, KOD3K, sos;

PROMPT *** Create  grants  V_FXANI_4V ***
grant SELECT                                                                 on V_FXANI_4V      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_4V      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_4V.sql =========*** End *** ===
PROMPT ===================================================================================== 
