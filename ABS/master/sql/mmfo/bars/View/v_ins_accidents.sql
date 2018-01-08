

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_ACCIDENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_ACCIDENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_ACCIDENTS ("ID", "DEAL_ID", "BRANCH", "BRANCH_NAME", "STAFF_ID", "STAFF_FIO", "STAFF_LOGNAME", "CRT_DATE", "ACDT_DATE", "COMM", "REFUND_SUM", "REFUND_DATE") AS 
  select a.id,
       a.deal_id,
       a.branch,
       b.name        as branch_name,
       a.staff_id,
       s.fio         as staff_fio,
       s.logname     as staff_logname,
       a.crt_date,
       a.acdt_date,
       a.comm,
       a.refund_sum,
       a.refund_date
  from ins_accidents a, branch b, staff$base s
 where a.branch = b.branch
   and a.staff_id = s.id
 order by a.deal_id, a.acdt_date;

PROMPT *** Create  grants  V_INS_ACCIDENTS ***
grant SELECT                                                                 on V_INS_ACCIDENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_ACCIDENTS.sql =========*** End **
PROMPT ===================================================================================== 
