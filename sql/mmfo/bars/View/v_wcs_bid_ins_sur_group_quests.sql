

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INS_SUR_GROUP_QUESTS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_INS_SUR_GROUP_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_INS_SUR_GROUP_QUESTS ("BID_ID", "INSURANCE_ID", "INSURANCE_NUM", "SURVEY_ID", "GROUP_ID", "RECTYPE_ID", "NEXT_RECTYPE_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "IS_CALCABLE", "IS_REQUIRED", "IS_READONLY", "IS_REWRITABLE", "IS_CHECKABLE", "CHECK_PROC") AS 
  select "BID_ID","INSURANCE_ID","INSURANCE_NUM","SURVEY_ID","GROUP_ID","RECTYPE_ID","NEXT_RECTYPE_ID","QUESTION_ID","QUESTION_NAME","TYPE_ID","IS_CALCABLE","IS_REQUIRED","IS_READONLY","IS_REWRITABLE","IS_CHECKABLE","CHECK_PROC"
  from (select bi.bid_id,
               bi.insurance_id,
               bi.insurance_num,
               sg.survey_id,
               sg.id as group_id,
               sgq.rectype_id,
               decode(sgq.rectype_id,
                      'SECTION',
                      lead(sgq.rectype_id, 1, 'SECTION')
                      over(partition by bi.bid_id,
                           bi.insurance_id,
                           bi.insurance_num order by sgq.ord),
                      'NONE') as next_rectype_id,
               sgq.question_id,
               q.name as question_name,
               q.type_id,
               q.is_calcable,
               wcs_utl.calc_sql_bool(bi.bid_id, sgq.is_required,
                                      bi.ws_id,
                                      bi.insurance_num) as is_required,
               wcs_utl.calc_sql_bool(bi.bid_id, sgq.is_readonly,
                                      bi.ws_id,
                                      bi.insurance_num) as is_readonly,
               sgq.is_rewritable,
               sgq.is_checkable,
               sgq.check_proc
          from v_wcs_bid_insurances       bi,
               wcs_insurances             i,
               wcs_survey_groups          sg,
               wcs_survey_group_questions sgq,
               wcs_questions              q
         where bi.insurance_id = i.id
           and i.survey_id = sg.survey_id
           and (sg.dnshow_if is null or
               wcs_utl.calc_sql_bool(bi.bid_id,
                                      sg.dnshow_if,
                                      bi.ws_id,
                                      bi.insurance_num) != 1)
           and sg.survey_id = sgq.survey_id
           and sg.id = sgq.sgroup_id
           and (sgq.dnshow_if is null or
               wcs_utl.calc_sql_bool(bi.bid_id,
                                      sgq.dnshow_if,
                                      bi.ws_id,
                                      bi.insurance_num) != 1)
           and sgq.question_id = q.id
         order by bi.bid_id,
                  bi.insurance_id,
                  bi.insurance_num,
                  sg.survey_id,
                  sg.ord,
                  sgq.ord)
 where rectype_id != 'SECTION'
    or next_rectype_id != 'SECTION';

PROMPT *** Create  grants  V_WCS_BID_INS_SUR_GROUP_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_INS_SUR_GROUP_QUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_INS_SUR_GROUP_QUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_INS_SUR_GROUP_QUESTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_INS_SUR_GROUP_QUESTS.sql ====
PROMPT ===================================================================================== 
