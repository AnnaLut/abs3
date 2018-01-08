

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ABC2.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view ABC2 ***

  CREATE OR REPLACE FORCE VIEW BARS.ABC2 ("P080", "R020", "OB22", "SD", "SK", "S") AS 
  select s.p080 p080, '', '',
 sum ( decode(sign(a.ost),-1, -a.ost, 0) ) sd,
 sum ( decode(sign(a.ost), 1, a.ost, 0) ) sk,
 sum ( abs(a.ost) ) s
from sal a, s_int s
where a. fdat= '14-sep-2001' and
      a.acc=s.acc and s.p080 is not null
group by s.p080
order by s.p080;

PROMPT *** Create  grants  ABC2 ***
grant SELECT                                                                 on ABC2            to BARSREADER_ROLE;
grant SELECT                                                                 on ABC2            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ABC2            to START1;
grant SELECT                                                                 on ABC2            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ABC2.sql =========*** End *** =========
PROMPT ===================================================================================== 
