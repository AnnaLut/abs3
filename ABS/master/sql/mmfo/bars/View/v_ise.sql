

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ISE.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ISE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ISE ("ISE", "NAME", "D_CLOSE") AS 
  select "ISE","NAME","D_CLOSE" from ise where ise <> '00000'
;

PROMPT *** Create  grants  V_ISE ***
grant SELECT                                                                 on V_ISE           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ISE           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ISE.sql =========*** End *** ========
PROMPT ===================================================================================== 
