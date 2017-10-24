
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_drop_undigital.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DROP_UNDIGITAL (par varchar2) return varchar2
is
  ret  varchar2(1024);
  i    int;
begin
  ret := '';
  if length(par)>0 then
    for i in 1..length(par)
    loop
      if isnumber(substr(par,i,1)) then
        ret:=ret||substr(par,i,1);
      end if;
    end loop;
  end if;
  return ret;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_drop_undigital.sql =========*** E
 PROMPT ===================================================================================== 
 