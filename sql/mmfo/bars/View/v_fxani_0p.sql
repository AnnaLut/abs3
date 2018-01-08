

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI_0P.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI_0P ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI_0P ("B", "E", "DEAL_TAG", "SWAP_TAG", "DAT", "DAT_A", "DAT_B", "RNK", "NLS", "NBS", "OB22", "REF", "STMT", "NTIK", "KVA", "KVB", "SUMA", "SUMB", "SUMC", "S", "FDAT", "SOS", "ACC", "KOD3", "KOD3K") AS 
  select d.B, d.E, f.deal_tag, f.swap_tag, f.dat,  f.dat_a, f.dat_b, f.rnk, a.nls,  a.nbs, a.ob22, o.ref, o.stmt, f.ntik,
          f.kva, f.kvb, f.suma, f.sumb, f.sumc, decode (o.dk, 0, -o.s, +o.s) s, o.fdat, o.sos, a.acc,
          substr(FOREX.get_forextype3  (f.deal_tag ), 1,15) KOD3,  substr(FOREX.get_forextype3K (f.deal_tag ), 1,15) KOD3k
   from Fx_deal f, V_SFDAT d, opldok o, accounts a
   where f.dat >= d.B   and f.dat <= d.E    and f.ref  = o.ref and  o.acc = a.acc and a.kv = 980   and a.nls like '6%' ;

PROMPT *** Create  grants  V_FXANI_0P ***
grant SELECT                                                                 on V_FXANI_0P      to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXANI_0P      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI_0P      to START1;
grant SELECT                                                                 on V_FXANI_0P      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI_0P.sql =========*** End *** ===
PROMPT ===================================================================================== 
