

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F39_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F39_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_F39_NC (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #39 для схемы G
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 14.02.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f39_NN(Dat_, 'C');
end;
/
show err;

PROMPT *** Create  grants  P_F39_NC ***
grant EXECUTE                                                                on P_F39_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F39_NC        to RPBN002;
grant EXECUTE                                                                on P_F39_NC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F39_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
