

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F51_NG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F51_NG ***

  CREATE OR REPLACE PROCEDURE BARS.P_F51_NG (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования @51 для схема "G"(внутрiшнiй файл
%               звiтностi Ощадбанку (@51.....)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 21.08.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   p_f51_NN (Dat_,'G');
end;
/
show err;

PROMPT *** Create  grants  P_F51_NG ***
grant EXECUTE                                                                on P_F51_NG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F51_NG        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F51_NG.sql =========*** End *** 
PROMPT ===================================================================================== 
