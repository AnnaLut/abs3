

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KOD_34_2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KOD_34_2 ("ID", "NAME") AS 
  select 1, '���������� �� �������� ��������' from dual
union
select 2, '���������� �� �������� �� ��������' from dual
union
select 3, '������ �� ���������, ����� 䳿 ��������� �������� �� ���������' from dual
union
select 4, '���������� �� �������� ��������� ����������' from dual
union
select 5, '����� 䳿 ��������� �������� ���������, � ���� ���� ���������� ������������� ��������' from dual
;

PROMPT *** Create  grants  V_CIM_KOD_34_2 ***
grant SELECT                                                                 on V_CIM_KOD_34_2  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KOD_34_2.sql =========*** End ***
PROMPT ===================================================================================== 
