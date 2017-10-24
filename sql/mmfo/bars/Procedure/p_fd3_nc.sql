

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD3_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD3_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD3_NC (Dat_ DATE, pr_op_ Number default 3)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #D3 для схема "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 25.02.2006
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pr_op_ - признак операции 3 - продаж валюти,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f70_NN (Dat_,'C',3);
end;
 
/
show err;

PROMPT *** Create  grants  P_FD3_NC ***
grant EXECUTE                                                                on P_FD3_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FD3_NC        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD3_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
