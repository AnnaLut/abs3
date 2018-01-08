

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST_SAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST_SAL ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST_SAL ("RNK", "ACC", "NLS", "KV", "NMS", "NBS", "ISP", "DAOS", "DAZS", "FDAT", "DATF", "DATP", "DOS", "KOS", "OST") AS 
  SELECT
 u.rnk,a.acc,a.nls,a.kv,a.nms,a.nbs,a.isp,a.daos,a.dazs,B.fdat,s.fdat,s.pdat,
 decode(s.fdat,B.fdat,s.dos,0),
 decode(s.fdat,B.fdat,s.kos,0),
 s.ostf-s.dos+s.kos
FROM accounts a, saldoa s, fdat B, cust_acc u
WHERE a.acc=s.acc AND
      u.acc=a.acc AND
     (a.acc,s.fdat) = (select c.acc,max(c.fdat)
                       from saldoa c
                       where a.acc=c.acc and c.fdat <= B.fdat
                       group by c.acc
                       );

PROMPT *** Create  grants  CUST_SAL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_SAL        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_SAL        to CUST_SAL;
grant FLASHBACK,SELECT                                                       on CUST_SAL        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST_SAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
