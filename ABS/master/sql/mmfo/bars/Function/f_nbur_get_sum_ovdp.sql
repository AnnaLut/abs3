CREATE OR REPLACE FUNCTION BARS.f_nbur_get_sum_ovdp (p_acc          IN NUMBER,
                                                     p_dat          IN DATE,
                                                     p_dat_ref_ovdp IN DATE DEFAULT NULL)
   RETURN NUMBER
-------------------------------------------------------------------
-- функція визначення справедливої вартості необтяжених ЦП
-------------------------------------------------------------------
-- ВЕРСІЯ: 04/12/2018 (30/11/2018)
-------------------------------------------------------------------
-- параметри:
--    p_acc - ідентифікатор рахунку
--    p_dat - на дату
--   p_dat_ref_ovdp - остання дата, за яку є дані в довіднику nbur_ovdp_6ex
-- повертає суму
----------------------------------------------------------------
IS
   l_sum    NUMBER;
   l_isin   VARCHAR2 (20);
BEGIN
   SELECT gl.p_icurval(
             s.kv,
             ROUND (
                  (ROUND(-fost (s.acc, p_dat) / 100 / f_cena_cp (s.id, p_dat, 0), 5) -- кількість всіх ЦП данного виду
                   - NVL (cp.get_from_cp_zal_kolz (s.ref, p_dat), 0) -- кількість обтяжених ЦП
                   )
                * fv_cp -- справедлива вартість одного ЦП
                * koef  -- коригуючий коефіцієнт
                * 100,
                0),
             p_dat)
             sum_nobt, -- сума необтяжених ЦП
          o.isin -- код ЦП
     INTO l_sum, l_isin
     FROM cp_v_zal_web s
     JOIN cp_kod c 
     ON (s.id = c.id)
     LEFT OUTER JOIN nbur_ovdp_6ex o
     ON (c.cp_id = o.isin AND o.date_fv = nvl(p_dat_ref_ovdp, p_dat))
   WHERE s.acc = p_acc;

   -- немає запису для даного виду ЦП в nbur_ovdp_6ex
   IF l_sum IS NULL AND l_isin IS NULL
   THEN
      SELECT gl.p_icurval(
             s.kv,
                  ROUND(-fost (s.acc, p_dat) / 100 / f_cena_cp (s.id, p_dat, 0), 5) -- кількість всіх ЦП данного виду
                   - NVL (cp.get_from_cp_zal_kolz (s.ref, p_dat), 0), -- кількість обтяжених ЦП
             p_dat)
             sum_nobt -- сума необтяжених ЦП
        INTO l_sum
        FROM cp_v_zal_web s
       WHERE s.acc = p_acc;
   END IF;

   RETURN l_sum;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END;
/