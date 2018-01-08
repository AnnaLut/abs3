

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KAS_P.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KAS_P ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KAS_P ("NAME", "GRP", "NLS", "OSTC", "OSTB", "PID", "SD") AS 
  SELECT   v.NAME, v.grp, a.nls, a.ostc / 100 * -1 ostc,
            a.ostb / 100 * -1 ostb,
            make_docinput_url ('TOX',
                               'Пiдкрипити',
                               'KV_A',
                               a.kv,
                               'KV_B',
                               a.kv
                              ) pid,
            make_docinput_url ('TOX', 'Здати', 'KV_A', a.kv, 'KV_B', a.kv) sd
       FROM v_gl a, tabval v
      WHERE a.nbs IN ('1001', '1002')
        AND a.ob22 = '01'
        AND a.branch = SYS_CONTEXT ('bars_context', 'user_branch')
        AND a.kv = v.kv
        and a.dazs is null
   ORDER BY v.grp, v.NAME;

PROMPT *** Create  grants  V_KAS_P ***
grant SELECT                                                                 on V_KAS_P         to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_KAS_P         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KAS_P         to RCC_DEAL;
grant SELECT                                                                 on V_KAS_P         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_KAS_P         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_KAS_P         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KAS_P.sql =========*** End *** ======
PROMPT ===================================================================================== 
