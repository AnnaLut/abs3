

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF4_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF4_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FF4_NC (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #F4 для схемы C
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 13.01.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_ff4_NN (Dat_,'C');
end;
/
show err;

PROMPT *** Create  grants  P_FF4_NC ***
grant EXECUTE                                                                on P_FF4_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FF4_NC        to RPBN002;
grant EXECUTE                                                                on P_FF4_NC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF4_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
