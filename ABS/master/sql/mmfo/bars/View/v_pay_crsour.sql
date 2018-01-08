

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_CRSOUR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_CRSOUR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_CRSOUR ("OPERATION_TYPE_NAME", "DEBIT_ACCOUNT", "CREDIT_ACCOUNT", "DEBIT_MFO", "CREDIT_MFO", "AMOUNT", "CURRENCY_CODE", "PURPOSE", "URL", "URL_STP") AS 
  select "OPERATION_TYPE_NAME","DEBIT_ACCOUNT","CREDIT_ACCOUNT","DEBIT_MFO","CREDIT_MFO","AMOUNT","CURRENCY_CODE","PURPOSE","URL","URL_STP"
from   table(cdb_mediator.make_docinput(to_number(pul.get_mas_ini_val('ND'))));

PROMPT *** Create  grants  V_PAY_CRSOUR ***
grant SELECT                                                                 on V_PAY_CRSOUR    to BARSREADER_ROLE;
grant SELECT                                                                 on V_PAY_CRSOUR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_CRSOUR    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_CRSOUR.sql =========*** End *** =
PROMPT ===================================================================================== 
