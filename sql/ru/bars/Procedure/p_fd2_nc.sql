

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD2_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD2_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD2_NC (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #D2 для схема "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 16.03.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_fd2_NN (Dat_,'C');
end;
/
show err;

PROMPT *** Create  grants  P_FD2_NC ***
grant EXECUTE                                                                on P_FD2_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD2_NC        to RPBN002;
grant EXECUTE                                                                on P_FD2_NC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD2_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
