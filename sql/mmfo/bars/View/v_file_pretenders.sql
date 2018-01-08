

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FILE_PRETENDERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FILE_PRETENDERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FILE_PRETENDERS ("CUST_ID", "ACC_ID", "ACC_NUM", "ACC_TYPE", "ASVO_ACCOUNT", "CUST_NAME", "CUST_CODE", "DOC_SERIAL", "DOC_NUMBER", "DOC_ISSUED", "CUST_BDAY", "DOC_DATE", "INFO_ID", "BRANCH", "BRANCH_NAME") AS 
  SELECT c.rnk, a.acc, a.nls, a.tip, a.nlsalt, c.nmk, c.okpo, p.ser, p.numdoc,
          p.organ, p.bday, p.pdate, r.info_id, a.branch, b.NAME
     FROM customer c, person p, accounts a, dpt_file_row r, branch b
    WHERE c.rnk = p.rnk
      AND c.rnk = a.rnk
      AND c.okpo = r.id_code
      AND nlsalt IS NOT NULL
      AND a.branch = b.branch
      AND a.kv = 980
      and a.nbs in (2620,2625,8620)
   UNION
   SELECT c.rnk, a.acc, a.nls, a.tip, a.nlsalt, c.nmk, c.okpo, p.ser, p.numdoc,
          p.organ, p.bday, p.pdate, r.info_id, a.branch, b.NAME
     FROM customer c, person p, accounts a, dpt_file_row r, branch b
    WHERE c.rnk = p.rnk
      AND c.rnk = a.rnk
      AND c.okpo = r.id_code
      AND a.branch = b.branch
      AND a.kv = 980
      and a.nbs in (2620,2625,8620)
   UNION
   SELECT c.rnk, a.acc, a.nls, a.tip, a.nlsalt, c.nmk, c.okpo, p.ser, p.numdoc,
          p.organ, p.bday, p.pdate, r.info_id, a.branch, b.NAME
     FROM customer c, person p, accounts a, dpt_file_row r, branch b
    WHERE c.rnk = p.rnk
      AND c.rnk = a.rnk
      AND a.nlsalt = r.nls
      AND a.nlsalt IS NOT NULL
      AND a.branch = b.branch
      AND a.kv = 980
      and a.nbs in (2620,2625,8620)
   UNION
   SELECT c.rnk, a.acc, a.nls, a.tip, a.nls, c.nmk, c.okpo, p.ser, p.numdoc, p.organ,
          p.bday, p.pdate, r.info_id, a.branch, b.NAME
     FROM customer c, person p, accounts a, dpt_file_row r, branch b
    WHERE c.rnk = p.rnk
      AND c.rnk = a.rnk
      AND a.branch = b.branch
      AND a.nls = r.nls
      AND a.kv = 980
      and a.nbs in (2620,2625,8620)
   UNION
   SELECT c.rnk, a.acc, a.nls, a.tip, a.nls, c.nmk, c.okpo, p.ser, p.numdoc, p.organ,
          p.bday, p.pdate, r.info_id, a.branch, b.NAME
     FROM customer c,
          person p,
          accounts a,
          dpt_file_row r,
          branch b,
          obpc_acct pc,
          tabval t
    WHERE c.rnk = p.rnk
      AND c.rnk = a.rnk
      AND a.branch = b.branch
      AND a.kv = 980
      AND a.kf = pc.kf
      AND a.kv = t.kv
      AND t.lcv = pc.currency
      AND a.nls = pc.lacct
      AND pc.card_acct = r.nls
 ;

PROMPT *** Create  grants  V_FILE_PRETENDERS ***
grant SELECT                                                                 on V_FILE_PRETENDERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FILE_PRETENDERS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_FILE_PRETENDERS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FILE_PRETENDERS.sql =========*** End 
PROMPT ===================================================================================== 
