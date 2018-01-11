

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCP_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCP_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCP_ACCOUNTS ("NAME", "DDOG", "NDOG", "OKPO", "MFO", "NLS", "SCOPE_DOG", "ORDER_FEE", "AMOUNT_FEE", "FEE_TYPE_ID", "FEE_BY_TARIF", "FEE_MFO", "FEE_NLS", "FEE_OKPO", "CHECK_ON") AS 
  SELECT o.name,
          o.ddog,
          o.ndog,
          o.okpo,
          a.mfo,
          a.nls,
          (select text from ACCP_SCOPE where id = o.scope_dog) scope_dog,
          (select text from ACCP_ORDER_FEE where id =o.order_fee) order_fee,
          o.amount_fee,
          o.fee_type_id,
          o.fee_by_tarif,
          o.fee_mfo,
          o.fee_nls,
          o.fee_okpo,
          a.check_on
     FROM accp_orgs o, accp_accounts a
    WHERE o.okpo = a.okpo(+);

PROMPT *** Create  grants  V_ACCP_ACCOUNTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ACCP_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCP_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCP_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
