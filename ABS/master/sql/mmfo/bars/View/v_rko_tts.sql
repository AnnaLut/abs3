

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_TTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_TTS ("TT", "DK", "NTAR") AS 
  SELECT "TT","DK","NTAR" FROM RKO_TTS;

PROMPT *** Create  grants  V_RKO_TTS ***
grant SELECT                                                                 on V_RKO_TTS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RKO_TTS       to START1;
grant SELECT                                                                 on V_RKO_TTS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_TTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
