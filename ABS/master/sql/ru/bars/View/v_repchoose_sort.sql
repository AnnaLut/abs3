

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_SORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REPCHOOSE_SORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REPCHOOSE_SORT ("ID", "DESCRIPT", "SRT") AS 
  select '���', '�� ��� � ����� �������',  0 from dual
union all
select '���',  '�� ��� � ����� �������', 1 from dual
union all
select '�������', '�� ������� � ���',  2 from dual;

PROMPT *** Create  grants  V_REPCHOOSE_SORT ***
grant SELECT                                                                 on V_REPCHOOSE_SORT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REPCHOOSE_SORT to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REPCHOOSE_SORT.sql =========*** End *
PROMPT ===================================================================================== 
