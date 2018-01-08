

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CREDITDATA_QUESTS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_CREDITDATA_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_CREDITDATA_QUESTS ("BID_ID", "CRDDATA_ID", "CRDDATA_NAME", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "IS_CALCABLE", "IS_READONLY", "IS_CHECKABLE", "CHECK_PROC", "HAS_REL") AS 
  SELECT b.id AS bid_id,
            scd.crddata_id,
            cb.name AS crddata_name,
            scd.question_id,
            q.name AS question_name,
            q.type_id,
            q.is_calcable,
            wcs_utl.calc_sql_bool (b.id, scd.is_readonly) AS is_readonly,
            scd.is_checkable,
            scd.check_proc,
            wcs_utl.has_related_creditdata (scd.subproduct_id, scd.crddata_id)
               AS has_rel
       FROM wcs_bids b,
            wcs_subproduct_creditdata scd,
            wcs_creditdata_base cb,
            wcs_questions q
      WHERE     b.subproduct_id = scd.subproduct_id
            AND scd.crddata_id = cb.id
            AND scd.question_id = q.id
            AND scd.is_visible = 1
            AND (SELECT SUM (wcs_utl.has_bid_state (b.id, s.id))
                   FROM wcs_states s
                  WHERE    ','
                        || cb.state_id
                        || ',NEW_SBP_SELECTING,NEW_PRESCORING' LIKE
                           '%,' || s.id || ',%') > 0
            AND (scd.dnshow_if IS NULL
                 OR wcs_utl.calc_sql_bool (b.id, scd.dnshow_if) != 1)
   ORDER BY b.id, cb.ord;

PROMPT *** Create  grants  V_WCS_BID_CREDITDATA_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_CREDITDATA_QUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_CREDITDATA_QUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_CREDITDATA_QUESTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CREDITDATA_QUESTS.sql =======
PROMPT ===================================================================================== 
