

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_XOZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_XOZ ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_XOZ ("REF", "TT", "VOB", "ND", "PDAT", "VDAT", "S", "DATD", "NAM_A", "NLSA", "NAM_B", "NLSB", "MFOB", "NAZN", "ID_B", "KPR") AS 
  SELECT "REF",
          "TT",
          "VOB",
          "ND",
          "PDAT",
          "VDAT",
          "S/100",
          "DATD",
          "NAM_A",
          "NLSA",
          "NAM_B",
          "NLSB",
          "MFOB",
          "NAZN",
          "ID_B",
          "KPR"
     FROM (SELECT REF,
                  TT,
                  VOB,
                  ND,
                  PDAT,
                  VDAT,
                  S / 100,
                  DATD,
                  NAM_A,
                  NLSA,
                  NAM_B,
                  NLSB,
                  MFOB,
                  NAZN,
                  ID_B,
                  (SELECT COUNT (*) / 2
                     FROM bars.opldok
                    WHERE REF = o.REF)
                     kpr
             FROM bars.oper o
            WHERE     kv = kv2
                  AND kv = 980
                  AND sos > 0
                  AND O.USERID = bars.USER_ID
                  AND pdat >= TRUNC (SYSDATE))
    WHERE kpr = 1;

PROMPT *** Create  grants  OPER_XOZ ***
grant SELECT                                                                 on OPER_XOZ        to BARSREADER_ROLE;
grant SELECT                                                                 on OPER_XOZ        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_XOZ        to START1;
grant SELECT                                                                 on OPER_XOZ        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_XOZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
