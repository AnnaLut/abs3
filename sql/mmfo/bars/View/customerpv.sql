

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUSTOMERPV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view CUSTOMERPV ***

  CREATE OR REPLACE FORCE VIEW BARS.CUSTOMERPV ("RNK", "DAT1", "DAT2", "PARID", "VAL") AS 
  select rnk, dat1, dat2, parid, val
  from customerp;

PROMPT *** Create  grants  CUSTOMERPV ***
grant SELECT                                                                 on CUSTOMERPV      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERPV      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERPV      to CUST001;
grant SELECT                                                                 on CUSTOMERPV      to START1;
grant SELECT                                                                 on CUSTOMERPV      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUSTOMERPV.sql =========*** End *** ===
PROMPT ===================================================================================== 
