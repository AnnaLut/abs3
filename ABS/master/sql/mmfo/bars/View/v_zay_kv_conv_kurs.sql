

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_KV_CONV_KURS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_KV_CONV_KURS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_KV_CONV_KURS ("NAME_KV1", "KV1", "NAME_KV2", "KV2", "KURS_I", "KURS_F") AS 
  SELECT t1.name name_kv1,
          c.kv1,
          t2.name name_kv2,
          c.kv2,
          (SELECT kurs_i
             FROM diler_kurs_conv
            WHERE     TRUNC (dat) = TRUNC (SYSDATE)
                  AND kv1 = c.kv1
                  AND kv2 = c.kv2)
             kurs_i,
          (SELECT kurs_f
             FROM diler_kurs_conv
            WHERE     TRUNC (dat) = TRUNC (SYSDATE)
                  AND kv1 = c.kv1
                  AND kv2 = c.kv2)
             kurs_f
     FROM zay_conv_kv c, tabval t1, tabval t2
    WHERE c.kv1 = t1.kv AND c.kv2 = t2.kv;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_KV_CONV_KURS.sql =========*** End
PROMPT ===================================================================================== 
