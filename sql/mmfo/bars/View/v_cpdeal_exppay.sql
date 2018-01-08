

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CPDEAL_EXPPAY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CPDEAL_EXPPAY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CPDEAL_EXPPAY ("ID", "ISIN", "REF", "TRANS_ACC", "TRANS_NLS", "TRANS_KV", "TRANS_OST", "N_ACC", "N_NLS", "N_OST", "N_PAY", "R_ACC", "R_NLS", "R_OST", "R_PAY") AS 
  SELECT cd.id,
           (select CP_ID from cp_kod where id = cd.id) ISIN,
           cd.REF,
           (select acc from accounts where nls = '37392555' and kv = coalesce(aN.kv,aR.kv)) TRANS,
           (select nls from accounts where nls = '37392555' and kv = coalesce(aN.kv,aR.kv)) TRANS,
           (select kv from accounts where nls = '37392555' and kv = coalesce(aN.kv,aR.kv)) TRANS_kv,
           (select ostb/100 from accounts where nls = '37392555' and kv = coalesce(aN.kv,aR.kv)) TRANS_OST,
           aN.acc,
           aN.nls,
           -aN.ostc/100,
           0 as N_PAY,
           aR.acc,
           aR.nls,
           -aR.ostc/100,
           0 as R_PAY
      FROM cp_deal cd, accounts aN, accounts aR
     WHERE     CD.ACCEXPN = aN.acc(+)
           AND cd.accexpr = ar.acc(+)
           AND (aR.ostC <> 0 OR aN.ostC <> 0);

PROMPT *** Create  grants  V_CPDEAL_EXPPAY ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_CPDEAL_EXPPAY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CPDEAL_EXPPAY.sql =========*** End **
PROMPT ===================================================================================== 
