

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ATMREF08.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ATMREF08 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF08 ("ACC", "KV", "NLS", "NMS", "BRANCH", "TIP", "OB22", "OSTC", "DK", "KOL") AS 
  select a.acc, a.kv, a.nls, a.nms, a.branch, a.tip, a.ob22, a.ostc/100 OSTC , a.pap-1 DK,      (select count(*) from atm_ref1  where acc = a.acc) kol
  from accounts a     where  a.tip in ('AT8') and a.dazs is null and a.ostc < 0 ;

PROMPT *** Create  grants  V_ATMREF08 ***
grant SELECT                                                                 on V_ATMREF08      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ATMREF08      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ATMREF08.sql =========*** End *** ===
PROMPT ===================================================================================== 
