

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KAS_ZZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KAS_ZZ ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KAS_ZZ ("BRANCH", "DAT2", "IDM", "KODV", "SUM", "VDAT", "VID", "SOS") AS 
  SELECT DISTINCT              branch,
                             dat2,
                             idm,
                             kodv,
                             SUM (NVL (kz.s, kz.kol))
                                OVER (PARTITION BY kz.dat2,
                                                   kz.branch,
                                                   kz.kv,
                                                   kz.kodv,
                                                   kz.vdat,
                                                   kz.vid,
                                                   kz.sos
                                                   ) s_br_kv,
                             vdat,
                             vid,
                             sos
FROM v_kas_z kz
ORDER BY branch, kodv DESC;

PROMPT *** Create  grants  V_KAS_ZZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KAS_ZZ        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KAS_ZZ        to PYOD001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KAS_ZZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
