
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_from_accountspv.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_FROM_ACCOUNTSPV 
(p_spid int, p_acc INTEGER, p_dat DATE)
return varchar2 is
-- актуальне значення пар-ра рах-ку на дату
l_val accountsp.val%type:= null;

begin

begin
select val into l_val
from ACCOUNTSPV where acc = p_acc and parid = p_spid
                      and p_dat >= dat1 and p_dat <= dat2;
exception when no_data_found then null;
end;

return l_val;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_FROM_ACCOUNTSPV ***
grant EXECUTE                                                                on F_GET_FROM_ACCOUNTSPV to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_FROM_ACCOUNTSPV to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_from_accountspv.sql =========
 PROMPT ===================================================================================== 
 