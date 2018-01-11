

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZREF2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZREF2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZREF2 ("NLS", "NMS", "REF1", "STMT1", "FDAT1", "S0", "S", "MDATE", "NAM_B", "ID_B", "NAZN1", "REF2", "SOS", "FDAT2", "NLSA", "NAZN2", "ACC", "RNK", "OB22", "NOTP", "PRG", "BU") AS 
  SELECT a.nls,
          a.nms,
          x.ref1,
          x.STMT1,
          x.fdat FDAT1,
          x.s0 / 100 S0,
          x.s / 100 S,
          x.MDATE,
          o1.nam_b,
          o1.id_b,
          o1.nazn NAZN1,
          x.Ref2,
          o2.sos,
          o2.vdat FDAT2,
          o2.nlsa,
          o2.nazn NAZN2,
          x.acc,
          a.rnk,
          a.ob22,
          x.NOTP,
          x.PRG,
          x.BU
     FROM xoz_ref x,
          v_gl a,
          oper o1,
          (SELECT * FROM oper) o2
    WHERE x.acc = a.acc AND x.ref1 = o1.REF AND x.ref2 = o2.REF(+);

PROMPT *** Create  grants  V_XOZREF2 ***
grant SELECT                                                                 on V_XOZREF2       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_XOZREF2       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_XOZREF2       to START1;
grant SELECT                                                                 on V_XOZREF2       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZREF2.sql =========*** End *** ====
PROMPT ===================================================================================== 
