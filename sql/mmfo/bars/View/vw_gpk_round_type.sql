

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_GPK_ROUND_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_GPK_ROUND_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_GPK_ROUND_TYPE ("TYPE", "NAME") AS 
  SELECT 0 TYPE, '0.Коп 1123.45' NAME
  FROM dual
UNION ALL
SELECT 1 TYPE, '1.10 "Коп" 1123.50' NAME
  FROM dual
UNION ALL
SELECT 2 TYPE, '2.100 "Коп" 1124.00' NAME
  FROM dual
UNION ALL
SELECT 3 TYPE, '3.1000 "Коп" 1120.00' NAME
  FROM dual
UNION ALL
SELECT 4 TYPE, '4.10000 "Коп" 1100.00' NAME
  FROM dual
UNION ALL
SELECT 5 TYPE, '5.100000 "Коп" 1000.00' NAME
  FROM dual;

PROMPT *** Create  grants  VW_GPK_ROUND_TYPE ***
grant SELECT                                                                 on VW_GPK_ROUND_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on VW_GPK_ROUND_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_GPK_ROUND_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_GPK_ROUND_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
