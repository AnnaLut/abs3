

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/O59.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view O59 ***

  CREATE OR REPLACE FORCE VIEW BARS.O59 ("NLS", "KV", "NMS", "DAT1", "DAT2", "VOST", "DOS", "KOS", "IOST") AS 
  select a.nls,a.kv,a.nms,b.fdat,e.fdat,
  fost(a.acc,b.fdat) + fdos(a.acc,b.fdat,b.fdat)-fkos(a.acc,b.fdat,b.fdat),
  fdos(a.acc,b.fdat,e.fdat) ,
  fkos(a.acc,b.fdat,e.fdat),
  fost(a.acc,e.fdat)
from accounts a, fdat b, fdat e;

PROMPT *** Create  grants  O59 ***
grant SELECT                                                                 on O59             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on O59             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/O59.sql =========*** End *** ==========
PROMPT ===================================================================================== 
