

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_CC_PAWN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_CC_PAWN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_CC_PAWN ("PAWN", "NAME", "PR_REZ", "NBSZ", "NBSZ1", "NBSZ2", "NBSZ3", "S031", "KAT", "D_CLOSE", "CODE", "S031_279", "NAME_279", "PAWN_23", "GRP23", "OB22_FO", "OB22_UO", "OB22_U0") AS 
  SELECT pawn,
       name,
       pr_rez,
       nbsz,
       nbsz1,
       nbsz2,
       nbsz3,
       s031,
       kat,
       d_close,
       code,
       s031_279,
       name_279,
       pawn_23,
       grp23,
       ob22_fo,
       ob22_uo,
       ob22_u0
FROM cc_pawn;

PROMPT *** Create  grants  V_MBDK_CC_PAWN ***
grant SELECT                                                                 on V_MBDK_CC_PAWN  to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBDK_CC_PAWN  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_MBDK_CC_PAWN  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_CC_PAWN.sql =========*** End ***
PROMPT ===================================================================================== 
