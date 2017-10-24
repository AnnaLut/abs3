
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/min_n.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MIN_N 
(val1 number,val2 number) return number is
begin
  if val1>val2 then
    return val2;
  else
    return val1;
  end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/min_n.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 