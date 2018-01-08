

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUP_QUESTS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_SURVEY_GROUP_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_SURVEY_GROUP_QUESTS ("BID_ID", "SURVEY_ID", "GROUP_ID", "RECTYPE_ID", "NEXT_RECTYPE_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "IS_CALCABLE", "IS_REQUIRED", "IS_READONLY", "IS_REWRITABLE", "IS_CHECKABLE", "CHECK_PROC") AS 
  select "BID_ID","SURVEY_ID","GROUP_ID","RECTYPE_ID","NEXT_RECTYPE_ID","QUESTION_ID","QUESTION_NAME","TYPE_ID","IS_CALCABLE","IS_REQUIRED","IS_READONLY","IS_REWRITABLE","IS_CHECKABLE","CHECK_PROC"
  from (select b.id as bid_id,
               sg.survey_id,
               sg.id as group_id,
               sgq.rectype_id,
               decode(sgq.rectype_id,
                      'SECTION',
                      lead(sgq.rectype_id, 1, 'SECTION')
                      over(partition by b.id,
                           sg.survey_id,
                           sg.id order by sgq.ord),
                      'NONE') as next_rectype_id,
               sgq.question_id,
               q.name as question_name,
               q.type_id,
               q.is_calcable,
               wcs_utl.calc_sql_bool(b.id, sgq.is_required) as is_required,
               wcs_utl.calc_sql_bool(b.id, sgq.is_readonly) as is_readonly,
               sgq.is_rewritable,
               sgq.is_checkable,
               sgq.check_proc
          from wcs_bids                   b,
               wcs_subproduct_survey      ss,
               wcs_survey_groups          sg,
               wcs_survey_group_questions sgq,
               wcs_questions              q
         where b.subproduct_id = ss.subproduct_id
           and ss.survey_id = sg.survey_id
           and (sg.dnshow_if is null or
               wcs_utl.calc_sql_bool(b.id, sg.dnshow_if) != 1)
           and sg.survey_id = sgq.survey_id
           and sg.id = sgq.sgroup_id
           and (sgq.dnshow_if is null or
               wcs_utl.calc_sql_bool(b.id, sgq.dnshow_if) != 1)
           and sgq.question_id = q.id
           and (1 = wcs_utl.show_in_survey(b.id, sgq.question_id))
         order by b.id, sg.survey_id, sg.ord, sgq.ord)
 where rectype_id != 'SECTION'
    or next_rectype_id != 'SECTION';

PROMPT *** Create  grants  V_WCS_BID_SURVEY_GROUP_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUP_QUESTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUP_QUESTS.sql =====
PROMPT ===================================================================================== 
