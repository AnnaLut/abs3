

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEP_ODB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEP_ODB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEP_ODB ("ACC", "NBSOB22", "NLS", "KV", "NMS", "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "NACH", "ZACH", "RV7_N", "RV7_S", "RMV_OB", "NLS_CASE", "KV_980", "SK1", "SK2", "TT_P", "TT_DK") AS 
  SELECT acc, nbs || '/' || ob22 AS nbsob22, nls, kv, nms,
          'Прихід на вклад '     || nms a1,                                   -- Поповнення вкладу
          'Видано з вкладу '     || nms a2,                                   -- Видача з вкладу
          'Видано відсотки '     || nms a3,                                   -- Видача в?дсотк?в
          'Зараховано на вклад ' || nms a4,                                   -- Зарахування на вкладу
          'Списано з вкладу '    || nms a5,                                   -- Списано з вкладу
          'Нараховано % '        || nms a6,                                   -- Нарахувати %
          DECODE (zach,  NULL, '', 'Зараховано % '               || nms) a7,  -- Зарахувати %
          DECODE (rv7_s, NULL, '', 'Списано зайво нарахованi % ' || nms) a8,  -- Списано зайво нарахован? %
          DECODE (rv7_s, NULL, '', 'Списано зайво зарахованi % ' || nms) a9,  -- Списано зайво зарахован? %
          DECODE (rv7_s, NULL, '', 'Списано зайво виплаченi % '  || nms) a10, -- Списано зайво виплачен? %
          nach, zach, rv7_n, rv7_s, rmv_ob,
          branch_usr.get_branch_param2 ('CASH', 0) nls_case, '980' kv_980,
          '55' sk1, '16' sk2, DECODE (kv, 980, 515, 427) tt_p,
          DECODE (kv, 980, 0, 0) tt_dk
     FROM (SELECT   a.acc, a.nls, SUBSTR(a.nms, 1, 48) as nms, a.kv, (a.ostb/100) as zal_t,
                    nbs_ob22_odb (nbs_int, ob22_int) nach,
                    nbs_ob22_odb (nbs_ZAR, ob22_ZAR) zach,
                    nbs_ob22_odb (nbs_exp, ob22_exp) rv7_n,
                    nbs_ob22_odb (nbs_red, ob22_red) rv7_s,
                    nbs_ob22_odb (nbs_amr, ob22_amr) rmv_ob,
                    bsd nbs, m.ob22
               FROM (SELECT kv, bsd, ob22,
                            nbs_int, ob22_int,
                            nbs_exp, ob22_exp,
                            nbs_red, ob22_red,
                            DECODE (ob22_amr, NULL, '', nbs_amr) nbs_amr, ob22_amr,
                            DECODE (ob22_ZAR, NULL, '', nbs_int) nbs_ZAR, ob22_ZAR
                       FROM (SELECT DISTINCT                     --d.type_cod,
                                             d.kv, d.bsd, o.val ob22,
                                             d.bsn as nbs_int,
                                             (SELECT val FROM dpt_vidd_params WHERE vidd = o.vidd AND tag = 'INT_OB22') as ob22_int,
                                             DECODE (SUBSTR (d.bsd, 1, 3), '263', '7041', '7040') as nbs_exp,
                                             (SELECT val FROM dpt_vidd_params WHERE vidd = o.vidd AND tag = 'DB7_OB22') as ob22_exp,
                                             decode(newnbs.get_state, 0, '6399', '6350') as nbs_red,
                                             (SELECT val FROM dpt_vidd_params WHERE vidd = o.vidd AND tag = 'KR7_OB22') as ob22_red,
                                             '2636' as nbs_amr,
                                             (SELECT val FROM dpt_vidd_params WHERE vidd = o.vidd AND tag = 'AMR_OB22') as ob22_amr,
                                             d.bsn  as nbs_ZAR,
                                             DECODE (d.bsd, 2630, 11, 2620, (DECODE (o.val, 05, 15, 17, 14, 20, 14, 21, 14, '')), '') as ob22_ZAR
                                        FROM dpt_vidd_params o, dpt_vidd d
                                       WHERE o.tag = 'DPT_OB22'
                                         AND o.vidd = d.vidd
                                         AND d.vidd not in  ('98', '597', '479')
                            )
                    ) m,
                    v_gl a
              WHERE a.nbs = m.bsd
                AND a.ob22 = m.ob22
                AND a.kv = m.kv
                AND a.tip = 'ODB'
                AND a.dazs IS NULL
                AND a.branch = SYS_CONTEXT ('bars_context', 'user_branch')
           ORDER BY m.bsd, m.ob22, m.kv);

PROMPT *** Create  grants  V_DEP_ODB ***
grant SELECT                                                                 on V_DEP_ODB       to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_DEP_ODB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DEP_ODB       to RCC_DEAL;
grant SELECT                                                                 on V_DEP_ODB       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DEP_ODB       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_DEP_ODB       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEP_ODB.sql =========*** End *** ====
PROMPT ===================================================================================== 
