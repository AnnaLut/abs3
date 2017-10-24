
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calp_br.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALP_BR 
( s_   NUMBER, -- ����� ��������
  int_ NUMBER, -- ���.����.������
  dat1_ date , -- ���� "�" ������������
  dat2_ date , -- ���� "��" ������������
  basey_ int   -- ��� ���� ����������
  )   RETURN NUMBER as  --  05.03.2014 Sta � ���������� �����������  ( +0.5 ���� �������� ����������� �������� ���������)
BEGIN return round ( calp_NR (s_,int_,dat1_,dat2_,basey_) + (1/2), 0 ) ;
END calp_BR  ;
/
 show err;
 
PROMPT *** Create  grants  CALP_BR ***
grant EXECUTE                                                                on CALP_BR         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calp_br.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 