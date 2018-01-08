

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/E_DEAL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view E_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.E_DEAL ("NDI", "ND", "RNK", "SOS", "CC_ID", "SDATE", "WDATE", "ACC26", "ACC36", "ACCD", "NLS26", "NLS36", "NLS_D", "KV26", "KV36", "KVD", "USER_ID", "SA", "ACCP", "NLS_P", "KVP", "KF", "BRANCH") AS 
  SELECT e.NDI,
          e.nd,
          e.rnk,
          e.sos,
          e.cc_id,
          e.sdate,
          e.wdate,
          e.acc26,
          e.acc36,
          e.accd,
          a26.nls nls26,
          a36.nls nls36,
          ad.nls nls_d,
          a26.kv kv26,
          a36.kv kv36,
          ad.kv kvd,
          e.user_id,
          e.sa,
          e.accp,
          ap.nls,
          ap.kv,
          e.kf,
          a26.branch
     FROM (SELECT *
             FROM e_deal$base
            WHERE kf = SYS_CONTEXT ('bars_context', 'user_mfo')) e,
          accounts a26,
          accounts a36,
          accounts ad,
          accounts ap
    WHERE     e.acc26 = a26.acc
          AND e.acc36 = a36.acc(+)
          AND e.accp = ap.acc(+)
          AND e.accd = ad.acc(+);

PROMPT *** Create  grants  E_DEAL ***
grant SELECT                                                                 on E_DEAL          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_DEAL          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_DEAL          to ELT;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_DEAL          to START1;
grant SELECT                                                                 on E_DEAL          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_DEAL          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/E_DEAL.sql =========*** End *** =======
PROMPT ===================================================================================== 
