

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL3 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL3 ("FDAT", "DD", "RR", "P080", "OB22", "R020_FA", "ACC1", "NLS1", "OST1", "OST2", "OST4") AS 
  select D.FDAT,
   n.dd, n.rr, b.p080,b.ob22,b.r020_fa,a1.acc,a1.nls,
 NVL( FOST(a1.ACC,D.FDAT), 0 ),
 sum( NVL( FOST(a2.ACC,D.FDAT), 0 ) ),
 NVL( FOST(a1.ACC,D.FDAT), 0 ) - sum( NVL( FOST(a2.ACC,D.FDAT), 0 ) )
from FDAT D,
     nal_dec3 n,accounts a1,accounts a2,specparam_int b
where a1.nls=n.nls  and a2.accc=a1.acc
and a1.kv=980 and a2.kv=980 and a1.acc=b.acc
group BY D.FDAT,
         n.dd,  n.rr,b.p080,b.ob22,b.r020_fa, a1.acc,a1.nls,
         NVL( FOST(a1.ACC,D.FDAT), 0 )
 ;

PROMPT *** Create  grants  SB_NAL3 ***
grant SELECT                                                                 on SB_NAL3         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_NAL3         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL3         to NALOG;
grant SELECT                                                                 on SB_NAL3         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL3         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL3.sql =========*** End *** ======
PROMPT ===================================================================================== 
