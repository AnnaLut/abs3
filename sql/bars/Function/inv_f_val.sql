CREATE OR REPLACE function BARS.inv_f_val(kv1 number, kv2 number, s number, p_dat01 date) RETURN NUMBER is

/* Версия 1.0 19-07-2017 
   Перевод из одной валюты в другую
   kv1 - с какой валюты              
   kv2 - в какую валюту
   s   - сколько
*/

 l_s number; 
 l_dat31 date := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца

begin
   if    kv1 = 980 and kv2 <> 980 then l_s := p_ncurval(kv2,s,l_dat31);
   elsif kv2 = 980 and kv1 <> 980 then l_s := p_icurval(kv2,s,l_dat31);
   elsif kv1 <>980 and kv2 <> 980 then l_s := p_ncurval(kv2,p_icurval(kv1,s,l_dat31),l_dat31); 
   else                                l_s := s;
   end if;
   return l_s;
end;
/

 show err;
grant execute on inv_f_val to bars_access_defrole;
grant execute on inv_f_val to start1;

