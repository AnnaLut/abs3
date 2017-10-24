

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2F_POK_UNIT3.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2F_POK_UNIT3 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F2F_POK_UNIT3 (dat_ IN DATE,
                                            dat1_ date, 
                                            nbuc_ varchar2) is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формированияз раздела для файла 2F (Є ФІНМОНІТОРИНГ) 
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION     :    04.04.2017   ( 06/05/2016 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  04.04.2017  при выборках из finmon.oper исключаются операции со статусом =-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    kodf_    varchar2(2):='2F';
    sheme_   varchar2(1):='C';

begin
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3302000000000000000', 
        sum(znap) znap, nbuc_
   from (select count( * ) znap
         from finmon.oper o
         where NVL(o.kl_date, o.kl_date_branch_id) between Dat1_ and Dat_
           and status !=-1
           and opr_vid2 in (select trim(r020) 
                              from kl_f3_29
                              where kf = '2F'
                                and ddd = '302')
         having count( * ) <> 0)
   group by dat_, kodf_, '3302000000000000000';                                     

   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3303000000000000000', 
        sum(znap) znap, nbuc_
   from (select count( * ) znap
         from finmon.oper o
         where NVL(o.kl_date, o.kl_date_branch_id) between Dat1_ and Dat_ 
           and status !=-1
           and opr_vid3 in (select trim(r020) 
                              from kl_f3_29
                             where kf = '2F'
                               and ddd = '303')
         having count( * ) <> 0)
   group by dat_, kodf_, '3303000000000000000';      
   
   INSERT INTO tmp_nbu(datf, kodf, kodp, znap, nbuc)
   select dat_, kodf_, '3304000000000000000', 
        sum(znap) znap, nbuc_
   from (select count( * ) znap
         from finmon.oper o
         where NVL(o.kl_date, o.kl_date_branch_id) between Dat1_ and Dat_ 
           and status !=-1
           and opr_vid2 in (select trim(r020) 
                              from kl_f3_29
                             where kf = '2F' 
                               and ddd = '302')
           and opr_vid3 in (select trim(r020) 
                              from kl_f3_29
                             where kf = '2F'
                               and ddd = '303')
         having count( * ) <> 0)
   group by dat_, kodf_, '3304000000000000000';  
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2F_POK_UNIT3.sql =========*** E
PROMPT ===================================================================================== 
