

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FXANI.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FXANI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FXANI ("B", "E", "DEAL_TAG", "SWAP_TAG", "DAT", "DAT_A", "DAT_B", "RNK", "NLSD", "NLSK", "KV", "KVA", "KVB", "SUMA", "SUMB", "SUMC", "S", "FDAT", "SOS", "ACCD", "ACCK", "REF", "STMT", "NTIK", "KOD3", "KOD3K", "OND", "ONK", "TXT") AS 
  select d.B, d.E, f.deal_tag, f.swap_tag,  f.dat,  f.dat_a, f.dat_b, f.rnk, ad.nls NLSD, ak.nls NLSK,  ad.kv,
          f.kva, f.kvb, f.suma, f.sumb, f.sumc,  od.s, od.fdat, od.sos, ad.acc ACCD, ak.acc ACCK,  od.ref, od.stmt, f.ntik,
          substr(FOREX.get_forextype3  (f.deal_tag ), 1,15) KOD3,   substr(FOREX.get_forextype3K (f.deal_tag ), 1,15) KOD3k ,
          ad.nbs||'.'|| ad.ob22 OND,
          ak.nbs||'.'|| ak.ob22 ONK, od.txt
   from Fx_deal f, V_SFDAT d, opldok od, opldok ok, accounts ad, accounts ak
   where f.dat >= d.B    and f.dat <= d.E --and (ad.nls like '6%' or ak.nls like '6%') and ad.kv = 980 and ak.kv = 980
     and f.ref  = od.ref and od.dk  = 0   and od.acc = ad.acc and f.ref  = ok.ref and ok.dk  = 1   and ok.acc = ak.acc and ok.stmt = od.stmt ;

PROMPT *** Create  grants  V_FXANI ***
grant SELECT                                                                 on V_FXANI         to BARSREADER_ROLE;
grant SELECT                                                                 on V_FXANI         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FXANI         to START1;
grant SELECT                                                                 on V_FXANI         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FXANI.sql =========*** End *** ======
PROMPT ===================================================================================== 
