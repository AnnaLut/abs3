

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD3_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD3_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD3_NG (Dat_ DATE, pr_op_ Number default 3)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #D3 ��� ����� "G"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 25.02.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ���������: Dat_ - �������� ����
             pr_op_ - ������� �������� 3 - ������ ������,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f70_NN (Dat_,'G',3);
end;
/
show err;

PROMPT *** Create  grants  P_FD3_NG ***
grant EXECUTE                                                                on P_FD3_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD3_NG        to RPBN002;
grant EXECUTE                                                                on P_FD3_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD3_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
