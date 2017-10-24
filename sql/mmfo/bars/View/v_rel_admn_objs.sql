

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REL_ADMN_OBJS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REL_ADMN_OBJS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REL_ADMN_OBJS ("ID", "CODE", "DSC") AS 
  select  0, '00', '00. ����������� - ����'
  from dual
 union all
select  1, '01', '01. ����������� - ��������'
  from dual
 union all
select  2, '02', '02. ����������� - ����� ��������'
  from dual
 union all
select  3, '03', '03. ����������� - ���� ���'
  from dual
 union all
select  4, '04', '04. ����������� - �������'
  from dual
 union all
select  5, '05', '05. ����������� - ��������'
  from dual
 union all
select  6, '06', '06. ����������� - �������� ����'
  from dual
 union all
select  7, '07', '07. ����������� - ϳ�������'
  from dual
 union all
select  8, '08', '08. ���� - �������'
  from dual
 union all
select  9, '09', '09. ���� - ��������'
  from dual
 union all
select 10, '10', '10. ���� - �������� ����'
  from dual
;

PROMPT *** Create  grants  V_REL_ADMN_OBJS ***
grant SELECT                                                                 on V_REL_ADMN_OBJS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REL_ADMN_OBJS.sql =========*** End **
PROMPT ===================================================================================== 
