
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_is_resident.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IS_RESIDENT (p_kv in number, p_nls in varchar2, p_ref number := null ) return number
is
 l_n number := 1;
begin
  -- Функція для визначення резидентності клієнта по йго рахунку
  -- використовується при накладанні умовної візи валютного контролю (№7)
  select nvl((select case when R.REZID=2 or c.country != 804 then 0 else 1 end
                from accounts a join customer c on c.rnk=a.rnk join codcagent r on r.codcagent=c.codcagent where a.kv=p_kv and a.nls=p_nls), 1) into l_n from dual;
  if l_n = 1  and p_ref is not null then
    select nvl( (select case when w.value='2' then 0 else 1 end from operw w where w.tag='REZID' and w.ref=p_ref), l_n) into l_n from dual;
  end if;
  return l_n;
end;
/
 show err;
 
PROMPT *** Create  grants  F_IS_RESIDENT ***
grant EXECUTE                                                                on F_IS_RESIDENT   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_IS_RESIDENT   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_is_resident.sql =========*** End 
 PROMPT ===================================================================================== 
 