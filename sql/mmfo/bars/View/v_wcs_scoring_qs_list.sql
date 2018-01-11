

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_LIST.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_QS_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_QS_LIST ("SCORING_ID", "QUESTION_ID", "ORD", "TEXT", "SCORE") AS 
  select sq.scoring_id,
       sq.question_id,
       qli.ord,
       qli.text,
       (select wsql.score
          from wcs_scoring_qs_list wsql
         where wsql.scoring_id = sq.scoring_id
           and wsql.question_id = sq.question_id
           and wsql.ord = qli.ord) as score
  from wcs_scoring_questions sq, wcs_question_list_items qli
 where exists (select 1
          from wcs_questions q
         where q.id = sq.question_id
           and q.type_id = 'LIST')
   and sq.question_id = qli.question_id
 order by sq.scoring_id, sq.question_id, qli.ord;

PROMPT *** Create  grants  V_WCS_SCORING_QS_LIST ***
grant SELECT                                                                 on V_WCS_SCORING_QS_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_LIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_LIST.sql =========*** 
PROMPT ===================================================================================== 
