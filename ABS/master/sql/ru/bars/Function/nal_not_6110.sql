
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nal_not_6110.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NAL_NOT_6110 
(
  p_vidbiz VARCHAR2   -- ��� �������
)
 return VARCHAR2  is
-----------------------------------------------------------------
---   ������� ������ 6110 ��� �������� �� ������.������������
---   �� ����� ������. ����������
-----------------------------------------------------------------
 l_nls2    accounts.nls%type   ;    ----  ������� 6110

Begin

  IF p_vidbiz ='3' then
     l_nls2:=NBS_OB22('6510','F3');   --- ��
  ELSE
     l_nls2:=NBS_OB22('6510','F2');   --- ��:  ���� � ��
  END IF;

  RETURN l_nls2;

End NAL_NOT_6110;
/
 show err;
 
PROMPT *** Create  grants  NAL_NOT_6110 ***
grant EXECUTE                                                                on NAL_NOT_6110    to START1;
grant EXECUTE                                                                on NAL_NOT_6110    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nal_not_6110.sql =========*** End *
 PROMPT ===================================================================================== 
 