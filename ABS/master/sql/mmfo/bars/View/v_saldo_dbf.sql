

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SALDO_DBF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SALDO_DBF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SALDO_DBF ("ISP", "PAP", "NLS", "NLO", "IS1", "LIM", "DOS", "KOS", "DAPP", "TIPP", "PS", "SIO", "PR", "PSS", "PZO", "RNK", "DAOS", "VIDP", "KOD_OPL", "NEOM", "KR", "BANK", "NDO1", "DAPS", "NAMS") AS 
  select
x0.isp ,
x0.pap ,
x0.nls ,
x0.nlsalt ,
-x0.ostc ,
0,
x0.dos,
x0.kos,
to_char (x0.dapp, 'DD-MM-RR'),
0,
x0.vid,
0,
'       ',
0,
0,
x1.rnk,
x0.daos,
0,
0,
' ',
0,
0,
' ',
0,
x0.nms
from  accounts x0,  cust_acc x1
        where ((((x0.acc = x1.acc ) AND
        (x0.kv = 980)) AND (x0.nls < '90000000000000')) AND
        (x0.nls != '62048'));

PROMPT *** Create  grants  V_SALDO_DBF ***
grant SELECT                                                                 on V_SALDO_DBF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SALDO_DBF     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SALDO_DBF.sql =========*** End *** ==
PROMPT ===================================================================================== 
