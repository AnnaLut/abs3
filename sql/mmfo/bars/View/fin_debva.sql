

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBVA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBVA ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBVA ("MOD_ABS", "NBS_N", "NBS", "OB22", "NBS_P", "NBS_K", "KV", "OSTN", "KOL", "OSTP", "OSTK", "OSTD", "TACC", "POM") AS 
  SELECT MOD_abs,
          nbs_n,
          substr(nbs_n,1,4) nbs,
          substr(nbs_n,5,2) ob22,
          nbs_p,
          nbs_k,
          kv,
          ostn,
          kol,
          ostp,
          ostk,
          ostD,
          '=> Порфель =>' tacc,
          DECODE (ostn, ostD, '', 'Помилки') pom
     FROM (  SELECT f.MOD_abs,
                    f.nbs_n,
                    f.nbs_p,
                    f.nbs_k,
                    a.kv,
                    SUM (a.ostc) / 100 ostn,
                    COUNT (*) kol,
                    (SELECT SUM (ostc) / 100
                       FROM accounts
                      WHERE nbs || ob22 = f.nbs_p AND kv = a.kv)
                       ostp,
                    (SELECT SUM (ostc) / 100
                       FROM accounts
                      WHERE nbs || ob22 = f.nbs_k AND kv = a.kv)
                       ostk,
                    FIN_DEB.sum_mod (f.MOD_abs, f.nbs_n, a.kv) / 100 ostD
               FROM accounts a, fin_debT f
              WHERE a.dazs IS NULL AND a.nbs || a.ob22 = f.nbs_n
           GROUP BY f.MOD_abs,
                    f.nbs_n,
                    f.nbs_p,
                    f.nbs_k,
                    a.kv);

PROMPT *** Create  grants  FIN_DEBVA ***
grant SELECT                                                                 on FIN_DEBVA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBVA       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBVA.sql =========*** End *** ====
PROMPT ===================================================================================== 
