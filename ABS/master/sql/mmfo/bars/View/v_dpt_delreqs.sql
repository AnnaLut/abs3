

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_DELREQS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_DELREQS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_DELREQS ("REQ_ID", "REQ_CRDATE", "REQ_CRUSER", "REQ_PRCDATE", "REQ_PRCUSER", "DPT_ID", "DPT_ND", "DPT_DATE", "BRANCH", "BRANCH_NAME", "REQ_STATE", "REQ_STATENAME") AS 
  select r.req_id, r.req_crdate, s1.fio, r.req_prcdate, s2.fio,
       r.dpt_id, d.nd, d.datz, r.branch, b.name,
       r.req_state,
       decode(r.req_state, null, bars_msg.get_msg('DPT', 'REQUEST_ACTIVE'),
                              1, bars_msg.get_msg('DPT', 'REQUEST_ALLOWED'),
                             -1, bars_msg.get_msg('DPT', 'REQUEST_DISALLOWED'))
  from dpt_requests r, dpt_req_types rt, staff$base s1,
       staff$base s2, branch b,
       (select dc.deposit_id, dc.nd, dc.datz
          from dpt_deposit_clos dc,
               (select deposit_id, max(idupd) idupd
                  from dpt_deposit_clos
                 where (deposit_id, bdate) in (select deposit_id, max(bdate)
                                                 from dpt_deposit_clos
                                               group by deposit_id)
                 group by deposit_id) dm
         where dc.idupd = dm.idupd) d
 where r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'DELETE_DEAL'
   and r.req_cruserid  = s1.id
   and r.req_prcuserid = s2.id
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
with read only
 ;

PROMPT *** Create  grants  V_DPT_DELREQS ***
grant SELECT                                                                 on V_DPT_DELREQS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_DELREQS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_DELREQS   to DPT_ROLE;
grant SELECT                                                                 on V_DPT_DELREQS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_DELREQS   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_DELREQS.sql =========*** End *** 
PROMPT ===================================================================================== 
