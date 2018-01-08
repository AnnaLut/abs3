

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VY_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view VY_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.VY_SNO ("BAL", "NAME") AS 
  SELECT -1 bal, 'Зменшити з КІНЦЯ' NAME
  FROM dual
UNION ALL
SELECT 1 bal, 'Зменшити з ПОЧАТКУ'
  FROM dual
 ORDER BY 1;

PROMPT *** Create  grants  VY_SNO ***
grant SELECT                                                                 on VY_SNO          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VY_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
