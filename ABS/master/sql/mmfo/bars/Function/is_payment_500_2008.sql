
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_payment_500_2008.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_PAYMENT_500_2008 (p_ref in number) return number is
  --
  -- ���������� 1 ���� ������� ������ �� ������� 500 ��� 2008 ���� (p_ref - ���-� ��������)
  --
  l_src_ref   number;
  l_pdat      date;
begin
  -- ���� ������������ ���-�
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
 