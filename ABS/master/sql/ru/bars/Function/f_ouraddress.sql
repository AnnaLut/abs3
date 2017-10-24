
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ouraddress.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OURADDRESS 
return varchar2
is
n_adr varchar2(100);
begin
select substr(val,1,100) into n_adr from params where par = 'ADDRESS';
return n_adr;
end f_ouraddress;
/
 show err;
 
PROMPT *** Create  grants  F_OURADDRESS ***
grant EXECUTE                                                                on F_OURADDRESS    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OURADDRESS    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ouraddress.sql =========*** End *
 PROMPT ===================================================================================== 
 