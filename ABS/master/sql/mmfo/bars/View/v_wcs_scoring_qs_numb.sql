

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_NUMB.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_QS_NUMB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_QS_NUMB ("SCORING_ID", "QUESTION_ID", "ORD", "MIN_VAL", "MIN_SIGN", "MIN_SIGN_SIGN", "MAX_VAL", "MAX_SIGN", "MAX_SIGN_SIGN", "SCORE") AS 
  select sqn.scoring_id,
       sqn.question_id,
       sqn.ord,
       sqn.min_val,
       sqn.min_sign,
       stmin.sign      as min_sign_sign,
       sqn.max_val,
       sqn.max_sign,
       stmax.sign      as max_sign_sign,
       sqn.score
  from wcs_scoring_qs_numb sqn,
       (select *
          from wcs_sign_types t
         where t.id in ('LESS', 'LESS_OR_EQUAL')) stmin,
       (select *
          from wcs_sign_types t
         where t.id in ('LESS', 'LESS_OR_EQUAL')) stmax
 where sqn.min_sign = stmin.id
   and sqn.max_sign = stmax.id
 order by sqn.scoring_id, sqn.question_id, sqn.ord;

PROMPT *** Create  grants  V_WCS_SCORING_QS_NUMB ***
grant SELECT                                                                 on V_WCS_SCORING_QS_NUMB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_NUMB.sql =========*** 
PROMPT ===================================================================================== 
