

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_LST_FULL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_LST_FULL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_LST_FULL ("ACC", "NLS", "KV", "NMS", "ISP", "DAT0A", "DAT0B", "RKO_S0", "KOLDOK", "DAT1B", "A1_OSTC", "DAT2B", "A2_OSTC", "NLS_SP", "KV_SP", "ACCD", "COMM", "ACC1", "R1", "ACC2", "R2") AS 
  select a.acc,
            a.nls,
            a.kv,
            a.nms,
            a.isp,
            r.dat0a,
            r.dat0b,
            r.s0 / 100 as rko_s0,
            r.koldok,
            dat1b,
            -a1.ostc / 100 as a1_ostc,
            dat2b,
            -a2.ostc / 100 as a2_ostc,
            nvl (a0.nls, a.nls) as nls_sp,
            nvl (a0.kv, a.kv) as kv_sp,
            r.accd,
            r.comm,
            r.acc1,
            row_number () over (partition by r.acc1 order by r.acc1) r1,
            r.acc2,
            row_number () over (partition by r.acc2 order by r.acc2) r2
       from rko_lst  r,
            accounts a,
            accounts a0,
            accounts a1,
            accounts a2
      where     r.acc = a.acc
            and r.accd = a0.acc(+)
            and r.acc1 = a1.acc(+)
            and r.acc2 = a2.acc(+)
   order by substr (a.nls, 1, 4) || substr (a.nls, 6), a.kv;

PROMPT *** Create  grants  V_RKO_LST_FULL ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_RKO_LST_FULL  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_LST_FULL.sql =========*** End ***
PROMPT ===================================================================================== 
