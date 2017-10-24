
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pawn_kl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PAWN_KL (p_pawn integer) RETURN number is

/* Версия 1.0 01-09-2016
   Визначення Коефіцієнт ліквідності згідно пост.№351 по виду забезпечення';
   -------------------------------------
 */

 l_kl number;

begin
   begin
      select nvl(kl_351,0) into l_kl from v23_pawn where pawn = p_pawn;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN l_kl := 0;
   end;
   return l_kl;
end;
/
 show err;
 
PROMPT *** Create  grants  F_PAWN_KL ***
grant EXECUTE                                                                on F_PAWN_KL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PAWN_KL       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pawn_kl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 