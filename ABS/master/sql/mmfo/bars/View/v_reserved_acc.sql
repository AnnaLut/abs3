

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RESERVED_ACC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RESERVED_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RESERVED_ACC ("ACC", "NLS", "KV", "NMS", "FLAG_OPEN", "RNK", "OKPO", "NMK") AS 
  select a.acc, a.nls, a.kv, a.nms, null flag_open, c.rnk, c.okpo, c.nmk
  from accounts a, accountsw w, customer c
 where a.acc = w.acc
   and w.tag = 'RESERVED' and w.value = '1'
   and a.rnk = c.rnk
   and c.date_off is null;

PROMPT *** Create  grants  V_RESERVED_ACC ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_RESERVED_ACC  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RESERVED_ACC  to CUST001;
grant FLASHBACK,SELECT                                                       on V_RESERVED_ACC  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RESERVED_ACC.sql =========*** End ***
PROMPT ===================================================================================== 
