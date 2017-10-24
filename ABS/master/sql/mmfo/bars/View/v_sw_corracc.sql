

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_CORRACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_CORRACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_CORRACC ("ACC", "NLS", "KV", "LCV", "PAP", "NMS", "OSTC", "OSTB", "BIC", "DIG") AS 
  select a.acc, a.nls, a.kv, t.lcv, a.pap, a.nms, (decode(a.pap, 1, -1, 1)*a.ostc)/power(10, t.dig) ostc, (decode(a.pap, 1, -1, 1)*a.ostb)/power(10, t.dig) ostb, b.bic, t.dig
  from bic_acc b, accounts a, tabval t
 where b.acc = a.acc
   and a.kv  = t.kv
   and a.dazs is null
 ;

PROMPT *** Create  grants  V_SW_CORRACC ***
grant SELECT                                                                 on V_SW_CORRACC    to BARS013;
grant SELECT                                                                 on V_SW_CORRACC    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_CORRACC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_CORRACC.sql =========*** End *** =
PROMPT ===================================================================================== 
