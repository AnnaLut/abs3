

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBVA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBVA ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBVA ("MOD_ABS", "NBS_N", "NBS_P", "NBS_K", "KV", "OSTN", "KOL", "OSTP", "OSTK", "OSTD", "TACC", "POM") AS 
  select MOD_abs, nbs_n, nbs_p, nbs_k, kv, ostn, kol, ostp, ostk, ostD,  '=> Порфель =>' tacc,  Decode ( ostn, ostD, '', 'Помилки') pom
from (select f.MOD_abs, f.nbs_n, f.nbs_p, f.nbs_k, a.kv,
                   sum(a.ostc)/100 ostn, count(*) kol,
           (select sum(  ostc)/100 from accounts where nbs||ob22 = f.nbs_p and kv = a.kv) ostp,
           (select sum(  ostc)/100 from accounts where nbs||ob22 = f.nbs_k and kv = a.kv) ostk,
           FIN_DEB.sum_mod( f.MOD_abs, f.nbs_n, a.kv )/100 ostD
      from accounts a, fin_debT f
      where a.dazs is null and a.nbs||a.ob22 = f.nbs_n
      group by f.MOD_abs, f.nbs_n, f.nbs_p, f.nbs_k, a.kv
    );

PROMPT *** Create  grants  FIN_DEBVA ***
grant SELECT                                                                 on FIN_DEBVA       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBVA.sql =========*** End *** ====
PROMPT ===================================================================================== 
