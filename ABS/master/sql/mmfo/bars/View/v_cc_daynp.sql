

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_DAYNP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_DAYNP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_DAYNP ("KOD", "TXT") AS 
  SELECT -2 kod,'Без Кориктування' txt FROM DUAL
UNION ALL
SELECT -1 kod,'Попередній без вихіду на попер. місяць' txt FROM DUAL
UNION ALL
SELECT 0, 'Попередній' FROM DUAL
UNION ALL
SELECT 1, 'Наступний' FROM DUAL
UNION ALL
SELECT 2, 'Наступний без вихіду на наступ. місяць' FROM DUAL;

PROMPT *** Create  grants  V_CC_DAYNP ***
grant SELECT                                                                 on V_CC_DAYNP      to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_DAYNP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_DAYNP      to RCC_DEAL;
grant SELECT                                                                 on V_CC_DAYNP      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_DAYNP.sql =========*** End *** ===
PROMPT ===================================================================================== 
