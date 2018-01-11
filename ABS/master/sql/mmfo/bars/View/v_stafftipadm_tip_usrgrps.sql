

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_USRGRPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_TIP_USRGRPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_TIP_USRGRPS ("IDG", "NAME", "SEC_SEL", "SEC_DEB", "SEC_CRE") AS 
  select a.id, a.name, s.sec_sel sel, s.sec_deb deb, s.sec_cre cre
  from groups a, stafftip_grp s
 where a.id  = s.idg
   and s.idu = sys_context('bars_useradm', 'stafftip_id');

PROMPT *** Create  grants  V_STAFFTIPADM_TIP_USRGRPS ***
grant SELECT                                                                 on V_STAFFTIPADM_TIP_USRGRPS to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_TIP_USRGRPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFFTIPADM_TIP_USRGRPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFFTIPADM_TIP_USRGRPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_TIP_USRGRPS.sql =========
PROMPT ===================================================================================== 
