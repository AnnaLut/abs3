

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SALDOV_DBF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SALDOV_DBF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SALDOV_DBF ("NLS", "KV", "NLO", "BCH", "ISV", "DOSV", "KOSV", "ISP", "PAP", "PRST", "VDATE", "IS1", "DOS", "KOS", "RNK", "PR", "DAOS", "PSS", "KRAZ", "DAPS", "PS", "LIM", "NAMS") AS 
  select
x0.nls ,
x0.kv ,
x0.nlsalt ,
0 ,
-x0.ostc ,
x0.dos ,
x0.kos ,
x0.isp ,
x0.pap ,
0 ,
x0.dapp ,
-x0.ostq ,
x0.dosq ,
x0.kosq ,
x1.rnk ,
0 ,
x0.daos ,
0 ,
0 ,
0 ,
0 ,
0 ,
x0.nms from  accounts x0,  cust_acc x1
        where (((x0.acc = x1.acc ) AND
        ((x0.kv != 980) OR (x0.nls = '62048'))) AND
        (x0.nls < '90000000000000'));

PROMPT *** Create  grants  V_SALDOV_DBF ***
grant SELECT                                                                 on V_SALDOV_DBF    to BARSREADER_ROLE;
grant SELECT                                                                 on V_SALDOV_DBF    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SALDOV_DBF    to START1;
grant SELECT                                                                 on V_SALDOV_DBF    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SALDOV_DBF.sql =========*** End *** =
PROMPT ===================================================================================== 
