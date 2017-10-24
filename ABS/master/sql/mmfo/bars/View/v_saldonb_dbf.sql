

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SALDONB_DBF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SALDONB_DBF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SALDONB_DBF ("RNK", "DAOS", "ISP", "KV", "NBS", "NBO", "PAP", "NLS", "NLO", "NMS", "ISV", "IS1", "DOSV", "DOS", "KOSV", "KOS", "DAPP", "BANK") AS 
  select
x1.rnk ,
x0.daos ,
x0.isp ,
x0.kv ,
x0.nls ,
x0.nlsalt ,
x0.pap,
' ' ,
0 ,
x0.nms ,
-x0.ostc ,
-x0.ostq ,
x0.dos ,
x0.dosq ,
x0.kos,
x0.kosq ,
x0.dapp ,
0 from  accounts x0 , cust_acc x1 where
    ((x0.acc = x1.acc ) AND (x0.nls >= '90000000000000'));

PROMPT *** Create  grants  V_SALDONB_DBF ***
grant SELECT                                                                 on V_SALDONB_DBF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SALDONB_DBF   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SALDONB_DBF.sql =========*** End *** 
PROMPT ===================================================================================== 
