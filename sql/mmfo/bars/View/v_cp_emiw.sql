

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_EMIW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_EMIW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_EMIW ("RNK", "TAG", "VALUE") AS 
  select r.rnk, t.tag, (select substr(value,1,255) from  cp_emiw where rnk= r.rnk and tag = t.tag) 
from v_cp_emi r, v1_cp_tag t;

PROMPT *** Create  grants  V_CP_EMIW ***
grant SELECT                                                                 on V_CP_EMIW       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CP_EMIW       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_EMIW       to START1;
grant SELECT                                                                 on V_CP_EMIW       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_EMIW.sql =========*** End *** ====
PROMPT ===================================================================================== 
