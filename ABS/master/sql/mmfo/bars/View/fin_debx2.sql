

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBX2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBX2 ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBX2 ("MOD_ABS", "NBS_N", "ACC", "KV", "NLS", "OSTC", "BRANCH") AS 
  select f.mod_abs,a.nbs||a.ob22 nbs_n, a.acc, a.kv, a.nls, a.ostc,a.branch
from accounts a, fin_debt f, nd_acc n, cc_deal d
where a.dazs is  null and substr(d.prod,1,6) =f.nbs_n and d.vidd in (137,237,337) and d.nd = n.nd and n.acc= a.acc
       union all ------------------- Все, что есть в КП
select CASE WHEN d.vidd in (1,2,3) THEN 2 when d.vidd in (11,12,13) then 3  ELSE  NULL   END mod_abs,
          a.nbs||a.ob22,a.acc,a.kv,a.nls,a.ostc,a.branch from accounts a, nd_acc n, (select * from cc_deal where vidd in (1,2,3,11,12,13) ) d
                                                                  where  d.nd = n.nd and  a.dazs is null and a.nbs like '357_' and a.acc = n.acc
       union all ------------------- Все, что есть в абонплате
select 4, a.nbs||a.ob22,a.acc,a.kv,a.nls,a.ostc,a.branch from accounts a, e_deal d  where a.dazs is null and a.nbs like '357_' and a.acc = d.acc36
       union all    ------------------- Все, что есть в РКО
select 5, a.nbs||a.ob22,a.acc,a.kv,a.nls,a.ostc,a.branch from accounts a,rko_lst d  where a.dazs is null and a.nbs like '357_' and a.acc = d.acc1
       union all ---------- Все, что есть в BPK WAY4
select 7, a.nbs||a.ob22,a.acc,a.kv,a.nls,a.ostc,a.branch from accounts a, w4_acc d  where a.dazs is null and a.nbs like '357_' and a.acc = d.acc_3570
       union all    --- Все, что есть в CIN
select 6, a.nbs||a.ob22,a.acc,a.kv,a.nls,a.ostc,a.branch from accounts a,cin_cust d where a.dazs is null and a.nbs like '357_' and a.nls= d.nls_3578
;

PROMPT *** Create  grants  FIN_DEBX2 ***
grant SELECT                                                                 on FIN_DEBX2       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_DEBX2       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBX2       to START1;
grant SELECT                                                                 on FIN_DEBX2       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBX2.sql =========*** End *** ====
PROMPT ===================================================================================== 
