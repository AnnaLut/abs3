

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2E_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2E_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2E_NG (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #2E ��� ����� "G" 
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 06.03.2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f2E_NN (Dat_,'G');
end;
/
show err;

PROMPT *** Create  grants  P_F2E_NG ***
grant EXECUTE                                                                on P_F2E_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F2E_NG        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2E_NG.sql =========*** End *** 
PROMPT ===================================================================================== 