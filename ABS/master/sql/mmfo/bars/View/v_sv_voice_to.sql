

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_VOICE_TO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_VOICE_TO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_VOICE_TO ("ID", "FULL_NAME") AS 
  SELECT o.id, o.nm1||' '||o.nm2||' '||o.nm3 full_name
     FROM sv_owner o;

PROMPT *** Create  grants  V_SV_VOICE_TO ***
grant SELECT                                                                 on V_SV_VOICE_TO   to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_VOICE_TO   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_VOICE_TO   to RPBN002;
grant SELECT                                                                 on V_SV_VOICE_TO   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_VOICE_TO.sql =========*** End *** 
PROMPT ===================================================================================== 
