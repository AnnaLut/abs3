

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_1 ("KV", "NBS", "OB22", "BRANCH", "FDAT", "IOST", "VOST", "DEL", "TXT") AS 
  SELECT k.kv, k.nbs, k.ob22, k.branch, k.fdat, k.iost / 100, k.vost / 100,
       (k.iost - k.vost) / 100 del, o.txt
FROM sb_ob22 o,
     (SELECT f.fdat, a.kv, a.nbs, a.branch, a.ob22,
             NVL (SUM (fost (a.acc, f.fdat)), 0) iost,
             NVL (SUM (fost (a.acc, f.fdat - 1)), 0) vost
      FROM fdat f,
           (SELECT kv,nbs,branch,acc,ob22 FROM accounts WHERE nbs IN ('3801','3800','6204') ) a
      WHERE f.fdat >= TO_DATE ('01-03-2009', 'dd-mm-yyyy')
      GROUP BY f.fdat, a.kv, a.nbs, a.branch, a.ob22
      UNION ALL
      SELECT f.fdat, a.kv, a.nbs, 'ˆâ®£ ¯® “', a.ob22,
             NVL (SUM (fost (a.acc, f.fdat)), 0) iost,
             NVL (SUM (fost (a.acc, f.fdat - 1)), 0) vost
      FROM fdat f,
          (SELECT kv,nbs,acc,ob22 FROM accounts WHERE nbs IN ('3801','3800','6204') ) a
      WHERE f.fdat >= TO_DATE ('01-03-2009', 'dd-mm-yyyy')
      GROUP BY f.fdat, a.kv, a.nbs, a.ob22
      UNION ALL
      SELECT f.fdat, a.kv, a.nbs, 'ˆâ®£ ¯® “', '**',
             NVL (SUM (fost (a.acc, f.fdat)), 0) iost,
             NVL (SUM (fost (a.acc, f.fdat - 1)), 0) vost
      FROM fdat f,
          (SELECT kv,nbs,acc FROM accounts WHERE nbs IN ('3801','3800','6204')) a
      WHERE f.fdat >= TO_DATE ('01-03-2009', 'dd-mm-yyyy')
      GROUP BY f.fdat, a.kv, a.nbs) k
WHERE (k.iost <> 0 OR k.vost <> 0) AND k.ob22 = o.ob22(+) AND k.nbs = o.r020(+);

PROMPT *** Create  grants  VAL_1 ***
grant SELECT                                                                 on VAL_1           to BARSREADER_ROLE;
grant SELECT                                                                 on VAL_1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_1           to SALGL;
grant SELECT                                                                 on VAL_1           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VAL_1           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
