

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DEALS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_DEALS ("ND", "SOS", "CC_ID", "SDATE", "WDATE", "RNK", "VIDD", "LIMIT", "KPROLOG", "USER_ID", "OBS", "BRANCH", "IR", "PROD", "SDOG", "OPERW_TAG", "OPERW_VALUE") AS 
  select
  d.nd, d.sos, d.cc_id, d.sdate, d.wdate, d.rnk,
  d.vidd, d.limit, d.kprolog, d.user_id, d.obs,
  d.branch, d.ir, d.prod, d.sdog,
  w.tag as operw_tag, w.value as operw_value
from
  cc_deal d,
  mos_operw w
where
  d.nd = w.nd and
  w.tag = 'CIG_D13' and
  w.value > 0;

PROMPT *** Create  grants  V_CIG_DEALS ***
grant SELECT                                                                 on V_CIG_DEALS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIG_DEALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_DEALS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DEALS.sql =========*** End *** ==
PROMPT ===================================================================================== 
