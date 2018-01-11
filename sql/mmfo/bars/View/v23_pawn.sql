

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V23_PAWN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V23_PAWN ***

  CREATE OR REPLACE FORCE VIEW BARS.V23_PAWN ("PAWN", "NAME", "PR_REZ", "NBSZ", "NBSZ1", "NBSZ2", "NBSZ3", "S031", "KAT", "D_CLOSE", "CODE", "S031_279", "NAME_279", "PAWN_23", "GRP23", "OB22_FO", "OB22_UO", "OB22_U0", "KOD_351", "NAME_351", "DAY_IMP", "SUM_IMP", "PROC_IMP", "EF", "ATR", "HCC_M", "KL_351", "KPZ_351") AS 
  SELECT c.PAWN,
          c.NAME,
          c.PR_REZ,
          c.NBSZ,
          c.NBSZ1,
          c.NBSZ2,
          c.NBSZ3,
          c.S031,
          c.KAT,
          c.D_CLOSE,
          c.CODE,
          c.S031_279,
          c.NAME_279,
          c.PAWN_23,
          c.GRP23,
          c.OB22_FO,
          c.OB22_UO,
          c.OB22_U0,
          c.kod_351,
          substr(c.name_351,1,250) NAME_351,
          ad.day_IMP,
          ad.SUM_IMP,
          ad.PROC_IMP,
          ad.EF,
          ad.ATR,
          ad.HCC_M,
          nvl(ad.KL_351,0),
          nvl(ad.KPZ_351,0)
     FROM CC_PAWN c, cc_pawn23ADD ad
    WHERE c.pawn = ad.pawn(+);

PROMPT *** Create  grants  V23_PAWN ***
grant SELECT                                                                 on V23_PAWN        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V23_PAWN        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V23_PAWN        to START1;
grant SELECT                                                                 on V23_PAWN        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V23_PAWN.sql =========*** End *** =====
PROMPT ===================================================================================== 
