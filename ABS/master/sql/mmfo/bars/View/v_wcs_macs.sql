

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_MACS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_MACS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_MACS ("MAC_ID", "MAC_NAME", "TYPE_ID", "TYPE_NAME", "APPLY_LEVEL", "APPLY_LEVEL_NAME") AS 
  select m.id          as mac_id,
       m.name        as mac_name,
       m.type_id,
       mt.name       as type_name,
       m.apply_level,
       sh.name       as apply_level_name
  from wcs_macs m, wcs_mac_types mt, wcs_srv_hierarchy sh
 where m.type_id = mt.id
   and m.apply_level = sh.id
 order by m.id;

PROMPT *** Create  grants  V_WCS_MACS ***
grant SELECT                                                                 on V_WCS_MACS      to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_MACS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_MACS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_MACS.sql =========*** End *** ===
PROMPT ===================================================================================== 
