

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_DEAL ("REF", "ND", "DATD", "ID", "RNK", "CP_ID") AS 
  select d.ref, o.nd, o.datd, k.id, k.rnk, k.cp_id 
from cp_deal d, cp_kod k, oper o
where d.ref=o.ref and d.id = k.id;

PROMPT *** Create  grants  V_CP_DEAL ***
grant SELECT                                                                 on V_CP_DEAL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_DEAL       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
