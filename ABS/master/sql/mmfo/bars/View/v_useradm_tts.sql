

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_TTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_TTS ("ID", "NAME") AS 
  select tt, name from tts;

PROMPT *** Create  grants  V_USERADM_TTS ***
grant SELECT                                                                 on V_USERADM_TTS   to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_TTS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_TTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_TTS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_TTS.sql =========*** End *** 
PROMPT ===================================================================================== 
