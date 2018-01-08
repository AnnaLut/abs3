

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_APPLICANTS2IMMOBILE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_APPLICANTS2IMMOBILE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_APPLICANTS2IMMOBILE ("DPT_ID", "DPT_NUM", "DPT_SUM", "DPT_CUR", "CUST_NAME", "DPT_DAT", "DAT_BEGIN", "DAT_END", "BRANCH", "COMMENTS", "DAPP") AS 
  SELECT d.deposit_id,
          d.nd,
          a.ostc / 100,
          d.kv,
          c.nmk,
          d.datz,
          d.dat_begin,
          d.dat_end,
          d.branch,
          comments,
          a.dapp
     FROM DPT_DEPOSIT d,
          (SELECT MAX (fdat) AS dat
             FROM fdat
            WHERE fdat <= ADD_MONTHS (bankdate, -36)) f,
          CUSTOMER c,
          ACCOUNTS a
    WHERE     d.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND NOT EXISTS
                 (SELECT 1
                    FROM DPT_IMMOBILE n
                   WHERE n.dpt_id = d.deposit_id)
          AND (   (d.dat_end < f.dat)
               OR (    d.datZ <= f.dat
                   AND d.dat_end IS NULL
                   AND d.kv NOT IN (959, 961, 962) -- не банк.метали
                   AND NOT EXISTS
                              (SELECT 1
                                 FROM SALDOA s
                                WHERE     s.acc = d.acc
                                      AND s.fdat > f.dat
                                      AND (s.kos > 0 OR s.dos > 0))))
          AND c.rnk = d.rnk
          AND a.acc = d.acc
          AND a.blkD = 0;

PROMPT *** Create  grants  V_DPT_APPLICANTS2IMMOBILE ***
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to START1;
grant SELECT                                                                 on V_DPT_APPLICANTS2IMMOBILE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_APPLICANTS2IMMOBILE.sql =========
PROMPT ===================================================================================== 
