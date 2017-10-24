

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ARCDOCS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view ARCDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.ARCDOCS ("REC", "REF", "REF_A", "FN_A", "DAT_A", "FN_B", "DAT_B", "DATD", "DATP", "VDAT", "DK", "MFOA", "NLSA", "NAM_A", "MFOB", "NLSB", "NAM_B", "NAZN", "ND", "S", "D_REC", "SOS", "BLK", "VOB", "NAZNK", "NAZNS", "ID_A", "ID_B", "ID_O", "BIS", "KV", "REC_A", "REC_B") AS 
  select x0.rec, x0.ref, x0.ref_a, x0.fn_a, x0.dat_a, x0.fn_b, x0.dat_b,
          x0.datd, x0.datp, x0.datp, x0.dk, x0.mfoa, x0.nlsa, x0.nam_a,
          x0.mfob, x0.nlsb, x0.nam_b, x0.nazn, x0.nd, x0.s, x0.d_rec, x0.sos,
          x0.blk, x0.vob, x0.naznk, x0.nazns, x0.id_a, x0.id_b, x0.id_o,
          x0.bis, x0.kv, x0.rec_a, x0.rec_b
     from arc_rrp x0
 ;

PROMPT *** Create  grants  ARCDOCS ***
grant SELECT                                                                 on ARCDOCS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ARCDOCS         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ARCDOCS.sql =========*** End *** ======
PROMPT ===================================================================================== 
