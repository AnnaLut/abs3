CREATE OR REPLACE FUNCTION BARS.F_ZAL_CCF (p_dat01 date, p_nd integer) RETURN INTEGER is

/* Версия 1.1  21-03-2019   20-07-2018
   Наличие залога только 15, 156, 592, (34)
   -------------------------------------
  21-03-2019(1.1) - Вид забезпечення 34-Порука не впливає (не погіршує) параметр , але не виступає як окреме забезпечення
*/

 l_pawn  integer;
begin
   l_pawn := 0;
   for k in (select * from tmp_rez_obesp23 where dat = p_dat01 and nd = p_nd )
   LOOP
      if k.pawn in (15, 156, 592)         THEN  l_pawn := 1;
      elsif k.pawn in (34) and l_pawn = 1 THEN  l_pawn := 1;
      elsif k.pawn in (34) and l_pawn = 0 THEN  l_pawn := 0;
      else                                      return (0);
      end if;
   end LOOP;
   return(l_pawn);
end;
/
 show err;
 
PROMPT *** Create  grants F_ZAL_CCF ***
grant EXECUTE   on F_ZAL_CCF        to BARS_ACCESS_DEFROLE;
grant EXECUTE   on F_ZAL_CCF        to START1;

