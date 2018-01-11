

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_YY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_PROVODKI_YY ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_PROVODKI_YY ("PDAT", "FDAT", "REF", "TT", "KV", "OB_D", "NLSD", "NMSD", "OB_K", "NLSK", "NMSK", "S", "SQ", "NAZN", "SOS", "VOB") AS 
  SELECT n.PDAT,
          i.FDAT,
          i.REF,
          i.TT,
          i.KV,
          i.OB_D,
          i.NLSD,
          i.NMSD,
          i.OB_K,
          i.NLSK,
          i.NMSK,
          i.S,
          i.SQ,
          n.NAZN,
          n.sos,
          n.VOB
     FROM (SELECT *
             FROM oper nn
            WHERE     nazn LIKE PUL.GET ('Y')
                  AND EXISTS
                         (SELECT 1
                            FROM opldok
                           WHERE     fdat =
                                        NVL (
                                           TO_DATE (pul.get ('BD'),
                                                    'dd.mm.yyyy'),
                                           gl.bd)
                                 AND REF = nn.REF)) n,
          (SELECT oo.FDAT,
                  oo.REF,
                  oo.TT,
                  ad.KV,
                  oo.S / 100 S,
                  oo.SQ / 100 SQ,
                  ad.ob22 OB_D,
                  ad.nls NLSD,
                  ad.nms NMSD,
                  ak.ob22 OB_K,
                  ak.nls NLSK,
                  ak.nms NMSK
             FROM (  SELECT REF,
                            stmt,
                            fdat,
                            tt,
                            s,
                            sq,
                            SUM (DECODE (dk, 0, acc, 0)) ACCD,
                            SUM (DECODE (dk, 1, acc, 0)) ACCk
                       FROM opldok pp
                      WHERE     fdat =
                                   NVL (TO_DATE (pul.get ('BD'), 'dd.mm.yyyy'),
                                        gl.bd)
                            AND EXISTS
                                   (SELECT 1
                                      FROM oper
                                     WHERE     REF = pp.REF
                                           AND nazn LIKE PUL.GET ('Y'))
                   GROUP BY REF,
                            stmt,
                            fdat,
                            tt,
                            s,
                            sq) oo,
                  (SELECT *
                     FROM accounts
                    WHERE nls LIKE PUL.GET ('D') || '%') ad,
                  (SELECT *
                     FROM accounts
                    WHERE nls LIKE PUL.GET ('K') || '%') ak
            WHERE ad.acc = oo.accD AND ak.acc = oo.accK) i
    WHERE i.REF = n.REF;

PROMPT *** Create  grants  VAL_PROVODKI_YY ***
grant SELECT                                                                 on VAL_PROVODKI_YY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_YY.sql =========*** End **
PROMPT ===================================================================================== 
