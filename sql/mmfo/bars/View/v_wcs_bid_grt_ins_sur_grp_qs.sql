

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INS_SUR_GRP_QS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GRT_INS_SUR_GRP_QS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GRT_INS_SUR_GRP_QS ("BID_ID", "GARANTEE_ID", "GARANTEE_NUM", "INSURANCE_ID", "INSURANCE_NUM", "SURVEY_ID", "GROUP_ID", "RECTYPE_ID", "NEXT_RECTYPE_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "IS_CALCABLE", "IS_REQUIRED", "IS_READONLY", "IS_REWRITABLE", "IS_CHECKABLE", "CHECK_PROC") AS 
  select "BID_ID","GARANTEE_ID","GARANTEE_NUM","INSURANCE_ID","INSURANCE_NUM","SURVEY_ID","GROUP_ID","RECTYPE_ID","NEXT_RECTYPE_ID","QUESTION_ID","QUESTION_NAME","TYPE_ID","IS_CALCABLE","IS_REQUIRED","IS_READONLY","IS_REWRITABLE","IS_CHECKABLE","CHECK_PROC"
  from (select bgi.bid_id,
               bgi.garantee_id,
               bgi.garantee_num,
               bgi.insurance_id,
               bgi.insurance_num,
               sg.survey_id,
               sg.id as group_id,
               sgq.rectype_id,
               decode(sgq.rectype_id,
                      'SECTION',
                      lead(sgq.rectype_id, 1, 'SECTION')
                      over(partition by bgi.bid_id,
                           bgi.garantee_id,
                           bgi.garantee_num,
                           bgi.insurance_id,
                           bgi.insurance_num,
                           sg.survey_id,
                           sg.id order by sgq.ord),
                      'NONE') as next_rectype_id,
               sgq.question_id,
               q.name as question_name,
               q.type_id,
               q.is_calcable,
               wcs_utl.calc_sql_bool(bgi.bid_id,
                                      sgq.is_required,
                                      bgi.ws_id,
                                      bgi.insurance_num) as is_required,
               wcs_utl.calc_sql_bool(bgi.bid_id,
                                      sgq.is_readonly,
                                      bgi.ws_id,
                                      bgi.insurance_num) as is_readonly,
               sgq.is_rewritable,
               sgq.is_checkable,
               sgq.check_proc
          from v_wcs_bid_grt_insurances   bgi,
               wcs_insurances             i,
               wcs_survey_groups          sg,
               wcs_survey_group_questions sgq,
               wcs_questions              q
         where bgi.insurance_id = i.id
           and i.survey_id = sg.survey_id
           and (sg.dnshow_if is null or
               wcs_utl.calc_sql_bool(bgi.bid_id,
                                      sg.dnshow_if,
                                      bgi.ws_id,
                                      bgi.insurance_num) != 1)
           and sg.survey_id = sgq.survey_id
           and sg.id = sgq.sgroup_id
           and (sgq.dnshow_if is null or
               wcs_utl.calc_sql_bool(bgi.bid_id,
                                      sgq.dnshow_if,
                                      bgi.ws_id,
                                      bgi.insurance_num) != 1)
           and sgq.question_id = q.id
         order by bgi.bid_id,
                  bgi.garantee_id,
                  bgi.garantee_num,
                  bgi.insurance_id,
                  bgi.insurance_num,
                  sg.survey_id,
                  sg.ord,
                  sgq.ord)
 where rectype_id != 'SECTION'
    or next_rectype_id != 'SECTION';

PROMPT *** Create  grants  V_WCS_BID_GRT_INS_SUR_GRP_QS ***
grant SELECT                                                                 on V_WCS_BID_GRT_INS_SUR_GRP_QS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_INS_SUR_GRP_QS.sql ======
PROMPT ===================================================================================== 
