

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F01_CR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F01_CR ***

  CREATE OR REPLACE PROCEDURE BARS.P_F01_CR (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #01 ��� ����� "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 14.02.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f01_NN (Dat_,'C','R');
end;
/
show err;

PROMPT *** Create  grants  P_F01_CR ***
grant EXECUTE                                                                on P_F01_CR        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F01_CR        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F01_CR.sql =========*** End *** 
PROMPT ===================================================================================== 
