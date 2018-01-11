

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINTREQS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CHGINTREQS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CHGINTREQS ("REQ_ID", "REQ_CRDATE", "REQ_CRUSER", "REQ_PRCDATE", "REQ_PRCUSER", "DPT_ID", "DPT_ND", "DPT_DATE", "CUST_ID", "CUST_FIO", "CUST_IDCODE", "REQC_TYPE", "REQC_TYPENAME", "REQC_EXPDATE", "REQC_OLDINT", "REQC_NEWINT", "REQC_NEWBR", "REQC_BEGDATE", "BRANCH", "BRANCH_NAME", "REQ_STATE", "REQ_STATENAME") AS 
  select r.req_id, r.req_crdate, s1.fio, r.req_prcdate, s2.fio,
       r.dpt_id, d.nd, d.datz, c.rnk, c.nmk, c.okpo,
       rc.reqc_type,
       substr(decode(reqc_type, 1, bars_msg.get_msg('DPT', 'REQ_CHGINT_IND'),
                                2, bars_msg.get_msg('DPT', 'REQ_CHGINT_VID')), 1, 250),
       rc.reqc_expdate, reqc_oldint, reqc_newint,
       rc.reqc_newbr, rc.reqc_begdate, r.branch, b.name,
       r.req_state,
       substr(decode(r.req_state, null, bars_msg.get_msg('DPT', 'REQUEST_ACTIVE'),
                                     1, bars_msg.get_msg('DPT', 'REQUEST_ALLOWED'),
                                    -1, bars_msg.get_msg('DPT', 'REQUEST_DISALLOWED')), 1, 250)
  from dpt_requests r, dpt_req_types rt, staff$base s1, staff$base s2,
       branch b, dpt_req_chgints rc, customer c,
       (select dc.deposit_id, dc.nd, dc.datz, dc.rnk
          from dpt_deposit_clos dc,
               (select deposit_id, max(idupd) idupd
                  from dpt_deposit_clos
                 where (deposit_id, bdate) in (select deposit_id, max(bdate)
                                                 from dpt_deposit_clos
                                               group by deposit_id)
                 group by deposit_id) dm
         where dc.idupd = dm.idupd) d
 where r.reqtype_id    = rt.reqtype_id
   and rt.reqtype_code = 'AGRMNT_CHGINT'
   and r.req_cruserid  = s1.id
   and r.dpt_id        = d.deposit_id
   and r.branch        = b.branch
   and r.req_id        = rc.req_id
   and r.req_prcuserid = s2.id(+)
   and d.rnk           = c.rnk
with read only
 ;

PROMPT *** Create  grants  V_DPT_CHGINTREQS ***
grant SELECT                                                                 on V_DPT_CHGINTREQS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_CHGINTREQS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_CHGINTREQS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_CHGINTREQS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINTREQS.sql =========*** End *
PROMPT ===================================================================================== 
