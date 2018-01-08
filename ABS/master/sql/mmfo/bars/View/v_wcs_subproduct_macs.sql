

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_MACS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_MACS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_MACS ("SUBPRODUCT_ID", "MAC_ID", "MAC_NAME", "TYPE_ID", "TYPE_NAME", "APPLY_LEVEL", "APPLY_LEVEL_NAME", "VAL") AS 
  select sm.subproduct_id,
       sm.mac_id,
       sm.mac_name,
       sm.type_id,
       sm.type_name,
       sm.apply_level,
       sm.apply_level_name,
       wcs_utl.get_sbp_mac_formated(sm.subproduct_id,
                                    sm.mac_id,
                                    '/',
                                    trunc(sysdate)) as val
  from (select subproduct_id,
               mac_id,
               mac_name,
               type_id,
               type_name,
               apply_level,
               apply_level_name
          from v_wcs_sbp_mac_branches
         group by subproduct_id,
                  mac_id,
                  mac_name,
                  type_id,
                  type_name,
                  apply_level,
                  apply_level_name) sm
 order by sm.subproduct_id, sm.mac_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_MACS ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MACS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MACS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MACS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_MACS.sql =========*** 
PROMPT ===================================================================================== 
