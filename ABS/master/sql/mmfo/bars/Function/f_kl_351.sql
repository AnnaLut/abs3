
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kl_351.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KL_351 (p_acc integer, p_pawn integer) RETURN number is

/* Версия 1.0 25-01-2017
   Коефіцієнт ліквідності забезпечення (з виключеннями)
*/


 l_kl_351 number;

begin

   begin
      select  kl_351 into l_kl_351 from ex_kl351  where   acc = p_acc and pawn = p_pawn;
   exception when NO_DATA_FOUND THEN
      begin
         select  kl_351 into l_kl_351 from cc_pawn23add c  where   c.pawn = p_pawn;
      exception when NO_DATA_FOUND THEN l_kl_351 := 0;
      end;
   end;
   return l_kl_351;
end;
/
 show err;
 
PROMPT *** Create  grants  F_KL_351 ***
grant EXECUTE                                                                on F_KL_351        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KL_351        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kl_351.sql =========*** End *** =
 PROMPT ===================================================================================== 
 