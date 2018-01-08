

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VIREZ14.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VIREZ14 ***

  CREATE OR REPLACE FORCE VIEW BARS.VIREZ14 ("MFO", "TIPA", "ID", "EVENT", "VIDD", "KV", "A14", "B14", "N14", "P14", "R14", "Z14", "A15", "B15", "N15", "P15", "P152", "P153", "R15", "Z15") AS 
  select  MFO , tipa, id, event, vidd, kv ,
   a14, b14 , n14 , p14,              (a14+b14-n14) R14,  (- (a14+b14-n14)                 + p14              ) Z14,
   a15, b15 , n15 , p15, p152, p153,  (a15+b15-n15) R15,  (- (a15+b15-n15 +(a14+b14-n14) ) + p15 + p152 + p153) Z15 
from (select MFO, decode(tipa,null, to_number(substr(nls,1,4)), tipa) TIPA, id,   EVENT,vidd, kv, 
 sum (nvl(z14u ,0)) a14  ,  --рез.14 по МСФЗ бал.частина \
 sum (nvl(v14u ,0)) b14  ,  --рез.14 по МСФЗ Поза.бал.ч. /
 sum (nvl(z14n ,0) + nvl(v14n,0) ) n14,                     -- рез-14 по НБУ
 sum (nvl(p14  ,0)) P14  ,  -- Невизн-14
 sum (nvl(qz15u,0)) A15  ,  --рез.15 по МСФЗ бал.частина \    
 sum (nvl(qv15u,0)) B15  ,  --рез.15 по МСФЗ Поза.бал.ч. /    
 sum ( nvl(z15n,0) + nvl(v15n,0) ) N15,                     -- рез-15 по НБУ
 sum (nvl(p15  ,0)) P15  ,  -- Невизн-15.1
 sum (nvl(p152 ,0)) P152 ,  -- Невизн-15.2
 sum (nvl(p153 ,0)) P153    -- Невизн-15.3
      from rez14
      group by  MFO, decode(tipa,null, to_number(substr(nls,1,4)), tipa), id, EVENT, vidd, kv 
     );

PROMPT *** Create  grants  VIREZ14 ***
grant SELECT                                                                 on VIREZ14         to BARSREADER_ROLE;
grant SELECT                                                                 on VIREZ14         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIREZ14         to START1;
grant SELECT                                                                 on VIREZ14         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VIREZ14.sql =========*** End *** ======
PROMPT ===================================================================================== 
