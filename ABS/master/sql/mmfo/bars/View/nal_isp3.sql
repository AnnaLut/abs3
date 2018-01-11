

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NAL_ISP3.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view NAL_ISP3 ***

  CREATE OR REPLACE FORCE VIEW BARS.NAL_ISP3 ("DD", "ORD", "PP", "RR", "NMS", "NLS", "ACC", "ISP") AS 
  SELECT n.dd, n.ord, n.pp, n.rr, n.nms, b.nls, b.acc, b.isp
FROM nal_dec3  n,      accounts a,      accounts b
WHERE n.nls = a.nls  AND  a.acc = b.accc  AND  substr(b.nls,1,1)='8'
and a.kv=980 and b.kv=980
union all
SELECT m.dd, m.ord, m.pp, m.rr, m.nms, c.nls, c.acc, c.isp
FROM nal_dec3  m, accounts c
WHERE m.nls = c.nls and c.kv=980
 ;

PROMPT *** Create  grants  NAL_ISP3 ***
grant SELECT                                                                 on NAL_ISP3        to BARSREADER_ROLE;
grant SELECT                                                                 on NAL_ISP3        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_ISP3        to NALOG;
grant SELECT                                                                 on NAL_ISP3        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NAL_ISP3        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NAL_ISP3.sql =========*** End *** =====
PROMPT ===================================================================================== 
