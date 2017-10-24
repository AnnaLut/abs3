

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/O59S.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view O59S ***

  CREATE OR REPLACE FORCE VIEW BARS.O59S ("NLS", "KV", "NMS", "DAT1", "DAT2", "VOSTD", "VOSTK", "DOS", "KOS", "IOSTD", "IOSTK") AS 
  select nls,kv,nms,dat1,dat2,
        decode(sign(vost),1,0,-vost),
        decode(sign(vost),1, vost,0),
        dos,       kos,
        decode(sign(iost),1,0,-iost),
        decode(sign(iost),1, iost,0)
from o59
 where (vost<>0 or dos<>0 or kos<>0 or iost<>0);

PROMPT *** Create  grants  O59S ***
grant SELECT                                                                 on O59S            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on O59S            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/O59S.sql =========*** End *** =========
PROMPT ===================================================================================== 
