

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_AVER.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_AVER ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_AVER ("ACC", "NBS", "BRANCH", "NLS", "KV", "DAOS", "NMS", "TIP", "DAZS", "RNK", "DAT1", "DAT2", "KOL", "OST1", "DOS", "KOS", "OST2", "OSTA", "OSTQ") AS 
  SELECT a.ACC,
            a.NBS,
            a.tobo,
            a.NLS,
            a.KV,
            a.DAOS,
            a.NMS,
            a.TIP,
            a.DAZS,
            a.RNK,
            a.dat1,
            a.dat2,
            a.KOL,
            fost (a.acc, a.dat1 - 1) / 100 OST1,
            fdos (a.acc, a.dat1, a.dat2) / 100 DOS,
            fkos (a.acc, a.dat1, a.dat2) / 100 KOS,
            fost (a.acc, a.dat2) / 100 OST2,
              ROUND (
                   SUM (fost (a.acc, (a.DAT1 + o.num - 1)))
                 / (a.DAt2 - a.dat1 + 1),
                 0)
            / 100
               OSTA,
            DECODE (
               a.kv,
               980,   ROUND (SUM (fost (a.acc, (a.DAT1 + o.num - 1))) / a.kol,
                             0)
                    / 100,
                 ROUND (SUM (fostq (a.acc, (a.DAT1 + o.num - 1))) / a.kol, 0)
               / 100)
               OSTq
       FROM conductor o,
            (SELECT a.ACC,
                    a.NBS,
                    a.tobo,
                    a.NLS,
                    a.KV,
                    a.daos,
                    a.nms,
                    a.tip,
                    a.dazs,
                    a.rnk,
                    c.DAT1,
                    c.DAT2,
                    (c.DAT2 - c.DAT1 + 1) kol
               FROM accounts a,
                    (SELECT TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),
                                     'dd.mm.yyyy')
                               DAT1,
                            TO_DATE (pul.Get_Mas_Ini_Val ('sFdat2'),
                                     'dd.mm.yyyy')
                               DAT2
                       FROM DUAL) c
              WHERE     (a.daos <= c.dat1 OR NVL (a.dazs, c.dat2) >= c.dat1)
                    AND nbs like pul.Get_Mas_Ini_Val ('PNBS')) a
      WHERE a.DAT1 + (o.num - 1) <= a.DAT2
   GROUP BY a.ACC,
            a.NBS,
            a.tobo,
            a.NLS,
            a.KV,
            a.DAOS,
            a.NMS,
            a.TIP,
            a.DAZS,
            a.RNK,
            a.dat1,
            a.dat2,
            a.kol;

PROMPT *** Create  grants  ACC_AVER ***
grant SELECT                                                                 on ACC_AVER        to BARSREADER_ROLE;
grant SELECT                                                                 on ACC_AVER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_AVER        to START1;
grant SELECT                                                                 on ACC_AVER        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_AVER.sql =========*** End *** =====
PROMPT ===================================================================================== 
