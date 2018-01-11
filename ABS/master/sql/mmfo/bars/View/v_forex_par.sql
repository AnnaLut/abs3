

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_PAR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_PAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_PAR ("PAR", "VAL", "COMM", "KF") AS 
  select "PAR","VAL","COMM","KF" from PARAMS$BASE  where par like 'FX%';

PROMPT *** Create  grants  V_FOREX_PAR ***
grant SELECT                                                                 on V_FOREX_PAR     to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_FOREX_PAR     to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_FOREX_PAR     to START1;
grant SELECT                                                                 on V_FOREX_PAR     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_PAR.sql =========*** End *** ==
PROMPT ===================================================================================== 
