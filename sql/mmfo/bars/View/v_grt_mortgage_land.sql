

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_MORTGAGE_LAND.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_MORTGAGE_LAND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_MORTGAGE_LAND ("DEAL_ID", "GRT_TYPE_ID", "GROUP_ID", "GROUP_NAME", "TYPE_NAME", "TYPE_NBS", "TYPE_S031", "DETAIL_TABLE_ID", "DETAIL_TABLE_NAME", "DETAIL_TABLE_DESC", "GRT_PLACE_ID", "PLACE_NAME", "DEAL_RNK", "CUSTTYPE", "NMK", "OKPO", "DEAL_NUM", "DEAL_DATE", "DEAL_NAME", "DEAL_PLACE", "GRT_NAME", "GRT_COMMENT", "GRT_BUY_DOGNUM", "GRT_BUY_DOGDATE", "GRT_UNIT", "UNIT_SHORT_NAME", "UNIT_FULL_NAME", "UNIT_DESC", "GRT_CNT", "GRT_SUM", "GRT_SUM_EQ", "GRT_SUM_CURCODE", "CUR_LCV", "CUR_NAME", "CHK_DATE_AVAIL", "CHK_DATE_STATUS", "REVALUE_DATE", "CHK_SUM", "CHK_FREQ", "CALC_SUM", "ACC", "WARN_DAYS", "STAFF_ID", "STAFF_LOGNAME", "STAFF_FIO", "ND", "DOG_NUM", "DOG_SDATE", "DOG_WDATE", "DOG_VIDD", "BRANCH", "AREA", "LAND_PURPOSE", "BUILD_NUM", "BUILD_LIT", "OWNSHIP_DOC_SER", "OWNSHIP_DOC_NUM", "OWNSHIP_DOC_DATE", "OWNSHIP_DOC_REASON", "OWNSHIP_REGBOOK_NUM", "EXTRACT_REG_DATE", "EXTRACT_REG_ORGAN", "EXTRACT_REG_NUM", "EXTRACT_REG_SUM", "LESSEE_NUM", "LESSEE_NAME", "LESSEE_DOG_ENDDATE", "LESSEE_DOG_NUM", "LESSEE_DOG_DATE", "BANS_REG_NUM", "BANS_REG_DATE", "STATUS_ID", "STATUS_DATE", "STATUS_NAME") AS 
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
  v.area,
  v.land_purpose,
  v.build_num,
  v.build_lit,
  v.ownship_doc_ser,
  v.ownship_doc_num,
  v.ownship_doc_date,
  v.ownship_doc_reason,
  v.ownship_regbook_num,
  v.extract_reg_date,
  v.extract_reg_organ,
  v.extract_reg_num,
  v.extract_reg_sum,
  v.lessee_num,
  v.lessee_name,
  v.lessee_dog_enddate,
  v.lessee_dog_num,
  v.lessee_dog_date,
  v.bans_reg_num,
  v.bans_reg_date,
  d.status_id,
  d.status_date,
  d.status_name
from v_grt_deals d, grt_mortgage_land v
where d.deal_id = v.deal_id (+);

PROMPT *** Create  grants  V_GRT_MORTGAGE_LAND ***
grant SELECT                                                                 on V_GRT_MORTGAGE_LAND to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_MORTGAGE_LAND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_MORTGAGE_LAND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_MORTGAGE_LAND.sql =========*** En
PROMPT ===================================================================================== 
