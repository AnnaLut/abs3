

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZBR3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZBR3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZBR3 ("REF1", "STMT1", "BRANCH3", "S") AS 
  select REF REF1, s2 STMT1, nnd BRANCH3, s 
   from TMP_ARJK_OPER where ref = to_number ( pul.Get_Mas_Ini_Val('REF1' ) )  and  s2  = to_number ( pul.Get_Mas_Ini_Val('STMT1') );

PROMPT *** Create  grants  V_XOZBR3 ***
grant SELECT                                                                 on V_XOZBR3        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_XOZBR3        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_XOZBR3        to START1;
grant SELECT                                                                 on V_XOZBR3        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZBR3.sql =========*** End *** =====
PROMPT ===================================================================================== 
