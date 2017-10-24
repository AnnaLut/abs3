

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F6B_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F6B_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_F6B_NC (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #6B ��� ����� "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16.01.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f6B_NN (Dat_, 'C');
end;
/
show err;

PROMPT *** Create  grants  P_F6B_NC ***
grant EXECUTE                                                                on P_F6B_NC        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F6B_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
