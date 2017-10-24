

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC9_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC9_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC9_NG (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #C9 для схема "G"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 19.02.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pr_op_ - признак операции (2 - надходження вiд нерезидентiв)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_fc9_NN (Dat_,'G');
end;
/
show err;

PROMPT *** Create  grants  P_FC9_NG ***
grant EXECUTE                                                                on P_FC9_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FC9_NG        to RPBN002;
grant EXECUTE                                                                on P_FC9_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC9_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
