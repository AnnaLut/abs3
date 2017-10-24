

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F01_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F01_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F01_NG (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ #01 ��� ����� G
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 12.10.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
     p_f01_NN (Dat_ , 'G');
end; 
/
show err;

PROMPT *** Create  grants  P_F01_NG ***
grant EXECUTE                                                                on P_F01_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F01_NG        to RPBN002;
grant EXECUTE                                                                on P_F01_NG        to START1;
grant EXECUTE                                                                on P_F01_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F01_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
