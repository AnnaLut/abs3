

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FM_SAILOR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FM_SAILOR ***

  CREATE OR REPLACE FORCE VIEW BARS.FM_SAILOR ("NAME", "ID") AS 
  SELECT '�� ���������' name, '0' id FROM DUAL
   UNION ALL
   SELECT '�����' name, '1' id FROM DUAL
   UNION ALL
   SELECT '����������' name, '2' id FROM DUAL
   UNION ALL
   SELECT '�������� ���������' name, '3' id FROM DUAL
   UNION ALL
   SELECT 'ϳ��������' name, '4' id FROM DUAL
   UNION ALL
   SELECT '��������' name, '5' id FROM DUAL
   UNION ALL
   SELECT '�������' name, '6' id FROM DUAL
   UNION ALL
   SELECT '����������' name, '7' id FROM DUAL
   UNION ALL
   SELECT '��������������' name, '8' id FROM DUAL
   UNION ALL
   SELECT '� �������� ��������' name, '9' id FROM DUAL;

PROMPT *** Create  grants  FM_SAILOR ***
grant SELECT                                                                 on FM_SAILOR       to BARSREADER_ROLE;
grant SELECT                                                                 on FM_SAILOR       to BARSUPL;
grant SELECT                                                                 on FM_SAILOR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_SAILOR       to START1;
grant SELECT                                                                 on FM_SAILOR       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FM_SAILOR.sql =========*** End *** ====
PROMPT ===================================================================================== 
