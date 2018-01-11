

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INSU_CORPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view INSU_CORPS ***

  CREATE OR REPLACE FORCE VIEW BARS.INSU_CORPS ("NUSER", "ND", "SOS", "CC_ID", "DAT1", "DAT4", "RNK", "LIM", "NMK", "OKPO", "OST") AS 
  SELECT
 d.user_id,d.nd,d.sos,d.cc_id,d.sdate,d.wdate,d.rnk,d.limit,c.nmk,c.okpo,
 to_number(null)
FROM cc_deal D,   CUSTOMER C
WHERE d.vidd=17 and c.RNK=D.RNK
 ;

PROMPT *** Create  grants  INSU_CORPS ***
grant SELECT                                                                 on INSU_CORPS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_CORPS      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INSU_CORPS      to RCC_DEAL;
grant SELECT                                                                 on INSU_CORPS      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INSU_CORPS      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on INSU_CORPS      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INSU_CORPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
