

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL1 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL1 ("P080", "OB22", "R020_FA", "ACC2", "NLS2", "NMS2", "OST2", "ISP2", "ACC3", "NLS3", "OST3", "ISP3", "FDAT") AS 
  select  b.p080,b.ob22,b.r020_fa,
        a2.acc,a2.nls,substr(a2.nms,1,20), Fost(a2.ACC, D.FDAT), nvl(a2.isp,0),  a3.acc,a3.nls,
        FOST(a3.ACC, D.FDAT),  nvl(a3.isp,0), D.FDAT
from FDAT D,  accounts a2,accounts a3,specparam_int b
     where a3.accc =a2.acc and    a2.kv=980      and
           a2.acc  =b.acc
 ;

PROMPT *** Create  grants  SB_NAL1 ***
grant SELECT                                                                 on SB_NAL1         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_NAL1         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL1         to NALOG;
grant SELECT                                                                 on SB_NAL1         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL1         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL1.sql =========*** End *** ======
PROMPT ===================================================================================== 
