

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_73A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_73A ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_73A ("REF", "VDATE", "D73", "NLS", "KV", "NLSK", "KVK", "S", "S2", "NAZN", "ISP", "USER_NAME") AS 
  SELECT /*+index(o.o.p XIE_FDAT_ACC_OPLDOK)*/
              o.REF,
              trunc(o.fdat),
              NVL (SUBSTR (aux1.VALUE, 1, 3), '000'),
              o.nlsd,
              o.kv,
              o.nlsk,
              o.kv,
              o.s * 100,
              o.s * 100,
              o.nazn,
              s.ID,
              s.fio
         FROM provodki o,
              staff s,
              operw aux1
        WHERE o.kv <> 980
              AND ( o.nlsd like '100%' AND
                    o.nlsd not like '1007%' AND
                    o.nlsk not like '1007%'
                OR  o.nlsk like '100%' AND
                    o.nlsk not like '1007%' AND
                    o.nlsd not like '1007%')
              AND s.ID = o.isp
              AND aux1.REF(+) = o.REF
              AND aux1.tag(+) = 'D#73'
              and NOT exists (SELECT 1
                                    FROM op_rules
                                    WHERE tag LIKE '73%' and
                                          SUBSTR (tag, -3) = o.tt)
 UNION ALL
   SELECT /*+index(o.o.p XIE_FDAT_ACC_OPLDOK)*/
          o.REF,
          trunc(o.fdat),
          NVL (SUBSTR (aux1.VALUE, 1, 3), '000'),
          o.nlsd,
          o.kv,
          o.nlsk,
          o.kv,
          TO_NUMBER (o.s) * 100,
          TO_NUMBER (o.s) * 100,
          o.nazn,
          s.ID,
          s.fio
     FROM provodki o,
          staff s,
          operw aux1
    WHERE o.kv <> 980
          AND ( o.nlsd like '100%' AND
                o.nlsd not like '1007%' AND
                o.nlsk not like '1007%'
            OR  o.nlsk like '100%' AND
                o.nlsk not like '1007%' AND
                o.nlsd not like '1007%')
          AND s.ID = o.isp
          AND aux1.tag = '73' || o.tt
          AND aux1.REF = o.REF;

PROMPT *** Create  grants  CHECK_73A ***
grant SELECT                                                                 on CHECK_73A       to BARSREADER_ROLE;
grant SELECT                                                                 on CHECK_73A       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_73A       to START1;
grant SELECT                                                                 on CHECK_73A       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHECK_73A       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_73A.sql =========*** End *** ====
PROMPT ===================================================================================== 
