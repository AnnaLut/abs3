

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MONEXRI.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view MONEXRI ***

  CREATE OR REPLACE FORCE VIEW BARS.MONEXRI ("KOD_NBU", "FDAT1", "FDAT2", "FL", "RU", "NAME_RU", "KV", "OB22", "S_2909", "K_2909", "EK_2909", "S_2809", "K_2809", "EK_2809", "S_0000", "K_0000", "EK_0000", "I_2909", "R_2809", "RK_2809", "ERK_2809", "S_3739") AS 
  SELECT i.kod_nbu,
          i.FDAT1,
          i.FDAT2,
          i.fl,
          NVL (i.RU, -1),
          NVL (r.name, 'Íå âèçí.êîä ÐÓ'),
          i.KV,
          i.ob22,
          i.S_2909,
          i.K_2909,
          i.ek_2909,
          i.S_2809,
          i.K_2809,
          i.ek_2809,
          i.S_0000,
          i.K_0000,
          i.ek_0000,
          i.I_2909,
          i.R_2809,
          i.RK_2809,
          i.ERK_2809,
          i.S_3739
     FROM (  SELECT r.kod_nbu,
                    MIN (r.FDAT) fdat1,
                    MAX (r.FDAT) fdat2,
                    r.fl,
                    mfo_ru (SUBSTR (r.branch, 2, 6)) RU,
                    r.kv,
                    r.ob22,
                    SUM (r.S_2909) S_2909,
                    SUM (NVL2 (c.CCLC, 0, r.K_2909)) k_2909,
                    SUM (NVL2 (c.CCLC, r.K_2909, 0)) ek_2909,
                    SUM (r.S_2809) S_2809,
                    SUM (NVL2 (c.CCLC, 0, r.k_2809)) k_2809,
                    SUM (NVL2 (c.CCLC, r.k_2809, 0)) ek_2809,
                    SUM (r.S_0000) S_0000,
                    SUM (NVL2 (c.CCLC, 0, r.K_0000)) k_0000,
                    SUM (NVL2 (c.CCLC, r.k_0000, 0)) ek_0000,
                    SUM (r.S_2909 + NVL2 (c.CCLC, 0, r.K_2909)) I_2909,
                    SUM (r.S_2809 + r.S_0000) R_2809,
                    SUM (
                       NVL2 (c.CCLC, 0, r.K_2809) + NVL2 (c.CCLC, 0, r.K_0000))
                       RK_2809,
                    SUM (
                       NVL2 (c.CCLC, r.K_2809, 0) + NVL2 (c.CCLC, r.K_0000, 0))
                       ERK_2809,
                    SUM (
                         r.S_2809
                       + r.S_0000
                       + NVL2 (c.CCLC, 0, r.K_2809)
                       + NVL2 (c.CCLC, 0, r.K_0000)
                       - r.S_2909
                       - NVL2 (c.CCLC, 0, r.K_2909))
                       S_3739
               FROM monexr r
                    INNER JOIN V_SFDAT v ON r.fdat >= v.B AND r.fdat <= v.E
                    LEFT JOIN monex0 m ON m.KOD_NBU = r.KOD_NBU
                    LEFT JOIN
                    SWI_MTI_LIST l
                       ON     NVL (l.OB22_2909, '0') = NVL (m.OB22, '0')
                          AND NVL (l.OB22_2809, '0') = NVL (m.OB22_2809, '0')
                          AND NVL (l.OB22_KOM, '0') = NVL (m.OB22_KOM, '0')
                          AND NVL (l.KOD_NBU, '0') = NVL (m.KOD_NBU, '0')
                    LEFT JOIN SWI_MTI_CURR c ON l.NUM = c.NUM AND c.kv = r.kv
           GROUP BY r.kod_nbu,
                    r.fl,
                    mfo_ru (SUBSTR (r.branch, 2, 6)),
                    r.kv,
                    r.ob22) i
          LEFT JOIN banks_ru r ON i.ru = r.ru
   UNION ALL
     SELECT r.kod_nbu,
            MIN (r.FDAT) fdat1,
            MAX (r.FDAT) fdat2,
            r.fl,
            TO_NUMBER (NULL) RU,
            'ÐÀÇÎÌ ïî Ñèñò+Âàë',
            r.KV,
            r.ob22,
            SUM (r.S_2909) S_2909,
            SUM (NVL2 (c.CCLC, 0, r.K_2909)) k_2909,
            SUM (NVL2 (c.CCLC, r.K_2909, 0)) ek_2909,
            SUM (r.S_2809) S_2809,
            SUM (NVL2 (c.CCLC, 0, r.k_2809)) k_2809,
            SUM (NVL2 (c.CCLC, r.k_2809, 0)) ek_2809,
            SUM (r.S_0000) S_0000,
            SUM (NVL2 (c.CCLC, 0, r.K_0000)) k_0000,
            SUM (NVL2 (c.CCLC, r.k_0000, 0)) ek_0000,
            SUM (r.S_2909 + NVL2 (c.CCLC, 0, r.K_2909)) I_2909,
            SUM (r.S_2809 + r.S_0000) R_2809,
            SUM (NVL2 (c.CCLC, 0, r.K_2809) + NVL2 (c.CCLC, 0, r.K_0000))
               RK_2809,
            SUM (NVL2 (c.CCLC, r.K_2809, 0) + NVL2 (c.CCLC, r.K_0000, 0))
               ERK_2809,
            SUM (
                 r.S_2809
               + r.S_0000
               + NVL2 (c.CCLC, 0, r.K_2809)
               + NVL2 (c.CCLC, 0, r.K_0000)
               - r.S_2909
               - NVL2 (c.CCLC, 0, r.K_2909))
               S_3739
       FROM monexr r
            INNER JOIN V_SFDAT v ON r.fdat >= v.B AND r.fdat <= v.E
            LEFT JOIN monex0 m ON m.KOD_NBU = r.KOD_NBU
            LEFT JOIN
            SWI_MTI_LIST l
               ON     NVL (l.OB22_2909, '0') = NVL (m.OB22, '0')
                  AND NVL (l.OB22_2809, '0') = NVL (m.OB22_2809, '0')
                  AND NVL (l.OB22_KOM, '0') = NVL (m.OB22_KOM, '0')
                  AND NVL (l.KOD_NBU, '0') = NVL (m.KOD_NBU, '0')
            LEFT JOIN SWI_MTI_CURR c ON l.NUM = c.NUM AND c.kv = r.kv
   GROUP BY r.kod_nbu,
            r.fl,
            r.kv,
            r.ob22
   UNION ALL
     SELECT r.kod_nbu,
            MIN (r.FDAT) fdat1,
            MAX (r.FDAT) fdat2,
            r.fl,
            TO_NUMBER (NULL) RU,
            'ÐÀÇÎÌ ïî êîì. äîõ. ÂÏ â ãðí.',
            980 kv,
            r.ob22,
            0 S_2909,
            0 k_2909,
            SUM (NVL2 (c.CCLC, r.K_2909, 0)) ek_2909,
            0 S_2809,
            0 k_2809,
            SUM (NVL2 (c.CCLC, r.k_2809, 0)) ek_2809,
            0 S_0000,
            0 k_0000,
            SUM (NVL2 (c.CCLC, r.k_0000, 0)) ek_0000,
            0 I_2909,
            0 R_2809,
            0 RK_2809,
            SUM (NVL2 (c.CCLC, r.K_2809, 0) + NVL2 (c.CCLC, r.K_0000, 0))
               ERK_2809,
            SUM (
                 -NVL2 (c.CCLC, r.K_2909, 0)
               + NVL2 (c.CCLC, r.k_2809, 0)
               + NVL2 (c.CCLC, r.k_0000, 0))
               S_3739
       FROM monexr r
            INNER JOIN V_SFDAT v ON r.fdat >= v.B AND r.fdat <= v.E
            LEFT JOIN monex0 m ON m.KOD_NBU = r.KOD_NBU
            LEFT JOIN
            SWI_MTI_LIST l
               ON     NVL (l.OB22_2909, '0') = NVL (m.OB22, '0')
                  AND NVL (l.OB22_2809, '0') = NVL (m.OB22_2809, '0')
                  AND NVL (l.OB22_KOM, '0') = NVL (m.OB22_KOM, '0')
                  AND NVL (l.KOD_NBU, '0') = NVL (m.KOD_NBU, '0')
            LEFT JOIN SWI_MTI_CURR c ON l.NUM = c.NUM AND c.kv = r.kv
   GROUP BY r.kod_nbu, r.fl, r.ob22;

PROMPT *** Create  grants  MONEXRI ***
grant SELECT                                                                 on MONEXRI         to BARSREADER_ROLE;
grant SELECT                                                                 on MONEXRI         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEXRI         to START1;
grant SELECT                                                                 on MONEXRI         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MONEXRI.sql =========*** End *** ======
PROMPT ===================================================================================== 
