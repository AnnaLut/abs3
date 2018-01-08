

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTW_R.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTW_R ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTW_R ("RNK", "TAG", "RISK", "RISK_DATE", "IDUPD", "CHGACTION") AS 
  SELECT w.rnk RNK,
            w.tag,
            w.value RISK,
            w.chgdate RISK_DATE,
            w.idupd,
            case when w.chgaction = 1 then 'Додано запис'
                 when w.chgaction = 2 then 'Оновлено запис'
                 when w.chgaction = 3 then 'Видалено запис'
            end chgaction
       FROM customerw_update w
      WHERE w.tag = 'RIZIK'
      order by w.idupd;

PROMPT *** Create  grants  V_CUSTW_R ***
grant SELECT                                                                 on V_CUSTW_R       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTW_R       to CUST001;
grant SELECT                                                                 on V_CUSTW_R       to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTW_R.sql =========*** End *** ====
PROMPT ===================================================================================== 
