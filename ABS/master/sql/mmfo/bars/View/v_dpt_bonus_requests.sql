

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_BONUS_REQUESTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_BONUS_REQUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_BONUS_REQUESTS ("DPT_ID", "DPT_NUM", "DPT_DAT", "BONUS_ID", "BONUS_NAME", "BONUS_VALUE_PLAN", "BONUS_VALUE_FACT", "REQ_AUTO", "REQ_CONFIRM", "REQ_RECALC", "REQ_DELETED", "REC_STATEID", "REC_STATENAME", "REQ_DATE", "REQ_USERID", "REC_USERNAME", "PRC_DATE", "PRC_USERID", "PRC_USERNAME", "BRANCH") AS 
  SELECT r.dpt_id, d.nd, d.datz,
       r.bonus_id, b.bonus_name, r.bonus_value_plan, r.bonus_value_fact,
       r.request_auto, r.request_confirm, r.request_recalc, r.request_deleted,
       r.request_state, rs.state_name,
       r.request_date, r.request_user, s1.fio,
       r.process_date, r.process_user, s2.fio, d.branch
  FROM dpt_bonus_requests r, dpt_deposit d, dpt_bonuses b,
       staff$base s1, staff$base s2, dpt_bonus_request_states rs
 WHERE r.bonus_id = b.bonus_id
   AND r.dpt_id = d.deposit_id
   AND r.request_state = rs.state_code
   AND r.request_user = s1.id
   AND r.process_user = s2.id(+)
 ;

PROMPT *** Create  grants  V_DPT_BONUS_REQUESTS ***
grant SELECT                                                                 on V_DPT_BONUS_REQUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_BONUS_REQUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_BONUS_REQUESTS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_BONUS_REQUESTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_BONUS_REQUESTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_BONUS_REQUESTS.sql =========*** E
PROMPT ===================================================================================== 
