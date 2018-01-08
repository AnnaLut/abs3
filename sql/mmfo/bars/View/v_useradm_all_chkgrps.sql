

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_CHKGRPS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_ALL_CHKGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_ALL_CHKGRPS ("CHKID", "NAME") AS 
  select a.idchk, a.name
  from chklist a
minus
select a.idchk, a.name
  from chklist a, staff_chk l
 where a.idchk = l.chkid
   and l.id    = sys_context('bars_useradm', 'user_id')
 ;

PROMPT *** Create  grants  V_USERADM_ALL_CHKGRPS ***
grant SELECT                                                                 on V_USERADM_ALL_CHKGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_ALL_CHKGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_ALL_CHKGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_ALL_CHKGRPS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_ALL_CHKGRPS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_ALL_CHKGRPS.sql =========*** 
PROMPT ===================================================================================== 
