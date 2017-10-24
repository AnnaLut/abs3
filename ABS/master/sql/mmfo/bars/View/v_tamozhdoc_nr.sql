

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TAMOZHDOC_NR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TAMOZHDOC_NR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TAMOZHDOC_NR ("PID", "RNK", "NMK", "BENEFNAME", "BENEFCOUNTRY", "NAME_COUNTRY", "IMPEXP", "NAME", "DATEOPEN", "IDT", "NAME_TD", "DATE_TD", "SG", "KV", "KURS", "SV") AS 
  SELECT tc.pid, tc.rnk, c.nmk, tc.benefname, tc.benefcountry, co.name,
       tc.impexp, tc.name, tc.dateopen,
       tm.idt, tm.name, tm.datedoc, tm.s/100,
       tm.kv, to_char(tm.kurs,'9999.999999'),
       to_char(round(tm.s/tm.kurs)/100,'9999999999.99')
  FROM top_contracts tc, tamozhdoc tm,
       customer c, country co
 WHERE tc.closed = 0
   AND tc.id_oper = 1
   AND tm.pid = tc.pid
   AND tm.idr IS NULL
   AND tm.Id_parent IS NULL
   AND c.rnk = tc.rnk
   AND tc.benefcountry = co.country AND trim(tm.name) IS NOT NULL;

PROMPT *** Create  grants  V_TAMOZHDOC_NR ***
grant SELECT                                                                 on V_TAMOZHDOC_NR  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TAMOZHDOC_NR  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TAMOZHDOC_NR.sql =========*** End ***
PROMPT ===================================================================================== 
