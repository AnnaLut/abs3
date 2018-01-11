

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USERADM_RESOURCES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USERADM_RESOURCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USERADM_RESOURCES ("RES_ID", "RES_NAME", "RES_GRNTTAB_ID", "RES_GRNTTAB_NAME", "RES_ACCSTAB_ID", "RES_ACCSTAB_NAME") AS 
  select l.res_id,
       l.res_name,
       t1.tabid            res_grnttab_id,
       l.res_grntviewname  res_grnttab_name,
       t2.tabid            res_accstab_id,
       l.res_accsviewname  res_accstab_name
  from sec_resources b, sec_resources l,
       meta_tables t1, meta_tables t2
 where b.res_code = 'USER'
   and b.res_id   = l.res_parentid
   and 'Y' = decode(l.res_condition, null, 'Y',
                    bars_useradm.check_resource_condition(l.res_condition))
   and l.res_grntviewname = t1.tabname
   and l.res_accsviewname = t2.tabname
 ;

PROMPT *** Create  grants  V_USERADM_RESOURCES ***
grant SELECT                                                                 on V_USERADM_RESOURCES to ABS_ADMIN;
grant SELECT                                                                 on V_USERADM_RESOURCES to BARSREADER_ROLE;
grant SELECT                                                                 on V_USERADM_RESOURCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USERADM_RESOURCES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_USERADM_RESOURCES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USERADM_RESOURCES.sql =========*** En
PROMPT ===================================================================================== 
