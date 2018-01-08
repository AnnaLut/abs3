

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEBVX.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEBVX ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEBVX ("MOD_ABS", "NBS_N", "ACC", "KV", "NLS", "OSTC", "BRANCH", "SERR") AS 
  select mod_abs, nbs_n, acc, kv, nls, ostc/100 ostc, branch, 'Рахунки поза Модулем '|| mod_abs SERR
   from (select mod_abs, nbs_n, acc, kv, nls, ostc, branch from fin_debX1  minus
         select mod_abs, nbs_n, acc, kv, nls, ostc, branch from fin_debX2
         )
union all
   select mod_abs, nbs_n, acc, kv, nls, ostc/100 ostc, branch, 'Модуль '|| mod_abs || ' з помилковим ББББ.АА'  SERR
   from (select mod_abs, nbs_n, acc, kv, nls, ostc, branch from fin_debX2  minus
         select mod_abs, nbs_n, acc, kv, nls, ostc, branch from fin_debX1
         )
;

PROMPT *** Create  grants  FIN_DEBVX ***
grant SELECT                                                                 on FIN_DEBVX       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBVX       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEBVX.sql =========*** End *** ====
PROMPT ===================================================================================== 
