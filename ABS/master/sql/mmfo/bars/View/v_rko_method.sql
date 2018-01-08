

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_METHOD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_METHOD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_METHOD ("ACC", "ID_TARIF", "ID_RATE") AS 
  select a.acc, m.id_tarif, m.id_rate
  from v_rko_accounts a, rko_method m
 where a.acc = m.acc(+);

PROMPT *** Create  grants  V_RKO_METHOD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_METHOD    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_METHOD    to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_METHOD.sql =========*** End *** =
PROMPT ===================================================================================== 
