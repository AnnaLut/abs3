

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_CP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_CP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_CP ("ID", "RNK", "CP_ID", "KOL") AS 
  select k.id, k.rnk, k.cp_id, d.kol 
from (select id, count (*) kol from cp_deal group by id ) d, cp_kod k
where d.id = k.id;

PROMPT *** Create  grants  V_CP_CP ***
grant SELECT                                                                 on V_CP_CP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_CP         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_CP.sql =========*** End *** ======
PROMPT ===================================================================================== 
