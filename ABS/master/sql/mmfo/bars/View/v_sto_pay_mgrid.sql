

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STO_PAY_MGRID.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STO_PAY_MGRID ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STO_PAY_MGRID ("ORDER_ID", "PRODUCT_ID", "RECEIVER_EDRPOU", "RECEIVER_NAME", "PRODUCT_NAME") AS 
  select  distinct order_id, product_id, receiver_edrpou, receiver_name, product_name
from v_sto_payments;

PROMPT *** Create  grants  V_STO_PAY_MGRID ***
grant SELECT                                                                 on V_STO_PAY_MGRID to BARSREADER_ROLE;
grant SELECT                                                                 on V_STO_PAY_MGRID to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STO_PAY_MGRID to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STO_PAY_MGRID.sql =========*** End **
PROMPT ===================================================================================== 
