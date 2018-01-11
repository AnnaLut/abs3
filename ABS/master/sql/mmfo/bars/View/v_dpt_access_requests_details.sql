

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_ACCESS_REQUESTS_DETAILS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_ACCESS_REQUESTS_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_ACCESS_REQUESTS_DETAILS ("REQ_ID", "REQ_TYPE", "REQ_BDATE", "REQ_CRDATE", "REQ_CRUSERID", "REQ_PRCDATE", "REQ_PRCUSERID", "REQ_STATE", "REQ_DAT_START", "REQ_DAT_FINISH", "REQ_BRANCH", "REQ_COMMENTS", "TRUSTEE_ID", "TRUSTEE_NAME", "TRUSTEE_CODE", "TRUSTEE_BDAY", "TRUSTEE_TYPE_ID", "TRUSTEE_TYPE_NAME", "CERTIF_NUM", "CERTIF_DATE", "STATE_NAME", "CONTRACT_ID", "REQ_AMOUNT", "REQ_FLAGS", "DPT_NUM", "DPT_DAT_BEGIN", "DPT_DAT_END", "DPT_RNK") AS 
  ( select r.REQ_ID,       r.REQ_TYPE,    r.REQ_BDATE,
         r.REQ_CRDATE,   r.REQ_CRUSER,  r.REQ_PRCDATE, r.REQ_PRCUSER,
         r.REQ_STATE,
         r.DATE_START,   r.DATE_FINISH, r.BRANCH,      r.COMMENTS,
         r.TRUSTEE_RNK,  c.NMK,         c.OKPO,        p.BDAY,
         r.TRUSTEE_TYPE, t.NAME,        r.CERTIF_NUM,  r.CERTIF_DATE,
         case r.REQ_STATE
           when  0 then 'Запит не оброблено'
           when  1 then 'Запит підтверджено'
           when -1 then 'Запит відхилено'
           else null
         end,
         ra.CONTRACT_ID, ra.AMOUNT, ra.FLAGS,
         D.ND, D.DAT_BEGIN, D.DAT_END, D.RNK
    from CUST_REQUESTS   r
    left join CUST_REQ_ACCESS ra on (RA.REQ_ID = R.REQ_ID)
   inner join DPT_TRUSTEE_TYPE t on (t.id  = r.TRUSTEE_TYPE)
   inner join CUSTOMER c         on (c.rnk = r.TRUSTEE_RNK)
   inner join PERSON   p         on (p.rnk = r.TRUSTEE_RNK)
   inner join DPT_DEPOSIT d      on (d.deposit_id = ra.CONTRACT_ID)
   where R.REQ_STATE Is Not Null
);

PROMPT *** Create  grants  V_DPT_ACCESS_REQUESTS_DETAILS ***
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to START1;
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to UPLD;
grant SELECT                                                                 on V_DPT_ACCESS_REQUESTS_DETAILS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_ACCESS_REQUESTS_DETAILS.sql =====
PROMPT ===================================================================================== 
