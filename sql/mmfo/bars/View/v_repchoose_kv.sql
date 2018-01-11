

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_KV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPCHOOSE_KV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPCHOOSE_KV ("ID", "DESCRIPT") AS 
  select '%', 'Всі валюти' from dual
union all
select '980', 'Гривня' from dual
union all
select '<>980', 'Валюта' from dual
 ;

PROMPT *** Create  grants  V_REPCHOOSE_KV ***
grant SELECT                                                                 on V_REPCHOOSE_KV  to BARSREADER_ROLE;
grant SELECT                                                                 on V_REPCHOOSE_KV  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPCHOOSE_KV  to RPBN001;
grant SELECT                                                                 on V_REPCHOOSE_KV  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_KV.sql =========*** End ***
PROMPT ===================================================================================== 
