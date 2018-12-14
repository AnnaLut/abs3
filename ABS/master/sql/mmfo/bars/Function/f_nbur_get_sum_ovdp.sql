CREATE OR REPLACE FUNCTION BARS.f_nbur_get_sum_ovdp (p_acc          IN NUMBER,
                                                     p_dat          IN DATE,
                                                     p_dat_ref_ovdp IN DATE DEFAULT NULL)
   RETURN NUMBER
-------------------------------------------------------------------
-- ������� ���������� ����������� ������� ����������� ��
-------------------------------------------------------------------
-- ���Ѳ�: 04/12/2018 (30/11/2018)
-------------------------------------------------------------------
-- ���������:
--    p_acc - ������������� �������
--    p_dat - �� ����
--   p_dat_ref_ovdp - ������� ����, �� ��� � ��� � �������� nbur_ovdp_6ex
-- ������� ����
----------------------------------------------------------------
IS
   l_sum    NUMBER;
   l_isin   VARCHAR2 (20);
BEGIN
   SELECT gl.p_icurval(
             s.kv,
             ROUND (
                  (ROUND(-fost (s.acc, p_dat) / 100 / f_cena_cp (s.id, p_dat, 0), 5) -- ������� ��� �� ������� ����
                   - NVL (cp.get_from_cp_zal_kolz (s.ref, p_dat), 0) -- ������� ��������� ��
                   )
                * fv_cp -- ����������� ������� ������ ��
                * koef  -- ���������� ����������
                * 100,
                0),
             p_dat)
             sum_nobt, -- ���� ����������� ��
          o.isin -- ��� ��
     INTO l_sum, l_isin
     FROM cp_v_zal_web s
     JOIN cp_kod c 
     ON (s.id = c.id)
     LEFT OUTER JOIN nbur_ovdp_6ex o
     ON (c.cp_id = o.isin AND o.date_fv = nvl(p_dat_ref_ovdp, p_dat))
   WHERE s.acc = p_acc;

   -- ���� ������ ��� ������ ���� �� � nbur_ovdp_6ex
   IF l_sum IS NULL AND l_isin IS NULL
   THEN
      SELECT gl.p_icurval(
             s.kv,
                  ROUND(-fost (s.acc, p_dat) / 100 / f_cena_cp (s.id, p_dat, 0), 5) -- ������� ��� �� ������� ����
                   - NVL (cp.get_from_cp_zal_kolz (s.ref, p_dat), 0), -- ������� ��������� ��
             p_dat)
             sum_nobt -- ���� ����������� ��
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