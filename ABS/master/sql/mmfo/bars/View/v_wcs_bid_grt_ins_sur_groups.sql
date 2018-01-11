

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INS_SUR_GROUPS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GRT_INS_SUR_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GRT_INS_SUR_GROUPS ("BID_ID", "GARANTEE_ID", "GARANTEE_NUM", "INSURANCE_ID", "INSURANCE_NUM", "SURVEY_ID", "GROUP_ID", "GROUP_NAME", "RESULT_QID", "IS_FILLED") AS 
  select bgi.bid_id,
       bgi.garantee_id,
       bgi.garantee_num,
       bgi.insurance_id,
       bgi.insurance_num,
       sg.survey_id as survey_id,
       sg.id as group_id,
       sg.name as group_name,
       sg.result_qid,
       to_number(wcs_utl.get_answ(bgi.bid_id,
                                  sg.result_qid,
                                  bgi.ws_id,
                                  bgi.insurance_num)) as is_filled
  from v_wcs_bid_grt_insurances bgi, wcs_insurances i, wcs_survey_groups sg
 where bgi.insurance_id = i.id
   and i.survey_id = sg.survey_id
   and (wcs_utl.calc_sql_bool(bgi.bid_id,
                              sg.dnshow_if,
                              bgi.ws_id,
                              bgi.insurance_num) <> 1 or
       sg.dnshow_if is null)
 order by bgi.bid_id,
          bgi.garantee_id,
          bgi.garantee_num,
          bgi.insurance_id,
          bgi.insurance_num,
          sg.survey_id,
          sg.ord;

PROMPT *** Create  grants  V_WCS_BID_GRT_INS_SUR_GROUPS ***
grant SELECT                                                                 on V_WCS_BID_GRT_INS_SUR_GROUPS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_GRT_INS_SUR_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_GRT_INS_SUR_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INS_SUR_GROUPS.sql ======
PROMPT ===================================================================================== 
