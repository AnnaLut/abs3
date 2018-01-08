

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SQZAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SQZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SQZAL ("NAME", "ID") AS 
  SELECT '̳���' name, 0 id FROM DUAL
   UNION ALL
   SELECT '������' name, 1 id FROM DUAL
   UNION ALL
   SELECT '������' name, 3 id FROM DUAL;

PROMPT *** Create  grants  V_SQZAL ***
grant SELECT                                                                 on V_SQZAL         to BARSREADER_ROLE;
grant SELECT                                                                 on V_SQZAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SQZAL         to START1;
grant SELECT                                                                 on V_SQZAL         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SQZAL.sql =========*** End *** ======
PROMPT ===================================================================================== 
