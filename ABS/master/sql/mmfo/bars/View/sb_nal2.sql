

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL2 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL2 ("FDAT", "DD", "RR", "P080", "OB22", "R020_FA", "ACC1", "NLS1", "OST1", "ISP1", "ACC2", "NLS2", "NMS2", "OST2", "ISP2", "OST3", "OST4") AS 
  select
D.FDAT, n.dd, n.rr, b.p080, b.ob22, b.r020_fa, a1.acc, a1.nls,
  FOST(a1.ACC,D.FDAT), a1.isp, a2.acc, a2.nls, substr(a2.nms,1,20),
  NVL(FOST(a2.ACC,D.FDAT),0),a2.isp,
 sum(NVL(FOST(a3.ACC,D.FDAT),0)),
 NVL(FOST(a2.ACC,D.FDAT),0) - sum( NVL(FOST(a3.ACC,D.FDAT),0) )
from FDAT D,
     nal_dec3 n,accounts a1,accounts a2,accounts a3,specparam_int b
where a1.nls=n.nls and a3.accc (+)=a2.acc and
      a2.accc=a1.acc and a1.kv=980 and a2.kv=980 and a1.acc=b.acc
group by D.FDAT, n.dd,n.rr,b.p080,b.ob22,b.r020_fa,
         a1.acc,a1.nls,
         FOST(a1.ACC,D.FDAT),
         a1.isp,
         a2.acc,a2.nls,a2.nms,
         NVL(FOST(a2.ACC,D.FDAT),0),
         a2.isp
 ;

PROMPT *** Create  grants  SB_NAL2 ***
grant SELECT                                                                 on SB_NAL2         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_NAL2         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL2         to NALOG;
grant SELECT                                                                 on SB_NAL2         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL2         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL2.sql =========*** End *** ======
PROMPT ===================================================================================== 
