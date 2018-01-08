

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_YES.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_YES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_YES ("NAME", "ID") AS 
  SELECT 'Taê' name, 'YES' id FROM DUAL;

PROMPT *** Create  grants  V_YES ***
grant SELECT                                                                 on V_YES           to BARSREADER_ROLE;
grant SELECT                                                                 on V_YES           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_YES           to START1;
grant SELECT                                                                 on V_YES           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_YES.sql =========*** End *** ========
PROMPT ===================================================================================== 
