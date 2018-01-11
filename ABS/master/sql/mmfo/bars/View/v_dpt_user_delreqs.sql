

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_USER_DELREQS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_USER_DELREQS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_USER_DELREQS ("REQ_ID", "DPT_ID", "DPT_ND", "DPT_DATE", "USER_FIO") AS 
  select /*+ ORDERED*/
       r.req_id, r.dpt_id, d.nd, d.datz, s.fio
  from dpt_requests r, dpt_req_types rt, dpt_req_deldeals rd,
       dpt_deposit d, staff$base s,
       (select user_id from dual) s2
 where decode(r.req_state, null, 1, null) = 1
   and r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'DELETE_DEAL'
   and r.req_id        = rd.req_id
   and rd.user_id      = s2.user_id
   and r.dpt_id        = d.deposit_id
   and r.req_cruserid  = s.id
   and rd.user_state is null
with read only
 ;

PROMPT *** Create  grants  V_DPT_USER_DELREQS ***
grant SELECT                                                                 on V_DPT_USER_DELREQS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_USER_DELREQS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_USER_DELREQS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_USER_DELREQS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_USER_DELREQS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_USER_DELREQS.sql =========*** End
PROMPT ===================================================================================== 
