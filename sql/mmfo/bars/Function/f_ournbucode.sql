
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ournbucode.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OURNBUCODE 
return number
is
nbucode	number;
begin
select c_reg into nbucode
from banks, spr_obl
where mfo = f_ourmfo () and
kod_reg = substr(sab,2,1);
return nbucode;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ournbucode.sql =========*** End *
 PROMPT ===================================================================================== 
 