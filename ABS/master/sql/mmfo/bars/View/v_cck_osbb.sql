

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_OSBB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_OSBB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_OSBB ("ND", "CC_ID", "RNK", "VIDD", "SDOG", "SDATE", "WDATE", "BRANCH", "PROD", "ERR") AS 
  select  ND,CC_ID,RNK,VIDD,SDOG,SDATE, WDATE, BRANCH, PROD,  (select count(*) from tmp_operW where ord = d.nd)
from cc_deal  d where sos >= 10 and sos < 14 and ( prod like '206219%' or prod like '206309%');

PROMPT *** Create  grants  V_CCK_OSBB ***
grant SELECT                                                                 on V_CCK_OSBB      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_OSBB      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_OSBB.sql =========*** End *** ===
PROMPT ===================================================================================== 
