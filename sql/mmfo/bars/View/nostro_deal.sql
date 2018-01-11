

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NOSTRO_DEAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view NOSTRO_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.NOSTRO_DEAL ("RNK", "NDI", "ND", "KV", "NLS", "ACC", "MFO", "BIC", "CC_ID", "SDATE", "WDATE", "LIMIT", "FIN23", "OBS23", "KAT23", "K23", "SOS", "IR", "SDOG", "BRANCH", "PROD", "FIN_351", "PD", "DREC", "SND") AS 
  SELECT d.rnk,
          CASE WHEN d.ndi IS NULL THEN d.nd ELSE d.ndi END,
          d.nd,
          a.kv,
          a.nls,
          a.acc,
          b.mfo,
          b.bic,
          d.CC_ID,
          d.SDATE,
          d.WDATE,
          d.LIMIT,
          d.FIN23,
          d.OBS23,
          d.KAT23,
          d.k23,
          d.SOS,
          d.IR,
          d.SDOG,
          d.BRANCH,
          d.PROD,
          d.FIN_351,
          d.pd,
          'Редагування Парам.',
          TO_CHAR (d.ND)
     FROM CC_DEAL d,
          CustBank b,
          accounts a,
          nd_acc n
    WHERE     d.vidd IN (150, 1502)
          AND d.rnk = b.rnk
          AND d.nd = n.nd
          AND n.acc = a.acc;

PROMPT *** Create  grants  NOSTRO_DEAL ***
grant SELECT                                                                 on NOSTRO_DEAL     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NOSTRO_DEAL     to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NOSTRO_DEAL     to START1;
grant SELECT                                                                 on NOSTRO_DEAL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NOSTRO_DEAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
