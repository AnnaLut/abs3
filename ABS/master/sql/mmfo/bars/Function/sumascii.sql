
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sumascii.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SUMASCII (par varchar2) return number
is
  vnum  number;
  i_    number;
begin
  if par is null then
    return 0;
  else
    vnum := 0;
    i_   := 1;
    while i_<=length(par)
    loop
      vnum := vnum+ascii(substr(par,i_,1));
      i_   := i_+1;
    end loop;
    return vnum;
  end if;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sumascii.sql =========*** End *** =
 PROMPT ===================================================================================== 
 