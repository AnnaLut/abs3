
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_caller_name.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_CALLER_NAME return varchar2 is
  l_cs   varchar2(32767);
  l_prev integer;
  l_next integer;
begin
  --
  -- определяем имя вызвавшей процедуры, для блока кода, позвавшего get_caller_name()
  --
  l_cs   := dbms_utility.format_call_stack;
  l_next := instr(l_cs, chr(10));
  for i in 1..5 loop
    l_prev := l_next;
    l_next := instr(l_cs, chr(10), l_prev+1);
  end loop;
  return substr(l_cs, l_prev+21, l_next-l_prev-21);
end;
 
/
 show err;
 
PROMPT *** Create  grants  GET_CALLER_NAME ***
grant EXECUTE                                                                on GET_CALLER_NAME to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_caller_name.sql =========*** En
 PROMPT ===================================================================================== 
 