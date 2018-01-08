

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FIN_REP_FM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FIN_REP_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FIN_REP_FM ("FM", "NAME") AS 
  Select 'P' fm, '�.�1 �� �.�2� �������� ��� ���������� ����������  ' name from dual
union all Select 'M' fm, '�.�1� �� �.�2̖ ������ ����������  '                  name from dual
union all Select 'C' fm, '�.�1�� �� �.�2�і ������ ����������  '                name from dual
;

PROMPT *** Create  grants  V_FIN_REP_FM ***
grant SELECT                                                                 on V_FIN_REP_FM    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FIN_REP_FM.sql =========*** End *** =
PROMPT ===================================================================================== 
