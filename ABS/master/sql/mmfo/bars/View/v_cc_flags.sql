

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_FLAGS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_FLAGS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_FLAGS ("KOD", "TXT") AS 
  SELECT kod, txt
 FROM (          SELECT '00' kod, '� ���������. % �� ��������� ����'      txt    FROM DUAL
       UNION ALL SELECT '01' kod, '� ���������. % �� ��������� �����'    txt    FROM DUAL
       UNION ALL SELECT '10' kod, '��� ������   % �� ��������� ����'      txt    FROM DUAL
       UNION ALL SELECT '11' kod, '��� ������   % �� ��������� �����'    txt    FROM DUAL
       UNION ALL SELECT '02' kod, '� ���������. % �������������� ����'     txt    FROM DUAL
       UNION ALL SELECT '12' kod, '��� �������   % �������������� ����'     txt    FROM DUAL
       UNION ALL SELECT '90' kod, '�i��i�� ����,% �� ��������� ����'      txt    FROM DUAL
       UNION ALL SELECT '91' kod, '�i��i�� ����,% �� ��������� �����'    txt    FROM DUAL
      );

PROMPT *** Create  grants  V_CC_FLAGS ***
grant SELECT                                                                 on V_CC_FLAGS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_FLAGS      to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_FLAGS.sql =========*** End *** ===
PROMPT ===================================================================================== 
