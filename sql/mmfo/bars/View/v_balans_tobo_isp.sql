

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO_ISP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_TOBO_ISP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_TOBO_ISP ("TOBO", "FDAT", "NBS", "ISP", "FIO", "DOS", "KOS", "ISD", "ISK") AS 
  select s.tobo, s.fdat fdat, s.nbs nbs, s.isp isp, f.fio fio,
       sum(gl.p_icurval(s.kv,s.dos,s.fdat)) dos,
       sum(gl.p_icurval(s.kv,s.kos,s.fdat)) kos,
      -sum(decode(sign(s.ost),-1,gl.p_icurval(s.kv,s.ost,s.fdat),0)) isd,
       sum(decode(sign(s.ost), 1,gl.p_icurval(s.kv,s.ost,s.fdat),0)) isk
from sal_branch s, staff f
where (s.dazs is null or s.dazs>=s.fdat) and f.id=s.isp
group by s.tobo, s.fdat, s.nbs, s.isp, f.fio

 ;

PROMPT *** Create  grants  V_BALANS_TOBO_ISP ***
grant SELECT                                                                 on V_BALANS_TOBO_ISP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_TOBO_ISP to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_TOBO_ISP to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO_ISP.sql =========*** End 
PROMPT ===================================================================================== 
