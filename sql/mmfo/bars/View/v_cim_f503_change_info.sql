

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_CHANGE_INFO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_CHANGE_INFO ("ID", "INFO") AS 
  select '1' as id, '1 - ��� ���' as info from dual
union all select '2' as id, '2 - ���� ����������' as info from dual
union all select '3' as id, '3 - ���� ���� ���������' as info from dual
union all select '4' as id, '4 - ����������� ����� � ��������� �� ������ ��������' as info from dual
union all select '5' as id, '5 - ������� �볺��� � ������ �������������� �����' as info from dual
union all select '6' as id, '6 - ���������� ������������� ��������' as info from dual
union all select '7' as id, '7 - ����' as info from dual;

PROMPT *** Create  grants  V_CIM_F503_CHANGE_INFO ***
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_CHANGE_INFO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_CHANGE_INFO.sql =========***
PROMPT ===================================================================================== 
