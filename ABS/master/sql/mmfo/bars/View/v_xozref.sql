

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZREF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZREF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZREF ("ACC", "REF1", "STMT1", "REFD", "KV", "NLS", "OB22", "NBS", "PROD", "BRANCH", "NMS", "OSTC", "VDAT", "S", "S0", "TXT", "NAZN", "MFOB", "NLSB", "NAM_B", "ID_B", "ND", "DATD", "MDATE", "DNI", "DNIP", "NOTP") AS 
  SELECT x.ACC,
          x.ref1,
          x.stmt1,
          x.refD,
          a.kv,
          a.nls,
          a.ob22,
          a.nbs,
          a.nbs || a.ob22 PROD,
          a.branch,
          a.nms,
          -a.ostc / 100 OSTC,
          x.fdat VDAT,
          x.s / 100 S,
          x.s0 / 100 S0,
          a.nms txt,
          o.nazn,
          o.mfob,
          o.nlsb,
          o.nam_b,
          o.id_b,
          o.nd,
          o.datd,
          x.mdate,
          (x.MDATE - gl.bd) DNI,
          (x.MDATE - x.fdat) DNIP,
          x.NOTP
     FROM xoz_ref x, accounts a, oper o
    WHERE x.s > 0 AND x.ref2 IS NULL AND x.acc = a.acc AND x.ref1 = o.REF;

PROMPT *** Create  grants  V_XOZREF ***
grant SELECT                                                                 on V_XOZREF        to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on V_XOZREF        to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on V_XOZREF        to START1;
grant SELECT                                                                 on V_XOZREF        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZREF.sql =========*** End *** =====
PROMPT ===================================================================================== 
