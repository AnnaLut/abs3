

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OVER.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OVER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OVER ("NLSA", "ACCA", "NLSB", "ACCB", "KV", "TIPO", "OST1", "OST2", "OST", "NMSA", "NMSB", "NMK") AS 
  select  
a.nls, a.acc, b.nls,b.acc, 
a.kv, c.tipo, a.ostc, b.ostc, 
a.ostc+b.ostc, a.nms, b.nms, u.nmk     
from accounts a, accounts b, acc_over c, cust_acc cu, customer u  
where a.acc=c.acc and b.acc=c.acco and 
cu.acc=a.acc and cu.rnk=u.rnk;

PROMPT *** Create  grants  V_OVER ***
grant SELECT                                                                 on V_OVER          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OVER          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OVER.sql =========*** End *** =======
PROMPT ===================================================================================== 
