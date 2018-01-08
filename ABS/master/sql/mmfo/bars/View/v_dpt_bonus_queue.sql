

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_BONUS_QUEUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_BONUS_QUEUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_BONUS_QUEUE ("REQ_ID", "DPT_ID", "BRANCH", "REQ_BDATE", "REQ_CRDATE", "REQ_CRUSERID") AS 
  SELECT q.req_id, q.dpt_id, q.branch, q.req_bdate, q.req_crdate, q.req_cruserid
  FROM dpt_requests q, dpt_req_types qt
 WHERE decode(q.req_state, null, 1, null) = 1
   AND q.reqtype_id = qt.reqtype_id
   AND qt.reqtype_code = 'BONUS'
 ;

PROMPT *** Create  grants  V_DPT_BONUS_QUEUE ***
grant SELECT                                                                 on V_DPT_BONUS_QUEUE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_BONUS_QUEUE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_BONUS_QUEUE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_BONUS_QUEUE.sql =========*** End 
PROMPT ===================================================================================== 
