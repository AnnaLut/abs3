

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZ_REFZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZ_REFZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZ_REFZ ("ACC1", "REF", "S", "TT", "SOS", "FDAT", "STMT", "NLS1", "OB1", "NLS2", "OB2", "NAZN", "ISP") AS 
  SELECT x.acc1, x.REF, x.s/100 s, x.tt, x.sos, x.fdat, x.stmt,  x.NLS1, x.ob1, x.NLS2,    x.OB2, p.nazn, p.userid ISP
     FROM oper p,
          (SELECT o1.acc acc1, o1.REF,  o1.s, o1.tt,  o1.sos,  o1.fdat,  o1.stmt,  a1.nls NLS1, a1.ob22 ob1,  a2.nls NLS2,  a2.ob22 OB2
           FROM opldok o1,  accounts a1,  xoz_ob22 x,  opldok o2,  accounts a2
           WHERE o1.dk = 1 AND o1.acc = A1.ACC AND a1.nbs || a1.ob22 = x.deb AND o2.dk = 0 AND o2.acc = A2.ACC 
             AND a2.nbs || a2.ob22 = x.krd    AND o2.REF = o1.REF    AND o2.stmt = o1.stmt ) x
    WHERE x.REF = p.REF;

PROMPT *** Create  grants  V_XOZ_REFZ ***
grant SELECT                                                                 on V_XOZ_REFZ      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZ_REFZ      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZ_REFZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
