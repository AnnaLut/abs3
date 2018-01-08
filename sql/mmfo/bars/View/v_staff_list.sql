

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_LIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_LIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_LIST ("DEPT_ID", "DEPT_NAME", "UPR_ID", "UPR_NAME", "OTD_ID", "OTD_NAME", "SECT_ID", "SECT_NAME", "USERID", "FIO") AS 
  select b2.idlh, b3.namel,
       b2.idlm, b4.namel,
       b2.idls_d, b5.namel,
       b2.idls_s, b6.namel,
       b1.idu, s.fio
  from b_schedule_subdiv_user b1,
       b_schedule_subdivision b2,
       b_schedule_levhigh     b3,
       b_schedule_levmdl      b4,
       b_schedule_levsml_d    b5,
       b_schedule_levsml_s    b6,
       staff$base s
 where b1.idu  = s.id
   and b1.idd  = b2.idd(+)
   and b2.idlh = b3.idl(+)
   and b2.idlm = b4.idl(+) 
   and b2.idls_d = b5.idl(+)
   and b2.idls_s = b6.idl(+)
order by 1,3,5,7,9;

PROMPT *** Create  grants  V_STAFF_LIST ***
grant SELECT                                                                 on V_STAFF_LIST    to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_LIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_LIST.sql =========*** End *** =
PROMPT ===================================================================================== 
