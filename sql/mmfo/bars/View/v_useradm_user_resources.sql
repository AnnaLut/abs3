

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_RESOURCES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_USER_RESOURCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_USER_RESOURCES ("RES_ID", "RES_CODE", "RES_NAME", "RES_PARENTID", "RES_TABNAME", "RES_USERCOL", "RES_GRNTVIEWNAME", "RES_ACCSVIEWNAME", "RES_APPROVE") AS 
  select l.res_id,
       l.res_code,
       l.res_name,
       l.res_parentid,
       l.res_tabname,
       l.res_usercol,
       l.res_grntviewname,
       l.res_accsviewname,
       l.res_approve
  from sec_resources b, sec_resources l
 where b.res_code = 'USER'
   and l.res_type = 'U'
   and b.res_id   = l.res_parentid
 ;

PROMPT *** Create  grants  V_USERADM_USER_RESOURCES ***
grant SELECT                                                                 on V_USERADM_USER_RESOURCES to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_USER_RESOURCES to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_USER_RESOURCES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_USER_RESOURCES.sql =========*
PROMPT ===================================================================================== 
