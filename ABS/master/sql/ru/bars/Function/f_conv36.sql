
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_conv36.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CONV36 (p_num in number) return varchar2 is
  enqstr  constant varchar2(255) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  base    constant pls_integer := 36;
  n    number;
  s    varchar2(12);
begin
  n:= p_num;

  while n >= base loop
    s := substr(enqstr, mod(n,base)+1, 1) || s;
    n := trunc(n / base);
  end loop;

  return substr(enqstr, n+1, 1) || s;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_conv36.sql =========*** End *** =
 PROMPT ===================================================================================== 
 