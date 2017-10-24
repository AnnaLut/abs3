
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_payment_500_2008.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_PAYMENT_500_2008 (p_ref in number) return number is
  --
  -- возвращает 1 если возврат пришел на выплату 500 грн 2008 года (p_ref - док-т возврата)
  --
  l_src_ref   number;
  l_pdat      date;
begin
  -- ищем оригинальный док-т
  begin
    select to_number(nd) into l_src_ref from oper where ref=p_ref;
  exception when others then
    return 0;
  end;
  select pdat into l_pdat from oper where ref=l_src_ref;
  if extract(year from l_pdat)=2008 then
    return 1;
  else
    return 0;
  end if;
end is_payment_500_2008;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_payment_500_2008.sql =========**
 PROMPT ===================================================================================== 
 