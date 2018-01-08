

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_CP_V.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_CP_V ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_CP_V ("REF", "DATD", "TT", "KV", "NLSA", "NLSB", "SUMMA", "CP_IN", "CP_MR", "NAZN") AS 
  SELECT o1.REF,
          o1.datp,
          o1.tt,
          o1.kv,
          o1.nlsa,
          o1.nlsb,
          TO_CHAR (o1.s / 100, '999G999G999G990D99') SUMMA,
          --       o1.s/100 SUMMA,
          s1.CP_IN,
          s2.CP_MR,
          o1.nazn
     FROM oper o1,
          (SELECT REF, VALUE CP_IN
             FROM operw
            WHERE     REF IN (SELECT REF
                                FROM oper
                               WHERE sos = 5 AND pdat >= SYSDATE - 180)
                  AND tag = 'CP_IN') s1,
          (SELECT REF, VALUE CP_MR
             FROM operw
            WHERE     REF IN (SELECT REF
                                FROM oper
                               WHERE sos = 5 AND pdat >= SYSDATE - 180)
                  AND tag = 'CP_MR') s2
    WHERE     o1.REF = s1.REF(+)
          AND o1.REF = s2.REF(+)
          AND o1.pdat >= SYSDATE - 180
          AND o1.sos = 5
          AND (   SUBSTR (o1.nlsa, 1, 4) IN
                     ('6050',
                      '6051',
                      '6052',
                      '6053',
                      '6057',
                      '6203',
                      '6393',
                      '7703',
                      '7704',
                      '7720',
                      decode(NEWNBS.GET_STATE,0,'6050','6121'),
                      decode(NEWNBS.GET_STATE,0,'6051','6122'),
                      decode(NEWNBS.GET_STATE,0,'6052','6124'),
                      decode(NEWNBS.GET_STATE,0,'6053','6125'),
                      decode(NEWNBS.GET_STATE,0,'6057','6126'),
                      decode(NEWNBS.GET_STATE,0,'7720','7707')
                      )
               OR SUBSTR (o1.nlsb, 1, 4) IN
                     ('6050',
                      '6051',
                      '6052',
                      '6053',
                      '6057',
                      '6203',
                      '6393',
                      '7703',
                      '7704',
                      '7720',
                      decode(NEWNBS.GET_STATE,0,'6050','6121'),
                      decode(NEWNBS.GET_STATE,0,'6051','6122'),
                      decode(NEWNBS.GET_STATE,0,'6052','6124'),
                      decode(NEWNBS.GET_STATE,0,'6053','6125'),
                      decode(NEWNBS.GET_STATE,0,'6057','6126'),
                      decode(NEWNBS.GET_STATE,0,'7720','7707')
                      ));

PROMPT *** Create  grants  OPER_CP_V ***
grant SELECT                                                                 on OPER_CP_V       to BARSREADER_ROLE;
grant SELECT                                                                 on OPER_CP_V       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPER_CP_V       to START1;
grant SELECT                                                                 on OPER_CP_V       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_CP_V.sql =========*** End *** ====
PROMPT ===================================================================================== 
