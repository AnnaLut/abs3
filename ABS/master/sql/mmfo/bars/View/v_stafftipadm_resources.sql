

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_RESOURCES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFFTIPADM_RESOURCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFFTIPADM_RESOURCES ("RES_ID", "RES_NAME", "RES_CODE", "RES_TIPSGRNTTAB_ID", "RES_TIPSGRNTTAB_NAME", "RES_TIPSACCSTAB_ID", "RES_TIPSACCSTAB_NAME") AS 
  select l.res_id,
       l.res_name,
       l.res_code,
       t1.tabid            res_tipsgrnttab_id,
       l.res_grntviewname  res_tipsgrnttab_name,
       t2.tabid            res_tipsaccstab_id,
       l.res_accsviewname  res_tipsaccstab_name
  from sec_resources b, sec_resources l,
       meta_tables t1, meta_tables t2
 where b.res_code = 'USER'
   and b.res_id   = l.res_parentid
   and 'Y' = decode(l.res_condition, null, 'Y',
                    bars_useradm.check_resource_condition(l.res_condition))
   and l.res_tipsgrntviewname = t1.tabname
   and l.res_tipsaccsviewname = t2.tabname;

PROMPT *** Create  grants  V_STAFFTIPADM_RESOURCES ***
grant SELECT                                                                 on V_STAFFTIPADM_RESOURCES to ABS_ADMIN;
grant SELECT                                                                 on V_STAFFTIPADM_RESOURCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFFTIPADM_RESOURCES.sql =========**
PROMPT ===================================================================================== 
