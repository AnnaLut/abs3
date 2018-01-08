

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_Z.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_PROVODKI_Z ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_PROVODKI_Z ("PDAT", "NAZN", "SOS", "VOB", "FDAT", "REF", "TT", "KV", "NLSD", "NLSK", "S", "SQ", "OB_D", "NMSD", "OB_K", "NMSK") AS 
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
     FROM (select * from oper where vob = 96 ) o,
          accounts ad,
          accounts ak,
          (SELECT *
             FROM PART_ZVT_DOC
            WHERE     nlsD LIKE PUL.GET ('D') || '%'
                  AND nlsK LIKE PUL.GET ('K') || '%'
                  AND fdat = pul_BD) z
    WHERE     ad.nls = z.nlsd
          AND ad.kv = z.kv
          AND ak.nls = z.nlsk
          AND ak.kv = z.kv
          AND o.REF = z.REF;

PROMPT *** Create  grants  VAL_PROVODKI_Z ***
grant SELECT                                                                 on VAL_PROVODKI_Z  to BARSREADER_ROLE;
grant SELECT                                                                 on VAL_PROVODKI_Z  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_PROVODKI_Z  to START1;
grant SELECT                                                                 on VAL_PROVODKI_Z  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_Z.sql =========*** End ***
PROMPT ===================================================================================== 
