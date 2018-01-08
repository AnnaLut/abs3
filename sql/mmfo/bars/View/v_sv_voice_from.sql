

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_VOICE_FROM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_VOICE_FROM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_VOICE_FROM ("ID", "FULL_NAME") AS 
  SELECT o.id, o.nm1||' '||o.nm2||' '||o.nm3 full_name
     FROM sv_owner o;

PROMPT *** Create  grants  V_SV_VOICE_FROM ***
grant SELECT                                                                 on V_SV_VOICE_FROM to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_VOICE_FROM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_VOICE_FROM to RPBN002;
grant SELECT                                                                 on V_SV_VOICE_FROM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_VOICE_FROM.sql =========*** End **
PROMPT ===================================================================================== 
