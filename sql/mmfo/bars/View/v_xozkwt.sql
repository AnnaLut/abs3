

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZKWT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZKWT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZKWT ("KV", "NLS", "OB22", "BRANCH", "OST", "NMS", "REF1", "STMT1", "REF2", "ACC", "MDATE", "S", "FDAT", "S0", "DATZ") AS 
  select  a.kv, a.nls, a.ob22, a.branch, a.ostc/100 ost, a.nms, x.REF1, x.STMT1, x.REF2, x.ACC, x.MDATE, x.S/100 s, x.FDAT, x.S0/100 s0, x.DATZ
from xoz_ref x, accounts a  where a.acc= x.acc and  x.datz = NVL( to_date (pul.GET('DATZ'), 'dd.mm.yyyy') , gl.bd )  ;

PROMPT *** Create  grants  V_XOZKWT ***
grant SELECT                                                                 on V_XOZKWT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZKWT        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZKWT.sql =========*** End *** =====
PROMPT ===================================================================================== 
