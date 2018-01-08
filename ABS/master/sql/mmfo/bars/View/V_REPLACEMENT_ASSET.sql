

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPLACEMENT_ASSET.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPLACEMENT_ASSET ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPLACEMENT_ASSET ("ID", "NAME") AS 
  SELECT '5' ID, 'заміна активу внаслідок реструктуризації' FROM DUAL
   UNION ALL
   SELECT '6' ID, 'заміна активу , не повязана з реструктуризацією' FROM DUAL;

PROMPT *** Create  grants  V_REPLACEMENT_ASSET ***
grant SELECT                                                                 on V_REPLACEMENT_ASSET to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPLACEMENT_ASSET to START1;
grant SELECT                                                                 on V_REPLACEMENT_ASSET to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPLACEMENT_ASSET.sql =========*** En
PROMPT ===================================================================================== 
