

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_CRVACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_CRVACC ("BRANCH", "ACC", "NLS", "KV", "NMK", "RNK", "OKPO", "DAOS", "OST", "PLAN_DAZS", "FILE_NAME", "FILE_DATE") AS 
  select a.branch, a.acc, a.nls, a.kv, c.nmk, c.rnk, c.okpo,
       to_char(a.daos,'dd.mm.yyyy'), a.ostc/100 ost,
       to_char(o.dat,'dd.mm.yyyy'),
       x.file_name, to_char(x.file_date,'dd.mm.yyyy hh24:mi:ss')
  from accounts a, customer c, ow_crvacc_close o, ow_xafiles x
 where a.nbs = '2625' and a.tip = 'W4V' and a.ob22 = '22' and a.dazs is null
   and a.rnk = c.rnk
   and a.acc = o.acc(+)
   and o.file_name = x.file_name(+)
   and a.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_OW_CRVACC ***
grant DELETE,SELECT                                                          on V_OW_CRVACC     to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT                                                          on V_OW_CRVACC     to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_CRVACC.sql =========*** End *** ==
PROMPT ===================================================================================== 
