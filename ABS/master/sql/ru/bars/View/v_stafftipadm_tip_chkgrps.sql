

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_CHKGRPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_TIP_CHKGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_TIP_CHKGRPS ("CHKID", "NAME") AS 
  select a.idchk, a.name
  from chklist a, stafftip_chk s
 where a.idchk = s.chkid
   and s.id = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_TIP_CHKGRPS ***
grant SELECT                                                                 on V_STAFFTIPADM_TIP_CHKGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_TIP_CHKGRPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_CHKGRPS.sql =========
PROMPT ===================================================================================== 
