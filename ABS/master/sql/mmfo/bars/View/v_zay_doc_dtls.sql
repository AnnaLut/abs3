

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_DOC_DTLS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_DOC_DTLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_DOC_DTLS ("POS", "TAG_UKR", "TAG_RUS", "REF_TBL", "REF_COL", "RQD", "DATA_TP") AS 
  SELECT 1              as POS
     , '���� �����' as TAG_UKR
     , '���� �������' as TAG_RUS
     , 'ZAY_AIMS'     as REF_TBL
     , 'AIM'          as REF_COL
     , 1              as RQD -- Required
     , 'N'            as DATA_TP -- Data Type
  FROM dual
 UNION ALL
SELECT 2, '� ���������', '� ���������', NULL, NULL, 1, 'C'
  FROM dual
 UNION ALL
SELECT 3, '���� ���������', '���� ���������', NULL, NULL, 1, 'D'
  FROM dual
 UNION ALL
SELECT 4, '���� �������� ���', '���� ��������� ���', NULL, NULL, 0, 'D'
  FROM dual
 UNION ALL
SELECT 5, '���� ����� ���', '���� ������ ���', NULL, NULL, 0, 'C'
  FROM dual
 UNION ALL
SELECT 6, '����� �������� ������', '������ ������������ ������', 'COUNTRY', 'COUNTRY', 1, 'N'
  FROM dual
 UNION ALL
SELECT 7, 'ϳ������ ��� ����� ������', '��������� ��� ������� ������', 'V_KOD_70_2', 'P63', 1, 'C'
  FROM dual
 UNION ALL
SELECT 8, '����� �����������', '������ �����������', 'COUNTRY', 'COUNTRY', 1, 'N'
  FROM dual
 UNION ALL
SELECT 9, '��� ������������ �����', '��� ������������ �����', 'v_rc_bnk', 'b010', 1, 'C'
  FROM dual
 UNION ALL
SELECT 10,'����� ���������� �����', '������������ ������������ �����', NULL, NULL, 1, 'C'
  FROM dual
 UNION ALL
SELECT 11,'������� �����', '�������� ������', 'V_KOD_70_4', 'P70', 0, 'C'
  FROM dual
 UNION ALL
SELECT 12,'� �������� ���', '� ��������� ���', NULL, NULL, 0, 'C'
  FROM dual
 UNION ALL
SELECT 13,'��� ����� �� �������� (#2C)', '��� ������� �� ������� (# 2C)', 'V_P_L_2C', 'ID', 1, 'C'
  FROM dual
 UNION ALL
SELECT 14,'������ �������� (#2C)', '������� �������� (# 2C)', 'V_P12_2C', 'CODE', 1, 'C'
  FROM dual;

PROMPT *** Create  grants  V_ZAY_DOC_DTLS ***
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to START1;
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_ZAY_DOC_DTLS  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_DOC_DTLS.sql =========*** End ***
PROMPT ===================================================================================== 
