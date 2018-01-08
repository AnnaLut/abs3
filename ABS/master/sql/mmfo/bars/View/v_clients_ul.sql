

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLIENTS_UL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLIENTS_UL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLIENTS_UL ("RNK", "NMK", "SAB") AS 
  SELECT   rnk, nmk, sab
     FROM   customer
    WHERE   date_off IS NULL
            AND (custtype = 2 OR (custtype = 3 AND sed IN ('34', '91')));

PROMPT *** Create  grants  V_CLIENTS_UL ***
grant SELECT                                                                 on V_CLIENTS_UL    to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_CLIENTS_UL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CLIENTS_UL    to START1;
grant SELECT                                                                 on V_CLIENTS_UL    to UPLD;
grant FLASHBACK,SELECT                                                       on V_CLIENTS_UL    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLIENTS_UL.sql =========*** End *** =
PROMPT ===================================================================================== 
