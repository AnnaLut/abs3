

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FX_SWAP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FX_SWAP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FX_SWAP ("DEAL_TAG", "NPP", "DAT1", "DAT2", "VDAT", "KVA", "S_A", "KVB", "S_B", "BASEY_A", "RATE_A", "BASEY_B", "RATE_B") AS 
  select deal_tag, npp, dat1, dat2, vdat,
       kva, suma/100 s_a, kvb, sumb/100 s_b,
       basey_a, rate_a, basey_b, rate_b
from fx_swap;

PROMPT *** Create  grants  V_FX_SWAP ***
grant SELECT                                                                 on V_FX_SWAP       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FX_SWAP       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FX_SWAP       to FOREX;
grant SELECT                                                                 on V_FX_SWAP       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FX_SWAP.sql =========*** End *** ====
PROMPT ===================================================================================== 
