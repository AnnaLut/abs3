

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCOUNTSPV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCOUNTSPV ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCOUNTSPV ("ACC", "DAT1", "DAT2", "PARID", "VAL") AS 
  select acc, dat1, dat2, parid, val
  from accountsp;

PROMPT *** Create  grants  ACCOUNTSPV ***
grant SELECT                                                                 on ACCOUNTSPV      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSPV      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTSPV      to CUST001;
grant SELECT                                                                 on ACCOUNTSPV      to START1;
grant SELECT                                                                 on ACCOUNTSPV      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCOUNTSPV.sql =========*** End *** ===
PROMPT ===================================================================================== 
