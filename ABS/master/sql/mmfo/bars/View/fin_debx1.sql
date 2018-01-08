

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBX1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBX1 ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBX1 ("MOD_ABS", "NBS_N", "ACC", "KV", "NLS", "OSTC", "BRANCH") AS 
  select f.mod_abs, f.nbs_n, a.acc, a.kv, a.nls, a.ostc,a.branch from accounts a, fin_debt f
where a.dazs is null and a.nbs||a.ob22=f.nbs_n  ;

PROMPT *** Create  grants  FIN_DEBX1 ***
grant SELECT                                                                 on FIN_DEBX1       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_DEBX1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBX1       to START1;
grant SELECT                                                                 on FIN_DEBX1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBX1.sql =========*** End *** ====
PROMPT ===================================================================================== 
