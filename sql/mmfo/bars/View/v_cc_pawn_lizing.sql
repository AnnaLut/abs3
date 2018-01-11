

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_LIZING.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_PAWN_LIZING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_PAWN_LIZING ("PAWN", "NAME", "KL_351") AS 
  SELECT pawn, NAME, kl_351 FROM v23_pawn  WHERE pawn in (25,30,31,38,250,301,302,304,305,312) and d_close IS NULL
     order by pawn;

PROMPT *** Create  grants  V_CC_PAWN_LIZING ***
grant SELECT                                                                 on V_CC_PAWN_LIZING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_PAWN_LIZING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_PAWN_LIZING.sql =========*** End *
PROMPT ===================================================================================== 
