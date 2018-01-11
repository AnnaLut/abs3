

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBS_BRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBS_BRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBS_BRANCH ("UR_PLAN", "UR_FAKT", "BRANCH", "NLS", "KV", "ACC", "OSTC", "NMS") AS 
  select p.ur,decode(length(a.branch),8,1,15,2,3),
  a.branch, a.nls,a.kv,a.acc, a.ostc, a.nms
from accounts a, NBS_BRANCH p
where p.ur<> decode(length(a.branch),8,1,15,2,3)
  and p.ur is not null
  and a.nbs=p.nbs
  and a.dazs is null
 ;

PROMPT *** Create  grants  V_NBS_BRANCH ***
grant SELECT                                                                 on V_NBS_BRANCH    to ABS_ADMIN;
grant SELECT                                                                 on V_NBS_BRANCH    to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBS_BRANCH    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBS_BRANCH    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBS_BRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
