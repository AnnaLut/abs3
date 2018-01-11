

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUR_TEK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CUR_TEK ***

  CREATE OR REPLACE FORCE VIEW BARS.CUR_TEK ("KV", "VDATE", "BSUM", "RATE_O", "RATE_B", "RATE_S") AS 
  select c.kv, c.vdate, c.bsum, c.RATE_O, c.RATE_B, c.RATE_s
from cur_rates c
where c.kv<>980 and (c.kv,c.vdate)=
(select r.kv,max(r.vdate) from cur_rates r
where r.kv=c.kv and r.vdate<=bankdate
group by r.kv);

PROMPT *** Create  grants  CUR_TEK ***
grant SELECT                                                                 on CUR_TEK         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_TEK         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUR_TEK         to START1;
grant SELECT                                                                 on CUR_TEK         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUR_TEK.sql =========*** End *** ======
PROMPT ===================================================================================== 
