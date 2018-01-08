

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_SDI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_SDI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_SDI ("ND", "VIDD", "CC_ID", "DAT1", "DAT4", "OST", "DOSR", "PROS", "IRN", "KV6", "NLS6", "OST6", "AMRT", "IRR1", "IRR2") AS 
  select d.nd, d.vidd, d.cc_id, d.sdate, d.wdate, -a8.ostc,
       -least(a8.ostx-a8.ostc,0)   DOSR,
       greatest(a8.ostx-a8.ostc,0) PROS,
       acrn.FPROCN(a8.acc,0, gl.BD),
       a6.kv, a6.nls, a6.ostc,
       FDOS(a6.acc, a6.daos,gl.bd) AMRT,
       round(acrn.FPROCN(a8.acc,-2, gl.BD),4) IRR1,
       round(d.IR,4)
from cc_deal d, accounts a8, accounts a6, nd_acc n8, nd_acc n6
where d.vidd in (1,2,3,11,12,13)
  and d.nd=n8.nd and n8.acc=a8.acc and a8.tip='LIM' and a8.ostc<0
  and d.nd=n6.nd and n6.acc=a6.acc and a6.tip='SDI' and a6.ostc>0
  and  exists
  (select 1 from cc_many where nd=d.nd and sdp<>0)
 ;

PROMPT *** Create  grants  V_CC_SDI ***
grant SELECT                                                                 on V_CC_SDI        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_SDI        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_SDI        to RCC_DEAL;
grant SELECT                                                                 on V_CC_SDI        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_SDI        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_SDI.sql =========*** End *** =====
PROMPT ===================================================================================== 
