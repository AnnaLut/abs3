

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_MBDK2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_MBDK2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_MBDK2 ("OPERATION_TYPE_NAME", "DEBIT_ACCOUNT", "CREDIT_ACCOUNT", "DEBIT_MFO", "CREDIT_MFO", "AMOUNT", "CURRENCY_CODE", "PURPOSE", "URL", "URL_STP") AS 
  select "OPERATION_TYPE_NAME","DEBIT_ACCOUNT","CREDIT_ACCOUNT","DEBIT_MFO","CREDIT_MFO","AMOUNT","CURRENCY_CODE","PURPOSE","URL","URL_STP"
from   table(mbk.make_docinput(to_number(pul.get_mas_ini_val('ND'))));

PROMPT *** Create  grants  V_PAY_MBDK2 ***
grant SELECT                                                                 on V_PAY_MBDK2     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_MBDK2.sql =========*** End *** ==
PROMPT ===================================================================================== 
