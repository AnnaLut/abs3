

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_ARCHIVE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_ARCHIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_ARCHIVE ("KF", "BRANCH", "DPT_ID", "ND", "VIDD_ID", "VIDD_NM", "CCY_ID", "CCY_CODE", "CTR_AMT", "CUST_ID", "CUST_NM", "ACC_NUM", "DEP_BAL", "INT_BAL", "RATE", "CTR_DT", "BEG_DT", "END_DT", "CNT_DUBL", "USER_ID", "EBPY", "RPT_DT") AS 
  SELECT d.KF,
            d.BRANCH,
            d.deposit_id,
            d.ND,
            d.VIDD,
            v.type_name,
            v.kv,
            t.lcv,
            d.LIMIT,
            d.rnk,
            c.nmk,
            a.nls,
            NVL (fost (d.acc, DPT_RPT_UTIL.GET_FINISH_DT) / t.denom, 0)
               AS DEP_BAL,
            NVL (fost (i.acra, DPT_RPT_UTIL.GET_FINISH_DT) / t.denom, 0)
               AS INT_BAL,
            NVL (acrn.fproc (d.acc, DPT_RPT_UTIL.GET_FINISH_DT), 0) AS RATE,
            d.datz,
            d.dat_begin,
            d.dat_end,
            NVL (d.cnt_dubl, 0) AS CNT_DUBL,
            d.USERID,
            CASE WHEN D.ARCHDOC_ID > 0 THEN '“¿ ' ELSE 'Õ≤' END EBPY,
            (SELECT REQ_BNKDAT
               FROM DPT_EXTREFUSALS
              WHERE DPTID = d.deposit_id AND REQ_STATE = 1)
       FROM BARS.DPT_DEPOSIT_CLOS d
            JOIN BARS.DPT_VIDD v ON (v.VIDD = d.VIDD)
            JOIN BARS.TABVAL$GLOBAL t ON (t.KV = d.KV)
            JOIN BARS.ACCOUNTS a ON (a.ACC = d.ACC)
            JOIN BARS.CUSTOMER c ON (c.RNK = d.RNK)
            JOIN BARS.INT_ACCN i ON (i.ACC = d.ACC AND i.ID = 1)
      WHERE (d.IDUPD) IN (  SELECT MAX (IDUPD)
                              FROM DPT_DEPOSIT_CLOS
                             WHERE BDATE <= DPT_RPT_UTIL.GET_FINISH_DT
                          GROUP BY deposit_id)
   ORDER BY d.VIDD;

PROMPT *** Create  grants  V_DPT_ARCHIVE ***
grant SELECT                                                                 on V_DPT_ARCHIVE   to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_ARCHIVE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_ARCHIVE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_ARCHIVE.sql =========*** End *** 
PROMPT ===================================================================================== 
