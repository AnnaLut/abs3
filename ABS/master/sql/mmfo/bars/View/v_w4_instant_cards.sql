

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_INSTANT_CARDS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_INSTANT_CARDS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_INSTANT_CARDS ("ACC", "NLS", "KV", "TIP", "DAOS", "CARD_CODE", "CODE", "PRODUCT_CODE", "DATE_OPEN", "DATE_CLOSE") AS 
  select i.acc, i.nls, i.kv, i.tip, i.daos,
       i.card_code, d.code, d.product_code,
       d.date_open, d.date_close
  from v_w4_acc_instant i, w4_card d
 where d.sub_code like i.sub_code || '%';

PROMPT *** Create  grants  V_W4_INSTANT_CARDS ***
grant SELECT                                                                 on V_W4_INSTANT_CARDS to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_INSTANT_CARDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_INSTANT_CARDS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_INSTANT_CARDS.sql =========*** End
PROMPT ===================================================================================== 
