

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DATA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_DATA ("CUST_ID", "CUST_TYPE", "RNK", "UPD_DATE", "SYNC_DATE", "BRANCH", "CUST_NAME", "CUST_CODE", "DOG_ID", "ND", "PHASE_ID", "PAY_METHOD_ID", "PAY_PERIOD_ID", "OPERATION", "CONTRACT_TYPE", "CONTRACT_CODE", "CONTRACT_DATE", "CONTRACT_START_DATE", "CURRENCY_ID", "CREDIT_PURPOSE", "NEGATIVE_STATUS", "APPLICATION_DATE", "EXP_END_DATE", "FACT_END_DATE", "DOG_UPD_DATE", "DOG_SYNC_DATE", "CREDIT_ID", "LIMIT_CURR_ID", "LIMIT_SUM", "CREDIT_UPD_DATE", "CREDIT_USAGE", "RES_CURR_ID", "RES_SUM", "C_OVERDUE_CURR_ID", "C_OVERDUE_SUM", "CREDIT_SYNC_DATE", "INSTALMENT_ID", "BODY_SUM", "BODY_CURR_ID", "BODY_TOTAL_CNT", "INSTALMENT_CURR_ID", "INSTALMENT_SUM", "INST_UPD_DATE", "OUTSTAND_CNT", "OUTSTAND_CURR_ID", "OUTSTAND_SUM", "OVERDUE_CNT", "I_OVERDUE_CURR_ID", "I_OVERDUE_SUM", "INST_SYNC_DATE", "CUR_GRP", "CUR_NAME", "CUR_LCV", "LAST_LIMIT_SUM", "LAST_BODY_SUM", "LAST_BODY_TOTAL_CNT", "LAST_INSTALMENT_SUM") AS 
  select
  c.cust_id,
  c.cust_type,
  c.rnk,
  c.upd_date,
  c.sync_date,
  c.branch,
  c.cust_name,
  c.cust_code,
  cg.id as dog_id,
  cg.nd,
  cg.phase_id,
  cg.pay_method_id,
  cg.pay_period_id,
  cg.operation,
  cg.contract_type,
  cg.contract_code,
  cg.contract_date,
  cg.contract_start_date,
  cg.currency_id,
  cg.credit_purpose,
  cg.negative_status,
  cg.application_date,
  cg.exp_end_date,
  cg.fact_end_date,
  cg.upd_date as dog_upd_date,
  cg.sync_date as dog_sync_date,
  cc.id as credit_id,
  cc.limit_curr_id,
  cc.limit_sum,
  cc.update_date as credit_upd_date,
  cc.credit_usage,
  cc.res_curr_id,
  cc.res_sum,
  cc.overdue_curr_id as c_overdue_curr_id,
  cc.overdue_sum as c_overdue_sum,
  cc.sync_date as credit_sync_date,
  ci.id as instalment_id,
  ci.body_sum,
  ci.body_curr_id,
  ci.body_total_cnt,
  ci.instalment_curr_id,
  ci.instalment_sum,
  ci.update_date as inst_upd_date,
  ci.outstand_cnt,
  ci.outstand_curr_id,
  ci.outstand_sum,
  ci.overdue_cnt,
  ci.overdue_curr_id as i_overdue_curr_id,
  ci.overdue_sum as i_overdue_sum,
  ci.sync_date as inst_sync_date,
  t.grp as cur_grp,
  t.name as cur_name,
  t.lcv as cur_lcv,
  first_value(cc.limit_sum) over (partition by cg.branch, cg.nd, cg.contract_type order by cc.update_date desc ROWS UNBOUNDED PRECEDING) as last_limit_sum,
  first_value(ci.body_sum) over (partition by cg.branch, cg.nd, cg.contract_type order by ci.update_date desc ROWS UNBOUNDED PRECEDING) as last_body_sum,
  first_value(ci.body_total_cnt) over (partition by cg.branch, cg.nd, cg.contract_type order by ci.update_date desc ROWS UNBOUNDED PRECEDING) as last_body_total_cnt,
  first_value(ci.instalment_sum) over (partition by cg.branch, cg.nd, cg.contract_type order by ci.update_date desc ROWS UNBOUNDED PRECEDING) as last_instalment_sum
from
   cig_customers c,
   cig_dog_general cg,
   cig_dog_instalment ci,
   cig_dog_credit cc,
   tabval$global t
where cg.currency_id=t.kv
  and c.cust_id = cg.cust_id
  and c.branch = cg.branch
  and cg.id=ci.dog_id(+)
  and cg.branch = ci.branch (+)
  and cg.id=cc.dog_id(+)
  and cg.branch = cc.branch(+)
  and not exists (select dog_id from cig_dog_stop where dog_id = cg.id and branch = cg.branch);

PROMPT *** Create  grants  V_CIG_DATA ***
grant SELECT                                                                 on V_CIG_DATA      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DATA.sql =========*** End *** ===
PROMPT ===================================================================================== 
