

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_DAILY_BALANCES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_DM_DAILY_BALANCES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_DAILY_BALANCES ("REPORT_DATE", "KF", "ACC_ID", "CUST_ID", "VOST", "DOS", "KOS", "OST", "VOSTQ", "DOSQ", "KOSQ", "OSTQ") AS 
  SELECT REPORT_DATE,
       KF,
       ACC_ID,
       CUST_ID,
       VOST,
       DOS,
       KOS,
       OST,
       VOSTQ,
       DOSQ,
       KOSQ,
       OSTQ
  FROM NBUR_DM_BALANCES_DAILY;

PROMPT *** Create  grants  V_NBUR_DM_DAILY_BALANCES ***
grant SELECT                                                                 on V_NBUR_DM_DAILY_BALANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DM_DAILY_BALANCES to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_DAILY_BALANCES.sql =========*
PROMPT ===================================================================================== 
