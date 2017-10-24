

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F08_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F08_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F08_NG (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #08 для схемы G
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 12.10.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f08_NN (Dat_ , 'G');
end;
/
show err;

PROMPT *** Create  grants  P_F08_NG ***
grant EXECUTE                                                                on P_F08_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F08_NG        to RPBN002;
grant EXECUTE                                                                on P_F08_NG        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F08_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
