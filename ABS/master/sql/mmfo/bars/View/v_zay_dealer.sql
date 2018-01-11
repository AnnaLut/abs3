

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DEALER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DEALER ("SOS", "KV", "PR", "SB", "SBQ", "SS", "SSQ") AS 
  select decode(z.sos, 0, 0, 1), z.kv2,
       decode(iif_d(trunc(d.dat), trunc(sysdate), 0, 1, 0) *
              iif_d(z.fdat, bankdate, 1, 1, 0) *
              iif_n((d.kurs_s - z.kurs_z) * (z.kurs_z - d.kurs_b), 0, 0, 1, 1),
              0,
              decode(z.priority, 2, 1, 0) * iif_d(z.fdat, bankdate, 1, 1, 0),
              1),
       sum(iif_n(z.dk, 1, 0, z.s2, 0)),
       sum(iif_n(z.dk, 1, 0, z.s2*z.kurs_z, 0)),
       sum(iif_n(z.dk, 1, 0, 0, z.s2)),
       sum(iif_n(z.dk, 1, 0, 0, z.s2*z.kurs_z))
  from v_zay_queue z,
       (select dat, kv, kurs_s, kurs_b
          from diler_kurs
         where (kv, dat) in (select kv, max(dat)
                               from diler_kurs
                              where dat between trunc(sysdate) and
                                                trunc(sysdate)+0.99999
                              group by kv)) d
 where d.kv(+) = z.kv2
   and (z.viza >= 1  and z.priority = 0 or
        z.viza  = 2  and z.priority > 0)
 group by z.sos, z.kv2,
          decode(iif_d(trunc(d.dat), trunc(sysdate), 0, 1, 0) *
                 iif_d(z.fdat, bankdate, 1, 1, 0) *
                 iif_n((d.kurs_s - z.kurs_z) * (z.kurs_z - d.kurs_b), 0, 0, 1, 1),
                 0,
                 decode(z.priority, 2, 1, 0) * iif_d(z.fdat, bankdate, 1, 1, 0),
                 1);

PROMPT *** Create  grants  V_ZAY_DEALER ***
grant SELECT                                                                 on V_ZAY_DEALER    to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_DEALER    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_DEALER    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ZAY_DEALER    to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_DEALER    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DEALER.sql =========*** End *** =
PROMPT ===================================================================================== 
