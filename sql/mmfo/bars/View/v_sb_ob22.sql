

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SB_OB22.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SB_OB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SB_OB22 ("R020", "OB22", "NAME", "OPN_DT", "CLS_DT") AS 
  select R020, OB22, TXT, D_OPEN, D_CLOSE
  from BARS.SB_OB22
;

PROMPT *** Create  grants  V_SB_OB22 ***
grant SELECT                                                                 on V_SB_OB22       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SB_OB22       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SB_OB22.sql =========*** End *** ====
PROMPT ===================================================================================== 
