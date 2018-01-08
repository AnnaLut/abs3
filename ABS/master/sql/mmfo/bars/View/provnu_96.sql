

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVNU_96.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVNU_96 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVNU_96 ("ACCD", "TT", "REF", "KV", "NLSD", "S", "SQ", "FDAT", "PDATF", "DATPF", "VDATF", "NAZN", "ACCK", "NLSK", "ISP", "VOB", "OTM", "STMT") AS 
  SELECT d1.acc, d1.tt, d1.REF, d2.kv,
          decode(d2.tip,'T00',o.nlsa,d2.nls),
          k1.s, k1.sq, d1.fdat,
          o.pdat,o.datp,o.vdat,
          DECODE (d1.tt, o.tt, o.nazn,
                    DECODE (d1.tt, 'PO3', o.nazn, t.NAME)),
          k1.acc,
          decode(k2.tip,'T00',o.nlsb,k2.nls),
          o.userid, o.vob, d1.otm,d1.stmt
     FROM oper o, tts t, opldok d1, opldok k1, accounts d2, accounts k2
    WHERE o.REF = d1.REF and o.vob=96   and d1.tt='PO3'
      AND t.tt = d1.tt
      AND d1.sos = 5
      AND d1.fdat = k1.fdat
      AND k1.sos = 5
      AND d1.REF = k1.REF
      AND d1.tt = k1.tt
      AND d1.acc = d2.acc
      AND k1.acc = k2.acc
      AND d2.kv = k2.kv
      AND d1.stmt = k1.stmt
      AND d1.dk = 0
      AND k1.dk = 1
      AND d1.s = k1.s
      AND d1.sq = k1.sq
 ;

PROMPT *** Create  grants  PROVNU_96 ***
grant SELECT                                                                 on PROVNU_96       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROVNU_96       to NALOG;
grant SELECT                                                                 on PROVNU_96       to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROVNU_96       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVNU_96.sql =========*** End *** ====
PROMPT ===================================================================================== 
