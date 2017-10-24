

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC9_NC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC9_NC ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC9_NC (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #C9 для схема "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 21.09.2009 (19.02.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pr_op_ - признак операции (2 - надходження вiд нерезидентiв)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_fc9_NN (Dat_,'C');
end;
/
show err;

PROMPT *** Create  grants  P_FC9_NC ***
grant EXECUTE                                                                on P_FC9_NC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FC9_NC        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC9_NC.sql =========*** End *** 
PROMPT ===================================================================================== 
