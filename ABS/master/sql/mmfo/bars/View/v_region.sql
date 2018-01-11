

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REGION.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REGION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REGION ("ID", "NAME") AS 
  select 0 id, 'Всі регіони' name from dual
          union all
          select rnk id, nmk name from customer where stmt = 3 and sab is not null and rnk in (select rnk||'01' from BANKS_RU);

PROMPT *** Create  grants  V_REGION ***
grant SELECT                                                                 on V_REGION        to BARSREADER_ROLE;
grant SELECT                                                                 on V_REGION        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REGION        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REGION.sql =========*** End *** =====
PROMPT ===================================================================================== 
