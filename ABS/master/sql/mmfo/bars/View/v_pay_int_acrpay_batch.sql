

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_INT_ACRPAY_BATCH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_INT_ACRPAY_BATCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_INT_ACRPAY_BATCH ("BATCH_ID", "USER_LOGIN", "CREATE_DATE", "INFO", "FILTER") AS 
  select "BATCH_ID","USER_LOGIN","CREATE_DATE","INFO","FILTER" from pay_int_acrpay_batch order by create_date desc;

PROMPT *** Create  grants  V_PAY_INT_ACRPAY_BATCH ***
grant SELECT                                                                 on V_PAY_INT_ACRPAY_BATCH to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_INT_ACRPAY_BATCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_INT_ACRPAY_BATCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_INT_ACRPAY_BATCH.sql =========***
PROMPT ===================================================================================== 
