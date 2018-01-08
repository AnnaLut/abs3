PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_LIZING.sql =========*** Run *** ====
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CC_PAWN_LIZING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_PAWN_LIZING AS 
     SELECT pawn, NAME, kl_351 FROM v23_pawn  WHERE pawn in (25,30,31,38,250,301,302,304,305,312) and d_close IS NULL
     order by pawn;
/* Перечень видов залога согласно письма от Кузьменко Виталия 24-10-2017 17:02 к заявке COBUMMFO-5208  */

PROMPT *** Create  grants  V_CC_PAWN_LIZING ***
grant SELECT  on V_CC_PAWN_LIZING   to BARS_ACCESS_DEFROLE;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_LIZING.sql =========*** End *** ====
PROMPT ===================================================================================== 
