

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_TOTALS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_TOTALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_TOTALS ("TIP", "VIDD", "KV", "ID", "CP_ID", "DATP", "CENA", "CENAK", "CENAP", "CENAA", "N1", "N2", "OSTN", "R1", "R2", "R3", "R4", "OSTR", "D1", "D2", "D3", "OSTD", "P1", "P2", "P3", "OSTP", "KF") AS 
  SELECT TIP,
            VIDD,
            KV,
            ID,
            CP_ID,
            DATP,
            round(CENA,2),
            round(CASE
               WHEN N1 != 0 THEN ROUND ( ( (N1 + R1 + P1 - D1) / N1) * CENA, 2)
               ELSE 0
            END,2)
               AS CENAK,
            round(CASE
               WHEN N2 != 0 THEN ROUND ( ( (N2 + R2 + P2 - D2) / N2) * CENA, 2)
               ELSE NULL
            END,2)
               AS CENAP,
            round(CASE
               WHEN OSTN != 0
               THEN
                  ROUND ( ( (OSTN + OSTR + OSTP - OSTD) / OSTN) * CENA, 2)
               ELSE
                  NULL
            END,2)
               AS CENAA,
            round(N1,2),
            round(N2,2),
            round(OSTN,2),
            round(R1,2),
            round(R2,2),
            round(R3,2),
            round(R4,2),
            round(OSTR,2),
            round(D1,2),
            round(D2,2),
            round(D3,2),
            round(OSTD,2),
            round(P1,2),
            round(P2,2),
            round(P3,2),
            round(OSTP,2),
            round(KF,6)
       FROM (SELECT TIP,
                    VIDD,
                    ID,
                    CP_ID,
                    DATP,
                    CENA,
                    KV,
                    N1,
                    R1,
                    D1,
                    P1,
                    N2,
                    R3,
                    D3,
                    P3,
                    R4,
                    OSTR R2,
                    OSTN,
                    OSTR,
                    OSTP,
                    OSTD,
                    (D1 - D3 - OSTD) D2,
                    (P1 - P3 - OSTP) P2,
                    CASE
                       WHEN KV = 980
                       THEN
                          1
                       ELSE
                          (SELECT RATE_O / BSUM
                             FROM cur_rates cr
                            WHERE     cr.kv = KV
                                  AND vdate =
                                         (SELECT MAX (vdate)
                                            FROM cur_rates cr2
                                           WHERE cr2.kv = KV AND vdate <= gl.bd)
                                  AND ROWNUM = 1)
                    END
                       KF
               FROM (  SELECT cp_kod.TIP,
                              SUBSTR (a.nls, 1, 4) VIDD,
                              CP_KOD.ID,
                              CP_KOD.CP_ID,
                              a.mdate DATP,
                              CP_KOD.CENA,
                              a.KV,
                              SUM (c.N) / 100 N1,
                              SUM (c.R) / 100 R1,
                              SUM (c.D) / 100 D1,
                              SUM (c.P) / 100 P1,
                              (SELECT NVL (-SUM (R.ostc) / 100, 0)
                                 FROM accounts R, cp_deal e
                                WHERE e.id = CP_KOD.id AND e.accR = R.acc)
                                 OSTR,
                              (SELECT NVL (-SUM (D.ostc) / 100, 0)
                                 FROM accounts D, cp_deal e
                                WHERE e.id = CP_KOD.id AND e.accD = D.acc)
                                 OSTD,
                              (SELECT NVL (-SUM (P.ostc) / 100, 0)
                                 FROM accounts P, cp_deal e
                                WHERE e.id = CP_KOD.id AND e.accP = P.acc)
                                 OSTP,
                              (SELECT NVL (-SUM (N.ostc) / 100, 0)
                                 FROM accounts N, cp_deal e
                                WHERE e.id = CP_KOD.id AND e.acc = N.acc)
                                 OSTN,
                              (SELECT NVL (SUM (c.N) / 100, 0)
                                 FROM CP_ARCH c, oper o
                                WHERE     c.OP = 2
                                      AND c.REF = o.REF
                                      AND o.sos = 5
                                      AND id = CP_KOD.ID)
                                 N2,
                              (SELECT NVL (SUM (c.R) / 100, 0)
                                 FROM CP_ARCH c, oper o
                                WHERE     c.OP = 2
                                      AND c.REF = o.REF
                                      AND o.sos = 5
                                      AND id = CP_KOD.ID)
                                 R3,
                              (SELECT NVL (SUM (c.D) / 100, 0)
                                 FROM CP_ARCH c, oper o
                                WHERE     c.OP = 2
                                      AND c.REF = o.REF
                                      AND o.sos = 5
                                      AND id = CP_KOD.ID)
                                 D3,
                              (SELECT NVL (SUM (c.P) / 100, 0)
                                 FROM CP_ARCH c, oper o
                                WHERE     c.OP = 2
                                      AND c.REF = o.REF
                                      AND o.sos = 5
                                      AND id = CP_KOD.ID)
                                 P3,
                              (SELECT NVL (SUM (c.R) / 100, 0)
                                 FROM CP_ARCH c, oper o
                                WHERE     c.OP = 3
                                      AND c.REF = o.REF
                                      AND o.sos = 5
                                      AND id = CP_KOD.ID)
                                 R4
                         FROM CP_ARCH c,
                              oper o,
                              CP_KOD,
                              accounts a
                        WHERE     c.acc = a.acc
                              AND c.OP = cp_kod.TIP
                              AND c.REF = o.REF
                              AND o.sos = 5
                              AND c.id = CP_KOD.id
                              AND CP_KOD.id IN (SELECT id
                                                  FROM cp_kod
                                                 WHERE id > 0)
                     GROUP BY cp_kod.TIP,
                              SUBSTR (a.nls, 1, 4),
                              CP_KOD.ID,
                              CP_KOD.CP_ID,
                              a.mdate,
                              CP_KOD.CENA,
                              a.KV))
   ORDER BY TIP, VIDD, ID;

PROMPT *** Create  grants  V_CP_TOTALS ***
grant SELECT                                                                 on V_CP_TOTALS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_TOTALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_TOTALS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_TOTALS.sql =========*** End *** ==
PROMPT ===================================================================================== 
