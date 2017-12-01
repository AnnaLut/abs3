CREATE OR REPLACE function BARS.MBDK_2700_FREQ (p_nd integer) RETURN number is

/* Версия 1.0 28-07-2017
   Определение переодичноть погашения % для 2700
*/
l_freq number;

begin
   for k in (select * from nd_acc  where nd = p_nd )
   LOOP
      if    k.acc in (54852101, 54852301) THEN l_freq :=   7;
      elsif k.acc in (46941001)           THEN l_freq := 180;
      end if;
   end LOOP;
   return(l_freq);
end;
/

grant execute on MBDK_2700_FREQ to bars_access_defrole;
grant execute on MBDK_2700_FREQ to start1;


