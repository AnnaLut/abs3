

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ATMREF07.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ATMREF07 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF07 ("ACC", "KV", "NLS", "NMS", "BRANCH", "TIP", "OB22", "OSTC", "DK", "KOL") AS 
  select a.acc, a.kv, a.nls, a.nms, a.branch, a.tip, a.ob22, a.ostc/100 OSTC , a.pap-1 DK,     (select count(*) from atm_ref1  where acc = a.acc) kol
  from accounts a     where  a.tip in ('AT7') and a.dazs is null and pap = 2 and ostc > 0;

PROMPT *** Create  grants  V_ATMREF07 ***
grant SELECT                                                                 on V_ATMREF07      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ATMREF07      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ATMREF07.sql =========*** End *** ===
PROMPT ===================================================================================== 
