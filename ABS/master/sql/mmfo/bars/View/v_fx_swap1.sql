

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FX_SWAP1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FX_SWAP1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FX_SWAP1 ("DEAL_TAG", "NPP", "DAT1", "DAT2", "VDAT", "KVA", "S_A", "KVB", "S_B", "BASEY_A", "RATE_A", "BASEY_B", "RATE_B") AS 
  select "DEAL_TAG","NPP","DAT1","DAT2","VDAT","KVA","S_A","KVB","S_B","BASEY_A","RATE_A","BASEY_B","RATE_B" from V_FX_SWAP where  deal_tag = to_number (pul.get('DSW') ) ;

PROMPT *** Create  grants  V_FX_SWAP1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FX_SWAP1      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FX_SWAP1.sql =========*** End *** ===
PROMPT ===================================================================================== 
