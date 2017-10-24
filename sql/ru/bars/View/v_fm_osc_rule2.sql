PROMPT *** Create  view V_FM_OSC_RULE2 ***


create or replace view v_fm_osc_rule2 (ref, vdat) as
-- ============================================================================
-- 2. ������ ����� � �������� ����
-- ============================================================================
-- ��� ������������ ��: 1010, 1011, 1012, 1020, 1021, 1022, 1031, 1032 
-- ============================================================================
-- SUM=15000000 ��
-- ( ACCOUNTS=1001, 1002, 1005 (����� ����� ���) ���
--   ACCOUNTSA = 2902, 2909 (����� ����� ���) )
-- <�������������� � ��������� 20, 21, 22, 25, 26, 28, 29, 37 ���� ������� (� �.�. ������� ����� �����)
-- 21.04.2017 - �������� � ������������ � COBUSUPABS-5844
-- 1. ���� �ϻ �������� ���� ���ʻ
-- 2. ACCOUNTSA = 2625 �� ACCOUNTSB = 2924 �� PURPOSE = ������� (���� ��� �������)
-- 3. ACCOUNTSA = 2924 �� ACCOUNTSB = 2924 �� PURPOSE = ������� ������ (������� ������ �����������) ��� PURPOSE = ������������� (���� ��� �������) ��� PURPOSE = ������������ (���� ��� �������).
-- 4. ACCOUNTSA = 2924 �� ACCOUNTSB = 2625
-- ============================================================================
SELECT o.REF, o.vdat
     FROM oper o
    WHERE     (       SUBSTR (o.nlsa, 1, 4) IN ('1001', '1002', '1005') AND o.mfoa = f_ourmfo
                  AND SUBSTR (o.nlsb, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsb, 1, 4) IN ('1001', '1002', '1005') AND o.mfob = f_ourmfo
                  AND SUBSTR (o.nlsa, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsa, 1, 4) IN ('2902', '2909') AND o.dk = 1 AND o.mfoa = f_ourmfo
                  AND SUBSTR (o.nlsb, 1, 2) IN ('20','21','22','25','26','28','29','37')
               OR     SUBSTR (o.nlsb, 1, 4) IN ('2902', '2909') AND o.dk = 0 AND o.mfob = f_ourmfo
                  AND SUBSTR (o.nlsa, 1, 2) IN ('20','21','22','25','26','28','29','37')

               OR     SUBSTR (o.nlsa, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsb, 1, 4) IN ('2924')
                  AND (UPPER(TRIM(o.NAZN)) like '%����������%' OR UPPER(TRIM(o.NAZN)) like '������ ��Ҳ���:%' OR UPPER(TRIM(o.NAZN)) like '%�����������%')

               OR     SUBSTR (o.nlsb, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsa, 1, 4) IN ('2625')
                  AND UPPER(TRIM(o.NAZN)) like '%�����%'

               OR     SUBSTR (o.nlsa, 1, 4) IN ('2924')
                  AND SUBSTR (o.nlsb, 1, 4) IN ('2625')

               OR o.TT in ('040','041','042','043','044','045','AA1','AA2','AA3','AA4','AA5','AA6','AA7','AA8','AA9', 'PKK' ))

          AND gl.p_icurval (NVL (o.kv, 980), NVL (o.s, 0), o.vdat) >=
                 15000000;

grant select on v_fm_osc_rule2 to finmon01;
grant select on v_fm_osc_rule2 to bars_access_defrole;
