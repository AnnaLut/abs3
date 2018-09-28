

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CREDIT_CONTRACTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CREDIT_CONTRACTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CREDIT_CONTRACTS ("CONTR_ID", "CONTR_TYPE", "CONTR_TYPE_NAME", "NUM", "SUBNUM", "RNK", "OKPO", "NMK", "NMKK", "PASSPORT", "CUSTTYPE", "ND", "VED", "VED_NAME", "OPEN_DATE", "CLOSE_DATE", "KV", "S", "BENEF_ID", "BENEF_NAME", "BENEF_ADR", "COUNTRY_ID", "COUNTRY_NAME", "STATUS_ID", "STATUS_NAME", "COMMENTS", "BRANCH", "BRANCH_NAME", "OWNER", "OWNER_UID", "OWNER_NAME", "BIC", "B010", "BANK_NAME", "SERVICE_BRANCH", "EA_URL", "PERCENT_NBU", "S_LIMIT", "CREDITOR_TYPE", "CREDITOR_TYPE_NAME", "BORROWER_ID", "CREDIT_TYPE", "CREDIT_TYPE_NAME", "CREDIT_TERM", "CREDIT_TERM_NAME", "CREDIT_PREPAY", "CREDIT_PREPAY_NAME", "NAME", "ADD_AGREE", "PERCENT_NBU_TYPE", "PERCENT_NBU_NAME", "PERCENT_NBU_INFO", "R_AGREE_DATE", "R_AGREE_NO", "PREV_DDOC_KEY", "PREV_REESTR_ATTR", "ENDING_DATE_INDIV", "PARENT_CH_DATA", "ENDING_DATE", "DATE_TERM_CHANGE", "S_IN_PL", "S_OUT_PL", "S_V_PR", "Z_PR", "S_PR_NBU", "S_DOD_PL", "F503_REASON", "F503_STATE", "F503_NOTE", "F504_REASON", "F504_NOTE", "F503_PERCENT_TYPE", "F503_PERCENT_BASE", "F503_PERCENT_MARGIN", "F503_PERCENT", "F503_PURPOSE", "F503_PERCENT_BASE_T", "F503_PERCENT_BASE_VAL", "F503_CHANGE_INFO", "F057") AS 
  SELECT c.contr_id,
          c.contr_type,
          c.contr_type_name,
          c.num,
          c.subnum,
          c.rnk,
          c.okpo,
          c.nmk,
          c.nmkk,
          NVL2 (p.rnk, p.ser || ' ' || p.numdoc, NULL),
          c.custtype,
          c.nd,
          c.ved,
          c.ved_name,
          c.open_date,
          c.close_date,
          c.kv,
          c.s,
          c.benef_id,
          c.benef_name,
          c.benef_adr,
          c.country_id,
          c.country_name,
          c.status_id,
          c.status_name,
          c.comments,
          c.branch,
          c.branch_name,
          c.owner,
          c.owner_uid,
          c.owner_name,
          c.bic,
          c.b010,
          c.bank_name,
          c.service_branch,
          ea_url,
          percent_nbu,                                            /*percent,*/
          ROUND (s_limit / 100, 2),
          ccd.creditor_type,
          (SELECT name
             FROM cim_creditor_type
            WHERE id = ccd.creditor_type
              and delete_date is null),
          ccd.borrower,
          ccd.credit_type,
          (SELECT name
             FROM cim_credit_type
            WHERE id = ccd.credit_type
              and delete_date is null),
          --ccd.credit_period, (select name from cim_credit_period where id=ccd.credit_period),
          ccd.credit_term,
          (SELECT name
             FROM cim_credit_term
            WHERE id = ccd.credit_term),
          --ccd.credit_method, (select name from cim_credit_method where id=ccd.credit_method),
          ccd.credit_prepay,
          (SELECT name
             FROM cim_credit_prepay
            WHERE id = ccd.credit_prepay),
          ccd.name,
          ccd.add_agree,
          ccd.percent_nbu_type,
          (SELECT name
             FROM cim_credit_percent
            WHERE id = ccd.percent_nbu_type),
          ccd.percent_nbu_info,
          ccd.r_agree_date,
          ccd.r_agree_no,
          ccd.prev_doc_key,
          ccd.prev_reestr_attr,
          ccd.ending_date_indiv,
          ccd.parent_ch_data,
          ccd.ending_date,
          ccd.date_term_change,
          /* ccd.margin, ccd.tranche_no, ccd.tr_summa, ccd.tr_currency, ccd.tr_rate_name, ccd.tr_rate,
          ccd.credit_opertype,(select name from cim_credit_opertype where id=ccd.credit_opertype),ccd.credit_operdate*/
          NVL (
             (SELECT SUM (s_vk)
                FROM v_cim_bound_payments
               WHERE direct = 0 AND pay_flag = 2 AND contr_id = c.contr_id),
             0),
          NVL (
             (SELECT SUM (s_vk)
                FROM v_cim_bound_payments
               WHERE direct = 1 AND pay_flag = 2 AND contr_id = c.contr_id),
             0),
          NVL (
             (SELECT SUM (s_vk)
                FROM v_cim_bound_payments
               WHERE direct = 1 AND pay_flag = 3 AND contr_id = c.contr_id),
             0),
          NULL, --nvl((select rzp from cim_credgraph_tmp where dat=(select min(dat) from cim_credgraph_tmp where dat>=bankdate))/100,0),
          NULL, --nvl((select rzpnbu from cim_credgraph_tmp where dat=(select min(dat) from cim_credgraph_tmp where dat>=bankdate))/100,0),
          NVL (
             (SELECT SUM (s_vk)
                FROM v_cim_bound_payments
               WHERE     direct = 1
                     AND pay_flag > 3
                     AND pay_flag < 7
                     AND contr_id = c.contr_id),
             0),
          f503_reason,
          f503_state,
          f503_note,
          f504_reason,
          f504_note,
          f503_percent_type,
          f503_percent_base,
          f503_percent_margin,
          f503_percent,
          to_number(f503_purpose),
          ccd.f503_percent_base_t,
          ccd.f503_percent_base_val,
          ccd.f503_change_info,
          ccd.f057
     FROM person p, v_cim_all_contracts c, cim_contracts_credit ccd
    WHERE     p.rnk(+) = c.rnk
          AND c.contr_id = ccd.contr_id(+)
          AND c.contr_type = 2;

PROMPT *** Create  grants  V_CIM_CREDIT_CONTRACTS ***
grant SELECT                                                                 on V_CIM_CREDIT_CONTRACTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CREDIT_CONTRACTS.sql =========***
PROMPT ===================================================================================== 
