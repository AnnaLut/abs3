

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE1_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE1_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE1_NC (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #E1 для схема "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 31.08.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_fe1_NN (Dat_,'C');
end;
 
/
show err;

PROMPT *** Create  grants  P_FE1_NC ***
grant EXECUTE                                                                on P_FE1_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FE1_NC        to RPBN002;
grant EXECUTE                                                                on P_FE1_NC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE1_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
