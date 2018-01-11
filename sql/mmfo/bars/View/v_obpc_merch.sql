

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_MERCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_MERCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_MERCH ("MERCH", "KV", "BRANCH_N", "CITY", "CARD_SYSTEM", "TRANSIT_NLS") AS 
  select m.merch, m.kv, d.name, d.city, m.card_system, a.nls
  from obpc_merch m, accounts a, demand_filiales d
 where m.transit_acc = a.acc(+)
 and m.kv=980 and m.merch = d.client_1(+)
union all
select m.merch, m.kv, d.name, d.city, m.card_system, a.nls
  from obpc_merch m, accounts a, demand_filiales d
 where m.transit_acc = a.acc(+)
 and m.kv=840 and m.merch = d.client_0(+);

PROMPT *** Create  grants  V_OBPC_MERCH ***
grant SELECT                                                                 on V_OBPC_MERCH    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_MERCH    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_MERCH    to OBPC;
grant SELECT                                                                 on V_OBPC_MERCH    to UPLD;
grant FLASHBACK,SELECT                                                       on V_OBPC_MERCH    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_MERCH.sql =========*** End *** =
PROMPT ===================================================================================== 
