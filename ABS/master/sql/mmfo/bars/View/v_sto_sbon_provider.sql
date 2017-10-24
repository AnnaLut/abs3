

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_SBON_PROVIDER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_SBON_PROVIDER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_SBON_PROVIDER ("ID", "SBON_CONTRACT_NUMBER", "WORK_MODE_ID", "WORK_MODE", "RECEIVER_MFO", "RECEIVER_ACCOUNT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "PAYMENT_NAME", "TRANSIT_ACCOUNT", "STATE", "UPDATE_DATE", "EXTRA_ATTRIBUTES_METADATA") AS 
  select p.id,
       t.contract_number sbon_contract_number,
       p.order_type_id - 1 work_mode_id,
          (SELECT s.type_name
             FROM sto_type s
            WHERE s.id = p.order_type_id)
             work_mode,
       t.receiver_mfo,
       t.receiver_account,
          t.receiver_edrpou||'/'||t.receiver_name  ||'('|| t.contract_id|| ') '||t.payment_name receiver_name,
       t.receiver_edrpou,
       t.payment_name,
       t.transit_account,
          CASE
             WHEN p.state = 0 THEN 'Активний'
             WHEN p.state = 1 THEN 'Блокований'
             WHEN p.state = 2 THEN 'Закритий'
             ELSE NULL
          END
             state,
          CAST (NULL AS DATE) update_date,
          (SELECT e.extra_attributes_metadata
             FROM sto_prod_extra_attributes e
            WHERE e.product_id = p.id)
             extra_attributes_metadata
     FROM sto_product p JOIN sto_sbon_product t ON t.id = p.id
     order by 7;

PROMPT *** Create  grants  V_STO_SBON_PROVIDER ***
grant SELECT                                                                 on V_STO_SBON_PROVIDER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_SBON_PROVIDER.sql =========*** En
PROMPT ===================================================================================== 
