

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_SURVEY_GROUPS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GRT_SURVEY_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GRT_SURVEY_GROUPS ("BID_ID", "GARANTEE_ID", "GARANTEE_NUM", "SURVEY_ID", "GROUP_ID", "GROUP_NAME", "RESULT_QID", "IS_FILLED") AS 
  select bg.bid_id,
       bg.garantee_id,
       bg.garantee_num,
       sg.survey_id as survey_id,
       sg.id as group_id,
       sg.name as group_name,
       sg.result_qid,
       to_number(wcs_utl.get_answ(bg.bid_id,
                                  sg.result_qid,
                                  bg.ws_id,
                                  bg.garantee_num)) as is_filled
  from v_wcs_bid_garantees bg, wcs_garantees g, wcs_survey_groups sg
 where bg.garantee_id = g.id
   and g.survey_id = sg.survey_id
   and (wcs_utl.calc_sql_bool(bg.bid_id,
                              sg.dnshow_if,
                              bg.ws_id,
                              bg.garantee_num) <> 1 or
       sg.dnshow_if is null)
   and (select count(*)
          from v_wcs_bid_grt_sur_group_quests sgq
         where sgq.bid_id = bg.bid_id
           and sgq.garantee_id = bg.garantee_id
           and sgq.garantee_num = bg.garantee_num
           and sgq.survey_id = sg.survey_id
           and sgq.group_id = sg.id) > 0
 order by bg.bid_id, bg.garantee_id, bg.garantee_num, sg.survey_id, sg.ord;

PROMPT *** Create  grants  V_WCS_BID_GRT_SURVEY_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_GRT_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_SURVEY_GROUPS.sql =======
PROMPT ===================================================================================== 
