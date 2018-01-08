

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view NOT_CCK_PK ***

  CREATE OR REPLACE FORCE VIEW BARS.NOT_CCK_PK ("KV", "NBS", "K", "S", "K1", "S1", "K2", "S2", "KK", "SS") AS 
  SELECT kv, nbs, k, -s / 100 s, k1, -s1 / 100 s1, k2, -s2 / 100 s2,
          k - k1 - k2 kk, - (s - s1 - s2) / 100 ss
     FROM (SELECT   kv, nbs, SUM (k) k, SUM (s) s, SUM (k1) k1, SUM (s1) s1,
                    SUM (k2) k2, SUM (s2) s2
               FROM (SELECT   a.kv, a.nbs, COUNT (*) k, SUM (a.ostc) s, 0 k1,
                              0 s1, 0 k2, 0 s2
                         FROM accounts a
                        WHERE a.nbs IN
   ('2202','2203','2207','2208','2209',
    '2212','2213','2217','2218','2219',
    '2222','2223','2227','2228','2229',
    '2232','2233','2237','2238','2239',
    '9129')
                          AND a.dazs IS NULL
                     GROUP BY a.kv, a.nbs
                     UNION ALL
                     SELECT   a.kv, a.nbs, 0 k, 0 s, COUNT (*) k1,
                              SUM (a.ostc) s1, 0 k2, 0 s2
                         FROM accounts a
                        WHERE a.nbs IN
   ('2202','2203','2207','2208','2209',
    '2212','2213','2217','2218','2219',
    '2222','2223','2227','2228','2229',
    '2232','2233','2237','2238','2239',
    '9129')
                          AND a.dazs IS NULL
                          AND EXISTS (SELECT 1
                                        FROM nd_acc
                                       WHERE acc = a.acc)
                     GROUP BY a.kv, a.nbs
                     UNION ALL
                     SELECT   a.kv, a.nbs, 0 k, 0 s, 0 k1, 0 s1, COUNT (*) k2,
                              SUM (a.ostc) s2
                         FROM accounts a
                        WHERE a.nbs IN
   ('2202','2203','2207','2208','2209',
    '2212','2213','2217','2218','2219',
    '2222','2223','2227','2228','2229',
    '2232','2233','2237','2238','2239',
    '9129')
                          AND a.dazs IS NULL
                          AND EXISTS (
                                  SELECT 1
                                    FROM bpk_acc
                                   WHERE a.acc IN
                                                (acc_ovr, acc_9129, acc_2208))
                     GROUP BY a.kv, a.nbs)
           GROUP BY kv, nbs);

PROMPT *** Create  grants  NOT_CCK_PK ***
grant SELECT                                                                 on NOT_CCK_PK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOT_CCK_PK      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOT_CCK_PK.sql =========*** End *** ===
PROMPT ===================================================================================== 
