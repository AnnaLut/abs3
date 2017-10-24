

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECKPB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECKPB ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECKPB ("REF", "VDATE", "NLS", "KV", "NLSK", "KVK", "S", "S2", "NAZN", "ISP", "FIO", "KOD_N", "KOD_B", "KOD_G") AS 
  SELECT o.REF,
            o.fdat,
            o.nlsd,
            o.kv,
            o.nlsk,
            o.kv,
            SUBSTR (TO_CHAR (o.s * 100), 1, 16),
            SUBSTR (TO_CHAR (o.s * 100), 1, 16),
            o.nazn,
            s.id,
            s.fio,
            NVL (SUBSTR (a1.VALUE, 1, 10), '          '),
            NVL (SUBSTR (a2.VALUE, 1, 10), '          '),
            NVL (SUBSTR (a3.VALUE, 1, 10), '          ')
       FROM provodki o,
            oper z,
            staff s,
            operw a1,
            operw a2,
            operw a3
      WHERE     o.kv <> 980
            AND (   (o.nlsd LIKE '1500%' AND o.nlsk LIKE '1%')
                 OR (o.nlsd LIKE '1600%' AND o.nlsk LIKE '1%')
                 OR (o.nlsd LIKE '1200%' AND o.nlsk LIKE '1%')
                 OR (o.nlsd LIKE '1207%' AND o.nlsk LIKE '1%')
                 OR (o.nlsd LIKE '1300%' AND o.nlsk LIKE '1%')
                 OR (o.nlsd LIKE '1500%' AND o.nlsk LIKE '2%')
                 OR (o.nlsd LIKE '1600%' AND o.nlsk LIKE '2%')
                 OR (o.nlsd LIKE '1200%' AND o.nlsk LIKE '2%')
                 OR (o.nlsd LIKE '1207%' AND o.nlsk LIKE '2%')
                 OR (o.nlsd LIKE '1300%' AND o.nlsk LIKE '2%')
                 OR (o.nlsd LIKE '1500%' AND o.nlsk LIKE '3%')
                 OR (o.nlsd LIKE '1600%' AND o.nlsk LIKE '3%')
                 OR (o.nlsd LIKE '1200%' AND o.nlsk LIKE '3%')
                 OR (o.nlsd LIKE '1207%' AND o.nlsk LIKE '3%')
                 OR (o.nlsd LIKE '1300%' AND o.nlsk LIKE '3%')
                 OR (o.nlsd LIKE '1%' AND o.nlsk LIKE '1500%')
                 OR (o.nlsd LIKE '1%' AND o.nlsk LIKE '1600%')
                 OR (o.nlsd LIKE '1%' AND o.nlsk LIKE '1200%')
                 OR (o.nlsd LIKE '1%' AND o.nlsk LIKE '1207%')
                 OR (o.nlsd LIKE '1%' AND o.nlsk LIKE '1300%')
                 OR (o.nlsd LIKE '2%' AND o.nlsk LIKE '1500%')
                 OR (o.nlsd LIKE '2%' AND o.nlsk LIKE '1600%')
                 OR (o.nlsd LIKE '2%' AND o.nlsk LIKE '1200%')
                 OR (o.nlsd LIKE '2%' AND o.nlsk LIKE '1207%')
                 OR (o.nlsd LIKE '2%' AND o.nlsk LIKE '1300%')
                 OR (o.nlsd LIKE '3%' AND o.nlsk LIKE '1500%')
                 OR (o.nlsd LIKE '3%' AND o.nlsk LIKE '1600%')
                 OR (o.nlsd LIKE '3%' AND o.nlsk LIKE '1200%')
                 OR (o.nlsd LIKE '3%' AND o.nlsk LIKE '1207%')
                 OR (o.nlsd LIKE '3%' AND o.nlsk LIKE '1300%'))
            AND z.REF = o.REF
            AND s.id = z.userid
            AND a1.REF(+) = o.REF
            AND a1.tag(+) = 'KOD_N'
            AND a2.REF(+) = o.REF
            AND a2.tag(+) = 'KOD_B'
            AND a3.REF(+) = o.REF
            AND a3.tag(+) = 'KOD_G'
   ORDER BY o.fdat, o.REF;

PROMPT *** Create  grants  CHECKPB ***
grant SELECT                                                                 on CHECKPB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECKPB         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECKPB.sql =========*** End *** ======
PROMPT ===================================================================================== 
