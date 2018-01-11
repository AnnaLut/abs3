

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_PFILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_PFILES ("FILE_NAME", "FILE_DATE", "N", "S") AS 
  select f_n, f_d, count(*) n, sum(s) s
  from ( select q.f_n, q.f_d, o.s
           from pkk_history q, oper o
          where q.ref = o.ref
            and o.branch like sys_context ('bars_context', 'user_branch_mask')
            and q.f_n is not null
         union all
         select q.f_n, q.f_d, o.s
           from pkk_history_arc q, oper o
          where q.ref = o.ref
            and o.branch like sys_context ('bars_context', 'user_branch_mask')
            and q.f_n is not null
         union all
         select q.f_n, q.f_d, o.s
           from pkk_que q, oper o
          where q.sos = 1
            and q.ref = o.ref
            and o.branch like sys_context ('bars_context', 'user_branch_mask')
         union all
         select q.f_n, q.f_d, o.s
           from pkk_inf_history q, arc_rrp o
          where q.rec = o.rec
            and '/' || o.kf || '/' like sys_context ('bars_context', 'user_branch_mask')
            and q.f_n is not null
         union all
         select q.f_n, q.f_d, o.s
           from pkk_inf_arc q, arc_rrp o
          where q.rec = o.rec
            and '/' || o.kf || '/' like sys_context ('bars_context', 'user_branch_mask')
            and q.f_n is not null )
 group by f_n, f_d ;

PROMPT *** Create  grants  V_OBPC_PFILES ***
grant SELECT                                                                 on V_OBPC_PFILES   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_PFILES   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_PFILES   to OBPC;
grant SELECT                                                                 on V_OBPC_PFILES   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_PFILES   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_OBPC_PFILES   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_PFILES.sql =========*** End *** 
PROMPT ===================================================================================== 
