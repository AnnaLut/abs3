

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_BANK_VIPISKA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_BANK_VIPISKA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_BANK_VIPISKA ("VALUE_DATE", "VALUE_DATE_TXT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "PAYER_MFO", "BANK_NAME", "PAYER_ACCOUNT", "PAYMENT_AMOUNT", "FEE_AMOUNT", "SUMA", "RAZOM_DO_SPLATI", "SUMA_DO_SPLATI", "DEBT_AMOUNT", "PAYED_DATE", "PRODUCT_NAME", "PAYER_ADDR_FACT", "PAYER_REGION_FACT", "PAYER_TEL", "CUSTOMER_ACCOUNT", "PAYMENT_ID", "ORDER_ID", "RNK", "TRANS_ACC_2924", "AMOUNT", "ALL_AMOUNT") AS 
  SELECT                  /*ƒл€ отчета Ѕанк. выписка по регул€рным платежам*/
         TRUNC (sp.value_date) AS value_date,
             '«а '
          || TO_CHAR (sp.value_date,
                      'month',
                      'nls_date_language = UKRAINIAN')
          || ' м≥с€ць '
          || TO_CHAR (sp.value_date, 'yyyy')
             AS value_date_txt,
          sp.receiver_name,
          sp.receiver_edrpou,
          sp.receiver_mfo,
          sp.receiver_account,
          sp.payer_mfo,
          (SELECT nb
             FROM banks$base
            WHERE mfo = sp.payer_mfo)
             AS bank_name,
          sp.payer_account,
          sp.payment_amount,
          sp.fee_amount,
             TO_CHAR (NVL (sp.payment_amount, 0), 'FM9999999990.00')
          || ' '
          || val.LCV
             AS suma,
             TO_CHAR (NVL (sp.payment_amount, 0), 'FM9999999990.00')
          || ' '
          || val.LCV
             AS razom_do_splati,
             TO_CHAR (NVL (sp.payment_amount, 0), 'FM9999999990.00')
          || ' '
          || val.LCV
             AS suma_do_splati,
             TO_CHAR (
                GREATEST (
                   (NVL (sp.debt_amount, 0) - NVL (sp.payment_amount, 0)),
                   0),
                'FM9999999990.00')
          || ' '
          || val.LCV
             AS debt_amount,
          (SELECT TO_CHAR (MAX (sys_time), 'dd/mm/yyyy hh24:mi:ss')
             FROM sto_payment_tracking
            WHERE payment_id = sp.payment_id AND state = 5)
             AS payed_date,
          sp.product_name,
          (SELECT address
             FROM customer_address
            WHERE rnk = sp.rnk AND type_id = 2)
             payer_addr_fact,
          INITCAP (
             (SELECT t.region
                FROM territory t, customer_address ca
               WHERE     ca.rnk = sp.rnk
                     AND ca.type_id = 2
                     AND t.id = ca.territory_id))
             AS payer_region_fact,
          (SELECT NVL (teld, telw)
             FROM person
            WHERE rnk = sp.rnk)
             AS payer_tel,
          sp.customer_account,
          sp.payment_id,
          sp.order_id,
          sp.rnk,
          (SELECT nls
             FROM opl
            WHERE     REF = (SELECT MAX (document_id)
                               FROM sto_payment_document_link
                              WHERE payment_id = sp.payment_id)
                  AND dk = 1
                  AND SUBSTR (nls, 1, 4) = '2924')
             AS trans_acc_2924,
          payment_amount AS amount,
          payment_amount AS all_amount
     FROM v_sto_payments sp, tabval$global val
    WHERE val.kv = sp.payment_currency           --AND sp.payment_state_id = 5;

PROMPT *** Create  grants  V_STO_BANK_VIPISKA ***
grant SELECT                                                                 on V_STO_BANK_VIPISKA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_BANK_VIPISKA.sql =========*** End
PROMPT ===================================================================================== 
