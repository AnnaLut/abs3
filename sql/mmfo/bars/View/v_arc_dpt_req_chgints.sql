

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARC_DPT_REQ_CHGINTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARC_DPT_REQ_CHGINTS ("REQ_ID", "REQ_BDATE", "REQC_TYPE", "REQC_OLDINT", "REQC_NEWINT", "REQC_NEWBR", "BRANCH", "DPT_ID", "REQC_BEGDATE", "REQC_EXPDATE") AS 
  select d.req_id, r.req_bdate, d.reqc_type, d.reqc_oldint, 
       d.reqc_newint, d.reqc_newbr, d.branch, r.dpt_id,
       d.reqc_begdate, d.reqc_expdate
  from dpt_req_chgints d, dpt_requests r
 where d.req_id = r.req_id 
 ;

PROMPT *** Create  grants  V_ARC_DPT_REQ_CHGINTS ***
grant SELECT                                                                 on V_ARC_DPT_REQ_CHGINTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_ARC_DPT_REQ_CHGINTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ARC_DPT_REQ_CHGINTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARC_DPT_REQ_CHGINTS.sql =========*** 
PROMPT ===================================================================================== 
