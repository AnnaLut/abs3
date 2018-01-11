

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_DEAL_STS_HISTORY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_DEAL_STS_HISTORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_DEAL_STS_HISTORY ("ID", "DEAL_ID", "STATUS_ID", "STATUS_NAME", "SET_DATE", "COMM", "STAFF_ID", "STAFF_FIO", "STAFF_LOGNAME") AS 
  select dsh.id,
       dsh.deal_id,
       dsh.status_id,
       ds.name       as status_name,
       dsh.set_date,
       dsh.comm,
       dsh.staff_id,
       sb.fio        as staff_fio,
       sb.logname    as staff_logname
  from ins_deal_sts_history dsh, ins_deal_statuses ds, staff$base sb
 where dsh.status_id = ds.id
   and dsh.staff_id = sb.id
 order by dsh.id desc;

PROMPT *** Create  grants  V_INS_DEAL_STS_HISTORY ***
grant SELECT                                                                 on V_INS_DEAL_STS_HISTORY to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_DEAL_STS_HISTORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_DEAL_STS_HISTORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_DEAL_STS_HISTORY.sql =========***
PROMPT ===================================================================================== 
