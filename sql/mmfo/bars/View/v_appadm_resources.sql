

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_RESOURCES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_RESOURCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_RESOURCES ("RES_ID", "RES_NAME", "RES_GRNTTAB_ID", "RES_GRNTTAB_NAME", "RES_GRNTTAB_SEMANTIC", "RES_ACCSTAB_ID", "RES_ACCSTAB_NAME", "RES_ACCSTAB_SEMANTIC") AS 
  select s.res_id, s.res_name, tg.tabid, tg.tabname, tg.semantic,
       ta.tabid, ta.tabname, ta.semantic
   from sec_resources s, meta_tables tg, meta_tables ta, sec_resources r
  where s.res_grntviewname = tg.tabname
    and s.res_accsviewname = ta.tabname
    and s.res_parentid     = r.res_id
    and r.res_code         = 'APPLICATION'
union
select s.res_id, s.res_name, tg.tabid, tg.tabname, tg.semantic, ta.tabid, ta.tabname, ta.semantic
   from sec_resources s, meta_tables tg, meta_tables ta, sec_resources r
  where s.res_grntviewname = tg.tabname
    and s.res_accsviewname = ta.tabname
    and s.res_id           = r.res_parentid
    and r.res_code         = 'APPLICATION'
 ;

PROMPT *** Create  grants  V_APPADM_RESOURCES ***
grant SELECT                                                                 on V_APPADM_RESOURCES to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_RESOURCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_RESOURCES.sql =========*** End
PROMPT ===================================================================================== 
