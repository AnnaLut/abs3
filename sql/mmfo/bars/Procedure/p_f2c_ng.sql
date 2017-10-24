

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2C_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2C_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2C_NG (Dat_ DATE, pr_op_ Number default 1)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #2C для схема "G"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 17.02.2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pr_op_ - признак операции 1 - данi про намiр
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f2C_NN (Dat_,'G',1);
end;
/
show err;

PROMPT *** Create  grants  P_F2C_NG ***
grant EXECUTE                                                                on P_F2C_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F2C_NG        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2C_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
