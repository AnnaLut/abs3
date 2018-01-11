

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_COMMISREQ_ACTIVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_COMMISREQ_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_COMMISREQ_ACTIVE ("REQ_ID", "REQ_CRDATE", "REQ_CRUSER", "DPT_ID", "DPT_ND", "DPT_DATE", "AGRMNT_TYPE", "AGRMNT_TYPENAME", "CUST_ID", "CUST_FIO", "CUST_IDCODE", "BRANCH", "BRANCH_NAME") AS 
  select r.req_id, r.req_crdate, s1.fio,
       r.dpt_id, d.nd, d.datz,
       (select to_number(w.value)
          from dpt_depositw w
         where w.dpt_id = r.dpt_id
           and w.tag    = 'REQCI'),
       (select dv.name
          from dpt_depositw w, dpt_vidd_flags dv
         where w.dpt_id = r.dpt_id
           and w.tag    = 'REQCI'
           and dv.id    = to_number(w.value)),
       c.rnk, c.nmk, c.okpo, r.branch, b.name
  from dpt_requests r, dpt_req_types rt, staff$base s1,
       dpt_deposit d, branch b, customer c
 where decode(r.req_state, null, 1, null) = 1
   and r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'AGRMNT_COMMIS'
   and r.req_cruserid  = s1.id
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
   and d.rnk           = c.rnk
with read only
 ;

PROMPT *** Create  grants  V_DPT_COMMISREQ_ACTIVE ***
grant SELECT                                                                 on V_DPT_COMMISREQ_ACTIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_COMMISREQ_ACTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_COMMISREQ_ACTIVE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_COMMISREQ_ACTIVE to DPT_ROLE;
grant SELECT                                                                 on V_DPT_COMMISREQ_ACTIVE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_COMMISREQ_ACTIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_COMMISREQ_ACTIVE.sql =========***
PROMPT ===================================================================================== 
