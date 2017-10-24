
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_numeric_characters.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NUMERIC_CHARACTERS (p_s varchar2)
return varchar2
is
    l_symb varchar2(5);
    l_ret  varchar2(50);
begin
   begin
    select substr(5/4,2,1) into l_symb from dual;
    l_ret:=replace(replace(p_s,',', l_symb),'.',l_symb);
   end;
  return l_ret;
end;
/
 show err;
 
PROMPT *** Create  grants  F_NUMERIC_CHARACTERS ***
grant EXECUTE                                                                on F_NUMERIC_CHARACTERS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_NUMERIC_CHARACTERS to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_numeric_characters.sql =========*
 PROMPT ===================================================================================== 
 