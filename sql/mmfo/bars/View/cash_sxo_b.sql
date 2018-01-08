

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CASH_SXO_B.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CASH_SXO_B ***

  CREATE OR REPLACE FORCE VIEW BARS.CASH_SXO_B ("BRANCH", "BRANCH_SXO", "NLS_1007", "NMS", "NLS_1001") AS 
  select  b.BRANCH, x.BRANCH_sxo, x.nls_1007, x.nms ,
       substr( (select val from BRANCH_PARAMETERS where tag = 'CASHS' and branch = x.BRANCH_sxo), 1, 15) nls_1001
from branch2 b,
    (select p.BRANCH, a.branch BRANCH_sxo, a.nls nls_1007, a.nms
     from accounts a, (select * from BRANCH_PARAMETERS where tag = 'CASH7') p
     where val = a.nls and a.kv = 980
    ) x
where b.branch = x.branch(+);

PROMPT *** Create  grants  CASH_SXO_B ***
grant SELECT                                                                 on CASH_SXO_B      to BARSREADER_ROLE;
grant SELECT                                                                 on CASH_SXO_B      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_SXO_B      to START1;
grant SELECT                                                                 on CASH_SXO_B      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CASH_SXO_B.sql =========*** End *** ===
PROMPT ===================================================================================== 
