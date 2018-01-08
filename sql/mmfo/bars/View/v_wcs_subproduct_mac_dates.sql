

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_MAC_DATES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_MAC_DATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_MAC_DATES ("SUBPRODUCT_ID", "MAC_ID", "MAC_NAME", "TYPE_ID", "TYPE_NAME", "APPLY_LEVEL", "APPLY_LEVEL_NAME", "BRANCH", "APPLY_DATE", "VAL", "VAL_TEXT", "VAL_NUMB", "VAL_DECIMAL", "VAL_DATE", "VAL_LIST", "VAL_REFER", "VAL_FILE", "VAL_BOOL") AS 
  select sm.subproduct_id,
       sm.mac_id,
       m.name as mac_name,
       m.type_id,
       mt.name as type_name,
       m.apply_level,
       sh.name as apply_level_name,
       sm.branch,
       sm.apply_date,
       wcs_utl.get_sbp_mac_formated(sm.subproduct_id,
                                    sm.mac_id,
                                    sm.branch,
                                    sm.apply_date) as val,
       sm.val_text,
       sm.val_numb,
       sm.val_decimal,
       sm.val_date,
       sm.val_list,
       sm.val_refer,
       sm.val_file,
       sm.val_bool
  from wcs_subproduct_macs sm,
       wcs_macs            m,
       wcs_mac_types       mt,
       wcs_srv_hierarchy   sh
 where sm.mac_id = m.id
   and m.type_id = mt.id
   and m.apply_level = sh.id
 order by sm.subproduct_id, sm.mac_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_MAC_DATES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MAC_DATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MAC_DATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SUBPRODUCT_MAC_DATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_MAC_DATES.sql ========
PROMPT ===================================================================================== 
