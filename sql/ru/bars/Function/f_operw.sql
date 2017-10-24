
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_operw.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OPERW (p_ref in operw.ref%type,
                                   p_tag in operw.tag%type)
  return operw.value%type is
  l_res operw.value%type;
begin
  select ow.value
    into l_res
    from operw ow
   where ow.ref = p_ref
     and ow.tag = p_tag;
  return l_res;
exception
  when dup_val_on_index then
    return null;
  when no_data_found then
	return null;
end f_operw;
/
 show err;
 
PROMPT *** Create  grants  F_OPERW ***
grant EXECUTE                                                                on F_OPERW         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OPERW         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_operw.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 