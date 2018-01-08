

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_REASON.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_REASON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_REASON ("ID", "NAME") AS 
  select 1, '�������� �� ������ ���� ������������-�볺��� ��� �������� ������� �����' from dual
union
select 2, '�������� �� ������ ����� ������������ ���� �볺��� � ����������� ��������� �� ������ ����� �������� �� ��������' from dual;

PROMPT *** Create  grants  V_CIM_F503_REASON ***
grant SELECT                                                                 on V_CIM_F503_REASON to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_F503_REASON to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_F503_REASON to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_REASON.sql =========*** End 
PROMPT ===================================================================================== 
