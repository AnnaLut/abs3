

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ICCK.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ICCK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ICCK ("BRANCH", "NAME", "ACC", "NLS", "OB22", "NMS", "N1", "REF", "N2", "N3") AS 
  select branch, name, acc, nls, nlsalt, name1, n1, porog, n2 , n1-nvl(n2,0)
from CCK_AN_TMP;

PROMPT *** Create  grants  V_ICCK ***
grant SELECT                                                                 on V_ICCK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ICCK          to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ICCK.sql =========*** End *** =======
PROMPT ===================================================================================== 
