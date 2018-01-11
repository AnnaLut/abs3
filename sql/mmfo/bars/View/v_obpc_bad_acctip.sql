

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_ACCTIP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_BAD_ACCTIP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_BAD_ACCTIP ("BRANCH", "NLS", "LCV", "NMS", "CARD_ACCT", "CARD_SYSTEM", "TIP", "TIP_NAME", "OB22", "OB22_NAME") AS 
  select b.branch, b.nls, a.currency, b.nms, a.card_acct,
       d.name, b.tip, t.name, s.ob22, o.txt
  from obpc_acct a, accounts b, specparam_int s, tips t, sb_ob22 o, demand_card_type d
 where a.acc = b.acc
    -- только открытые счета
   and nvl(a.status,'0')<>'4' and b.dazs is null
   and b.acc = s.acc
   and b.tip = t.tip
   and b.nbs = o.r020
   and s.ob22 = o.ob22
   and a.card_type = d.card_type
   and (    b.tip  not in (select tip from demand_acc_type where card_type = d.card_type)
         or s.ob22 not in (select ob22 from obpc_tips where tip=b.tip) )
   and b.nbs in ('2625','2605');

PROMPT *** Create  grants  V_OBPC_BAD_ACCTIP ***
grant SELECT                                                                 on V_OBPC_BAD_ACCTIP to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_BAD_ACCTIP to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_BAD_ACCTIP to OBPC;
grant SELECT                                                                 on V_OBPC_BAD_ACCTIP to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_BAD_ACCTIP to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_OBPC_BAD_ACCTIP to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_BAD_ACCTIP.sql =========*** End 
PROMPT ===================================================================================== 
