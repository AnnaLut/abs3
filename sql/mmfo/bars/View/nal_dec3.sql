

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_DEC3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_DEC3 ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_DEC3 ("NLS", "DD", "RR", "PP", "NMS", "NMS1", "PPS", "ORD", "FORMULA", "FORMUL1", "NLSG", "NLSG1") AS 
  SELECT  NLS,  DD, RR, PP, NMS, NMS1,PPS,
        ORD,FORMULA,FORMUL1, NLSG, NLSG1
FROM   NAL_DEC3$BASE
WHERE  KF=SYS_CONTEXT('bars_context','user_mfo')
       with check option 
 ;

PROMPT *** Create  grants  NAL_DEC3 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_DEC3        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC3        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC3        to NALOG;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC3        to NAL_DEC3;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC3        to NAL_DEC3$BASE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_DEC3        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NAL_DEC3        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_DEC3.sql =========*** End *** =====
PROMPT ===================================================================================== 
