

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CREDITDATA_GROUPS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_CREDITDATA_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_CREDITDATA_GROUPS ("BID_ID", "GROUP_ID", "GROUP_NAME", "SUBPRODUCT_ID") AS 
  SELECT bid_id, GROUP_ID, group_name, subproduct_id
       FROM (SELECT DISTINCT b.id AS bid_id,
                             cg.id AS GROUP_ID,
                             cg.name AS group_name,
                             cg.ord,
                             b.subproduct_id
               FROM wcs_bids b,
                    wcs_subproduct_creditdata sc,
                    wcs_creditdata_groups cg
              WHERE b.subproduct_id = sc.subproduct_id AND sc.GROUP_ID = cg.id
                    AND (wcs_utl.calc_sql_bool (b.id, cg.dnshow_if) <> 1
                         OR cg.dnshow_if IS NULL)
                    AND (SELECT COUNT (*)
                           FROM v_wcs_bid_creditdata_quests cgq
                          WHERE cgq.bid_id = b.id AND cgq.GROUP_ID = cg.id) > 0)
   ORDER BY ord;

PROMPT *** Create  grants  V_WCS_BID_CREDITDATA_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_CREDITDATA_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CREDITDATA_GROUPS.sql =======
PROMPT ===================================================================================== 
