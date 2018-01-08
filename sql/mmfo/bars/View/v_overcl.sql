

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OVERCL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OVERCL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OVERCL ("ACC", "NLS", "KV", "NMS", "RNK", "NMK", "KOS", "FDAT") AS 
  select a.acc,a.nls,a.kv,a.nms,c.rnk,c.nmk,s.kos,s.fdat
  from cust_acc ca,
       customer c,
       accounts a,
       saldoa   s
where (a.nbs  ='2600' or
  a.nbs in (select nbs2600 from acc_over_nbs))
  and a.ACC   = ca.ACC
  and c.rnk   = ca.rnk
  and a.ACC not in (select acc from acc_over)
  and s.ACC   = a.acc
  and s.kos <> 0
 ;

PROMPT *** Create  grants  V_OVERCL ***
grant INSERT                                                                 on V_OVERCL        to ABS_ADMIN;
grant INSERT,SELECT                                                          on V_OVERCL        to BARS009;
grant INSERT                                                                 on V_OVERCL        to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on V_OVERCL        to TECH005;
grant INSERT                                                                 on V_OVERCL        to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OVERCL        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OVERCL.sql =========*** End *** =====
PROMPT ===================================================================================== 
