
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/isnumber.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ISNUMBER (par varchar2) return boolean
is
  vnum   number;
begin
  vnum := to_number(par);
  return true;
exception when others then
  return false;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/isnumber.sql =========*** End *** =
 PROMPT ===================================================================================== 
 