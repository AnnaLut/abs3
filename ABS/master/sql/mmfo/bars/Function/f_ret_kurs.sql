
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_kurs.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_KURS (p_kv_ number, p_dat_ date) return number is
	l_dat_ date;
	l_kurs_ number;
	l_bsum_ number;
begin
	SELECT  r.bsum, r.rate_o
	into l_bsum_, l_kurs_
	FROM cur_rates r
	WHERE r.kv = p_kv_               AND
	      r.vdate = (SELECT max(rr.vdate)
		  		  	 FROM cur_rates rr
		             WHERE rr.kv=p_kv_ and
					 	   rr.vdate<=p_dat_);


	return l_kurs_/l_bsum_;
end;
 
/
 show err;
 
PROMPT *** Create  grants  F_RET_KURS ***
grant EXECUTE                                                                on F_RET_KURS      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_kurs.sql =========*** End ***
 PROMPT ===================================================================================== 
 