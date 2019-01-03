
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_tip.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_TIP (p_nbs accounts.nbs%type, p_tip accounts.tip%type) RETURN accounts.tip%type is

/* Версия 1.1   02-10-2018  21-12-2016
   Тип счета
   02-10-2018(1.1) - Если тип счета SNA - не меняем
*/

 l_tip accounts.tip%type;

begin
   if p_tip = 'SNA' THEN return p_tip;
   else
      begin
         select tip into l_tip from BPK_NBS_TIP where nbs = p_nbs;
      exception when NO_DATA_FOUND THEN l_tip := p_tip;
      end;
      return l_tip;
   end if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_TIP ***
grant EXECUTE                                                                on F_GET_TIP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_TIP       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_tip.sql =========*** End *** 
 PROMPT ===================================================================================== 
 