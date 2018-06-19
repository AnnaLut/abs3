CREATE OR REPLACE function BARS.f_ddd(p_nbs char) RETURN char is

/* Версия 1.0 24-01-2017
   Параметр DDD по NBS
*/


 l_DDD varchar2(3);

begin
   begin
      select DDD into l_DDD from kl_f3_29 where r020 = p_nbs and rownum=1 and kf='1B';
   exception when NO_DATA_FOUND THEN l_DDD := NULL;
   end;
   return l_DDD;
end;
/
