
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ob22.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_OB22 (p_kv in number, p_nls in varchar2) return varchar2
is
 l_str varchar2(2);
begin
  -- Функція для визначення OB22 Рахунку
  -- використовується при накладанні умовної візи валютного контролю (№7)
  select nvl((select OB22 from accounts a where a.kv=p_kv and a.nls=p_nls), null) into l_str from dual;
  return l_str;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_OB22 ***
grant EXECUTE                                                                on F_GET_OB22      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_OB22      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ob22.sql =========*** End ***
 PROMPT ===================================================================================== 
 