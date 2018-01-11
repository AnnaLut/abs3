

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_DATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORING_QS_DATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORING_QS_DATE ("SCORING_ID", "QUESTION_ID", "ORD", "MIN_VAL", "MIN_SIGN", "MIN_SIGN_SIGN", "MAX_VAL", "MAX_SIGN", "MAX_SIGN_SIGN", "SCORE") AS 
  select sqd.scoring_id,
       sqd.question_id,
       sqd.ord,
       sqd.min_val,
       sqd.min_sign,
       stmin.sign      as min_sign_sign,
       sqd.max_val,
       sqd.max_sign,
       stmax.sign      as max_sign_sign,
       sqd.score
  from wcs_scoring_qs_date sqd,
       (select *
          from wcs_sign_types t
         where t.id in ('LESS', 'LESS_OR_EQUAL')) stmin,
       (select *
          from wcs_sign_types t
         where t.id in ('LESS', 'LESS_OR_EQUAL')) stmax
 where sqd.min_sign = stmin.id
   and sqd.max_sign = stmax.id
 order by sqd.scoring_id, sqd.question_id, sqd.ord;

PROMPT *** Create  grants  V_WCS_SCORING_QS_DATE ***
grant SELECT                                                                 on V_WCS_SCORING_QS_DATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_DATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SCORING_QS_DATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORING_QS_DATE.sql =========*** 
PROMPT ===================================================================================== 
