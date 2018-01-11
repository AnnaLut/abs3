

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_V_GPK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_V_GPK ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_V_GPK ("GPK", "NAME") AS 
  SELECT 1 GPK, '1.Погашення тіла кредиту рівними сумами'  name from dual union all
   SELECT 2 GPK, '2.Погашення тіла кредиту в кінці терміну' name from dual union all
   SELECT 3 GPK, '3.Погашенння кредиту рівними долями з %% ( ануїтет )' name from dual;

PROMPT *** Create  grants  CC_V_GPK ***
grant SELECT                                                                 on CC_V_GPK        to BARSREADER_ROLE;
grant SELECT                                                                 on CC_V_GPK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_V_GPK        to START1;
grant SELECT                                                                 on CC_V_GPK        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_V_GPK.sql =========*** End *** =====
PROMPT ===================================================================================== 
