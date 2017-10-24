

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX ("B", "REF", "REFA", "REFB", "SOS", "SWAP_TAG", "DEAL_TAG", "NTIK", "RNK", "DAT", "ACC9A", "ACC9B", "KVA", "DAT_A", "SUMA", "QA1", "QA2", "KVB", "DAT_B", "SUMB", "QB1", "QB2", "P1", "P2", "FAKT_R", "PRGN_R", "KOD", "NPP") AS 
  select y."B",y."REF",y."REFA",y."REFB",y."SOS",y."SWAP_TAG",y."DEAL_TAG",y."NTIK",y."RNK",y."DAT",y."ACC9A",y."ACC9B",y."KVA",y."DAT_A",y."SUMA",y."QA1",y."QA2",y."KVB",y."DAT_B",y."SUMB",y."QB1",y."QB2", QA1-QB1 P1, QA2-QB2 P2, decode ( B, dat_a, (QA2-QB2) - (QA1-QB1), 0 )  FAKT_R,
                                    decode ( B, dat_a, 0, (QA2-QB2) - (QA1-QB1) )  PRGN_R,
      substr(FOREX.get_forextype3 (y.deal_tag ) , 1,15) KOD,
      substr(FOREX.get_forextype3 (y.deal_tag ) ,   -3) NPP
--      (y.deal_tag - y.swap_tag ) + 1 NPP
from ( SELECT d.B, x.ref, refa, refb, x.sos,
              x.swap_tag, x.deal_tag , x.ntik, x.Rnk, x.dat , acc9a, acc9b,
              x.kva,x.dat_a, x.suma/100 sumA, DECODE(x.dat,d.B,0,gl.p_icurval(x.kva,x.suma,d.B-1)) QA1, gl.p_icurval(x.kva,x.suma,d.B)/100 QA2,
              x.kvb,x.dat_b, x.sumb/100 sumb, DECODE(x.dat,d.B,0,gl.p_icurval(x.kvb,x.sumb,d.B-1)) QB1, gl.p_icurval(x.kvb,x.sumb,d.B)/100 QB2
       FROM fx_deal x, V_SFDAT d
       WHERE exists (select 1 from oper where ref = x.ref and sos>0)
         and NVL (x.sos, 10) < 15
    ) y ;

PROMPT *** Create  grants  V_FOREX ***
grant SELECT                                                                 on V_FOREX         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX.sql =========*** End *** ======
PROMPT ===================================================================================== 
