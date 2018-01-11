

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_IN_BONUS_QUEUE_DETAILS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_IN_BONUS_QUEUE_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_IN_BONUS_QUEUE_DETAILS ("DPT_ID", "BONUS_ID", "BONUS_NAME", "BONUSVAL_PLAN", "BONUSVAL_FACT", "REQ_STATEID", "REQ_STATENAME", "REQ_AUTO", "REQ_CONFIRM", "REQ_RECALC", "REQ_DATE", "REQ_USERID", "REQ_USERNAME") AS 
  SELECT r.dpt_id, r.bonus_id, b.bonus_name,  r.bonus_value_plan, r.bonus_value_fact,
       r.request_state, s.state_name, r.request_auto, r.request_confirm, r.request_recalc,
       r.request_date, r.request_user, f.fio
  FROM dpt_bonus_requests r, v_dpt_in_bonus_queue q, dpt_bonuses b, dpt_bonus_request_states s, staff$base f
 WHERE r.dpt_id = q.dpt_id
   AND b.bonus_id = r.bonus_id
   AND s.state_code = r.request_state
   AND r.request_user = f.id
   AND r.request_deleted = 'N'
 UNION ALL
SELECT q.dpt_id, 0, 'базова ставка', q.dpt_rate, q.dpt_rate,
       'ALLOW', null, 'Y', 'N', 'N', q.dpt_dat, null, null
  FROM v_dpt_in_bonus_queue q
ORDER BY 1, 2
 ;

PROMPT *** Create  grants  V_DPT_IN_BONUS_QUEUE_DETAILS ***
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE_DETAILS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE_DETAILS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_IN_BONUS_QUEUE_DETAILS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_IN_BONUS_QUEUE_DETAILS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_IN_BONUS_QUEUE_DETAILS.sql ======
PROMPT ===================================================================================== 
