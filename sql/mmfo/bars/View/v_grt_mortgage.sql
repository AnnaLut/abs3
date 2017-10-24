

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_MORTGAGE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_MORTGAGE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_MORTGAGE ("DEAL_ID", "GRT_TYPE_ID", "GROUP_ID", "GROUP_NAME", "TYPE_NAME", "TYPE_NBS", "TYPE_S031", "DETAIL_TABLE_ID", "DETAIL_TABLE_NAME", "DETAIL_TABLE_DESC", "GRT_PLACE_ID", "PLACE_NAME", "DEAL_RNK", "CUSTTYPE", "NMK", "OKPO", "DEAL_NUM", "DEAL_DATE", "DEAL_NAME", "DEAL_PLACE", "GRT_NAME", "GRT_COMMENT", "GRT_BUY_DOGNUM", "GRT_BUY_DOGDATE", "GRT_UNIT", "UNIT_SHORT_NAME", "UNIT_FULL_NAME", "UNIT_DESC", "GRT_CNT", "GRT_SUM", "GRT_SUM_EQ", "GRT_SUM_CURCODE", "CUR_LCV", "CUR_NAME", "CHK_DATE_AVAIL", "CHK_DATE_STATUS", "REVALUE_DATE", "CHK_SUM", "CHK_FREQ", "CALC_SUM", "ACC", "WARN_DAYS", "STAFF_ID", "STAFF_LOGNAME", "STAFF_FIO", "ND", "DOG_NUM", "DOG_SDATE", "DOG_WDATE", "DOG_VIDD", "BRANCH", "ROOMS_CNT", "APP_NUM", "TOTAL_SPACE", "LIVING_SPACE", "FLOOR", "ADDR", "BUIDING_TYPE", "BUILDING_NUM", "BUILDING_LIT", "CITY", "CITY_DISTR", "LIVING_DISTR", "MICRO_DISTR", "AREA_NUM", "BUILD_SECT_COUNT", "ADD_GRT_ADDR", "MORT_DOC_NUM", "MORT_DOC_DATE", "OWNSHIP_REG_NUM", "OWNSHIP_REG_CHECKSUM", "STATUS_ID", "STATUS_DATE", "STATUS_NAME") AS 
  select
  d.deal_id,
  d.grt_type_id,
  d.group_id,
  d.group_name,
  d.type_name,
  d.type_nbs,
  d.type_s031,
  d.detail_table_id,
  d.detail_table_name,
  d.detail_table_desc,
  d.grt_place_id,
  d.place_name,
  d.deal_rnk,
  d.custtype,
  d.nmk,
  d.okpo,
  d.deal_num,
  d.deal_date,
  d.deal_name,
  d.deal_place,
  d.grt_name,
  d.grt_comment,
  d.grt_buy_dognum,
  d.grt_buy_dogdate,
  d.grt_unit,
  d.unit_short_name,
  d.unit_full_name,
  d.unit_desc,
  d.grt_cnt,
  d.grt_sum,
  p_icurval(d.grt_sum_curcode, d.grt_sum, gl.bd) as grt_sum_eq,
  d.grt_sum_curcode,
  d.cur_lcv,
  d.cur_name,
  d.chk_date_avail,
  d.chk_date_status,
  d.revalue_date,
  d.chk_sum,
  d.chk_freq,
  d.calc_sum,
  d.acc,
  d.warn_days,
  d.staff_id,
  d.staff_logname,
  d.staff_fio,
  d.nd,
  d.dog_num,
  d.dog_sdate,
  d.dog_wdate,
  d.dog_vidd,
  d.branch,
  v.rooms_cnt,
  v.app_num,
  v.total_space,
  v.living_space,
  v.floor,
  v.addr,
  v.buiding_type,
  v.building_num,
  v.building_lit,
  v.city,
  v.city_distr,
  v.living_distr,
  v.micro_distr,
  v.area_num,
  v.build_sect_count,
  v.add_grt_addr,
  v.mort_doc_num,
  v.mort_doc_date,
  v.ownship_reg_num,
  v.ownship_reg_checksum,
  d.status_id,
  d.status_date,
  d.status_name
from v_grt_deals d, grt_mortgage v
where d.deal_id = v.deal_id (+);

PROMPT *** Create  grants  V_GRT_MORTGAGE ***
grant SELECT                                                                 on V_GRT_MORTGAGE  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_MORTGAGE.sql =========*** End ***
PROMPT ===================================================================================== 
