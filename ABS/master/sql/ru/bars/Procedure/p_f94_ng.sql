

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F94_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F94_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F94_NG (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #94 ��� ����� G
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 03.02.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f94_NN (Dat_, 'G');
end;
/
show err;

PROMPT *** Create  grants  P_F94_NG ***
grant EXECUTE                                                                on P_F94_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F94_NG        to RPBN002;
grant EXECUTE                                                                on P_F94_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F94_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
