

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SSB_NAL1.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SSB_NAL1 ***

  CREATE OR REPLACE FORCE VIEW BARS.SSB_NAL1 ("P080", "OB22", "R020_FA", "ACCN", "NLSN", "NMSN", "OSTN", "ISPN", "ACCF", "NLSF", "OSTF", "ISPF", "FDAT") AS 
  select  b.p080,b.ob22,b.r020_fa,
        a2.acc,a2.nls,substr(a2.nms,1,20), Fost(a2.ACC, D.FDAT), nvl(a2.isp,0),  a3.acc,a3.nls,
        FOST(a3.ACC, D.FDAT),  nvl(a3.isp,0), D.FDAT
from FDAT D,  accounts a2,accounts a3,specparam_int b
     where a3.accc =a2.acc and    a2.kv=980      and
           a2.acc  =b.acc
 ;

PROMPT *** Create  grants  SSB_NAL1 ***
grant SELECT                                                                 on SSB_NAL1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SSB_NAL1        to NALOG;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SSB_NAL1        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SSB_NAL1.sql =========*** End *** =====
PROMPT ===================================================================================== 
