

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_BOOL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_QS_BOOL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_QS_BOOL ("SCORING_ID", "QUESTION_ID", "SCORE_IF_0", "SCORE_IF_1") AS 
  select sq.scoring_id, sq.question_id, sqb.score_if_0, sqb.score_if_1
  from wcs_scoring_questions sq, wcs_scoring_qs_bool sqb
 where exists (select *
          from wcs_questions q
         where q.id = sq.question_id
           and q.type_id = 'BOOL')
   and sq.scoring_id = sqb.scoring_id (+)
   and sq.question_id = sqb.question_id (+)
 order by sq.scoring_id, sq.question_id;

PROMPT *** Create  grants  V_WCS_SCORING_QS_BOOL ***
grant SELECT                                                                 on V_WCS_SCORING_QS_BOOL to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_BOOL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_BOOL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_BOOL.sql =========*** 
PROMPT ===================================================================================== 
