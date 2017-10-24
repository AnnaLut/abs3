
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ku_ku.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KU_KU (kv_ number, s_ number, dat_ date)
return number
IS
nOut		number;
dVdate		date;
begin
select
	max (vdate)
into
	dVdate
from
	cur_rates
where
	kv = kv_ and
	vdate <= dat_;
select
	s_ * rate_o / bsum
into
	nOut
from
	cur_rates
where
	kv = kv_ and
	vdate = dVdate;
	return nOut;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ku_ku.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 