

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUP_QUESTS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_SURVEY_GROUP_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_SURVEY_GROUP_QUESTS ("BID_ID", "SURVEY_ID", "GROUP_ID", "RECTYPE_ID", "NEXT_RECTYPE_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "IS_CALCABLE", "IS_REQUIRED", "IS_READONLY", "IS_REWRITABLE", "IS_CHECKABLE", "CHECK_PROC") AS 
  SELECT "BID_ID",
          "SURVEY_ID",
          "GROUP_ID",
          "RECTYPE_ID",
          "NEXT_RECTYPE_ID",
          "QUESTION_ID",
          "QUESTION_NAME",
          "TYPE_ID",
          "IS_CALCABLE",
          "IS_REQUIRED",
          "IS_READONLY",
          "IS_REWRITABLE",
          "IS_CHECKABLE",
          "CHECK_PROC"
     FROM (  SELECT b.id AS bid_id,
                    sg.survey_id,
                    sg.id AS GROUP_ID,
                    sgq.rectype_id,
                    DECODE (
                       sgq.rectype_id,
                       'SECTION', LEAD (
                                     sgq.rectype_id,
                                     1,
                                     'SECTION')
                                  OVER (PARTITION BY b.id, sg.survey_id, sg.id
                                        ORDER BY sgq.ord),
                       'NONE')
                       AS next_rectype_id,
                    sgq.question_id,
                    q.name AS question_name,
                    q.type_id,
                    q.is_calcable,
                    wcs_utl.calc_sql_bool (b.id, sgq.is_required)
                       AS is_required,
                    wcs_utl.calc_sql_bool (b.id, sgq.is_readonly)
                       AS is_readonly,
                    sgq.is_rewritable,
                    sgq.is_checkable,
                    sgq.check_proc
               FROM wcs_bids b,
                    wcs_subproduct_survey ss,
                    wcs_survey_groups sg,
                    wcs_survey_group_questions sgq,
                    wcs_questions q
              WHERE b.subproduct_id = ss.subproduct_id
                    AND ss.survey_id = sg.survey_id
                    AND (sg.dnshow_if IS NULL
                         OR wcs_utl.calc_sql_bool (b.id, sg.dnshow_if) != 1)
                    AND sg.survey_id = sgq.survey_id
                    AND sg.id = sgq.sgroup_id
                    AND (sgq.dnshow_if IS NULL
                         OR wcs_utl.calc_sql_bool (b.id, sgq.dnshow_if) != 1)
                    AND sgq.question_id = q.id
                    AND (1 = wcs_utl.show_in_survey (b.id, sgq.question_id))
           ORDER BY b.id,
                    sg.survey_id,
                    sg.ord,
                    sgq.ord)
    WHERE next_rectype_id != 'SECTION'
          OR (next_rectype_id = 'SECTION' AND GROUP_ID = 'CL_GRP_4');

PROMPT *** Create  grants  V_WCS_BID_SURVEY_GROUP_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_SURVEY_GROUP_QUESTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SURVEY_GROUP_QUESTS.sql =====
PROMPT ===================================================================================== 
