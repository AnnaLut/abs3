

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/REZ_3800.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view REZ_3800 ***

  CREATE OR REPLACE FORCE VIEW BARS.REZ_3800 ("FDAT", "BRANCH", "KV", "SUM_REZ", "NLS", "OST_3800", "DEL") AS 
  SELECT B, branch, kv, sum_rez, NLS, ost_3800, (sum_rez+ost_3800)
FROM (SELECT d.B,  SUBSTR (a.branch || '000000/' , 1, 15)  BRANCH,
             a.kv, max (decode(a.nbs,'3800',a.nls,'1' ) )     NLS,
             SUM (decode(a.nbs,'3800',0    , m.ost) )/100 sum_rez,
             SUM (decode(a.nbs,'3800',m.ost, 0    ) )/100 ost_3800
      FROM v_gl a,  ACCM_SNAP_BALANCES m, V_SFDAT d, ACCM_CALENDAR c
      where a.kv <> 980
        and (
            a.nbs in (SELECT nbs_rez FROM srezerv_ob22 WHERE nbs_rez IS NOT NULL)
              OR
            a.nbs ='3800' and a.ob22='16'
            )
        and a.acc = m.acc
        and m.caldt_id = c.caldt_id
        and c.caldt_date = d.B
      group by  d.B, SUBSTR (a.branch||'000000/',1,15),a.kv
      having (SUM (decode(a.nbs,'3800',0    , m.ost) )<>0
               OR
              SUM (decode(a.nbs,'3800',m.ost, 0    ) )<>0
             )
);

PROMPT *** Create  grants  REZ_3800 ***
grant SELECT                                                                 on REZ_3800        to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on REZ_3800        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_3800        to SALGL;
grant SELECT                                                                 on REZ_3800        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/REZ_3800.sql =========*** End *** =====
PROMPT ===================================================================================== 
