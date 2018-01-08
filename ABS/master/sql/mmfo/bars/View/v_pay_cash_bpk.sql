

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_CASH_BPK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_CASH_BPK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_CASH_BPK ("P_DATA", "P_DATA_BEG", "P_DATA_END", "F_DATA", "BRANCH", "RNK", "NLS", "NMS", "OST", "ACC", "OKPO", "SER_NUMDOC") AS 
  select w.RVIDT, w.RVIDT +1, w.RVIDT-1,
       a.dazs, a.branch, w.rnk, a.nls, a.nms, a.ostc/100 S, a.acc,
       c.okpo , p.SER||' '||p.NUMDOC
from v_gl a, customer c, person p,
    (select rnk,to_date(value,'dd/mm/yyyy') RVIDT
     from customerw where tag = 'RVIDT'  and length(value) =10
     ) w
where a.rnk  = w.rnk
--  and not exists (select 1 from customerw where tag ='RVRDT' and rnk= a.rnk)
  and a.rnk  = c.rnk
  and a.rnk  = p.rnk
  and a.nbs  = '2625'
  and a.ob22 = '22'
  and a.kv   = 980
  and a.ostc > 0
  and a.ostc = a.ostb;

PROMPT *** Create  grants  V_PAY_CASH_BPK ***
grant SELECT                                                                 on V_PAY_CASH_BPK  to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_PAY_CASH_BPK  to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_PAY_CASH_BPK  to PYOD001;
grant SELECT                                                                 on V_PAY_CASH_BPK  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_CASH_BPK.sql =========*** End ***
PROMPT ===================================================================================== 
