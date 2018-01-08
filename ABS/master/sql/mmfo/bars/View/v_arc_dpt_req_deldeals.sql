

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARC_DPT_REQ_DELDEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARC_DPT_REQ_DELDEALS ("REQ_ID", "REQ_BDATE", "USER_ID", "USER_BDATE", "USER_DATE", "USER_STATE", "DPT_ID", "BRANCH") AS 
  select d.req_id, r.req_bdate, d.user_id, d.user_bdate,
       d.user_date, d.user_state, r.dpt_id, d.branch
  from dpt_req_deldeals d, dpt_requests r
 where d.req_id = r.req_id 
 ;

PROMPT *** Create  grants  V_ARC_DPT_REQ_DELDEALS ***
grant SELECT                                                                 on V_ARC_DPT_REQ_DELDEALS to BARSREADER_ROLE;
grant SELECT                                                                 on V_ARC_DPT_REQ_DELDEALS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ARC_DPT_REQ_DELDEALS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_REQ_DELDEALS.sql =========***
PROMPT ===================================================================================== 
