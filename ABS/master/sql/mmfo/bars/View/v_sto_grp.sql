

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_GRP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_GRP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_GRP ("NUM", "NAME") AS 
  (SELECT rownum as NUM, NAME FROM STO_GRP UNION ALL SELECT (select max(rownum)+1 from STO_GRP) as NUM, 'ÔÎ‡Ú≥Ê —¡ŒÕ' FROM DUAL);

PROMPT *** Create  grants  V_STO_GRP ***
grant SELECT                                                                 on V_STO_GRP       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_GRP.sql =========*** End *** ====
PROMPT ===================================================================================== 
