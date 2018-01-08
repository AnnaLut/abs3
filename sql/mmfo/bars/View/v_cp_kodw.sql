

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_KODW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_KODW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_KODW ("ID", "TAG", "VALUE") AS 
  select k.id, t.tag, (select substr(value,1,255) from  cp_kodw where id= k.id and tag = t.tag) 
from cp_kod k, v2_cp_tag t;

PROMPT *** Create  grants  V_CP_KODW ***
grant SELECT                                                                 on V_CP_KODW       to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_CP_KODW       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_KODW       to START1;
grant SELECT                                                                 on V_CP_KODW       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_KODW.sql =========*** End *** ====
PROMPT ===================================================================================== 
