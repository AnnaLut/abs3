

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPEN_BANKDATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPEN_BANKDATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPEN_BANKDATES ("FDAT") AS 
  select fdat
  from fdat
 where nvl(stat, 0) = 0
with read only;

PROMPT *** Create  grants  V_OPEN_BANKDATES ***
grant SELECT                                                                 on V_OPEN_BANKDATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OPEN_BANKDATES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPEN_BANKDATES.sql =========*** End *
PROMPT ===================================================================================== 
