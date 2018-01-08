

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBS_PROF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBS_PROF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBS_PROF ("NBS", "NP", "PR", "ID", "TAG", "NAME", "VAL", "SQL_TEXT") AS 
  SELECT p.nbs, p.np, v.pr, v.id, v.tag, v.name, p.val, p.sql_text
FROM nbs_prof p, v_nbs_proftag v
WHERE p.pr=v.pr and p.id=v.id
 ;

PROMPT *** Create  grants  V_NBS_PROF ***
grant SELECT                                                                 on V_NBS_PROF      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NBS_PROF      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBS_PROF      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_NBS_PROF      to START1;
grant SELECT                                                                 on V_NBS_PROF      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NBS_PROF      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_NBS_PROF      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBS_PROF.sql =========*** End *** ===
PROMPT ===================================================================================== 
