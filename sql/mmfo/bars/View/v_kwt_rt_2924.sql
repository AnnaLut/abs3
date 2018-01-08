

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KWT_RT_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KWT_RT_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KWT_RT_2924 ("ACC", "KV", "NLS", "NMS", "OST31", "REF", "FDAT", "S") AS 
  select a.acc, a.kv, a.nls, a.nms,  bars.fost ( a.acc,  to_date   ( pul.get ('DAT01') ,'dd-mm-yyyy')-1 )/100 ost31,
       t.ref, t.fdat, t.s/100 s
from (select * from accounts        where acc = to_number ( pul.get ('ACC'  ) ) ) a,
     (select * from kwt_rt_2924 where acc = to_number ( pul.get ('ACC'  ) ) ) t
where a.acc = t.acc (+) ;

PROMPT *** Create  grants  V_KWT_RT_2924 ***
grant SELECT                                                                 on V_KWT_RT_2924   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KWT_RT_2924   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KWT_RT_2924.sql =========*** End *** 
PROMPT ===================================================================================== 
