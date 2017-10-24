
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_dptamount.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DPTAMOUNT (p_accid in accounts.acc%type)
  return number
is
  /*
    функция исп.в пакете acrn для ступ.базовых ставоки с типом № 7 и возвращает
       - сумму первичного взноса (для вкладных счетов)
       - 0                       (для остальных счетов)
  */
  l_amount number(38);
begin

  begin
    select nvl(limit, 0) into l_amount from dpt_deposit where acc = p_accid;
  exception
    when no_data_found then
      l_amount := 0;
  end;

  return l_amount;

end get_dptamount;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_dptamount.sql =========*** End 
 PROMPT ===================================================================================== 
 