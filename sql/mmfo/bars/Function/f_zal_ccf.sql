CREATE OR REPLACE FUNCTION BARS.F_ZAL_CCF (p_dat01 date, p_nd integer) RETURN INTEGER is

/* Версия 1.0  20-07-2018
   Наличие залога только 15, 156, 592, 34
   -------------------------------------
*/

 l_pawn  integer;
begin
   for k in (select * from tmp_rez_obesp23 where dat = p_dat01 and nd = p_nd )
   LOOP
      if k.pawn in (15, 156, 592, 34) THEN  l_pawn := 1;
      else                                  return (0);
      end if;
   end LOOP;
   return(l_pawn);
end;
/
 show err;
 
PROMPT *** Create  grants F_ZAL_CCF ***
grant EXECUTE   on F_ZAL_CCF        to BARS_ACCESS_DEFROLE;
grant EXECUTE   on F_ZAL_CCF        to START1;

