

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE0_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE0_NG (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #E0 для схема "G"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 31.08.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_fe0_NN (Dat_,'G');
end;
 
/
show err;

PROMPT *** Create  grants  P_FE0_NG ***
grant EXECUTE                                                                on P_FE0_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FE0_NG        to RPBN002;
grant EXECUTE                                                                on P_FE0_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
