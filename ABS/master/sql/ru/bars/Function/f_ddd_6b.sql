
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ddd_6b.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DDD_6B (p_nbs char) RETURN char is

/* Версия 1.0 24-01-2017
   Параметр DDD по NBS
*/


 l_DDD varchar2(3);

begin
   begin
      select DDD into l_DDD from kl_f3_29 where r020 = p_nbs and rownum=1 and kf='6B';
   exception when NO_DATA_FOUND THEN l_DDD := NULL;
   end;
   return l_DDD;
end;
/
 show err;
 
PROMPT *** Create  grants  F_DDD_6B ***
grant EXECUTE                                                                on F_DDD_6B        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DDD_6B        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ddd_6b.sql =========*** End *** =
 PROMPT ===================================================================================== 
 