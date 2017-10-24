
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_pawn_kpz.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PAWN_KPZ (p_pawn integer) RETURN number is

/* Версия 1.0 01-09-2016
   Визначення Мінімального коефіцієнту покриття боргу забезпеченням по виду забезпечення';
   -------------------------------------
 */

 l_kpz number;

begin
   begin
      select nvl(kpz_351,0) into l_kpz from v23_pawn where pawn = p_pawn;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN l_kpz := 0;
   end;
   return l_kpz;
end;
/
 show err;
 
PROMPT *** Create  grants  F_PAWN_KPZ ***
grant EXECUTE                                                                on F_PAWN_KPZ      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PAWN_KPZ      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_pawn_kpz.sql =========*** End ***
 PROMPT ===================================================================================== 
 