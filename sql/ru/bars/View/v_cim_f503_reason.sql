

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_REASON.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_REASON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_REASON ("ID", "NAME") AS 
  select 1, '��i� ������������-��i���� ��� ������� ������ �����' from dual
union
select 2, '���i �����.��i�� ��-�� � ������.����.�� ��.���i��' from dual;

PROMPT *** Create  grants  V_CIM_F503_REASON ***
grant SELECT                                                                 on V_CIM_F503_REASON to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_REASON.sql =========*** End 
PROMPT ===================================================================================== 
