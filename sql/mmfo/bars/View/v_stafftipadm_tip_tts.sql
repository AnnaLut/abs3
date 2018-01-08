

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_TTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_TIP_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_TIP_TTS ("TT", "NAME") AS 
  select a.tt, a.name
  from tts a, stafftip_tts s
 where a.tt = s.tt
   and s.id = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_TIP_TTS ***
grant SELECT                                                                 on V_STAFFTIPADM_TIP_TTS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_TIP_TTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_TTS.sql =========*** 
PROMPT ===================================================================================== 
