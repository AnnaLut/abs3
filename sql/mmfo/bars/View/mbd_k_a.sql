

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBD_K_A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view MBD_K_A ***

  CREATE OR REPLACE FORCE VIEW BARS.MBD_K_A ("RNK", "OKPO", "NMK", "KV", "NLS", "ACC", "ND", "CC_ID", "USERID", "DK", "ZDATE", "BDATE", "SDATE", "WDATE", "LIMIT", "VIDD", "TIPD", "KPROLOG") AS 
  select c.rnk, c.okpo, c.nmk, a.kv, a.nls, a.acc, d.nd, d.cc_id,
       d.USER_ID, v.tipd-1, d.sdate, p.bdate, p.WDATE, d.wdate, d.limit,
       v.vidd, v.tipd, d.kprolog
from customer c, cc_deal d, cc_vidd v, accounts a, cc_add p
where c.custtype=1   AND  c.rnk=d.rnk  AND  d.nd=p.nd     AND
      d.vidd=v.vidd  AND  p.adds= 0    AND  P.ACCS=A.ACC;

PROMPT *** Create  grants  MBD_K_A ***
grant SELECT                                                                 on MBD_K_A         to BARSREADER_ROLE;
grant SELECT                                                                 on MBD_K_A         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBD_K_A         to FOREX;
grant SELECT                                                                 on MBD_K_A         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MBD_K_A         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBD_K_A.sql =========*** End *** ======
PROMPT ===================================================================================== 
