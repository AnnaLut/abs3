

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_CRD_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_CRD_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_CRD_DEALS ("GRT_DEAL_ID", "ND", "SOS", "SOS_NAME", "CC_ID", "SDATE", "WDATE", "RNK", "NMK", "CUSTTYPE", "CUSTTYPE_NAME", "OKPO", "VIDD", "VIDD_NAME", "S", "KV", "KV_NAME", "KV_LCV", "BRANCH") AS 
  select
  g.grt_deal_id,
  d.nd,
  d.sos,
  d.sos_name,
  d.cc_id,
  d.sdate,
  d.wdate,
  d.rnk,
  d.nmk,
  d.custtype,
  d.custtype_name,
  d.okpo,
  d.vidd,
  d.vidd_name,
  d.s,
  d.kv,
  d.kv_name,
  d.kv_lcv,
  d.branch
from
  v_crd_deals_min d,
  cc_grt g
where d.nd = g.nd;

PROMPT *** Create  grants  V_GRT_CRD_DEALS ***
grant SELECT                                                                 on V_GRT_CRD_DEALS to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_CRD_DEALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_CRD_DEALS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_CRD_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
