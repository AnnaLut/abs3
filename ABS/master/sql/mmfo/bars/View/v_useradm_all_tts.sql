

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_TTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_TTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_TTS ("TT", "NAME") AS 
  select a.tt, a.name
  from tts a
 where substr(a.flags,1,1) = '1'
   and tt not in ( select tt
                     from op_rules
                    where tag = 'ISOFF' and val = '1'
                 )
minus
select a.tt, a.name
  from tts a, staff_tts l
 where a.tt = l.tt
   and l.id = sys_context('bars_useradm', 'user_id');

PROMPT *** Create  grants  V_USERADM_ALL_TTS ***
grant SELECT                                                                 on V_USERADM_ALL_TTS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_ALL_TTS to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_ALL_TTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_TTS.sql =========*** End 
PROMPT ===================================================================================== 
