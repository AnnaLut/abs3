
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s190.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S190 (dat_ in date, acc_ in number, p_nd_ in varchar2, acc_exp_ in number:= null) return varchar2
   -- version 01/04/2016
is
 days_ number;
begin
  days_ := f_get_expire_days(dat_ , acc_ , p_nd_ , acc_exp_ , null );

  if days_ <= 0 then return '1';
  elsif days_ <= 7 then return '1';
  elsif days_ >= 8 and days_ <= 30 then return '2';
  elsif days_ >= 31 and days_ <= 90 then return '3';
  elsif days_ >= 91 and days_ <= 180 then return '4';
  elsif days_ > 180 then  return '5';
  end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s190.sql =========*** End ***
 PROMPT ===================================================================================== 
 