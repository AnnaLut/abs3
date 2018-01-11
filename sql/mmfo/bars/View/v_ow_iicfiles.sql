

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES ("FILE_NAME", "FILE_DATE", "FILE_N", "FILE_S", "FILE_R", "TICK_NAME", "TICK_DATE", "TICK_STATUS", "TICK_ACCEPT_REC", "TICK_REJECT_REC") AS 
  select f.file_name, f.file_date, f.file_n, f.file_s, f.file_n - nvl(r.c,0) file_rr,
       f.tick_name, f.tick_date, f.tick_status, f.tick_accept_rec, f.tick_reject_rec
  from ow_iicfiles f,
       ( select f_n, sum(c) c
           from ( select f_n, count(*) c from ow_pkk_que group by f_n
                   union all
                  select f_n, count(*) c from ow_pkk_history group by f_n
                   union all
                  select f_n, count(*) c from ow_acc_que group by f_n
                   union all
                  select f_n, count(*) c from ow_acc_history group by f_n )
          group by f_n ) r
 where f.file_name = r.f_n(+);

PROMPT *** Create  grants  V_OW_IICFILES ***
grant SELECT                                                                 on V_OW_IICFILES   to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_IICFILES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES   to OW;
grant SELECT                                                                 on V_OW_IICFILES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES.sql =========*** End *** 
PROMPT ===================================================================================== 
