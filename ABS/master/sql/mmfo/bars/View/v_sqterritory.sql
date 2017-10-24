

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SQTERRITORY.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SQTERRITORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SQTERRITORY ("CITY") AS 
  SELECT 
      REGION||', '||
      DISTRICT||', '||
      CITY
    FROM TERRITORY;

PROMPT *** Create  grants  V_SQTERRITORY ***
grant SELECT                                                                 on V_SQTERRITORY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SQTERRITORY   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SQTERRITORY.sql =========*** End *** 
PROMPT ===================================================================================== 
