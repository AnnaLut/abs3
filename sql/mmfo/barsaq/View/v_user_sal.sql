

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_USER_SAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_SAL ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_USER_SAL ("ACC", "NLS", "KV", "NMS", "FDAT", "PDAT", "OST", "DOS", "KOS", "OSTQ", "DOSQ", "KOSQ", "TRCN") AS 
  select  a.acc, a.nls, a.kv, a.nms,
        b.fdat,
        decode(B.fdat,s.fdat,s.pdat, s.fdat) pdat,
        s.ostf ost,
        decode(s.fdat, B.fdat,  s.dos, 0) dos,
        decode(s.fdat, B.fdat,  s.kos, 0) kos,
        bars.gl.p_icurval(a.kv, s.ostf, s.fdat) ostq,
        decode(s.fdat, B.fdat,  bars.gl.p_icurval(a.kv, s.dos, s.fdat), 0) dosq,
        decode(s.fdat, B.fdat,  bars.gl.p_icurval(a.kv, s.kos, s.fdat), 0) kosq,
        s.trcn
from barsaq.aq_subscribers_acc q, bars.accounts a, bars.saldoa s, bars.fdat B
where q.name=USER and q.acc=s.acc and a.acc=s.acc AND (a.acc,s.fdat) =
             (SELECT c.acc,max(c.fdat) FROM bars.saldoa c
              WHERE a.acc=c.acc AND c.fdat <= B.fdat GROUP BY c.acc)
 ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_USER_SAL.sql =========*** End *** =
PROMPT ===================================================================================== 
