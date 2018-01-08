

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_CHKGRPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_ALL_CHKGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_ALL_CHKGRPS ("CHKID", "NAME") AS 
  select a.idchk, a.name
  from chklist a
 minus
select a.idchk, a.name
  from chklist a, stafftip_chk s
 where a.idchk = s.chkid
   and s.id = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_ALL_CHKGRPS ***
grant SELECT                                                                 on V_STAFFTIPADM_ALL_CHKGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_CHKGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_CHKGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFFTIPADM_ALL_CHKGRPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_ALL_CHKGRPS.sql =========
PROMPT ===================================================================================== 
