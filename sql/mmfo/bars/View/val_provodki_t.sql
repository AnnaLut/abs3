

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_T.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_PROVODKI_T ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_PROVODKI_T ("PDAT", "NAZN", "SOS", "VOB", "FDAT", "REF", "TT", "KV", "NLSD", "NLSK", "S", "SQ", "OB_D", "NMSD", "OB_K", "NMSK") AS 
  SELECT o.PDAT,
          o.NAZN,
          o.sos,
          o.VOB,
          z.FDAT,
          z.REF,
          z.TT,
          z.KV,
          z.NLSD,
          z.NLSK,
          z.S / 100 s,
          z.SQ / 100 sq,
          ad.ob22 OB_D,
          ad.NMS nmsD,
          ak.ob22 OB_K,
          ak.nms NMSK
     FROM (select * from oper  ) o,
          (select * from operw where tag = PUL.GET ('TAG') ) w,
          accounts ad,
          accounts ak,
          (SELECT * FROM PART_ZVT_DOC
            WHERE     nlsD LIKE PUL.GET ('D') || '%'
                  AND nlsK LIKE PUL.GET ('K') || '%'
                  AND fdat = pul_BD) z
    WHERE     ad.nls = z.nlsd
          AND ad.kv = z.kv
          AND ak.nls = z.nlsk
          AND ak.kv = z.kv
          AND o.REF = z.REF
          and w.ref = z.ref;

PROMPT *** Create  grants  VAL_PROVODKI_T ***
grant SELECT                                                                 on VAL_PROVODKI_T  to BARSREADER_ROLE;
grant SELECT                                                                 on VAL_PROVODKI_T  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_PROVODKI_T  to START1;
grant SELECT                                                                 on VAL_PROVODKI_T  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_T.sql =========*** End ***
PROMPT ===================================================================================== 
