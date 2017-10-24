

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STHTYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STHTYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STHTYPE ("NAME", "ID") AS 
  SELECT 'Одноквартирний' name, 1 id FROM DUAL
   UNION ALL
   SELECT 'Двоквартирний' name, 2 id FROM DUAL
   UNION ALL
   SELECT 'Багатоквартирний ' name, 3 id FROM DUAL;

PROMPT *** Create  grants  V_STHTYPE ***
grant SELECT                                                                 on V_STHTYPE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STHTYPE       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STHTYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
