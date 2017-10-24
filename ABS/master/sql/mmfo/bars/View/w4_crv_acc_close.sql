

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_CRV_ACC_CLOSE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_CRV_ACC_CLOSE ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_CRV_ACC_CLOSE ("ACC", "NLS", "BRANCH", "CRV_RNK") AS 
  select a.acc, a.nls, a.branch, w.value crv_rnk
  from w4_acc o, accounts a, customerw w,
       (select min(to_date(val,'dd.mm.yyyy')) dat from ow_params where par = 'CRV_CDAT') d
 where o.acc_pk = a.acc
   and a.tip = 'W4V' and a.nls like '2625%'
   and a.dazs is not null
   and a.dazs < bankdate and (d.dat is null or a.dazs >= d.dat)
   and a.rnk = w.rnk
   and w.tag = 'RVRNK';

PROMPT *** Create  grants  W4_CRV_ACC_CLOSE ***
grant SELECT                                                                 on W4_CRV_ACC_CLOSE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_CRV_ACC_CLOSE to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_CRV_ACC_CLOSE.sql =========*** End *
PROMPT ===================================================================================== 
