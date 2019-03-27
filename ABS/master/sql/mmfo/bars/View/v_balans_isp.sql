

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_ISP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_ISP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_ISP ("FDAT", "NBS", "ISP", "FIO", "DOS", "KOS", "ISD", "ISK") AS 
  SELECT s.FDAT, s.nbs, s.ISP, f.FIO, DOS, KOS, ISD, ISK
from staff f,
  (select fdat, nbs, isp,
          SUM(dosr) dos,  SUM(kosr) kos,
          SUM(decode(zn,1,OSTQ,  0   )) ISD,
          SUM(decode(zn,1,0   ,-OSTQ )) ISK
   FROM (select a.isp, a.nbs, d.caldt_DATE fdat,
           gl.p_icurval(a.kv,b.dos, d.caldt_DATE) dosr,
           gl.p_icurval(a.kv,b.kos, d.caldt_DATE) kosr,   sign(b.OST) ZN,
           decode(d.caldt_DATE,gl.BD,gl.p_icurval(a.kv,b.OST,d.caldt_DATE),
                                 b.OSTQ) OSTQ
         FROM accm_calendar d, accm_snap_balances b, accounts a
         where b.acc=a.acc  and d.caldt_ID=b.caldt_ID and a.nbs not like '8%'
           and a.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
           and (b.ost<>0 or b.dos <>0 or b.kos<>0)
         )
   GROUP BY FDAT, nbs, isp
   ) s
where s.isp = f.id (+)
 ;

PROMPT *** Create  grants  V_BALANS_ISP ***
grant SELECT                                                                 on V_BALANS_ISP    to BARSREADER_ROLE;
grant SELECT                                                                 on V_BALANS_ISP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_ISP    to UPLD;
grant SELECT                                                                 on V_BALANS_ISP    to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_ISP    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_ISP.sql =========*** End *** =
PROMPT ===================================================================================== 