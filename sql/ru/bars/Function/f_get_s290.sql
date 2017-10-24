
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s290.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S290 (dat_ in date, acc_ in number, p_nd_ in varchar2, acc_exp_ in number:= null) return varchar2
   -- version 29/02/2012 (08/09/2009, 07/09/2009, 13.08.2009)
is
 days_ number;
begin
  days_ := f_get_expire_days(dat_ , acc_ , p_nd_ , acc_exp_, 1 );

  if days_ <= 0 then return '0';
  elsif days_ <= 7 then return '3';
  elsif days_ >= 8 and days_ <= 31 then return '5';
  elsif days_ >= 32 and days_ <= 60 then return 'I';
  elsif days_ >= 61 and days_ <= 90 then return 'J';
  elsif days_ >= 91 and days_ <= 120 then return 'K';
  elsif days_ >= 121 and days_ <= 150 then return 'L';
  elsif days_ >= 151 and days_ <= 180 then return 'M';
  elsif days_ >= 181 then  return 'N';
  end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s290.sql =========*** End ***
 PROMPT ===================================================================================== 
 