

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALOTC.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALOTC ***

  CREATE OR REPLACE FORCE VIEW BARS.SALOTC ("ACC", "NLS", "KV", "NMS", "FDAT", "DOS", "KOS", "OSTF", "NBS") AS 
  select a.acc,a.nls, a.kv, a.nms, B.fdat,
           iif_d (s.fdat, B.fdat, 0, s.dos, 0),
           iif_d (s.fdat, B.fdat, 0, s.kos, 0),
           s.ostf - s.dos + s.kos,a.nbs
       from accounts a, saldoa s, FDAT1 B
       where a.acc=s.acc and
           s.fdat in
          (select max(c.fdat) from saldoa c where c.acc=a.acc and
           c.fdat <= B.fdat);

PROMPT *** Create  grants  SALOTC ***
grant SELECT                                                                 on SALOTC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALOTC          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALOTC.sql =========*** End *** =======
PROMPT ===================================================================================== 
