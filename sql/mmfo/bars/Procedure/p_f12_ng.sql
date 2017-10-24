

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12_NG (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #12 для схемы G
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 19.10.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f12_NN_sb (Dat_ , 'G');
end;
/
show err;

PROMPT *** Create  grants  P_F12_NG ***
grant EXECUTE                                                                on P_F12_NG        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
