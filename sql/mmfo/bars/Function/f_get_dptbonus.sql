PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_dptbonus.sql =========*** Run
PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION BARS.F_GET_DPTBONUS (p_bonus_id  in int, p_dpt_id in dpt_deposit.deposit_id%type) return number is
l_bonusval number;
l_rnk dpt_deposit.rnk%type;
begin
 ----- автор первоначальной версии неизвестен. Где используется, неизвестно. Стоило бы удалить...
 ----- но, чтоб работало, переделано Лившицем 24.02.2018
  begin
  select rnk
  into l_rnk
  from dpt_deposit 
  where deposit_id = p_dpt_id;
  exception when others then
    return 0;
  end;  

  dpt_bonus.set_dpt_bonus_context(l_rnk, null, p_dpt_id);
  l_bonusval := dpt_bonus.get_bonus_value(p_bonus_id);

return l_bonusval;
end;
/
show err;
 
PROMPT *** Create  grants  F_GET_DPTBONUS ***
grant EXECUTE                                                                on F_GET_DPTBONUS  to BARS_ACCESS_DEFROLE;

 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_dptbonus.sql =========*** End
PROMPT ===================================================================================== 
 
