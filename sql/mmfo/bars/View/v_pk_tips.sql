

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PK_TIPS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PK_TIPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PK_TIPS ("TIP", "NAME") AS 
  select unique t.tip, t.name
  from obpc_tips o, tips t
 where o.tip = t.tip
 ;

PROMPT *** Create  grants  V_PK_TIPS ***
grant SELECT                                                                 on V_PK_TIPS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PK_TIPS       to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PK_TIPS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PK_TIPS.sql =========*** End *** ====
PROMPT ===================================================================================== 
