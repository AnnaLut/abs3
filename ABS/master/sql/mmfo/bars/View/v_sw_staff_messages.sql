

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_STAFF_MESSAGES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_STAFF_MESSAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_STAFF_MESSAGES ("ID", "LOGNAME", "FIO", "CNT") AS 
  select w.id, s.logname, decode(w.id, null, 'Нераспределенные', s.fio) fio, count(*) cnt
  from sw_journal w, staff s
 where w.id = s.id(+)
   and w.swref not in (select swref from sw_oper)
   and w.mt    not in (select mt    from sw_stmt)
   and substr(to_char(w.mt), 1, 1) not in ('3')
   and w.date_pay is null
group by w.id, s.logname, s.fio;

PROMPT *** Create  grants  V_SW_STAFF_MESSAGES ***
grant SELECT                                                                 on V_SW_STAFF_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_STAFF_MESSAGES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_STAFF_MESSAGES.sql =========*** En
PROMPT ===================================================================================== 
