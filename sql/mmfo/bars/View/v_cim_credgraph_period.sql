

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_CREDGRAPH_PERIOD.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_CREDGRAPH_PERIOD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_CREDGRAPH_PERIOD ("CONTR_ID", "ROW_ID", "END_DATE", "CR_METHOD_ID", "CR_METHOD", "PAYMENT_PERIOD_ID", "PAYMENT_PERIOD", "PAYMENT_DELAY", "Z", "ADAPTIVE_ID", "ADAPTIVE", "PERCENT", "PERCENT_NBU", "PERCENT_BASE_ID", "PERCENT_BASE", "PERCENT_PERIOD_ID", "PERCENT_PERIOD", "PERCENT_DELAY", "GET_DAY_ID", "GET_DAY", "PAY_DAY_ID", "PAY_DAY", "PAYMENT_DAY", "PERCENT_DAY") AS 
  SELECT p.contr_id, rowidtochar(rowid) as row_id, p.end_date, p.cr_method, (select name from cim_credit_method where id=p.cr_method),
          p.payment_period, (select name from cim_credit_period where id=p.payment_period), p.payment_delay, round(p.z/100,2),
          p.adaptive, (select name from cim_credit_adaptive where id=p.adaptive),
          p.percent, p.percent_nbu,
          p.percent_base, (select name from cim_credit_base where id=p.percent_base),
          p.percent_period, (select name from cim_credit_period where id=p.percent_period), p.percent_delay,
          p.get_day, (select name from cim_consider where id=p.get_day),
          p.pay_day, (select name from cim_consider where id=p.pay_day), payment_day, percent_day
          --p.holiday, (select name from cim_consider where id=p.holiday)
     from cim_credgraph_period p
     order by p.end_date;

PROMPT *** Create  grants  V_CIM_CREDGRAPH_PERIOD ***
grant SELECT                                                                 on V_CIM_CREDGRAPH_PERIOD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_CREDGRAPH_PERIOD.sql =========***
PROMPT ===================================================================================== 
