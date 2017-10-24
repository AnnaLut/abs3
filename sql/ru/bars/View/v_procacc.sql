

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROCACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROCACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROCACC ("NN", "TT", "NAME") AS 
  select 1 nn, 'N00/D' tt, '�������� ������������� ����������' name
     from DUAL
   union
   select 2, 'N00/K', '�������� ������������� ���������'
     from DUAL
   union
   select 3, 'N00/K', '��������� ������������� ����������'
     from DUAL
   union
   select 4, 'N99/D', '�������� ��������������� ����������'
     from DUAL
   union
   select 5, 'N99/K', '�������� ��������������� ���������'
     from DUAL
   union
   select 6, 'TNB/K', '��������� ���������������'
     from DUAL
   union
   select 7, 'T00/K', '��������� ������������ ��������������'
     from DUAL
   union
   select 8, 'T00/K', '��������� ������������ ����������������'
     from DUAL
   union
   select 9, 'T00/K', '��������� ������������ ���������������'
     from DUAL
   union
   select 10, 'T00/K', '�������� ��������������� ����������'
     from DUAL
   union
   select 11, 'T0D/D', '�������� ��������������� ���������'
     from DUAL
   union
   select 12, '902/K', '�������� ������������ ����������'
     from DUAL
   union
   select 13, '90D/D', '�������� ������������ ���������'
     from DUAL;

PROMPT *** Create  grants  V_PROCACC ***
grant SELECT                                                                 on V_PROCACC       to BARS014;
grant SELECT                                                                 on V_PROCACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PROCACC       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROCACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
