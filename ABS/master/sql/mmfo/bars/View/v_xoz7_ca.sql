

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZ7_CA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZ7_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZ7_CA ("BR7", "OB7", "NLS7", "NMS7", "S7", "KODZ", "OB40", "RI", "OB3", "TRZ", "MFOA", "NLSA", "S", "NAZN") AS 
  SELECT a7.branch BR7,
          a7.ob22 OB7,
          a7.nls nls7,
          a7.nms nms7,
          0 S7,
          NULL kodz,
          NULL ob40,
          NULL RI,
          x.ob22 OB3,
          x.nlsb TRZ,
          x.mfoa,
          x.nlsa,
          x.s / 100 S,
          x.nazn
     FROM (SELECT SUBSTR (xoz.DREC (D_REC, 'OB'), 1, 2) ob22,
                  s,
                  nlsb,
                  mfoa,
                  nlsa,
                  nazn,
                  rec
             FROM arc_rrp
            WHERE rec = TO_NUMBER (pul.get ('RECD_CA'))) x,
          (  SELECT a.*
               FROM accounts a, xoz_ob22 z
              WHERE     z.deb = pul.get ('PROD')
                    AND z.krd = a.nbs || a.ob22
                    AND a.dazs IS NULL
                    AND a.kv = 980
           ORDER BY a.nls) a7
   UNION ALL
   SELECT a7.branch BR7,
          a7.ob22 OB7,
          a7.nls nls7,
          a7.nms nms7,
          a7.S7 / 100 s7,
          a7.kodz,
          a7.ob40,
          a7.RI,
          x.ob22 OB3,
          x.nlsb TRZ,
          x.mfoa,
          x.nlsa,
          x.s / 100 S,
          a7.nazn
     FROM (SELECT SUBSTR (xoz.DREC (D_REC, 'OB'), 1, 2) ob22,
                  s,
                  nlsb,
                  mfoa,
                  nlsa,
                  nazn,
                  rec
             FROM arc_rrp
            WHERE rec = TO_NUMBER (pul.get ('RECD_CA'))) x,
          (SELECT a.branch,
                  a.ob22,
                  a.nls,
                  a.nms,
                  Z.S7,
                  z.nazn,
                  z.kodz,
                  z.ob40,
                  z.ROWID RI
             FROM accounts a, xoz7_ca z
            WHERE     a.acc = z.acc7
                  AND a.dazs IS NULL
                  AND a.kv = 980
                  AND z.rec = TO_NUMBER (pul.get ('RECD_CA'))) a7;

PROMPT *** Create  grants  V_XOZ7_CA ***
grant SELECT                                                                 on V_XOZ7_CA       to BARSREADER_ROLE;
grant SELECT                                                                 on V_XOZ7_CA       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZ7_CA       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZ7_CA.sql =========*** End *** ====
PROMPT ===================================================================================== 
