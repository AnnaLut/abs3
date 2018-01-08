

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_LOAN_SCHEDULE_PLAN.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_LOAN_SCHEDULE_PLAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_LOAN_SCHEDULE_PLAN ("LOAN_ID", "PLAN_DATE", "PAYMENT", "PAYMENT_BODY", "PAYMENT_PERCENT", "REST", "COMMISSION") AS 
  SELECT
		CC.ND as LOAN_ID
		,CC.FDAT AS PLAN_DATE
		,CC.SUMO AS PAYMENT
		,CC.SUMG AS PAYMENT_BODY
		,CC.SUMO - CC.SUMG AS PAYMENT_PERCENT
		,CC.LIM2 AS REST
		,CC.SUMK AS COMMISSION
   FROM CC_LIM CC ORDER BY CC.FDAT ASC;

PROMPT *** Create  grants  V_MBM_LOAN_SCHEDULE_PLAN ***
grant SELECT                                                                 on V_MBM_LOAN_SCHEDULE_PLAN to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_LOAN_SCHEDULE_PLAN.sql =========*
PROMPT ===================================================================================== 
