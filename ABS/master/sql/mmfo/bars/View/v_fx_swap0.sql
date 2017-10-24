

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FX_SWAP0.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FX_SWAP0 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FX_SWAP0 ("TXT", "DT", "ST", "NMK", "NTIK", "KVA", "SA", "KVB", "SB") AS 
  select 'Пл.календар по відсоткам' txt, f.deal_tag DT, f.swap_tag ST ,
          c.nmk,f.ntik, f.kva, f.suma/100 SA, f.kvb, f.sumb/100 SB
from fx_deal  f , customer c
where f.rnk = c.rnk (+)  and   f.deal_tag = to_number (pul.get('DSW') ) ;

PROMPT *** Create  grants  V_FX_SWAP0 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_FX_SWAP0      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FX_SWAP0.sql =========*** End *** ===
PROMPT ===================================================================================== 
