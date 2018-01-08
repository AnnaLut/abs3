

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PS_LIST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PS_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PS_LIST ("NBS", "NAME") AS 
  SELECT nbs, name
       FROM ps
      WHERE     (d_close IS NULL OR d_close > bankdate)
            AND LENGTH (TRIM (nbs)) = 4
            AND nbs BETWEEN '1000' AND '9999'
   ORDER BY 1;

PROMPT *** Create  grants  V_PS_LIST ***
grant SELECT                                                                 on V_PS_LIST       to BARSREADER_ROLE;
grant SELECT                                                                 on V_PS_LIST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PS_LIST       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PS_LIST.sql =========*** End *** ====
PROMPT ===================================================================================== 
