CREATE OR REPLACE function BARS.f_cur (p_dat01 date, p_kv integer) RETURN NUMBER is

/* Версия 1.0 12-04-2017 
   Курс
                
*/

 l_cur number; 
 
begin
   begin
      SELECT rate_o/bsum into l_cur FROM  cur_rates
      WHERE  vdate = ( SELECT MAX (vdate) FROM cur_rates   WHERE vdate <= p_dat01 AND kv = p_kv )  AND kv = p_kv;
   exception when NO_DATA_FOUND THEN l_cur := 0; 
   end;
   return l_cur;

end;
/

 show err;

grant execute on f_cur to bars_access_defrole;
grant execute on f_cur to start1;
