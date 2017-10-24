

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_OPERW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_OPERW ***

  CREATE OR REPLACE PROCEDURE BARS.SET_OPERW (
  p_ref    operw.ref%type,
  p_tag    operw.tag%type,
  p_value  operw.value%type )
is
begin
  insert into operw (ref, tag, value)
  values (p_ref, p_tag, p_value);
exception when dup_val_on_index then
  update operw
     set value = p_value
   where ref = p_ref
     and tag = p_tag;
end;
/
show err;

PROMPT *** Create  grants  SET_OPERW ***
grant EXECUTE                                                                on SET_OPERW       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_OPERW       to START1;
grant EXECUTE                                                                on SET_OPERW       to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_OPERW.sql =========*** End ***
PROMPT ===================================================================================== 
