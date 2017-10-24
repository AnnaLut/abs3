
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_from_accountspv_dat2.sql ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_FROM_ACCOUNTSPV_DAT2 
(p_spid int, p_acc INTEGER, p_dat DATE)
return date is
-- v.1.0 від 31/03-15
-- актуальне значення DAT2
l_val accountsp.val%type:= null;
l_dat2 accountsp.dat2%type:= null;

begin

begin
select min(dat2) into l_dat2
from ACCOUNTSPV where acc = p_acc and parid = p_spid
                      and p_dat <= dat2;
exception when no_data_found then null;
end;

return l_dat2;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_FROM_ACCOUNTSPV_DAT2 ***
grant EXECUTE                                                                on F_GET_FROM_ACCOUNTSPV_DAT2 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_FROM_ACCOUNTSPV_DAT2 to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_from_accountspv_dat2.sql ====
 PROMPT ===================================================================================== 
 