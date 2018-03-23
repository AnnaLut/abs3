CREATE OR REPLACE function BARS.f_acc8 (p_nd integer) RETURN NUMBER is

/* Версия 1.0 12-04-2017 
   ACC счета 8999
               
*/

 l_acc8 number; 
 
begin
   begin
      select a.acc into l_acc8 from nd_acc n, accounts a where n.nd = p_nd and n.acc = a.acc and a.tip = 'LIM';
   exception when NO_DATA_FOUND THEN l_acc8 := NULL; 
   end;
   return l_acc8;

end;
/

 show err;

grant execute on f_acc8 to bars_access_defrole;
grant execute on f_acc8 to start1;


