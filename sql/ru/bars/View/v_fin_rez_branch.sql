

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_BRANCH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_REZ_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_REZ_BRANCH ("NBS", "OB22", "NLS", "BRANCH", "N1", "N2", "DAT1", "DAT2") AS 
  select substr(nls,1,4) NBS,
       substr(nls,5,2) OB22,
       nls, branch,
       n1/100 N1, n2/100 N2,
       to_date( substr(name1, 2, 8),'yyyymmdd') DAT1,
       to_date( substr(name1,10, 8),'yyyymmdd') DAT2
from CCK_AN_TMP;

PROMPT *** Create  grants  V_FIN_REZ_BRANCH ***
grant SELECT                                                                 on V_FIN_REZ_BRANCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FIN_REZ_BRANCH to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_REZ_BRANCH.sql =========*** End *
PROMPT ===================================================================================== 
