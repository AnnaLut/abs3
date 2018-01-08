

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_LST_FULL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_LST_FULL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_LST_FULL ("ACC", "NLS", "KV", "NMS", "ISP", "DAT0A", "DAT0B", "RKO_S0", "KOLDOK", "DAT1B", "A1_OSTC", "DAT2B", "A2_OSTC", "NLS_SP", "KV_SP", "ACCD", "COMM", "ACC1", "R1", "ACC2", "R2", "RNK") AS 
  SELECT a.acc,
            a.nls,
            a.kv,
            a.nms,
            a.isp,
            r.dat0a,
            r.dat0b,
            r.s0 / 100 AS rko_s0,
            r.koldok,
            dat1b,
            -a1.ostc / 100 AS a1_ostc,
            dat2b,
            -a2.ostc / 100 AS a2_ostc,
            NVL (a0.nls, a.nls) AS nls_sp,
            NVL (a0.kv, a.kv) AS kv_sp,
            r.accd,
            r.comm,
            r.acc1,
            ROW_NUMBER () OVER (PARTITION BY r.acc1 ORDER BY r.acc1) r1,
            r.acc2,
            ROW_NUMBER () OVER (PARTITION BY r.acc2 ORDER BY r.acc2) r2,
            a.rnk
       FROM rko_lst r,
            accounts a,
            accounts a0,
            accounts a1,
            accounts a2
      WHERE     r.acc = a.acc
            AND r.accd = a0.acc(+)
            AND r.acc1 = a1.acc(+)
            AND r.acc2 = a2.acc(+)
   ORDER BY SUBSTR (a.nls, 1, 4) || SUBSTR (a.nls, 6), a.kv;

PROMPT *** Create  grants  V_RKO_LST_FULL ***
grant SELECT                                                                 on V_RKO_LST_FULL  to BARSREADER_ROLE;
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_LST_FULL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RKO_LST_FULL  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_LST_FULL.sql =========*** End ***
PROMPT ===================================================================================== 
