

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_DEALS_WARN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_DEALS_WARN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_DEALS_WARN ("DEAL_ID", "GRT_TYPE_ID", "GROUP_ID", "GROUP_NAME", "TYPE_NAME", "TYPE_NBS", "TYPE_S031", "DETAIL_TABLE_ID", "DETAIL_TABLE_NAME", "DETAIL_TABLE_DESC", "GRT_PLACE_ID", "PLACE_NAME", "DEAL_RNK", "CUSTTYPE", "NMK", "OKPO", "DEAL_NUM", "DEAL_DATE", "DEAL_NAME", "DEAL_PLACE", "GRT_NAME", "GRT_COMMENT", "GRT_BUY_DOGNUM", "GRT_BUY_DOGDATE", "GRT_UNIT", "UNIT_SHORT_NAME", "UNIT_FULL_NAME", "UNIT_DESC", "GRT_CNT", "GRT_SUM", "GRT_SUM_EQ", "GRT_SUM_CURCODE", "CUR_LCV", "CUR_NAME", "CHK_DATE_AVAIL", "CHK_DATE_STATUS", "REVALUE_DATE", "CHK_SUM", "ACC", "WARN_DAYS", "STAFF_ID", "CHK_FREQ", "CALC_SUM", "STAFF_LOGNAME", "STAFF_FIO", "ND", "DOG_NUM", "DOG_SDATE", "DOG_WDATE", "DOG_VIDD", "BRANCH", "STATUS_ID", "STATUS_DATE", "STATUS_NAME", "FORM_NAME", "PLANNED_DATE", "EV_ID", "WARN_DATE", "EVENT_NAME") AS 
  select d."DEAL_ID",d."GRT_TYPE_ID",d."GROUP_ID",d."GROUP_NAME",d."TYPE_NAME",d."TYPE_NBS",d."TYPE_S031",d."DETAIL_TABLE_ID",d."DETAIL_TABLE_NAME",d."DETAIL_TABLE_DESC",d."GRT_PLACE_ID",d."PLACE_NAME",d."DEAL_RNK",d."CUSTTYPE",d."NMK",d."OKPO",d."DEAL_NUM",d."DEAL_DATE",d."DEAL_NAME",d."DEAL_PLACE",d."GRT_NAME",d."GRT_COMMENT",d."GRT_BUY_DOGNUM",d."GRT_BUY_DOGDATE",d."GRT_UNIT",d."UNIT_SHORT_NAME",d."UNIT_FULL_NAME",d."UNIT_DESC",d."GRT_CNT",d."GRT_SUM",d."GRT_SUM_EQ",d."GRT_SUM_CURCODE",d."CUR_LCV",d."CUR_NAME",d."CHK_DATE_AVAIL",d."CHK_DATE_STATUS",d."REVALUE_DATE",d."CHK_SUM",d."ACC",d."WARN_DAYS",d."STAFF_ID",d."CHK_FREQ",d."CALC_SUM",d."STAFF_LOGNAME",d."STAFF_FIO",d."ND",d."DOG_NUM",d."DOG_SDATE",d."DOG_WDATE",d."DOG_VIDD",d."BRANCH",d."STATUS_ID",d."STATUS_DATE",d."STATUS_NAME",d."FORM_NAME", w.planned_date, w.ev_id, w.warn_date, w.event_name from
(
  select d.deal_id, d.warn_days, e.id as ev_id, e.planned_date, e.planned_date - d.warn_days as warn_date, et.event_name
  from grt_deals d, grt_events e, grt_event_types et
  where d.deal_id = e.deal_id
  and e.type_id = et.event_id
  and e.actual_date is null
) w, v_grt_deals d
where w.deal_id = d.deal_id
  and w.warn_date <= sysdate
  and d.status_id > 0;

PROMPT *** Create  grants  V_GRT_DEALS_WARN ***
grant SELECT                                                                 on V_GRT_DEALS_WARN to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_DEALS_WARN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_DEALS_WARN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_DEALS_WARN.sql =========*** End *
PROMPT ===================================================================================== 
