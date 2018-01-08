

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRD_DEALS_MIN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRD_DEALS_MIN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRD_DEALS_MIN ("ND", "SOS", "SOS_NAME", "CC_ID", "SDATE", "WDATE", "RNK", "NMK", "CUSTTYPE", "CUSTTYPE_NAME", "OKPO", "VIDD", "VIDD_NAME", "S", "KV", "KV_NAME", "KV_LCV", "BRANCH") AS 
  select
  d.nd,
  d.sos,
  s.name as sos_name,
  d.cc_id,
  d.sdate,
  d.wdate,
  d.rnk,
  c.nmk,
  c.custtype,
  ct.name as custtype_name,
  c.okpo,
  d.vidd,
  cv.name as vidd_name,
  ca.s as s,
  ca.kv,
  t.name as kv_name,
  t.lcv as kv_lcv,
  d.branch
from
  cc_deal d,
  cc_add ca,
  customer c,
  custtype ct,
  cc_vidd cv,
  cc_sos s,
  tabval$global t
where d.nd = ca.nd
  and d.rnk = c.rnk
  and c.custtype = ct.custtype
  and d.vidd = cv.vidd
  and d.sos = s.sos
  and ca.kv = t.kv;

PROMPT *** Create  grants  V_CRD_DEALS_MIN ***
grant SELECT                                                                 on V_CRD_DEALS_MIN to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRD_DEALS_MIN.sql =========*** End **
PROMPT ===================================================================================== 
