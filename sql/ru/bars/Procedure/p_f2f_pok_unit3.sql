

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2F_POK_UNIT3.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2F_POK_UNIT3 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2F_POK_UNIT3 (dat_ IN DATE,
                                            dat1_ date,
                                            nbuc_ varchar2) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формированияз раздела для файла 2F (НЕМАЄ ФІНМОНІТОРИНГУ)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    06/05/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    kodf_    varchar2(2):='2F';
    sheme_   varchar2(1):='C';
begin
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3302000000000000000',
        sum(znap) znap, nbuc
   from tmp_nbu
   where kodf = 'D0' and
        datf between dat1_ and dat_ and
        substr(kodp, 1, 3) = '302'
   group by dat_, kodf_, '3302000000000000000', nbuc;

   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3303000000000000000',
        sum(znap) znap, nbuc
   from tmp_nbu
   where kodf = 'D0' and
        datf between dat1_ and dat_ and
        substr(kodp, 1, 3) = '310'
   group by dat_, kodf_, '3303000000000000000', nbuc;

   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3304000000000000000',
        sum(znap) znap, nbuc
   from tmp_nbu
   where kodf = 'D0' and
        datf between dat1_ and dat_ and
        substr(kodp, 1, 3) in ('302', '310')
   group by dat_, kodf_, '3304000000000000000', nbuc;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2F_POK_UNIT3.sql =========*** E
PROMPT ===================================================================================== 
