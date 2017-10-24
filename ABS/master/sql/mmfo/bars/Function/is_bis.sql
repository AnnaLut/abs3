
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/is_bis.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IS_BIS (p_ref in integer) return integer is
  l_num integer;
begin
  -- проверка: содержит ли документ строки БИС
  select 1 into l_num from operw where ref=p_ref
  and tag in ('П    ', 'C    ', 'П1   ', 'C1   ', 'П01  ', 'C01  ');
  return 1;
exception when no_data_found then
  return 0;
end;
 
/
 show err;
 
PROMPT *** Create  grants  IS_BIS ***
grant EXECUTE                                                                on IS_BIS          to PUBLIC;
grant EXECUTE                                                                on IS_BIS          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/is_bis.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 