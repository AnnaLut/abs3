

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F77SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F77SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F77SB (Dat_ DATE, pr_int NUMBER DEFAULT 1)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования @77 для схема "C"
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2015.  All Rights Reserved.
% VERSION     : 21.05.2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  параметры: Dat_ - отчетная дата
             pmode - NUMBER DEFAULT  - 2 для внутрішнього файлу @77
             type_   NUMBER DEFAULT 1,
             pnd_    NUMBER DEFAULT NULL,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
BEGIN
   p_fA7_NN (Dat_,
             2,
             1,
             NULL);
END;
/
show err;

PROMPT *** Create  grants  P_F77SB ***
grant EXECUTE                                                                on P_F77SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F77SB         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F77SB.sql =========*** End *** =
PROMPT ===================================================================================== 
