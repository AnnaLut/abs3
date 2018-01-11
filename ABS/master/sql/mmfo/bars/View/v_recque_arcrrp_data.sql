

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RECQUE_ARCRRP_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RECQUE_ARCRRP_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RECQUE_ARCRRP_DATA ("MFOA", "MFOB", "NLSA", "NLSB", "NAM_A", "NAM_B", "S", "KV", "DK", "NAZN", "REC", "BLK", "N", "REF", "FN_A", "DATD", "REC_A", "BIS", "VOB", "ND", "REF_A", "ID_A", "ID_B", "PRTY", "OTM", "SIGN", "DAT_A") AS 
  SELECT arc_rrp.mfoa,
            arc_rrp.mfob,
            arc_rrp.nlsa,
            arc_rrp.nlsb,
            arc_rrp.nam_a,
            arc_rrp.nam_b,
            arc_rrp.s,
            arc_rrp.kv,
            arc_rrp.dk,
            arc_rrp.nazn,
            arc_rrp.rec,
            arc_rrp.blk,
            1 n,
            arc_rrp.REF,
            arc_rrp.fn_a,
            arc_rrp.datd,
            arc_rrp.rec_a,
            arc_rrp.bis,
            arc_rrp.vob,
            arc_rrp.nd,
            arc_rrp.ref_a,
            arc_rrp.id_a,
            arc_rrp.id_b,
            NVL (arc_rrp.prty, 0) prty,
            rec_que.otm,
            arc_rrp.SIGN,
            arc_rrp.dat_a
       FROM rec_que, arc_rrp
      WHERE     arc_rrp.s > 0
            AND arc_rrp.blk > 0
            AND arc_rrp.fn_b IS NULL
            AND arc_rrp.rec = rec_que.rec
   ORDER BY arc_rrp.blk
;

PROMPT *** Create  grants  V_RECQUE_ARCRRP_DATA ***
grant SELECT                                                                 on V_RECQUE_ARCRRP_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_RECQUE_ARCRRP_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RECQUE_ARCRRP_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RECQUE_ARCRRP_DATA.sql =========*** E
PROMPT ===================================================================================== 
