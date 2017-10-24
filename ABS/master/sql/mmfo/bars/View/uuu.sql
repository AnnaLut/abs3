

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/UUU.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view UUU ***

  CREATE OR REPLACE FORCE VIEW BARS.UUU ("NLS", "KV", "FDAT", "DOS", "KOS", "OST") AS 
  select distinct a.nls, a.kv, B.fdat,
       iif_d (s.fdat, B.fdat, 0, s.dos, 0),
       iif_d (s.fdat, B.fdat, 0, s.kos, 0),
       s.ostf - s.dos + s.kos
from accounts a, saldoa s,
     saldoa B
where a.acc=s.acc and
      s.fdat in
  (select max(c.fdat) from saldoa c where c.acc=a.acc and
   c.fdat <= B.fdat);

PROMPT *** Create  grants  UUU ***
grant SELECT                                                                 on UUU             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UUU             to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/UUU.sql =========*** End *** ==========
PROMPT ===================================================================================== 
