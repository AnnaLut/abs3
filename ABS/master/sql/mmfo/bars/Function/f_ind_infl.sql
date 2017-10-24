
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ind_infl.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IND_INFL 

( p_S number  , -- ����� ��������� -�����������
  p_DAT0 date   -- ���� ��������� ����������� �����
) RETURN number IS

  l_DATi  date;
  l_Si  number;

begin

  l_DATi := nvl(gl.bdate, trunc(sysdate) );

  l_Si   := F_IND_INFL_ex ( p_S    => p_S    , -- ����� ��������� -�����������
                            p_DAT0 => p_DAT0 , -- ���� ��������� ����������� �����
                            p_DATi => l_DATi   -- �������� ���� ��� ��������� ��������� "�������������" �����
                            );
  Return ( l_Si ) ;

end F_IND_INFL ;
/
 show err;
 
PROMPT *** Create  grants  F_IND_INFL ***
grant EXECUTE                                                                on F_IND_INFL      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_IND_INFL      to START1;
grant EXECUTE                                                                on F_IND_INFL      to STO;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ind_infl.sql =========*** End ***
 PROMPT ===================================================================================== 
 