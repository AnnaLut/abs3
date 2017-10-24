

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12_REP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12_REP ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12_REP (Datn_ DATE, Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования отчетов по #12 файлу
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 04.03.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Datn_-начальная отчетная дата,Dat_-конечная отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin

   p_f12rovno (Datn_, Dat_ );

end;
/
show err;

PROMPT *** Create  grants  P_F12_REP ***
grant EXECUTE                                                                on P_F12_REP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F12_REP       to RPBN001;
grant EXECUTE                                                                on P_F12_REP       to RPBN002;
grant EXECUTE                                                                on P_F12_REP       to START1;
grant EXECUTE                                                                on P_F12_REP       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12_REP.sql =========*** End ***
PROMPT ===================================================================================== 
