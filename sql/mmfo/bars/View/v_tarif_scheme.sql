

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF_SCHEME.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF_SCHEME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF_SCHEME ("ID", "NAME") AS 
  select id, name
  from TARIF_SCHEME
 where d_close is null or d_close > bankdate;

PROMPT *** Create  grants  V_TARIF_SCHEME ***
grant SELECT                                                                 on V_TARIF_SCHEME  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF_SCHEME  to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF_SCHEME.sql =========*** End ***
PROMPT ===================================================================================== 
