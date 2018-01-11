

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KL_S184.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KL_S184 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KL_S184 ("S184", "NAME") AS 
  select 1, '���������������� ������ � �������� ��� ����������� ������� ��������� �� 2 �� 365 (366) ��� �������' from dual
union
select 2, '�������������� � �������� ��� ����������� ������� ��������� ����� 365 (366) ���' from dual;

PROMPT *** Create  grants  V_CIM_KL_S184 ***
grant SELECT                                                                 on V_CIM_KL_S184   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_KL_S184   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_KL_S184   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KL_S184.sql =========*** End *** 
PROMPT ===================================================================================== 
