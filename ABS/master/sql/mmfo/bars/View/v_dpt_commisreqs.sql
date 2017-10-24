

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_COMMISREQS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_COMMISREQS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_COMMISREQS ("REQ_ID", "REQ_CRDATE", "REQ_CRUSER", "REQ_PRCDATE", "REQ_PRCUSER", "DPT_ID", "DPT_ND", "DPT_DATE", "AGRMNT_TYPE", "AGRMNT_TYPENAME", "CUST_ID", "CUST_FIO", "CUST_IDCODE", "BRANCH", "BRANCH_NAME", "REQ_STATE", "REQ_STATENAME") AS 
  select r.req_id, r.req_crdate, s1.fio, r.req_prcdate, s2.fio,
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
       c.rnk, c.nmk, c.okpo, r.branch, b.name,
       r.req_state,
       substr(decode(r.req_state, null, bars_msg.get_msg('DPT', 'REQUEST_ACTIVE'),
                                     1, bars_msg.get_msg('DPT', 'REQUEST_ALLOWED'),
                                    -1, bars_msg.get_msg('DPT', 'REQUEST_DISALLOWED')), 1, 250)
  from dpt_requests r, dpt_req_types rt, staff$base s1, staff$base s2,
       dpt_deposit d, branch b, customer c
 where r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'AGRMNT_COMMIS'
   and r.req_cruserid  = s1.id
   and r.req_prcuserid = s2.id(+)
   and not exists (select 1
                     from dpt_agreements
                    where dpt_id = r.dpt_id
                      and comiss_reqid = r.req_id)
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
   and d.rnk           = c.rnk
union all
select r.req_id, r.req_crdate, s1.fio, r.req_prcdate, s2.fio,
       r.dpt_id, d.nd, d.datz, dv.id, dv.name, c.rnk, c.nmk, c.okpo,
       r.branch, b.name, r.req_state,
       substr(decode(r.req_state, null, bars_msg.get_msg('DPT', 'REQUEST_ACTIVE'),
                                     1, bars_msg.get_msg('DPT', 'REQUEST_ALLOWED'),
                                    -1, bars_msg.get_msg('DPT', 'REQUEST_DISALLOWED')), 1, 250)
  from dpt_requests r, dpt_agreements da, staff$base s1, staff$base s2,
       dpt_vidd_flags dv, branch b, customer c,
       (select dc.deposit_id, dc.nd, dc.datz, dc.rnk
          from dpt_deposit_clos dc,
               (select deposit_id, max(idupd) idupd
                  from dpt_deposit_clos
                 where (deposit_id, bdate) in (select deposit_id, max(bdate)
                                                 from dpt_deposit_clos
                                               group by deposit_id)
                 group by deposit_id) dm
         where dc.idupd = dm.idupd) d
 where r.dpt_id        = da.dpt_id
   and r.req_id        = da.comiss_reqid
   and r.req_cruserid  = s1.id
   and r.req_prcuserid = s2.id(+)
   and da.agrmnt_type  = dv.id
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
   and d.rnk           = c.rnk
with read only
 ;

PROMPT *** Create  grants  V_DPT_COMMISREQS ***
grant SELECT                                                                 on V_DPT_COMMISREQS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_COMMISREQS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_COMMISREQS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_COMMISREQS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_COMMISREQS.sql =========*** End *
PROMPT ===================================================================================== 
