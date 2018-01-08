

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KASS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KASS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KASS ("NSM", "BRANCH", "NAME", "DAT2", "IDZ", "SVID", "KV", "KODV", "NAMEV", "S1", "K2", "K3", "K4", "NOMS", "CENA", "VID", "SOS", "IDS", "REFA", "REFB", "SUMK_REF", "IDM", "D", "DD") AS 
  SELECT KAS_ZV.NSM,
            KAS_ZV.BRANCH,
            b.NAME,
            KAS_ZV.DAT2,
            KAS_ZV.IDZ,
            KAS_ZV.SVID,
            KAS_ZV.KV,
            KAS_ZV.KODV,
            CASE
               WHEN kas_zv.vid = 1 THEN tv.name
               WHEN kas_zv.vid = 2 THEN bm.namev
               WHEN kas_zv.vid = 3 THEN spr.namev
               WHEN kas_zv.vid = 4 THEN vb.namev
            END
               namev,
            CASE
               WHEN kas_zv.vid = 2 THEN bm.s1 * KAS_ZV.k2
               WHEN kas_zv.vid = 3 THEN spr.s1 * KAS_ZV.k3
               WHEN kas_zv.vid = 4 THEN KAS_ZV.K4
               ELSE KAS_ZV.S1
            END
               s1,
            KAS_ZV.k2,
            KAS_ZV.K3,
            KAS_ZV.K4,
            ku.noms,
            CASE
               WHEN kas_zv.vid = 2 THEN bm.cena
               WHEN kas_zv.vid = 3 THEN spr.cena
               WHEN kas_zv.vid = 4 THEN 1
            END
               cena,
            KAS_ZV.VID,
            KAS_ZV.SOS,
            KAS_ZV.IDS,
            KAS_ZV.refa,
            KAS_ZV.refb,
            0 sumk_ref,
            KAS_ZV.IDM,
            KAS_ZV.IDZ d,
            KAS_ZV.IDS dd

       FROM KAS_ZV
            JOIN branch b ON KAS_ZV.BRANCH = b.branch
            LEFT JOIN tabval tv ON tv.kv = kas_zv.kv AND kas_zv.vid = 1
            LEFT JOIN (SELECT kod,
                              ROUND (NVL (ves_un, ves / 31.1034807), 2) S1,
                              ROUND (NVL (ves_un, ves / 31.1034807), 2) CENA,
                              name NAmEV
                         FROM BANK_METALS) bm
               ON bm.kod = KAS_ZV.KODV AND kas_zv.vid = 2
            LEFT JOIN (SELECT KOD_MONEY,
                              DECODE (PR_KUPON, NULL, NOMINAL, 0) S1,
                              DECODE (PR_KUPON, NULL, NOMINAL, 0) CENA,
                              NAMEMONEY NAMEV
                         FROM spr_mon) spr
               ON kas_zv.vid = 3 AND spr.KOD_MONEY = KAS_ZV.KODV
            LEFT JOIN (SELECT ob22, NAME namev FROM valuables) vb
               ON kas_zv.vid = 4 AND vb.ob22 = KAS_ZV.KODV
            LEFT JOIN (SELECT ids, noms FROM kas_u) ku ON ku.ids = KAS_ZV.ids
      WHERE KAS_ZV.SOS IN (1)
   ORDER BY KAS_ZV.SOS,
            KAS_ZV.BRANCH,
            KAS_ZV.DAT2,
            KAS_ZV.VID,
            KAS_ZV.IDZ;

PROMPT *** Create  grants  V_KASS ***
grant SELECT                                                                 on V_KASS          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KASS          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KASS          to PYOD001;
grant SELECT                                                                 on V_KASS          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KASS.sql =========*** End *** =======
PROMPT ===================================================================================== 
