
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/calc_pdat.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CALC_PDAT (dat_ date) return date is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Функция поиска даты начала выходных дней,
%  			  	предшествующих даной дате. Если пред. день - рабочий,
%				то вернуть заданую дату
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 11.11.2004
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
 rdate_ date:=dat_-1;
 count_ number;
begin

  loop
   select count(*)
   into count_
   from holiday
   where holiday = rdate_
     and kv = 980;

   exit when count_=0;

   rdate_ := rdate_ - 1;
 end loop;

 return rdate_ + 1;

end;
/
 show err;
 
PROMPT *** Create  grants  CALC_PDAT ***
grant EXECUTE                                                                on CALC_PDAT       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/calc_pdat.sql =========*** End *** 
 PROMPT ===================================================================================== 
 