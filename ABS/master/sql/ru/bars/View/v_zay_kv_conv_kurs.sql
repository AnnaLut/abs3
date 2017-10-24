CREATE OR REPLACE FORCE VIEW bars.v_zay_kv_conv_kurs
(
   name_kv1,
   kv1,
   name_kv2,
   kv2,
   kurs_i,
   kurs_f
)
AS
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
          
grant select on bars.v_zay_kv_kurs to bars_access_defrole;