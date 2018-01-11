

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_YESNO.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_YESNO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_YESNO ("NAME", "ID") AS 
  SELECT 'Taê' name, 1 id FROM DUAL
   UNION ALL
   SELECT 'Í³' name, 0 id FROM DUAL;

PROMPT *** Create  grants  V_YESNO ***
grant SELECT                                                                 on V_YESNO         to BARSREADER_ROLE;
grant SELECT                                                                 on V_YESNO         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_YESNO         to START1;
grant SELECT                                                                 on V_YESNO         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_YESNO.sql =========*** End *** ======
PROMPT ===================================================================================== 
