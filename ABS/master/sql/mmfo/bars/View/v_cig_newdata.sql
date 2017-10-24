

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_NEWDATA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_NEWDATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_NEWDATA ("DATA_ID", "DATA_TYPE", "BRANCH", "DOG_ID", "ND", "PHASE_ID", "PAY_METHOD_ID", "PAY_PERIOD_ID", "OPERATION", "CONTRACT_TYPE", "CONTRACT_CODE", "CONTRACT_DATE", "CONTRACT_START_DATE", "CURRENCY_ID", "CREDIT_PURPOSE", "NEGATIVE_STATUS", "APPLICATION_DATE", "EXP_END_DATE", "FACT_END_DATE", "DOG_UPD_DATE", "DOG_SYNC_DATE", "CUST_ID", "INSTALMENT_ID", "BODY_SUM", "BODY_CURR_ID", "BODY_TOTAL_CNT", "INSTALMENT_CURR_ID", "INSTALMENT_SUM", "INST_UPD_DATE", "OUTSTAND_CNT", "OUTSTAND_CURR_ID", "OUTSTAND_SUM", "OVERDUE_CNT", "I_OVERDUE_CURR_ID", "I_OVERDUE_SUM", "INST_SYNC_DATE", "CREDIT_ID", "LIMIT_CURR_ID", "LIMIT_SUM", "CREDIT_UPD_DATE", "CREDIT_USAGE", "RES_CURR_ID", "RES_SUM", "C_OVERDUE_CURR_ID", "C_OVERDUE_SUM", "CREDIT_SYNC_DATE", "CUST_TYPE", "CUST_TYPE2", "RNK", "UPD_DATE", "SYNC_DATE", "CUST_NAME", "CUST_CODE", "CUR_GRP", "CUR_NAME", "CUR_LCV", "LAST_LIMIT_SUM", "LAST_BODY_SUM", "LAST_BODY_TOTAL_CNT", "LAST_INSTALMENT_SUM") AS 
  select tab."DATA_ID",tab."DATA_TYPE",tab."BRANCH",tab."DOG_ID",tab."ND",tab."PHASE_ID",tab."PAY_METHOD_ID",tab."PAY_PERIOD_ID",tab."OPERATION",tab."CONTRACT_TYPE",tab."CONTRACT_CODE",tab."CONTRACT_DATE",tab."CONTRACT_START_DATE",tab."CURRENCY_ID",tab."CREDIT_PURPOSE",tab."NEGATIVE_STATUS",tab."APPLICATION_DATE",tab."EXP_END_DATE",tab."FACT_END_DATE",tab."DOG_UPD_DATE",tab."DOG_SYNC_DATE",tab."CUST_ID",tab."INSTALMENT_ID",tab."BODY_SUM",tab."BODY_CURR_ID",tab."BODY_TOTAL_CNT",tab."INSTALMENT_CURR_ID",tab."INSTALMENT_SUM",tab."INST_UPD_DATE",nvl(tab."OUTSTAND_CNT",0) as OUTSTAND_CNT,tab."OUTSTAND_CURR_ID",nvl(tab."OUTSTAND_SUM",0) as OUTSTAND_SUM,nvl(tab."OVERDUE_CNT",0) as OVERDUE_CNT,tab."I_OVERDUE_CURR_ID",nvl(tab."I_OVERDUE_SUM",0) as I_OVERDUE_SUM,tab."INST_SYNC_DATE",tab."CREDIT_ID",tab."LIMIT_CURR_ID",tab."LIMIT_SUM",tab."CREDIT_UPD_DATE",tab."CREDIT_USAGE",tab."RES_CURR_ID",tab."RES_SUM",tab."C_OVERDUE_CURR_ID",nvl(tab."C_OVERDUE_SUM",0) as C_OVERDUE_SUM,tab."CREDIT_SYNC_DATE",
       c.cust_type,
       decode(c.cust_type, 3, decode(cci.classification, 2, 4, 3), c.cust_type) as cust_type2,
       c.rnk,
       c.upd_date,
       c.sync_date,
       c.cust_name,
       c.cust_code,
       t.grp as cur_grp,
       t.name as cur_name,
       t.lcv as cur_lcv,
       nvl(first_value(limit_sum) over(partition by tab.branch, nd, contract_type order by credit_upd_date desc ROWS UNBOUNDED PRECEDING),0) as last_limit_sum,
       nvl(first_value(body_sum) over(partition by tab.branch, nd, contract_type order by inst_upd_date desc ROWS UNBOUNDED PRECEDING),0) as last_body_sum,
       nvl(first_value(body_total_cnt) over(partition by tab.branch, nd, contract_type order by inst_upd_date desc ROWS UNBOUNDED PRECEDING),0) as last_body_total_cnt,
       nvl(first_value(instalment_sum) over(partition by tab.branch, nd, contract_type order by inst_upd_date desc ROWS UNBOUNDED PRECEDING),0) as last_instalment_sum
         from (select s.*,
               cg.id                  as dog_id,
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
               cg.upd_date            as dog_upd_date,
               cg.sync_date           as dog_sync_date,
               cg.cust_id,
               ci.id                  as instalment_id,
               ci.body_sum,
               ci.body_curr_id,
               ci.body_total_cnt,
               ci.instalment_curr_id,
               ci.instalment_sum,
               ci.update_date         as inst_upd_date,
               ci.outstand_cnt,
               ci.outstand_curr_id,
               ci.outstand_sum,
               ci.overdue_cnt,
               ci.overdue_curr_id     as i_overdue_curr_id,
               ci.overdue_sum         as i_overdue_sum,
               ci.sync_date           as inst_sync_date,
               null                   as credit_id,
               null                   as limit_curr_id,
               null                   as limit_sum,
               ci.update_date         as credit_upd_date,
               null                   as credit_usage,
               null                   as res_curr_id,
               null                   as res_sum,
               null                   as c_overdue_curr_id,
               null                   as c_overdue_sum,
               null                   as credit_sync_date
          from cig_sync_data s, cig_dog_general cg, cig_dog_instalment ci
         where s.data_type = 3
           and s.data_id = ci.id
           and s.branch = ci.branch
           and cg.id = ci.dog_id
           and cg.branch = ci.branch
        union all
        select s.*,
               cg.id                  as dog_id,
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
               cg.upd_date            as dog_upd_date,
               cg.sync_date           as dog_sync_date,
               cg.cust_id,
               null,
               null,
               null,
               null,
               null,
               null,
               cc.update_date,
               null,
               null,
               null,
               null,
               null,
               null,
               null,
               cc.id                  as credit_id,
               cc.limit_curr_id,
               cc.limit_sum,
               cc.update_date         as credit_upd_date,
               cc.credit_usage,
               cc.res_curr_id,
               cc.res_sum,
               cc.overdue_curr_id     as c_overdue_curr_id,
               cc.overdue_sum         as c_overdue_sum,
               cc.sync_date           as credit_sync_date
          from cig_sync_data s, cig_dog_general cg, cig_dog_credit cc
         where s.data_type = 4
           and s.data_id = cc.id
           and s.branch = cc.branch
           and cg.id = cc.dog_id
           and cg.branch = cc.branch
        union all
        select s.*,
               cg.id                  as dog_id,
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
               cg.upd_date            as dog_upd_date,
               cg.sync_date           as dog_sync_date,
               cg.cust_id,
               null,
               null,
               null,
               null,
               null,
               null,
               ccc.update_date,
               null,
               null,
               null,
               null,
               null,
               null,
               null,
               ccc.id                  as credit_id,
               ccc.limit_curr_id,
               ccc.limit_sum,
               ccc.update_date         as credit_upd_date,
               ccc.credit_usage,
               ccc.used_curr_id as res_curr_id,
               ccc.used_sum as res_sum,
               null     as c_overdue_curr_id,
               null     as c_overdue_sum,
               ccc.sync_date           as credit_sync_date
          from cig_sync_data s, cig_dog_general cg, cig_dog_noninstalment ccc
         where s.data_type = 5
           and s.data_id = ccc.id
           and s.branch = ccc.branch
           and cg.id = ccc.dog_id
           and cg.branch = ccc.branch
        ) tab,
       tabval$global t,
       cig_customers c,
       cig_cust_individual cci
 where tab.currency_id = t.kv
   and c.cust_id = tab.cust_id
   and c.branch = tab.branch
   and cci.cust_id(+) = c.cust_id
   and cci.branch(+) = c.branch
   and not exists (select 1 from cig_dog_stop where dog_id = tab.dog_id and branch = tab.branch);

PROMPT *** Create  grants  V_CIG_NEWDATA ***
grant SELECT                                                                 on V_CIG_NEWDATA   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_NEWDATA.sql =========*** End *** 
PROMPT ===================================================================================== 
