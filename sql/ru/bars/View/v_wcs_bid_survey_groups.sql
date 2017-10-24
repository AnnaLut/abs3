

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_SURVEY_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_SURVEY_GROUPS ("BID_ID", "SURVEY_ID", "GROUP_ID", "GROUP_NAME", "RESULT_QID", "IS_FILLED") AS 
  SELECT b.id AS bid_id,
            sg.survey_id AS survey_id,
            sg.id AS GROUP_ID,
            sg.name AS group_name,
            sg.result_qid,
            NVL (TO_NUMBER (wcs_utl.get_answ (b.id, sg.result_qid)), 0)
               AS is_filled
       FROM wcs_bids b, wcs_subproduct_survey ss, wcs_survey_groups sg /*,wcs_subproducts sb*/
      WHERE b.subproduct_id = ss.subproduct_id /*and sb.id=ss.subproduct_id
                                               and sb.end_date is null*/
                                              AND ss.survey_id = sg.survey_id
            AND (wcs_utl.calc_sql_bool (b.id, sg.dnshow_if) <> 1
                 OR sg.dnshow_if IS NULL)
            AND (SELECT COUNT (*)
                   FROM v_wcs_bid_survey_group_quests sgq
                  WHERE     sgq.bid_id = b.id
                        AND sgq.survey_id = sg.survey_id
                        AND sgq.GROUP_ID = sg.id) > 0
   ORDER BY b.id, sg.survey_id, sg.ord;

PROMPT *** Create  grants  V_WCS_BID_SURVEY_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 
