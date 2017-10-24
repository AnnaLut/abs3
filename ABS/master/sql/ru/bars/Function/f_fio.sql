
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_fio.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_FIO (p_fio VARCHAR2,p_n int)
RETURN VARCHAR2
IS
  l_i1  int;
  l_i2  int;
begin
  l_i1 := instr(p_fio,' ');
  l_i2 := instr(p_fio,' ',l_i1+1);
  if    p_n=1 then
    return substr(p_fio,1,l_i1-1);
  elsif p_n=2 then
    return substr(p_fio,l_i1+1,l_i2-l_i1-1);
  elsif p_n=3 then
    return substr(p_fio,l_i2+1);
  else
    return null;
  end if;
end f_fio;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_fio.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 