CREATE OR REPLACE function BARS.MBDK_TIP (p_vidd varchar2) RETURN number is

/* Версия 1.0 25-04-2017
   Определение типа МБДК
*/
 l_tip number;
 
begin
   begin
      select tipp into l_tip from V_MBDK_PRODUCT where vidd = p_vidd;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_tip := 0;  
   END; 
   return l_tip;
end;
/
show err;
grant execute on MBDK_TIP  to bars_access_defrole;
grant execute on MBDK_TIP  to start1;
/

