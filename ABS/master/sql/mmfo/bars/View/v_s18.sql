

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_S18.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_S18 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_S18 ("VIDD", "NMK", "BRANCH", "ND", "CC_ID", "SDATE", "WDATE", "S080", "R080", "OTM") AS 
  select
   d.VIDD, c.nmk, d.branch,d.nd, d.cc_id, d.sdate, d.wdate, s.s080,
   f.s080 R080, 0 otm
FROM cc_deal      d,
     customer     c,
     fin_obs_s080 f,
     cc_add       u,
     specparam    s
WHERE d.vidd in (1,2,3,11,12,13)
  and d.rnk   = c.rnk
  and d.nd    = u.nd
  AND u.adds  = 0
  AND u.accs  = s.acc(+)
  and c.crisk = f.fin
  AND d.obs=f.obs
  and nvl(s.s080,' ') <> f.s080
 ;

PROMPT *** Create  grants  V_S18 ***
grant SELECT                                                                 on V_S18           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_S18           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_S18.sql =========*** End *** ========
PROMPT ===================================================================================== 
