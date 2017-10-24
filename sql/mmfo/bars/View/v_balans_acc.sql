

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_ACC ("TOBO", "FDAT", "NBS", "ISP", "ACC", "NLS", "KV", "NMS", "NMK", "DIG", "DOS", "KOS", "ISD", "ISK") AS 
  SELECT a.BRANCH, d.caldt_DATE, a.nbs,a.isp,a.acc, a.nls,a.kv,a.nms, c.nmk, 2,
    b.dos,b.kos, DECODE(SIGN(b.ost),-1,-b.ost,0), DECODE(SIGN(b.ost),1,b.ost,0)
FROM accm_calendar d, accm_snap_balances b, accounts a , customer c
where b.acc=a.acc  and d.caldt_ID=b.caldt_ID and a.nbs not like '8%'
  and b.rnk=c.rnk
  and a.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
  and (b.ost<>0 or b.dos <>0 or b.kos<>0)
 ;

PROMPT *** Create  grants  V_BALANS_ACC ***
grant SELECT                                                                 on V_BALANS_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_ACC    to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_ACC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
