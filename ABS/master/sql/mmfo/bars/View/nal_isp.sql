

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_ISP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_ISP ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_ISP ("DD", "ORD", "PP", "RR", "NMS", "NLS", "ACC", "ISP") AS 
  SELECT n.dd, n.ord, n.pp, n.rr, n.nms, b.nls, b.acc, b.isp
FROM nal_dec  n,      accounts a,      accounts b
WHERE n.nls = a.nls  AND  a.acc = b.accc  AND  substr(b.nls,1,1)='8';

PROMPT *** Create  grants  NAL_ISP ***
grant SELECT                                                                 on NAL_ISP         to BARSREADER_ROLE;
grant SELECT                                                                 on NAL_ISP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_ISP         to START1;
grant SELECT                                                                 on NAL_ISP         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_ISP.sql =========*** End *** ======
PROMPT ===================================================================================== 
