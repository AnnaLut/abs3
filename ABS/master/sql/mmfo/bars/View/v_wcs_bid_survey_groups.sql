

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_SURVEY_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_SURVEY_GROUPS ("BID_ID", "SURVEY_ID", "GROUP_ID", "GROUP_NAME", "RESULT_QID", "IS_FILLED") AS 
  select b.id as bid_id,
       sg.survey_id as survey_id,
       sg.id as group_id,
       sg.name as group_name,
       sg.result_qid,
       to_number(wcs_utl.get_answ(b.id, sg.result_qid)) as is_filled
  from wcs_bids b, wcs_subproduct_survey ss, wcs_survey_groups sg
 where b.subproduct_id = ss.subproduct_id
   and ss.survey_id = sg.survey_id
   and (wcs_utl.calc_sql_bool(b.id, sg.dnshow_if) <> 1 or
       sg.dnshow_if is null)
   and (select count(*)
          from v_wcs_bid_survey_group_quests sgq
         where sgq.bid_id = b.id
           and sgq.survey_id = sg.survey_id
           and sgq.group_id = sg.id) > 0
 order by b.id, sg.survey_id, sg.ord;

PROMPT *** Create  grants  V_WCS_BID_SURVEY_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUPS.sql =========**
PROMPT ===================================================================================== 
