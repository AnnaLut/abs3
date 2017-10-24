

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DEALER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DEALER ("SOS", "KV", "PR", "SB", "SBQ", "SS", "SSQ") AS 
  SELECT   DECODE (z.sos, 0, 0, 1), z.kv2,
            DECODE (  iif_d (TRUNC (d.dat), TRUNC (SYSDATE), 0, 1, 0)
                    * iif_d (z.fdat, bankdate, 1, 1, 0)
                    * iif_n ((d.kurs_s - z.kurs_z) * (z.kurs_z - d.kurs_b),
                             0,
                             0,
                             1,
                             1
                            ),
                    0, DECODE (z.priority, 2, 1, 0)
                     * iif_d (z.fdat, bankdate, 1, 1, 0),
                    1
                   ),
            SUM (iif_n (z.dk, 1, 0, z.s2, 0)),
            SUM (iif_n (z.dk, 1, 0, z.s2 * z.kurs_z, 0)),
            SUM (iif_n (z.dk, 1, 0, 0, z.s2)),
            SUM (iif_n (z.dk, 1, 0, 0, z.s2 * z.kurs_z))
       FROM v_zay_queue z,
            (SELECT dat, kv, kurs_s, kurs_b
               FROM diler_kurs
              WHERE (kv, dat) IN (
                       SELECT   kv, MAX (dat)
                           FROM diler_kurs
                          WHERE dat BETWEEN TRUNC (SYSDATE)
                                        AND TRUNC (SYSDATE) + 0.99999
                       GROUP BY kv)) d
      WHERE d.kv(+) = z.kv2
        AND (z.viza >= 1 AND z.priority = 0 OR z.viza = 2 AND z.priority > 0
            )
   GROUP BY z.sos,
            z.kv2,
            DECODE (  iif_d (TRUNC (d.dat), TRUNC (SYSDATE), 0, 1, 0)
                    * iif_d (z.fdat, bankdate, 1, 1, 0)
                    * iif_n ((d.kurs_s - z.kurs_z) * (z.kurs_z - d.kurs_b),
                             0,
                             0,
                             1,
                             1
                            ),
                    0, DECODE (z.priority, 2, 1, 0)
                     * iif_d (z.fdat, bankdate, 1, 1, 0),
                    1
                   ) ;

PROMPT *** Create  grants  V_ZAY_DEALER ***
grant SELECT                                                                 on V_ZAY_DEALER    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY_DEALER    to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_DEALER    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER.sql =========*** End *** =
PROMPT ===================================================================================== 
