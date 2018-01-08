

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPER_OPERW_KODDZ.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view OPER_OPERW_KODDZ ***

  CREATE OR REPLACE FORCE VIEW BARS.OPER_OPERW_KODDZ ("BRANCH", "REF", "TT", "USERID", "NLSA", "NAM_A", "S", "KV", "DATD", "MFOB", "NLSB", "NAM_B", "ID_B", "NAZN", "KODDZ", "SUMDZ") AS 
  SELECT o.branch,
          o.REF,
          o.tt,
          o.userid,
          o.nlsa,
          o.nam_a,
          o.s / 100 S,
          o.kv,
          o.datd,
          o.mfob,
          o.nlsb,
          o.nam_b,
          o.id_b,
          o.nazn,
          REPLACE (REPLACE (k.koddz, ',', ''), '.', '') KODDZ,
          NVL ( (SELECT VALUE
                   FROM operw
                  WHERE tag = 'S_DZ' || k.TAG AND REF = o.REF),
               o.s / 100)
             SUMDZ
     FROM (SELECT branch,
                  REF,
                  tt,
                  userid,
                  nlsa,
                  nam_a,
                  S,
                  kv,
                  datd,
                  mfob,
                  nlsb,
                  nam_b,
                  id_b,
                  nazn
             FROM oper
            WHERE     sos = 5
                  /*  AND vdat >=
                           NVL (
                              TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                       'dd.mm.yyyy'),
                              gl.bd - 30)
                    AND vdat <=
                           NVL (
                              TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                       'dd.mm.yyyy'),
                              gl.bd)*/
                  AND EXISTS
                         (SELECT 1
                            FROM operw
                           WHERE tag LIKE 'K_DZ_' AND REF = oper.REF)) o,
          (SELECT REF, SUBSTR (tag, -1) tag, VALUE koddz
             FROM operw
            WHERE tag LIKE 'K_DZ_') k
    WHERE o.REF = k.REF;

PROMPT *** Create  grants  OPER_OPERW_KODDZ ***
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to ABS_ADMIN;
grant SELECT                                                                 on OPER_OPERW_KODDZ to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to START1;
grant SELECT                                                                 on OPER_OPERW_KODDZ to UPLD;
grant FLASHBACK,SELECT                                                       on OPER_OPERW_KODDZ to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPER_OPERW_KODDZ.sql =========*** End *
PROMPT ===================================================================================== 
