

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINTREQ_ACTIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CHGINTREQ_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CHGINTREQ_ACTIVE ("REQ_ID", "REQ_CRDATE", "REQ_CRUSER", "DPT_ID", "DPT_ND", "DPT_DATE", "CUST_ID", "CUST_FIO", "CUST_IDCODE", "REQC_TYPE", "REQC_TYPENAME", "REQC_EXPDATE", "REQC_OLDINT", "REQC_NEWINT", "REQC_NEWBR", "REQC_BEGDATE", "BRANCH", "BRANCH_NAME") AS 
  select r.req_id, r.req_crdate, s1.fio, r.dpt_id, d.nd, d.datz,
       c.rnk, c.nmk, c.okpo, rc.reqc_type, 
       substr(decode(reqc_type, 1, bars_msg.get_msg('DPT', 'REQ_CHGINT_IND'),
                                2, bars_msg.get_msg('DPT', 'REQ_CHGINT_VID')), 1, 250),
       rc.reqc_expdate, reqc_oldint, reqc_newint, 
       rc.reqc_newbr, rc.reqc_begdate, r.branch, b.name
  from dpt_requests r, dpt_req_types rt, staff$base s1,
       dpt_deposit d, branch b, dpt_req_chgints rc, customer c
 where decode(r.req_state, null, 1, null) = 1
   and r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'AGRMNT_CHGINT'
   and r.req_cruserid  = s1.id
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
   and r.req_id        = rc.req_id
   and d.rnk           = c.rnk
with read only 
 ;

PROMPT *** Create  grants  V_DPT_CHGINTREQ_ACTIVE ***
grant SELECT                                                                 on V_DPT_CHGINTREQ_ACTIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQ_ACTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQ_ACTIVE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_CHGINTREQ_ACTIVE to DPT_ROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQ_ACTIVE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_CHGINTREQ_ACTIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINTREQ_ACTIVE.sql =========***
PROMPT ===================================================================================== 
