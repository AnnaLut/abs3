

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F70_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F70_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F70_NG (Dat_ DATE, pr_op_ Number default 1)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #70 для схема "G"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 18.08.2005
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pr_op_ - признак операции (1 - купiвля/продаж валюти,
                                        2 - надходження вiд нерезидентiв
                                        3 - всi операцii
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f70_NN (Dat_,'G',1);
end; 
 
/
show err;

PROMPT *** Create  grants  P_F70_NG ***
grant EXECUTE                                                                on P_F70_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F70_NG        to RPBN002;
grant EXECUTE                                                                on P_F70_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F70_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
