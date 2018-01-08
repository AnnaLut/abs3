

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SBP_MAC_BRANCHES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SBP_MAC_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SBP_MAC_BRANCHES ("SUBPRODUCT_ID", "MAC_ID", "MAC_NAME", "TYPE_ID", "TYPE_NAME", "APPLY_LEVEL", "APPLY_LEVEL_NAME", "BRANCH", "BRANCH_NAME", "VAL") AS 
  select "SUBPRODUCT_ID","MAC_ID","MAC_NAME","TYPE_ID","TYPE_NAME","APPLY_LEVEL","APPLY_LEVEL_NAME","BRANCH","BRANCH_NAME","VAL"
  from (select sm.subproduct_id,
               sm.mac_id,
               sm.mac_name,
               sm.type_id,
               sm.type_name,
               sm.apply_level,
               sm.apply_level_name,
               sm.branch,
               sm.branch_name,
               wcs_utl.get_sbp_mac_formated(sm.subproduct_id,
                                            sm.mac_id,
                                            sm.branch,
                                            trunc(sysdate)) as val
          from (select subproduct_id,
                       mac_id,
                       mac_name,
                       type_id,
                       type_name,
                       apply_level,
                       apply_level_name,
                       branch,
                       branch_name
                  from v_wcs_sbp_mac_branch_dates
                 group by subproduct_id,
                          mac_id,
                          mac_name,
                          type_id,
                          type_name,
                          apply_level,
                          apply_level_name,
                          branch,
                          branch_name) sm
        union all
        select sm.subproduct_id,
               sm.mac_id,
               sm.mac_name,
               sm.type_id,
               sm.type_name,
               sm.apply_level,
               sm.apply_level_name,
               b.branch,
               b.name              as branch_name,
               null                as val
          from (select subproduct_id,
                       mac_id,
                       mac_name,
                       type_id,
                       type_name,
                       apply_level,
                       apply_level_name
                  from v_wcs_sbp_mac_branch_dates
                 group by subproduct_id,
                          mac_id,
                          mac_name,
                          type_id,
                          type_name,
                          apply_level,
                          apply_level_name) sm,
               branch b
         where length(b.branch) <=
               decode(sm.apply_level, 'CA', 1, 'RU', 8, 15)
           and (select count(*)
                  from wcs_subproduct_macs
                 where subproduct_id = sm.subproduct_id
                   and mac_id = sm.mac_id
                   and branch = b.branch) = 0)
 order by subproduct_id, mac_id, branch;

PROMPT *** Create  grants  V_WCS_SBP_MAC_BRANCHES ***
grant SELECT                                                                 on V_WCS_SBP_MAC_BRANCHES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SBP_MAC_BRANCHES.sql =========***
PROMPT ===================================================================================== 
