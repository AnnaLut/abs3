

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_ACC_INSTANT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_ACC_INSTANT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_ACC_INSTANT ("ACC", "NLS", "KV", "TIP", "DAOS", "CARD_CODE", "SUB_CODE") AS 
  select a.acc, a.nls, a.kv, a.tip, a.daos, w.card_code, c.sub_code
  from w4_acc_instant w, accounts a, w4_card c
 where w.acc = a.acc and a.tip = 'W4I'
   and w.card_code = c.code;

PROMPT *** Create  grants  V_W4_ACC_INSTANT ***
grant SELECT                                                                 on V_W4_ACC_INSTANT to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_ACC_INSTANT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_ACC_INSTANT to OW;
grant SELECT                                                                 on V_W4_ACC_INSTANT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_ACC_INSTANT.sql =========*** End *
PROMPT ===================================================================================== 
