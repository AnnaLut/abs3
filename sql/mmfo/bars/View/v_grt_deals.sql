

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_DEALS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_DEALS ("DEAL_ID", "GRT_TYPE_ID", "GROUP_ID", "GROUP_NAME", "TYPE_NAME", "TYPE_NBS", "TYPE_S031", "DETAIL_TABLE_ID", "DETAIL_TABLE_NAME", "DETAIL_TABLE_DESC", "GRT_PLACE_ID", "PLACE_NAME", "DEAL_RNK", "CUSTTYPE", "NMK", "OKPO", "DEAL_NUM", "DEAL_DATE", "DEAL_NAME", "DEAL_PLACE", "GRT_NAME", "GRT_COMMENT", "GRT_BUY_DOGNUM", "GRT_BUY_DOGDATE", "GRT_UNIT", "UNIT_SHORT_NAME", "UNIT_FULL_NAME", "UNIT_DESC", "GRT_CNT", "GRT_SUM", "GRT_SUM_EQ", "GRT_SUM_CURCODE", "CUR_LCV", "CUR_NAME", "CHK_DATE_AVAIL", "CHK_DATE_STATUS", "REVALUE_DATE", "CHK_SUM", "ACC", "WARN_DAYS", "STAFF_ID", "CHK_FREQ", "CALC_SUM", "STAFF_LOGNAME", "STAFF_FIO", "ND", "DOG_NUM", "DOG_SDATE", "DOG_WDATE", "DOG_VIDD", "BRANCH", "STATUS_ID", "STATUS_DATE", "STATUS_NAME", "FORM_NAME") AS 
  select
  d.deal_id,
  d.grt_type_id,
  g.group_id,
  g.group_name,
  t.type_name,
  t.nbs as type_nbs,
  t.s031 as type_s031,
  t.detail_table_id,
  dt.table_name as detail_table_name,
  dt.table_desc as detail_table_desc,
  d.grt_place_id,
  p.place_name,
  d.deal_rnk,
  c.custtype,
  c.nmk,
  c.okpo,
  d.deal_num,
  d.deal_date,
  d.deal_name,
  d.deal_place,
  d.grt_name,
  d.grt_comment,
  d.grt_buy_dognum,
  d.grt_buy_dogdate,
  d.grt_unit,
  u.unit_short_name,
  u.unit_full_name,
  u.unit_desc,
  d.grt_cnt,
  d.grt_sum,
  p_icurval(d.grt_sum_curcode, d.grt_sum, gl.bd) as grt_sum_eq,
  d.grt_sum_curcode,
  tv.lcv as cur_lcv,
  tv.name as cur_name,
  d.chk_date_avail,
  d.chk_date_status,
  d.revalue_date,
  d.chk_sum,
  d.acc,
  d.warn_days,
  d.staff_id,
  d.chk_freq,
  d.calc_sum,
  s.logname as staff_logname,
  s.fio as staff_fio,
  cg.nd,
  cd.cc_id as dog_num,
  cd.sdate as dog_sdate,
  cd.wdate as dog_wdate,
  cd.vidd as dog_vidd,
  d.branch,
  d.status_id,
  d.status_date,
  ds.status_name,
  'frm_'||lower(dt.table_name) as form_name
from
  grt_deals d,
  grt_types t,
  grt_groups g,
  grt_detail_tables dt,
  grt_places p,
  customer c,
  grt_units u,
  staff$base s,
  cc_grt cg,
  cc_deal cd,
  tabval$global tv,
  grt_deal_statuses ds
where d.grt_type_id = t.type_id
  and t.group_id = g.group_id
  and t.detail_table_id = dt.table_id
  and d.grt_place_id = p.place_id
  and d.deal_rnk = c.rnk
  and d.grt_unit = u.unit_id (+)
  and d.staff_id = s.id
  and d.deal_id = cg.grt_deal_id
  and cg.nd = cd.nd
  and d.grt_sum_curcode = tv.kv
  and d.status_id = ds.status_id;

PROMPT *** Create  grants  V_GRT_DEALS ***
grant SELECT                                                                 on V_GRT_DEALS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_DEALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_DEALS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_DEALS.sql =========*** End *** ==
PROMPT ===================================================================================== 
