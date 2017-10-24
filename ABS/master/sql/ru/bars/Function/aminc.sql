
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/aminc.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.AMINC (
  str_  varchar2,
  sym_  varchar2
) return number -- возвращает количество вхождений строки sym_ в строку str_
is
begin
  if length(sym_)=0 then
    return 0;
  end if;
  return (length(str_)-length(replace(str_,sym_)))/length(sym_);
end;
/
 show err;
 
PROMPT *** Create  grants  AMINC ***
grant EXECUTE                                                                on AMINC           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/aminc.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 