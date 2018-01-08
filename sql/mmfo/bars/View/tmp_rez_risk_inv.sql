

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_REZ_RISK_INV.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_REZ_RISK_INV ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_REZ_RISK_INV ("DAT") AS 
  select distinct fdat from fdat where fdat>add_months(bankdate,-1);

PROMPT *** Create  grants  TMP_REZ_RISK_INV ***
grant SELECT                                                                 on TMP_REZ_RISK_INV to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK_INV to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_REZ_RISK_INV.sql =========*** End *
PROMPT ===================================================================================== 
