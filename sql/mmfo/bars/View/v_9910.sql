

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_9910.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_9910 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_9910 ("TXT", "KOD") AS 
  SELECT '�������� ����������� �� ����������� �� ������',
          '9910/01 - �������� ����������� �� ����������� �� ������'
     FROM DUAL
        UNION ALL
   SELECT '��i��� �I�/�����i�/������ ������/��������',
          '9910/01 - ��i��� �I�/�����i�/������ ������/��������'
     FROM DUAL
   UNION ALL
   SELECT '�i����i�������� �������',
          '9910/06 - �i����i�������� �������'
     FROM DUAL
   UNION ALL
   SELECT '�����i�-���i��. �������',
          '9910/07 - �����i�-���i��. �������'
     FROM DUAL
   UNION ALL
   SELECT '��������� 01', '9760/01 - ��������� 01'
     FROM DUAL;

PROMPT *** Create  grants  V_9910 ***
grant SELECT                                                                 on V_9910          to BARSREADER_ROLE;
grant SELECT                                                                 on V_9910          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_9910          to PYOD001;
grant SELECT                                                                 on V_9910          to UPLD;
grant SELECT                                                                 on V_9910          to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_9910          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_9910.sql =========*** End *** =======
PROMPT ===================================================================================== 
