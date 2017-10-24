

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_DELREQ_DETAILS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_DELREQ_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_DELREQ_DETAILS ("REQ_ID", "USER_ID", "USER_FIO", "USER_DATE", "USER_STATE") AS 
  select d.req_id, d.user_id, s.fio, d.user_date,
       decode(d.user_state, null, bars_msg.get_msg('DPT', 'REQUSER_WAITING'),
                               1, bars_msg.get_msg('DPT', 'REQUSER_APPROVED'),
                              -1, bars_msg.get_msg('DPT', 'REQUSER_REFUSED'))
  from dpt_req_deldeals d, staff$base s
 where d.user_id = s.id
 ;

PROMPT *** Create  grants  V_DPT_DELREQ_DETAILS ***
grant SELECT                                                                 on V_DPT_DELREQ_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_DELREQ_DETAILS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_DELREQ_DETAILS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_DELREQ_DETAILS.sql =========*** E
PROMPT ===================================================================================== 
