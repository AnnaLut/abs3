

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_MONTHES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_MONTHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_MONTHES ("M_ID", "M_NAME") AS 
  select '1',      '�����'  from dual
union
select '2',      '�����'  from dual
union
select '3',      '��������'  from dual
union
select '4',      '������'  from dual
union
select '5',      '�������'  from dual
union
select '6',      '�������'  from dual
union
select '7',      '������'  from dual
union
select '8',      '�������'  from dual
union
select '9',      '��������'  from dual
union
select 'A',      '�������'  from dual
union
select 'B',      '��������'  from dual
union
select 'C',      '�������'  from dual;


PROMPT *** Create  grants  V_CIM_MONTHES ***
grant SELECT                                                                 on V_CIM_MONTHES   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_MONTHES.sql =========*** End *** 
PROMPT ===================================================================================== 
