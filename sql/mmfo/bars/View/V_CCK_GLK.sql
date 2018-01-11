

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_GLK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_GLK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_GLK ("ND", "FDAT", "LIM2", "OST", "DEL2", "FDAT1", "LIM1", "D9129", "DAYSN", "ACC", "NOT_9129") AS 
  SELECT x.nd
      ,x.fdat
      ,x.lim2
      ,nvl(x.ost, 0) ost
      ,x.lim2 + x.ost del2
      ,x.fdat - 1 fdat1
      ,decode(x.fdat1
             ,NULL
             ,x.lim2
             ,(SELECT lim2 / 100
                FROM cc_lim
               WHERE nd = x.nd
                 AND fdat = x.fdat1)) lim1
      ,(SELECT txt
          FROM nd_txt
         WHERE nd = x.nd
           AND tag = 'D9129') / 100 d9129
      ,x.not_sn daysn
      ,x.acc
      ,x.not_9129
  FROM (SELECT nd
              ,fdat
              ,lim2 / 100 lim2
              ,sumg / 100 sumg
              ,fost(acc, fdat) / 100 ost
              ,l.not_9129
              ,(SELECT MAX(fdat)
                  FROM cc_lim
                 WHERE nd = l.nd
                   AND fdat < l.fdat) fdat1
              ,l.not_sn
              ,l.acc
          FROM cc_lim l
         ) x;

PROMPT *** Create  grants  V_CCK_GLK ***
grant SELECT                                                                 on V_CCK_GLK       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_GLK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_GLK       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_GLK.sql =========*** End *** ====
PROMPT ===================================================================================== 
