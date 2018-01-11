

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGISTER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REGISTER ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REGISTER ("CUSTOMER_ID", "CUSTOMER_NAME", "CUSTOMER_OKPO", "CUSTOMER_REGION", "CUSTOMER_FULL_ADDRESS", "CUSTOMER_TYPE", "SUBS_NUMB", "SUBS_DATE", "SUBS_DOC_TYPE", "DEAL_NUMBER", "DEAL_DATE_FROM", "DEAL_DATE_TO", "DEAL_TERM", "DEAL_PRODUCT", "DEAL_STATE", "DEAL_TYPE_CODE", "DEAL_TYPE_NAME", "DEAL_SUM", "CREDIT_STATUS_ID", "CREDIT_STATUS_NAME", "CREDIT_STATUS_CODE", "CREDIT_COMMENT", "STATE_FOR_UI", "GOOD_COST", "NLS", "ACC", "DOC_DATE", "MONEY_DATE", "COMP_SUM", "VALID_STATUS", "BRANCH_CODE", "BRANCH_NAME", "MFO", "USER_ID", "USER_NAME", "REG_TYPE_ID", "REG_KIND_ID", "REG_ID", "CREATE_DATE", "DATE_FROM", "DATE_TO", "CREDIT_COUNT", "REG_KIND_CODE", "REG_TYPE_CODE", "REG_KIND_NAME", "REG_TYPE_NAME", "DEAL_ID", "DEAL_REGION", "DEAL_ADR_ID", "DEAL_FULL_ADDRESS", "DEAL_BUILD_TYPE", "REG_EVENTS") AS 
  WITH reg_body
           AS (  SELECT t.deal_id,
                        t.deal_region,
                        t.deal_adr_id,
                        t.deal_full_address,
                        t.deal_build_type,
                        listagg (
                           t.rn || '.' || t.deal_event || CHR (13) || CHR (10))
                        WITHIN GROUP (ORDER BY t.deal_id, t.deal_adr_id,t.rn)
                           reg_events
                   FROM (  SELECT t2.deal_adr_id,
                                  t2.deal_id,
                                  t2.deal_region,
                                  t2.deal_full_address,
                                  t2.deal_build_type,
                                  t2.deal_event,
                                  ROW_NUMBER ()
                                  OVER (PARTITION BY t2.deal_id, t2.deal_adr_id
                                        ORDER BY t2.deal_adr_id)
                                     rn
                             FROM (SELECT DISTINCT t1.deal_adr_id,
                                                   t1.deal_id,
                                                   t1.deal_region,
                                                   t1.deal_full_address,
                                                   t1.deal_build_type,
                                                   t1.deal_event
                                     FROM vw_escr_reg_body t1) t2
                         ORDER BY t2.deal_id, t2.deal_adr_id) t
               GROUP BY t.deal_id,
                        t.deal_region,
                        t.deal_adr_id,
                        t.deal_full_address,
                        t.deal_build_type
               ORDER BY t.deal_id, t.deal_adr_id)
   SELECT t.customer_id,
          t.customer_name,
          t.customer_okpo,
          t.customer_region,
          t.customer_full_address,
          t.customer_type,
          t.subs_numb,
          t.subs_date,
          t.subs_doc_type,
          t.deal_number,
          t.deal_date_from,
          t.deal_date_to,
          t.deal_term,
          t.deal_product,
          t.deal_state,
          t.deal_type_code,
          t.deal_type_name,
          t.deal_sum,
          t.credit_status_id,
          t.credit_status_name,
          t.credit_status_code,
          t.credit_comment,
          t.state_for_ui,
          t.good_cost,
          t.nls,
          t.acc,
          t.doc_date,
          t.money_date,
          t.comp_sum,
          t.valid_status,
          t.branch_code,
          t.branch_name,
          t.mfo,
          t.user_id,
          t.user_name,
          t.reg_type_id,
          t.reg_kind_id,
          t.reg_id,
          t.create_date,
          t.date_from,
          t.date_to,
          t.credit_count,
          t.reg_kind_code,
          t.reg_type_code,
          t.reg_kind_name,
          t.reg_type_name,
          t1.DEAL_ID,
          t1.DEAL_REGION,
          t1.DEAL_ADR_ID,
          t1.DEAL_FULL_ADDRESS,
          t1.DEAL_build_TYPE,
          t1.REG_EVENTS
     FROM vw_escr_reg_header t JOIN reg_body t1 ON t.DEAL_ID = t1.DEAL_ID
     --and t.branch_code LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
;

PROMPT *** Create  grants  VW_ESCR_REGISTER ***
grant SELECT                                                                 on VW_ESCR_REGISTER to BARSREADER_ROLE;
grant SELECT                                                                 on VW_ESCR_REGISTER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REGISTER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REGISTER.sql =========*** End *
PROMPT ===================================================================================== 
