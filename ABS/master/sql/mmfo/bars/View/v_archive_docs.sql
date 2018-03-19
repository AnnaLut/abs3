

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ARCHIVE_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ARCHIVE_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ARCHIVE_DOCS ("REC", "REF", "REF_A", "FN_A", "DAT_A", "FN_B", "DAT_B", "DATD", "DATP", "VDAT", "DK", "MFOA", "NLSA", "NAM_A", "MFOB", "NLSB", "NAM_B", "NAZN", "ND", "S", "D_REC", "SOS", "BLK", "VOB", "NAZNK", "NAZNS", "ID_A", "ID_B", "ID_O", "BIS", "KV", "REC_A", "REC_B", "NAME_A", "NAME_B") AS 
  SELECT x0.rec,
          x0.REF,
          x0.ref_a,
          x0.fn_a,
          x0.dat_a,
          x0.fn_b,
          x0.dat_b,
          x0.datd,
          x0.datp,
          x0.datp,
          x0.dk,
          x0.mfoa,
          x0.nlsa,
          x0.nam_a,
          x0.mfob,
          x0.nlsb,
          x0.nam_b,
          x0.nazn,
          x0.nd,
          x0.s,
          x0.d_rec,
          x0.sos,
          x0.blk,
          x0.vob,
          x0.naznk,
          x0.nazns,
          x0.id_a,
          x0.id_b,
          x0.id_o,
          x0.bis,
          x0.kv,
          x0.rec_a,
          x0.rec_b,
          B0.NB NAMEA,
          B1.NB NAMEB
     FROM arc_rrp x0, banks b0, banks b1
     WHERE X0.MFOA = B0.MFO AND X0.MFOB = B1.MFO;

PROMPT *** Create  grants  V_ARCHIVE_DOCS ***
grant SELECT                                                                 on V_ARCHIVE_DOCS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_ARCHIVE_DOCS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ARCHIVE_DOCS  to START1;
grant SELECT                                                                 on V_ARCHIVE_DOCS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ARCHIVE_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
