 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_tip_W4.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.f_get_tip_W4 (p_tip accounts.tip%type) RETURN accounts.tip%type is

/* Версия 1.0 20-09-2018
   Тип счета по счетам W4_ACC_INST
*/

 l_tip accounts.tip%type;

begin
   begin
      select tip351 into l_tip from tipw4_tip351 where tipw4 = p_tip;
   exception when NO_DATA_FOUND THEN l_tip := p_tip;
   end;
   return l_tip;
end;
/
 show err;
 
PROMPT *** Create  grants  f_get_tip_W4 ***
grant EXECUTE          on f_get_tip_W4       to BARS_ACCESS_DEFROLE;
grant EXECUTE          on f_get_tip_W4       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_tip.sql =========*** End *** 
 PROMPT ===================================================================================== 
