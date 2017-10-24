

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_F503_PERCENT_TYPE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_F503_PERCENT_TYPE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_F503_PERCENT_TYPE ("ID", "NAME") AS 
  select 2, '��������' from dual
union
select 3, '���������' from dual
union
select 0, '��������� ������� ��� ���������� ����������' from dual
;

PROMPT *** Create  grants  V_CIM_F503_PERCENT_TYPE ***
grant SELECT                                                                 on V_CIM_F503_PERCENT_TYPE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_F503_PERCENT_TYPE.sql =========**
PROMPT ===================================================================================== 
