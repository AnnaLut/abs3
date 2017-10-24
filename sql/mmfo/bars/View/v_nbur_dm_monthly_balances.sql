

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_MONTHLY_BALANCES.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_DM_MONTHLY_BALANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_MONTHLY_BALANCES ("REPORT_DATE", "KF", "ACC_ID", "CUST_ID", "DOS", "KOS", "OST", "DOSQ", "KOSQ", "OSTQ", "CRDOS", "CRKOS", "CRDOSQ", "CRKOSQ", "CUDOS", "CUKOS", "CUDOSQ", "CUKOSQ", "ADJ_BAL", "ADJ_BAL_UAH") AS 
  SELECT REPORT_DATE,
       KF,
       ACC_ID,
       CUST_ID,
       DOS,
       KOS,
       OST,
       DOSQ,
       KOSQ,
       OSTQ,
       CRDOS,
       CRKOS,
       CRDOSQ,
       CRKOSQ,
       CUDOS,
       CUKOS,
       CUDOSQ,
       CUKOSQ,
       ADJ_BAL,
       ADJ_BAL_UAH
  FROM NBUR_DM_BALANCES_MONTHLY;

PROMPT *** Create  grants  V_NBUR_DM_MONTHLY_BALANCES ***
grant SELECT                                                                 on V_NBUR_DM_MONTHLY_BALANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DM_MONTHLY_BALANCES to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_MONTHLY_BALANCES.sql ========
PROMPT ===================================================================================== 
