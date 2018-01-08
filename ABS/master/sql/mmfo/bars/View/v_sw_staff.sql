

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_STAFF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_STAFF ("ID", "FIO", "IO") AS 
  select s.id, s.fio, l.io io
  from staff s, sw_staff_list l
 where s.id = l.id
union all
select null id, 'Нераспределенные' fio, null io
  from dual
with read only
 ;

PROMPT *** Create  grants  V_SW_STAFF ***
grant SELECT                                                                 on V_SW_STAFF      to BARS013;
grant SELECT                                                                 on V_SW_STAFF      to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_STAFF      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_STAFF.sql =========*** End *** ===
PROMPT ===================================================================================== 
