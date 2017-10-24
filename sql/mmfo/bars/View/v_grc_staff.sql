

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRC_STAFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRC_STAFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRC_STAFF ("ID", "FIO") AS 
  SELECT s.ID, s.FIO
       FROM STAFF$BASE s
      WHERE s.id IN
               (1,                                        -- ������������� ���
                55,                                               ---- �������
                71,                                             ---- ���������
                100,                                              ---- �������
                102,                                             ---- ��������
                105,                                                 ---- ����
                107,                                              ---- �������
                108,                                                 ---- ����
                109,                                           ---- ����������
                110,                                            ---- ���������
                111,                                              ---- �������
                114,                                               -- ��������
                115,                                               ---- ������
                116,                                               ---- ������
                143,                                            -- ������ ����
                535,                                               -- ��������
                550,                                               -- ��������
                590,                                                  -- �����
                601, -- �������
                75,                                     -- �������� ����������
                97,                                        -- ������ ���������
                98,                                  -- ������������ ���������
                99,                                             -- ������-����
                70,                                                -- ��������
                52,                                             -- ��� ��� - 1
                53,                                             -- ��� ��� - 2
                123,                                              -- ��� ��� 3
                124,                                              -- ��� ��� 4
                106,                              -- ����������� ������� �����
                125,                                              -- ��� ��� 5
                150,                                       -- ����������� ����
                888,                                       -- SWIFT ����������
                889,                                       -- ������� ��������
                890,                                       -- ������� ��������
                999                                             -- ����-������
                   )
   ORDER BY s.id;

PROMPT *** Create  grants  V_GRC_STAFF ***
grant SELECT                                                                 on V_GRC_STAFF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRC_STAFF     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRC_STAFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
