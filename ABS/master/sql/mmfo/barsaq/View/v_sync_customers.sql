

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_CUSTOMERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SYNC_CUSTOMERS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_SYNC_CUSTOMERS ("KF", "CUST_RNK", "CUST_ID", "NAME", "CUST_CODE", "ADDRESS", "DATE_ON", "DATE_OFF", "CUST_TYPE", "PASP_TYPE", "PASP_SERIAL", "PASP_NUMBER", "PASP_DATE", "PASP_ISSUED", "BIRTH_DATE", "BIRTH_PLACE", "HOME_PHONE", "WORK_PHONE", "CUST_TYPE_ID", "LEGAL_NAME", "CHIEF_NAME", "CHIEF_PHONE", "BOOKKEEPER_NAME", "BOOKKEEPER_PHONE", "BRANCH_CODE", "BRANCH_NAME", "IMPORTED") AS 
  SELECT z.kf,
          c.rnk,
          r.rnk,
          c.nmk,
          c.okpo,
          c.adr,
          c.date_on,
          c.date_off,
          ct.name,
          pa.name,
          p.ser,
          p.numdoc,
          p.pdate,
          p.organ,
          p.bday,
          p.bplace,
          p.teld,
          p.telw,
          c.custtype,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          t.tobo,
          t.name,
          DECODE (r.rnk, NULL, 0, 1)
     FROM bars.customer c,
          bars.person p,
          bars.passp pa,
          bars.custtype ct,
          bars.tobo t,
          barsaq.customers r,
          (SELECT UNIQUE kf, rnk FROM barsaq.v_kf_accounts) z
    WHERE     c.rnk = p.rnk(+)
          AND c.custtype = ct.custtype
          AND c.custtype = 3
          AND c.tobo = t.tobo
          AND p.passp = pa.passp(+)
          AND c.rnk = z.rnk
          AND z.rnk = r.rnk(+)
          AND z.kf = r.bank_id(+)
   UNION ALL
   SELECT z.kf,
          c.rnk,
          r.rnk,
          c.nmk,
          c.okpo,
          c.adr,
          c.date_on,
          c.date_off,
          ct.name,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          c.custtype,
          cr.nmku,
          cr.ruk,
          cr.telr,
          cr.buh,
          cr.telb,
          t.tobo,
          t.name,
          DECODE (r.rnk, NULL, 0, 1)
     FROM bars.customer c,
          bars.corps cr,
          bars.custtype ct,
          bars.tobo t,
          barsaq.customers r,
          (SELECT UNIQUE kf, rnk FROM barsaq.v_kf_accounts) z
    WHERE     c.rnk = cr.rnk(+)
          AND c.custtype = ct.custtype
          AND ( c.custtype IN (1, 2))
          AND c.tobo = t.tobo
          AND c.rnk = z.rnk
          AND z.rnk = r.rnk(+)
          AND z.kf = r.bank_id(+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_SYNC_CUSTOMERS.sql =========*** End
PROMPT ===================================================================================== 
