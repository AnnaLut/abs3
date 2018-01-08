

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ABC1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view ABC1 ***

  CREATE OR REPLACE FORCE VIEW BARS.ABC1 ("P080", "R020", "OB22", "SD", "SK", "S") AS 
  select s.p080 p080, s.R020_FA r020, s.ob22 ob22,
  sum ( decode(sign(a.ost),-1, a.ost, 0) ) sd,
  sum ( decode(sign(a.ost), 1, a.ost, 0) ) sk,
  sum ( a.ost ) s
 from sal a, s_int s
 where a. fdat= '14-sep-2001' and 
       a.acc=s.acc and s.p080 is not null
 group by s.p080, s.R020_FA, s.ob22
 order by s.p080, s.R020_FA, s.ob22;

PROMPT *** Create  grants  ABC1 ***
grant SELECT                                                                 on ABC1            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ABC1            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ABC1.sql =========*** End *** =========
PROMPT ===================================================================================== 
