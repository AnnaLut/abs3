

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INS_SURVEY_GROUPS.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INS_SURVEY_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INS_SURVEY_GROUPS ("BID_ID", "INSURANCE_ID", "INSURANCE_NUM", "SURVEY_ID", "GROUP_ID", "GROUP_NAME", "RESULT_QID", "IS_FILLED") AS 
  select bi.bid_id,
       bi.insurance_id,
       bi.insurance_num,
       sg.survey_id as survey_id,
       sg.id as group_id,
       sg.name as group_name,
       sg.result_qid,
       to_number(wcs_utl.get_answ(bi.bid_id,
                                  sg.result_qid,
                                  bi.ws_id,
                                  bi.insurance_num)) as is_filled
  from v_wcs_bid_insurances bi, wcs_insurances i, wcs_survey_groups sg
 where bi.insurance_id = i.id
   and i.survey_id = sg.survey_id
   and (wcs_utl.calc_sql_bool(bi.bid_id,
                              sg.dnshow_if,
                              bi.ws_id,
                              bi.insurance_num) <> 1 or
       sg.dnshow_if is null)
 order by bi.bid_id,
          bi.insurance_id,
          bi.insurance_num,
          sg.survey_id,
          sg.ord;

PROMPT *** Create  grants  V_WCS_BID_INS_SURVEY_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_INS_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INS_SURVEY_GROUPS.sql =======
PROMPT ===================================================================================== 
