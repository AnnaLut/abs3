

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_PAYMENTS_SCHEDULE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_PAYMENTS_SCHEDULE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_PAYMENTS_SCHEDULE ("ID", "DEAL_ID", "PLAN_DATE", "PREV_PDATE", "NEXT_PDATE", "FACT_DATE", "PLAN_SUM", "FACT_SUM", "PMT_NUM", "PMT_COMM", "PAYED") AS 
  select ps.id,
       ps.deal_id,
       ps.plan_date,
       lag(ps.plan_date, 1, d.sdate) over (order by ps.deal_id, ps.plan_date) as prev_pdate,
       lead(ps.plan_date, 1, d.edate) over (order by ps.deal_id, ps.plan_date) as next_pdate,
       ps.fact_date,
       ps.plan_sum,
       ps.fact_sum,
       ps.pmt_num,
       ps.pmt_comm,
       ps.payed
  from ins_payments_schedule ps, ins_deals d
  where ps.deal_id = d.id
 order by ps.deal_id, ps.plan_date;

PROMPT *** Create  grants  V_INS_PAYMENTS_SCHEDULE ***
grant SELECT                                                                 on V_INS_PAYMENTS_SCHEDULE to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_PAYMENTS_SCHEDULE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_PAYMENTS_SCHEDULE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_PAYMENTS_SCHEDULE.sql =========**
PROMPT ===================================================================================== 
