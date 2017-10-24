

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_73A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_73A ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_73A ("REF", "VDATE", "D73", "NLS", "KV", "NLSK", "KVK", "S", "S2", "NAZN", "ISP", "USER_NAME") AS 
  SELECT   o.REF, o.fdat, NVL (SUBSTR (aux1.VALUE, 1, 3), '000'), o.nlsd,
            o.kv, o.nlsk, o.kv, TO_NUMBER (o.s) * 100, TO_NUMBER (o.s) * 100,
            o.nazn, s.ID, s.fio
       FROM provodki o, oper z, staff s, operw aux1
      WHERE o.kv <> 980
        AND (   (    TO_NUMBER (SUBSTR (o.nlsd, 1, 4)) < 1007
                 AND SUBSTR (o.nlsk, 1, 4) <> '1007'
                )
             OR (    TO_NUMBER (SUBSTR (o.nlsk, 1, 4)) < 1007
                 AND SUBSTR (o.nlsd, 1, 4) <> '1007'
                )
            )
        AND z.REF = o.REF
        AND s.ID(+) = z.userid
        AND aux1.tag(+) = 'D#73'
        AND aux1.REF(+) = o.REF
        AND o.tt NOT IN (SELECT SUBSTR (tag, -3)
                           FROM op_rules
                          WHERE tag LIKE '73%')
   UNION ALL
   SELECT   o.REF, o.fdat, NVL (SUBSTR (aux1.VALUE, 1, 3), '000'), o.nlsd,
            o.kv, o.nlsk, o.kv, TO_NUMBER (o.s) * 100, TO_NUMBER (o.s) * 100,
            o.nazn, s.ID, s.fio
       FROM provodki o, oper z, staff s, operw aux1
      WHERE o.kv <> 980
        AND (   (    TO_NUMBER (SUBSTR (o.nlsd, 1, 4)) < 1007
                 AND SUBSTR (o.nlsk, 1, 4) <> '1007'
                )
             OR (    TO_NUMBER (SUBSTR (o.nlsk, 1, 4)) < 1007
                 AND SUBSTR (o.nlsd, 1, 4) <> '1007'
                )
            )
        AND z.REF = o.REF
        AND s.ID(+) = z.userid
        AND aux1.tag = '73' || o.tt
        AND aux1.REF = o.REF
   ORDER BY 3, 2, 1;

PROMPT *** Create  grants  CHECK_73A ***
grant SELECT                                                                 on CHECK_73A       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_73A       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHECK_73A       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_73A.sql =========*** End *** ====
PROMPT ===================================================================================== 
