

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_CUSTOMERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_CUSTOMERS ("KF", "CUST_RNK", "CUST_ID", "NAME", "CUST_CODE", "ADDRESS", "DATE_ON", "DATE_OFF", "CUST_TYPE", "PASP_TYPE", "PASP_SERIAL", "PASP_NUMBER", "PASP_DATE", "PASP_ISSUED", "BIRTH_DATE", "BIRTH_PLACE", "HOME_PHONE", "WORK_PHONE", "CUST_TYPE_ID", "LEGAL_NAME", "CHIEF_NAME", "CHIEF_PHONE", "BOOKKEEPER_NAME", "BOOKKEEPER_PHONE", "BRANCH_CODE", "BRANCH_NAME", "IMPORTED") AS 
  select
z.kf, c.rnk, r.rnk, c.nmk, c.okpo, c.adr, c.date_on, c.date_off, ct.name,
pa.name, p.ser, p.numdoc, p.pdate, p.organ, p.bday,
p.bplace, p.teld, p.telw, c.custtype,
null,null,null,null,null,
t.tobo, t.name, decode(r.rnk, null, 0, 1)
from bars.customer c,
     bars.person p,
     bars.passp pa,
     bars.custtype ct,
     bars.tobo t,
     barsaq.customers r,
     (select unique kf, rnk from barsaq.v_kf_accounts) z
where c.rnk = p.rnk (+)
  and c.custtype = ct.custtype
  and c.custtype = 3
  and c.tobo = t.tobo
  and p.passp = pa.passp (+)
  and c.rnk = z.rnk
  and z.rnk = r.rnk (+)
  and z.kf  = r.bank_id (+)
union all
select
z.kf, c.rnk, r.rnk, c.nmk, c.okpo, c.adr, c.date_on, c.date_off, ct.name,
null, null, null, null, null, null,
null, null, null, c.custtype,
cr.nmku, cr.ruk, cr.telr, cr.buh, cr.telb,
t.tobo, t.name, decode(r.rnk, null, 0, 1)
from bars.customer c,
     bars.corps cr,
     bars.custtype ct,
     bars.tobo t,
     barsaq.customers r,
     (select unique kf, rnk from barsaq.v_kf_accounts) z
where c.rnk = cr.rnk (+)
  and c.custtype = ct.custtype
  and c.custtype in (1,2)
  and c.tobo = t.tobo
  and c.rnk = z.rnk
  and z.rnk = r.rnk (+)
  and z.kf  = r.bank_id (+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_CUSTOMERS.sql =========*** End
PROMPT ===================================================================================== 
