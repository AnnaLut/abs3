

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_NOT_CONFIRM_ACC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_NOT_CONFIRM_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_NOT_CONFIRM_ACC ("ACC", "RNK", "NMK", "OKPO", "NLS", "CARD_CODE") AS 
  select t.acc, t.rnk, c.nmk, c.okpo, a.nls, w.card_code
  from w4_acc_instant t
  join customer c
    on t.rnk = c.rnk
  join accounts a
    on a.acc = t.acc
  join w4_acc w on w.acc_pk = t.acc
 where t.state = 1;

PROMPT *** Create  grants  V_W4_NOT_CONFIRM_ACC ***
grant SELECT                                                                 on V_W4_NOT_CONFIRM_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_NOT_CONFIRM_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_NOT_CONFIRM_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_NOT_CONFIRM_ACC.sql =========*** E
PROMPT ===================================================================================== 
