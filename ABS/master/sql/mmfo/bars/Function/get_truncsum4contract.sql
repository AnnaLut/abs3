
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_truncsum4contract.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_TRUNCSUM4CONTRACT 
   (p_curcode contracts_truncsum.curcode%type)
return number
is
  l_truncsum contracts_truncsum.truncsum%type;
begin
  begin
    select truncsum
      into l_truncsum
      from contracts_truncsum
     where curcode = p_curcode;
  exception
    when no_data_found then
      l_truncsum := 0;
  end;
  return l_truncsum;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_truncsum4contract.sql =========
 PROMPT ===================================================================================== 
 