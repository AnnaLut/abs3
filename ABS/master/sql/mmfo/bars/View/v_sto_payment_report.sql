

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_PAYMENT_REPORT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_PAYMENT_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_PAYMENT_REPORT ("ORDER_NUM", "VALUE_DATE", "PAYER_ACCOUNT", "PAYER_IPN", "PAYMENT_AMOUNT", "FEE_AMOUNT", "PAYMENT_CURRENCY", "PAYER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_MFO", "RECEIVER_NAME", "RECEIVER_EDRPOU", "PURPOSE", "EXTRA_PAYMENT_INFO", "ORDER_USER_ID", "ORDER_BRANCH", "ORDER_DATE_TIME", "WITHDRAWAL_DATE_TIME", "PAYMENT_STATE", "SBON_PROVIDER_ID") AS 
  SELECT /*View for report 'Реєстр здійснених платежів',date created = 09.04.2015 */
         ROW_NUMBER () OVER (ORDER BY ROWNUM) order_num,
          p.value_date,
          a.nls payer_account,                          -- Рахунок відправника
          c.okpo payer_ipn,                -- Ідентифікаційний код відправника
          p.payment_amount,                                   -- Сума переказу
          p.fee_amount,                                  -- Комісія за переказ
          a.kv payment_currency,                            -- Валюта переказу
          a.kf payer_mfo,                             -- МФО банка відправника
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_account
             WHEN o.order_type_id = 2 THEN sbonf.receiver_account
             WHEN o.order_type_id = 3 THEN sp.receiver_account
             WHEN o.order_type_id = 4 THEN sp.receiver_account
             ELSE NULL
          END
             receiver_account,                           -- Рахунок отримувача
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_mfo
             WHEN o.order_type_id = 2 THEN sbonf.receiver_mfo
             WHEN o.order_type_id = 3 THEN sp.receiver_mfo
             WHEN o.order_type_id = 4 THEN sp.receiver_mfo
             ELSE NULL
          END
             receiver_mfo,                             -- МФО банку отримувача
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_name
             WHEN o.order_type_id = 2 THEN sbonf.receiver_name
             WHEN o.order_type_id = 3 THEN sp.receiver_name
             WHEN o.order_type_id = 4 THEN sp.receiver_name
             ELSE NULL
          END
             receiver_name,                                       -- отримувач
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_edrpou
             WHEN o.order_type_id = 2 THEN sbonf.receiver_edrpou
             WHEN o.order_type_id = 3 THEN sp.receiver_edrpou
             WHEN o.order_type_id = 4 THEN sp.receiver_edrpou
             ELSE NULL
          END
             receiver_edrpou,               -- Ідентифікаційний код отримувача
          CASE
             WHEN p.purpose IS NULL
             THEN
                CASE
                   WHEN o.order_type_id = 1 THEN sep.purpose
                   WHEN o.order_type_id = 2 THEN sbonf.purpose
                   WHEN o.order_type_id = 3 THEN sp.payment_name
                   WHEN o.order_type_id = 4 THEN sp.payment_name
                END
             ELSE
                p.purpose
          END
             purpose,                                   -- Призначення платежу
          sto_sbon_utl.parse_order_extra_attributes (o.id) extra_payment_info, -- Додаткові реквізити
          (SELECT u.fio
             FROM staff$base u
            WHERE u.id = o.user_id)
             order_user_id,         -- Код операціоніста, що створив форму 190
          (SELECT bp.branch
             FROM branch_parameters bp
            WHERE bp.branch = o.branch AND bp.tag = 'NAME_BRANCH')
             order_branch,                         -- ТВБВ створення форми 190
          TO_CHAR (o.registration_date, 'dd.mm.yyyy hh24:mi:ss')
             order_date_time,                  -- Дата/час створення форми 190
          TO_CHAR (CASE
                      WHEN (p.state = 4)
                      THEN
                         (SELECT MAX (v.dat)
                            FROM bars.oper_visa v
                           WHERE v.REF = (SELECT MAX (dl.document_id)
                                            FROM sto_payment_document_link dl
                                           WHERE dl.payment_id = p.id))
                      ELSE
                         NULL
                   END,
                   'dd.mm.yyyy hh24:mi:ss')
             withdrawal_date_time, -- Дата/час обробки платіжного доручення на ПЦ(списання коштів з картрахунку)
          sto_payment_utl.get_payment_state_name (p.state) payment_state, -- Статус (списано/не списано)
          sp.id sbon_provider_id
     FROM bars.sto_payment p
          JOIN bars.sto_order o ON o.id = p.order_id
          JOIN bars.accounts a ON a.acc = o.payer_account_id
          JOIN bars.customer c ON c.rnk = a.rnk
          LEFT JOIN bars.sto_product prod ON prod.id = o.product_id
          LEFT JOIN bars.sto_sbon_product sp ON sp.id = prod.id
          LEFT JOIN bars.sto_sep_order sep ON sep.id = o.id
          LEFT JOIN bars.sto_sbon_order_free sbonf ON sbonf.id = o.id
          LEFT JOIN bars.sto_sbon_order_contr sbonc ON sbonc.id = o.id
          LEFT JOIN bars.sto_sbon_order_no_contr sbonnc ON sbonnc.id = o.id;

PROMPT *** Create  grants  V_STO_PAYMENT_REPORT ***
grant SELECT                                                                 on V_STO_PAYMENT_REPORT to BARSREADER_ROLE;
grant SELECT                                                                 on V_STO_PAYMENT_REPORT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_PAYMENT_REPORT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_PAYMENT_REPORT.sql =========*** E
PROMPT ===================================================================================== 
