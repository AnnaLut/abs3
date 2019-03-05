CREATE OR REPLACE FUNCTION BARS.F_PAWN_KOD351 (p_pawn number) RETURN number is

/* Версия 1.0   21-02-2019 
   KOD_351 от PAWM
*/

l_kod351   number; 

begin
   begin
      select kod_351 into l_kod351 from cc_pawn where pawn = p_pawn;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_kod351 := 0;
   end;
   return (l_kod351);
end;
/
 show err;
 
PROMPT *** Create  grants  F_PAWN_KOD351 ***
grant EXECUTE                        on F_PAWN_KOD351 to BARS_ACCESS_DEFROLE;
grant EXECUTE                        on F_PAWN_KOD351 to START1;

