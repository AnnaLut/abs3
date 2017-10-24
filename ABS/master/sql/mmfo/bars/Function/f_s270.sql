
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_s270.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_S270 (dat_ in date, s270_ in varchar2, acc_ in number) return varchar2
is
nd_ number;
begin
 return f_get_s270(dat_ , s270_ , acc_ ,nd_);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_s270.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 