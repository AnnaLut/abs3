

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPA_CV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPA_CV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPA_CV ("NLS", "VID", "FDAT", "OPLDOK_REF", "MFO_D", "NLS_D", "MFO_K", "NLS_K", "DK", "S", "VOB", "ND", "KV", "DATD", "DATP", "NAM_A", "NAM_B", "NAZN", "D_REC", "NAZNK", "NAZNS", "ID_D", "ID_K", "REF", "DAT_A", "DAT_B") AS 
  WITH       
      acclist as (select nls, vid, acc, nbs from accounts a where nbs in (SELECT nbs FROM ps WHERE nbs LIKE '264_' AND LENGTH (LTRIM (RTRIM (nbs))) = 4)),
      saldolist as (select sa.acc, sa.fdat from saldoa sa, acclist a where sa.acc = a.acc),
      operlst as (select o.ref, o.acc, o.sos, o.fdat, o.dk from opldok o, saldolist sl where sl.fdat = o.fdat and sl.acc = o.acc and o.sos = 5)       
    SELECT s.nls nls,
          s.vid,
          p.fdat,
          p.ref as OPLDOK_REF,
          DECODE (r.dk, 1, r.mfoa, r.mfob) mfo_d,
          DECODE (r.dk, 1, r.nlsa, r.nlsb) nls_d,
          DECODE (r.dk, 1, r.mfob, r.mfoa) mfo_k,
          DECODE (r.dk, 1, r.nlsb, r.nlsa) nls_k,
          p.dk,
          r.s,
          r.vob,
          r.nd,
          r.kv,
          r.datd,
          NVL (arc.datp, r.datp) datp,
          DECODE (r.dk, 1, r.nam_a, r.nam_b) nam_a,
          DECODE (r.dk, 1, r.nam_b, r.nam_a) nam_b,
          r.nazn,
          arc.d_rec,
          arc.naznk,
          arc.nazns,
          DECODE (r.dk, 1, NVL (r.id_a, arc.id_a), NVL (r.id_b, arc.id_b))
             id_d,
          DECODE (r.dk, 1, NVL (r.id_b, arc.id_b), NVL (r.id_a, arc.id_a))
             id_k,
          NVL (arc.ref_a, to_char(r.REF)) REF,
          DECODE (p.dk, 1, NVL(ARC.dat_a, r.vdat), to_date(null)) as DAT_A,
          DECODE (p.dk, 1, to_date(null), NVL(ARC.dat_b, r.vdat)) as DAT_B
     FROM operlst p,
          acclist s,
          oper r,
          arc_rrp arc
    WHERE     p.acc = s.acc
          AND p.REF = r.REF          
          AND r.dk < 2
          AND r.REF = arc.REF(+)
          AND arc.dat_b(+) >= gl.bd - 10
          AND arc.dat_b(+) <= gl.bd + 1;

PROMPT *** Create  grants  V_DPA_CV ***
grant SELECT                                                                 on V_DPA_CV        to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPA_CV        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPA_CV        to START1;
grant SELECT                                                                 on V_DPA_CV        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPA_CV.sql =========*** End *** =====
PROMPT ===================================================================================== 
